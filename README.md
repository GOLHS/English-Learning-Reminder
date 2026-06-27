# Vocab Trainer

A fully offline Flutter English Vocabulary Trainer with spaced repetition (SRS), review engine, irregular verbs module, AI-powered stories, and test mode.

## Features

- **Vocabulary Management** — Add, edit, search, filter, and organize words with categories, difficulty, synonyms, antonyms, and examples
- **Spaced Repetition (SRS)** — Custom SM-2 algorithm with 4 grades (Forgot/Hard/Good/Easy) for both words and irregular verbs
- **Review Sessions** — 5-step review flow: show word → recall → reveal → write example → grade
- **Irregular Verbs** — 150+ built-in verbs grouped by pattern (i-a-u, o-e-en, ee-e-ee, etc.) with 5 review modes
- **Stories** — Read preloaded fables, write daily summaries, long-press words to add to vocabulary
- **AI Integration** — Story generation, vocabulary autofill (meaning + examples), answer checking (OpenAI / Gemini / Claude)
- **Test Mode** — Vocabulary quiz (word→meaning / meaning→word) and verb sentence writing (12 sentences across 10 tenses), both AI-corrected
- **Notifications** — Configurable hourly review reminders
- **Statistics** — Dashboard with weekly review chart (fl_chart), streaks, and insights
- **Offline-First** — All data stored locally in Isar database; no internet required except AI features

## Tech Stack

| Technology | Version | Purpose |
|-----------|---------|---------|
| Flutter | 3.22+ | UI framework |
| Dart | 3.9.2 | Language |
| Riverpod | 2.6 | State management |
| go_router | 14.8 | Navigation / routing |
| Isar | 3.1.0+1 | Local database (6 collections) |
| flutter_local_notifications | 18.0 | Push notifications |
| fl_chart | 0.70 | Statistics charts |
| http | — | AI API calls (OpenAI / Gemini / Claude) |

## Getting Started

### Prerequisites

- Flutter SDK 3.22+
- Dart 3.9.2+
- Android Studio or VS Code

### Setup

```bash
# Clone the repository
git clone <repo-url>
cd english_app

# Install dependencies
flutter pub get

# Regenerate Isar model code (after model changes)
dart run build_runner build --delete-conflicting-outputs

# Run on device
flutter run

# Build APK
flutter build apk --debug
flutter build apk --release
```

### Gemini API Key

To use AI features, get a free API key from:
https://aistudio.google.com/apikey

Set it in the app: **Settings → AI Settings** (or enter it at onboarding).

A default key is hardcoded in `lib/data/seed/seed_service.dart` for development.

## Project Structure

```
lib/
├── main.dart                       # Entry point
├── core/
│   ├── constants/                  # App constants, verb patterns, categories
│   ├── theme/                      # Material 3 light/dark themes
│   ├── router/                     # GoRouter configuration (30+ routes)
│   ├── utils/                      # Form validators, date utilities
│   └── widgets/                    # Shared UI components
├── data/
│   ├── database/                   # Isar database service
│   ├── models/                     # 6 data models (Word, Verb, Story, etc.)
│   ├── repositories/               # CRUD + query layer
│   └── seed/                       # Seed data (150+ verbs, 8 stories)
├── services/
│   ├── srs_engine.dart             # Spaced repetition algorithm
│   ├── ai_service.dart             # Multi-provider AI client
│   └── notification_service.dart   # Local notifications
└── features/
    ├── splash/                     # Splash screen
    ├── onboarding/                 # 4-step onboarding flow
    ├── home/                       # Dashboard
    ├── vocabulary/                 # Word management
    ├── verbs/                      # Irregular verbs
    ├── stories/                    # Stories + summaries
    ├── review/                     # SRS review session
    ├── test/                       # AI-powered test mode
    ├── statistics/                 # Stats with charts
    ├── settings/                   # Settings hub
    └── archive/                    # Archived words
```

## Database

6 Isar collections:
- **Word** — Vocabulary with SRS fields
- **Verb** — Irregular verb forms with SRS fields
- **ReviewLog** — Review attempt history
- **UserPreferences** — Settings (notifications, AI config, theme)
- **Story** — Stories with preloaded flag
- **StorySummary** — Daily summaries linked to stories

Regenerate `.g.dart` files after model changes:
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Key Commands

```bash
flutter analyze                    # Static analysis
flutter test                       # Run tests
flutter build apk --debug          # Debug APK
flutter build apk --release        # Release APK
```

## License

Private project.
