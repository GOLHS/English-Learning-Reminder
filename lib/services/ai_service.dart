import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../data/repositories/preferences_repository.dart';

final aiServiceProvider = Provider<AIService>((ref) {
  return AIService(ref);
});

class AIService {
  final Ref _ref;
  AIService(this._ref);

  Future<Map<String, String>> _getConfig() async {
    final prefs = await _ref.read(preferencesRepositoryProvider).get();
    return {
      'provider': prefs.aiProvider,
      'apiKey': prefs.aiApiKey,
      'model': prefs.aiModel,
    };
  }

  Future<String> chat(String prompt, {String? system}) async {
    final config = await _getConfig();
    if (config['apiKey'] == null || config['apiKey']!.isEmpty) {
      throw Exception('AI API key not configured. Set it in Settings > AI.');
    }

    switch (config['provider']) {
      case 'gemini':
        return _chatGemini(config, prompt, system);
      case 'claude':
        return _chatClaude(config, prompt, system);
      default:
        return _chatOpenAI(config, prompt, system);
    }
  }

  Future<String> _chatOpenAI(Map<String, String> config, String prompt, String? system) async {
    final messages = <Map<String, dynamic>>[];
    if (system != null) messages.add({'role': 'system', 'content': system});
    messages.add({'role': 'user', 'content': prompt});

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${config['apiKey']}',
      },
      body: jsonEncode({
        'model': config['model'],
        'messages': messages,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('OpenAI error (${response.statusCode}): ${response.body}');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = data['choices'] as List;
    if (choices.isEmpty) throw Exception('No response from OpenAI');
    return (choices[0] as Map<String, dynamic>)['message']['content'] as String;
  }

  Future<String> _chatGemini(Map<String, String> config, String prompt, String? system) async {
    final contents = <Map<String, dynamic>>[];
    if (system != null) {
      contents.add({'role': 'user', 'parts': [{'text': '[System instruction] $system'}]});
      contents.add({'role': 'model', 'parts': [{'text': 'Understood.'}]});
    }
    contents.add({'role': 'user', 'parts': [{'text': prompt}]});

    final response = await http.post(
      Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/${config['model']}:generateContent?key=${config['apiKey']}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'contents': contents}),
    );

    if (response.statusCode != 200) {
      throw Exception('Gemini error (${response.statusCode}): ${response.body}');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = data['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) throw Exception('No response from Gemini');
    final content = candidates[0] as Map<String, dynamic>;
    final parts = content['content']['parts'] as List;
    if (parts.isEmpty) throw Exception('Empty response from Gemini');
    return (parts[0] as Map<String, dynamic>)['text'] as String;
  }

  Future<String> _chatClaude(Map<String, String> config, String prompt, String? system) async {
    final messages = <Map<String, dynamic>>[
      {'role': 'user', 'content': prompt},
    ];

    final body = <String, dynamic>{
      'model': config['model'],
      'messages': messages,
      'max_tokens': 1024,
    };
    if (system != null) body['system'] = system;

    final response = await http.post(
      Uri.parse('https://api.anthropic.com/v1/messages'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': config['apiKey']!,
        'anthropic-version': '2023-06-01',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Claude error (${response.statusCode}): ${response.body}');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final content = data['content'] as List;
    if (content.isEmpty) throw Exception('No response from Claude');
    final text = content.whereType<Map<String, dynamic>>().firstWhere(
      (c) => c['type'] == 'text',
      orElse: () => <String, dynamic>{},
    );
    return text['text'] as String? ?? 'No text response';
  }

  Future<String> generateStory(String topic) async {
    return chat(
      'Write a short story in English (approximately 300-500 words) about: $topic. '
      'The story should be engaging and suitable for English learners. '
      'Use simple to intermediate vocabulary.',
      system: 'You are a creative writer. Write only the story text, no introductions or explanations.',
    );
  }

  Future<String> generateExamples(String word, {String? meaning, String? definition}) async {
    String context = '';
    if (meaning != null) context += ' meaning: $meaning';
    if (definition != null) context += ' definition: $definition';

    return chat(
      'Generate 3 example sentences using the word "$word".$context\n'
      'Format each sentence on a new line starting with "- ".',
      system: 'You are an English teacher. Provide natural, clear example sentences.',
    );
  }

  Future<String> suggestMeaning(String word) async {
    return chat(
      'What does the English word "$word" mean? '
      'Provide a brief, clear definition suitable for an English learner. '
      'Also provide the pronunciation in IPA format (e.g., /rɪˈzʌlɪənt/). '
      'Format: Meaning: ...\nPronunciation: ...',
      system: 'You are an English dictionary assistant.',
    );
  }

  Future<Map<String, dynamic>> checkAnswer(String questionType, String userAnswer, {String? expected, String? word, String? tense}) async {
    String prompt;
    String system;

    if (questionType == 'meaning') {
      prompt = 'The user was shown the meaning "${expected}" and answered "$userAnswer". '
          'The correct word is "${expected}". '
          'Is the user\'s answer correct? Reply with a JSON object: '
          '{"correct": true/false, "feedback": "brief explanation in 1-2 sentences"}';
      system = 'You are an English teacher. Respond only with valid JSON.';
    } else if (questionType == 'example') {
      prompt = 'Check this sentence using the word "$word":\n'
          'Sentence: $userAnswer\n\n'
          'Is the sentence grammatically correct and does it use "$word" naturally? '
          'Reply with a JSON object: '
          '{"correct": true/false, "feedback": "correction or advice in 1-2 sentences"}';
      system = 'You are an English grammar tutor. Respond only with valid JSON.';
    } else {
      prompt = 'Check this sentence using the verb "$word" in the "$tense" tense:\n'
          'Sentence: $userAnswer\n\n'
          'Is the verb form correct for this tense? '
          'Reply with a JSON object: '
          '{"correct": true/false, "feedback": "correction or advice in 1-2 sentences"}';
      system = 'You are an English grammar tutor. Respond only with valid JSON.';
    }

    final raw = await chat(prompt, system: system);
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      // fallback if response is not valid JSON
      final isCorrect = !raw.contains('incorrect') && !raw.contains('error') && !raw.contains('mistake');
      return {'correct': isCorrect, 'feedback': raw};
    }
  }

  Future<String> correctSentence(String sentence) async {
    return chat(
      'Correct the following English sentence if needed. If it is already correct, return it as-is. '
      'Explain the correction briefly.\n\nSentence: $sentence',
      system: 'You are an English grammar tutor.',
    );
  }
}
