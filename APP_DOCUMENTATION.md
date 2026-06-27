# Vocab Trainer — Application Documentation

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Architecture](#2-architecture)
3. [Directory Structure](#3-directory-structure)
4. [Data Models](#4-data-models)
5. [Repositories](#5-repositories)
6. [Services](#6-services)
7. [State Management (Providers)](#7-state-management-providers)
8. [Routes / Navigation](#8-routes--navigation)
9. [Screens / Features](#9-screens--features)
10. [Core Widgets](#10-core-widgets)
11. [Data Flow & Relationships](#11-data-flow--relationships)
12. [Key Design Decisions](#12-key-design-decisions)
13. [Development Conventions](#13-development-conventions)

---

## 1. Project Overview

A fully offline Flutter English Vocabulary Trainer mobile app with spaced repetition (SRS), review engine, irregular verbs module, stories module with AI generation, AI vocabulary fill, notifications, statistics, and AI-powered test mode.

**Stack:**
- Flutter 3.22+, Dart 3.9.2
- Android-first, iOS-compatible
- State management: Riverpod 2.6
- Routing: go_router 14.8
- Local database: Isar 3.1.0+1 (6 collections)
- AI: http (OpenAI / Gemini / Claude APIs)
- Notifications: flutter_local_notifications 18
- Charts: fl_chart 0.70

---

## 2. Architecture

Feature-first + clean architecture lite:

```
lib/
├── core/        # Shared: theme, constants, router, utils, reusable widgets
├── data/        # Data layer: models, database, repositories, seed data
├── services/    # Business logic: SRS engine, AI service, notifications
├── features/    # Feature modules (screens + feature-specific providers/widgets)
└── main.dart    # Entry point
```

**Layers:**
- **UI Layer** (`features/*.dart`): Screens, widgets, screen-level Riverpod providers
- **Business Logic Layer** (`services/*.dart`): SRS algorithm, AI API calls, notifications
- **Data Layer** (`data/`): Isar collections, repositories (CRUD + queries), seed data
- **Core Layer** (`core/`): Theme, constants, router, shared widgets, form validators

**Rule:** Business logic never goes in widgets. Repositories/Services/Use Cases are isolated.

---

## 3. Directory Structure

```
lib/
├── main.dart                              # Entry point: Isar init, seed, notifications, ProviderScope
│
├── core/
│   ├── constants/
│   │   └── app_constants.dart             # App name, verb pattern groups, categories, limits
│   ├── theme/
│   │   └── app_theme.dart                 # Material 3 light/dark themes (indigo seed)
│   ├── router/
│   │   └── app_router.dart                # GoRouter config, 30+ routes, routerProvider
│   ├── utils/
│   │   ├── validators.dart                # Form validation helpers
│   │   └── date_utils.dart                # Date formatting utilities
│   └── widgets/
│       ├── word_tile.dart                 # Word list tile with popup menu
│       ├── stat_card.dart                 # Dashboard stat card
│       ├── section_header.dart            # Section title + trailing action
│       ├── primary_button.dart            # Full-width elevated button
│       ├── form_section.dart              # Form label + Card wrapper
│       ├── error_banner.dart              # MaterialBanner error display
│       ├── empty_state.dart               # Empty state + LoadingShimmer
│       └── app_bottom_nav.dart            # 6-tab bottom navigation
│
├── data/
│   ├── database/
│   │   └── isar_service.dart              # Isar DB init, schema registration (6 collections)
│   ├── models/
│   │   ├── word_model.dart                # Word collection (+ .g.dart)
│   │   ├── verb_model.dart                # Verb collection (+ .g.dart)
│   │   ├── story_model.dart               # Story collection (+ .g.dart)
│   │   ├── story_summary_model.dart       # StorySummary collection (+ .g.dart)
│   │   ├── review_log_model.dart          # ReviewLog collection (+ .g.dart)
│   │   └── user_preferences.dart          # UserPreferences collection (+ .g.dart)
│   ├── repositories/
│   │   ├── word_repository.dart           # Word CRUD + queries
│   │   ├── verb_repository.dart           # Verb CRUD + queries
│   │   ├── story_repository.dart          # Story CRUD + queries
│   │   ├── story_summary_repository.dart  # StorySummary CRUD + queries
│   │   ├── review_log_repository.dart     # ReviewLog CRUD + queries
│   │   └── preferences_repository.dart    # UserPreferences CRUD + cache
│   └── seed/
│       ├── seed_service.dart              # Seeds: verbs, stories, AI config on first launch
│       ├── irregular_verbs.dart           # ~150+ irregular verbs with pattern groups
│       └── story_seed.dart                # 8 preloaded fable stories
│
├── services/
│   ├── srs_engine.dart                    # SM-2 algorithm with 4-grade interface
│   ├── ai_service.dart                    # Multi-provider AI client (OpenAI/Gemini/Claude)
│   ├── notification_service.dart          # Local notification scheduling
│   └── notification_provider.dart         # Riverpod provider for NotificationService
│
└── features/
    ├── splash/
    │   └── splash_screen.dart             # Splash → onboarding or home
    ├── onboarding/
    │   ├── onboarding_screen.dart         # 3-page welcome carousel
    │   ├── frequency_screen.dart          # Review intensity selection
    │   ├── custom_frequency_screen.dart   # Custom review settings
    │   └── notification_setup_screen.dart # Notification preferences + save
    ├── home/
    │   └── home_screen.dart               # Dashboard: due count, stats, quick actions
    ├── vocabulary/
    │   ├── vocabulary_list_screen.dart    # Word list with search/filter/sort
    │   ├── add_word_screen.dart           # Add/edit word with AI autofill
    │   ├── word_detail_screen.dart        # Word detail with SRS stats
    │   └── widgets/filter_sheet.dart      # Filter/sort bottom sheet
    ├── review/
    │   ├── review_session_screen.dart     # 5-step SRS review
    │   └── review_summary_screen.dart     # Post-review stats
    ├── verbs/
    │   ├── verbs_home_screen.dart         # Verb list with due count
    │   ├── add_verb_screen.dart           # Add/edit verb
    │   ├── verb_detail_screen.dart        # Verb detail with SRS stats
    │   └── verb_review_screen.dart        # Verb review (5 modes)
    ├── stories/
    │   ├── stories_home_screen.dart       # Story list with daily summary prompt
    │   ├── add_story_screen.dart          # Add/edit story + AI generation
    │   ├── story_detail_screen.dart       # Story reader + tappable words
    │   └── write_summary_screen.dart      # Write daily story summary
    ├── settings/
    │   ├── settings_screen.dart           # Settings hub
    │   ├── notification_settings_screen.dart
    │   ├── learning_settings_screen.dart
    │   ├── ai_settings_screen.dart        # API key + provider + model
    │   └── data_settings_screen.dart      # Export/import/reset
    ├── statistics/
    │   └── statistics_screen.dart         # Stats dashboard with fl_chart
    ├── archive/
    │   └── archive_screen.dart            # Archived words management
    └── test/
        └── test_screen.dart               # Test mode: Vocab quiz + Verb sentence writing
```

---

## 4. Data Models

### 4.1 Word (`word_model.dart`)
| Field | Type | Default | Notes |
|-------|------|---------|-------|
| `id` | `Id` | autoIncrement | Isar PK |
| `uuid` | `String` | `''` | Indexed, unique |
| `word` | `String` | `''` | The vocabulary word |
| `meaning` | `String` | `''` | Definition/translation |
| `examples` | `List<String>` | `[]` | Example sentences |
| `notes` | `String?` | null | Optional notes |
| `category` | `String?` | null | e.g. Travel, Business |
| `synonyms` | `List<String>` | `[]` | |
| `antonyms` | `List<String>` | `[]` | |
| `pronunciation` | `String?` | null | IPA |
| `difficulty` | `String` | `'Medium'` | Easy/Medium/Hard |
| `isMastered` | `bool` | false | Mastered flag |
| `isArchived` | `bool` | false | Archived flag |
| `createdAt` | `DateTime` | `DateTime.now()` | |
| `easeFactor` | `double` | 2.5 | SRS |
| `interval` | `int` | 0 | SRS (days) |
| `repetitions` | `int` | 0 | SRS count |
| `reviewCount` | `int` | 0 | Total reviews |
| `successCount` | `int` | 0 | Total successes |
| `consecutiveCorrect` | `int` | 0 | Streak |
| `nextReviewAt` | `DateTime?` | null | Next review date |
| `lastReviewedAt` | `DateTime?` | null | Last review date |

**Computed:** `successRate` (`reviewCount > 0 ? successCount / reviewCount : 0`)

**Factory:** `Word.create(...)` generates UUID, sets `nextReviewAt = DateTime.now()`

### 4.2 Verb (`verb_model.dart`)
| Field | Type | Default | Notes |
|-------|------|---------|-------|
| `id` | `Id` | autoIncrement | Isar PK |
| `uuid` | `String` | `''` | Indexed |
| `baseForm` | `String` | `''` | e.g. "sing" |
| `pastSimple` | `String` | `''` | e.g. "sang" |
| `pastParticiple` | `String` | `''` | e.g. "sung" |
| `meaning` | `String?` | null | |
| `examples` | `List<String>` | `[]` | |
| `difficulty` | `String` | `'Medium'` | |
| `patternGroup` | `String?` | null | e.g. "i-a-u (sing/sang/sung)" |
| `reviewScore` | `int` | 0 | |
| `createdAt` | `DateTime` | `DateTime.now()` | |
| *SRS fields* | *same as Word* | *same defaults* | easeFactor, interval, repetitions, reviewCount, successCount, consecutiveCorrect, nextReviewAt, lastReviewedAt |

**Computed:** `successRate`, `isDifficult` (`consecutiveCorrect < 2 && reviewCount >= 3`)

**Factory:** `Verb.create(...)` generates UUID, sets `nextReviewAt = DateTime.now()`

### 4.3 UserPreferences (`user_preferences.dart`)
Single-row collection storing all user settings:
- `onboardingCompleted`, `reviewIntensity`, `reviewsPerWord`, `reviewPeriod`, `maxDailyReviews`
- `notificationEnabled`, `notificationHour`, `notificationMinute`, `notificationDays`, `quietHoursStart`, `quietHoursEnd`
- `typingMode`, `showExamplesDuringRecall`, `defaultVerbReviewMode`, `autoPlayPronunciation`
- `themeMode`, `aiProvider`, `aiApiKey`, `aiModel`

### 4.4 Story (`story_model.dart`)
| Field | Type | Notes |
|-------|------|-------|
| `uuid` | `String` | Indexed |
| `title` | `String` | |
| `text` | `String` | Story content |
| `isPreloaded` | `bool` | Seed story flag |
| `isArchived` | `bool` | |
| `createdAt` | `DateTime` | |
| `updatedAt` | `DateTime?` | |

### 4.5 StorySummary (`story_summary_model.dart`)
| Field | Type | Notes |
|-------|------|-------|
| `uuid` | `String` | Indexed |
| `storyUuid` | `String` | Indexed, FK to Story |
| `text` | `String` | Summary content |
| `createdAt` | `DateTime` | |
| `summaryDate` | `DateTime` | Indexed, date-only |

### 4.6 ReviewLog (`review_log_model.dart`)
| Field | Type | Notes |
|-------|------|-------|
| `itemId` | `String` | Indexed, UUID of word/verb |
| `itemType` | `String` | `'word'` or `'verb'` |
| `result` | `String` | `forgot/hard/good/easy` |
| `reviewedAt` | `DateTime` | |
| `interval` | `double` | SRS state snapshot |
| `easeFactor` | `double` | SRS state snapshot |
| `repetitions` | `int` | SRS state snapshot |
| `wasCorrect` | `bool` | |

---

## 5. Repositories

Each repository wraps Isar queries and exposes `Future`-based methods. All repositories are provided via Riverpod `Provider` (singleton scoped to app lifecycle).

| Repository | Key Methods |
|-----------|-------------|
| **WordRepository** | `getAll`, `getDueWords`, `getByCategory`, `getByDifficulty`, `getMastered`, `getArchived`, `getDifficult`, `getForgotten`, `search`, `save`, `saveAll`, `delete` |
| **VerbRepository** | `getAll`, `getDueVerbs`, `getDifficult`, `getMastered`, `getByPatternGroup`, `save`, `saveAll`, `delete` |
| **StoryRepository** | `getAll`, `getRandom`, `getRandomExcludingPreloaded`, `save`, `saveAll`, `delete`, `markArchived` |
| **StorySummaryRepository** | `getByStory`, `getByStoryAndDate`, `hasWrittenToday`, `save`, `delete` |
| **ReviewLogRepository** | `save`, `getRecent`, `getByDateRange`, `getTodayCount`, `getCorrectTodayCount`, `getWeeklyCounts`, `deleteAll` |
| **PreferencesRepository** | `get` (cached), `save` (cached), `isOnboardingCompleted`, `completeOnboarding` |

---

## 6. Services

### 6.1 SRSEngine (`srs_engine.dart`)
Custom SM-2 algorithm with 4 grades:
| Grade | Interval | Ease Factor Change |
|-------|----------|-------------------|
| `forgot` | Reset → 1 day | EF unchanged |
| `hard` | Previous × 1.2 | EF -0.15 |
| `good` | Previous × EF | EF unchanged |
| `easy` | Previous × EF × 1.3 | EF +0.15 |

- Initial intervals: forgot=1d, hard=3d, good=7d, easy=15d
- First review uses fixed intervals, then transitions to adaptive formula
- Methods: `calculate()`, `applyToWord()`, `applyToVerb()`

### 6.2 AIService (`ai_service.dart`)
Multi-provider AI client supporting OpenAI, Gemini, Claude.
- Reads provider/model/key from `UserPreferences`
- Methods: `chat()`, `generateStory()`, `generateExamples()`, `suggestMeaning()`, `checkAnswer()`, `correctSentence()`
- `checkAnswer()` returns `{correct: bool, feedback: String}` in JSON

### 6.3 NotificationService (`notification_service.dart`)
- Uses flutter_local_notifications
- `scheduleHourlyReview()` — cancels previous, schedules new hourly repeat
- `periodicallyShow()` with `RepeatInterval.hourly`
- `requestPermissions()` called at startup

---

## 7. State Management (Providers)

**Pattern:** Riverpod `FutureProvider` for async data, `Provider` for singletons, `StateNotifierProvider` for complex state machines.

### Global / Service Providers (overridden in main)
| Provider | Type |
|----------|------|
| `isarServiceProvider` | `Provider<IsarService>` |
| `notificationServiceProvider` | `Provider<NotificationService>` |
| `aiServiceProvider` | `Provider<AIService>` |
| `routerProvider` | `Provider<GoRouter>` |

### Repository Providers (auto-wired)
| Provider | Type |
|----------|------|
| `wordRepositoryProvider` | `Provider<WordRepository>` |
| `verbRepositoryProvider` | `Provider<VerbRepository>` |
| `storyRepositoryProvider` | `Provider<StoryRepository>` |
| `storySummaryRepositoryProvider` | `Provider<StorySummaryRepository>` |
| `reviewLogRepositoryProvider` | `Provider<ReviewLogRepository>` |
| `preferencesRepositoryProvider` | `Provider<PreferencesRepository>` |

### Screen-Level Providers (in feature files)
- `_splashProvider` → checks onboarding → navigates to onboarding or home
- `_homeDataProvider` → aggregates due words/verbs counts + stats + streak
- `_vocabListProvider` → filtered/sorted word list
- `_verbsHomeProvider` → all verbs + due count
- `_testInitProvider` → all vocab + all verbs for test mode
- `_sessionProvider` / `_sessionStateProvider` → review session state machine
- `_statsProvider` → statistics data + weekly chart data
- `_storiesProvider` → stories list + today's summary status
- Story detail / summary providers (family providers keyed by UUID)

---

## 8. Routes / Navigation

GoRouter with `NoTransitionPage` for onboarding (avoids overlay hit-test crashes).

### Splash & Onboarding
| Route | Screen |
|-------|--------|
| `/splash` | `SplashScreen` |
| `/onboarding` | `OnboardingScreen` (3-page carousel) |
| `/onboarding/frequency` | `FrequencyScreen` |
| `/onboarding/custom` | `CustomFrequencyScreen` |
| `/onboarding/notifications` | `NotificationSetupScreen` |

### Main App (with bottom nav)
| Route | Screen | Bottom Tab |
|-------|--------|-----------|
| `/` | `HomeScreen` | Home (0) |
| `/vocabulary` | `VocabularyListScreen` | Vocabulary (1) |
| `/vocabulary/add` | `AddWordScreen` (create) | — |
| `/vocabulary/:id` | `WordDetailScreen` | — |
| `/vocabulary/:id/edit` | `AddWordScreen` (edit) | — |
| `/review` | `ReviewSessionScreen` | — |
| `/review/summary` | `ReviewSummaryScreen` | — |
| `/test` | `TestModeScreen` | — |
| `/test/vocab` | `VocabTestScreen` | — |
| `/test/verbs` | `VerbTestScreen` | — |
| `/verbs` | `VerbsHomeScreen` | Verbs (3) |
| `/verbs/add` | `AddVerbScreen` | — |
| `/verbs/:id` | `VerbDetailScreen` | — |
| `/verbs/:id/edit` | `AddVerbScreen` (edit) | — |
| `/verbs/review?mode=` | `VerbReviewScreen` | — |
| `/stories` | `StoriesHomeScreen` | Stories (2) |
| `/stories/add` | `AddStoryScreen` | — |
| `/stories/:id` | `StoryDetailScreen` | — |
| `/stories/:id/edit` | `AddStoryScreen` (edit) | — |
| `/stories/:id/summarize` | `WriteSummaryScreen` | — |
| `/stats` | `StatisticsScreen` | Stats (4) |
| `/settings` | `SettingsScreen` | Settings (5) |
| `/settings/notifications` | `NotificationSettingsScreen` | — |
| `/settings/learning` | `LearningSettingsScreen` | — |
| `/settings/ai` | `AiSettingsScreen` | — |
| `/settings/data` | `DataSettingsScreen` | — |
| `/archive` | `ArchiveScreen` | — |

---

## 9. Screens / Features

### 9.1 Splash & Onboarding
- **SplashScreen:** App icon + loading indicator; checks `isOnboardingCompleted` → navigates to onboarding or home
- **OnboardingScreen:** 3-page carousel (smarter learning, long-term memory, real usage) with "Next" / "Get Started" buttons. Uses `ColoredBox` + `SafeArea` (no Scaffold to avoid hit-test crash)
- **FrequencyScreen:** Intensity cards (Light/Balanced/Intensive/Custom) → CustomFrequencyScreen or NotificationSetupScreen
- **CustomFrequencyScreen:** Sliders for reviewsPerWord, period, maxDaily
- **NotificationSetupScreen:** Enable toggle, time picker, day selector, quiet hours → saves onboarding as complete → navigates to `/`

### 9.2 Home (`/`)
- `_HomeData`: due words count, due verbs count, mastered words, total words, total verbs, today reviewed count, weekly history, streak
- Widgets: `_TodayReviewCard` (due items + time estimate + Start Review), `_TestCard` (quiz mode), stat grid (`_MetricTile`), quick action tiles (Add Word, Add Verb, Stories, Test)
- Calls `scheduleHourlyReview()` when data loads

### 9.3 Vocabulary (`/vocabulary`)
- **List:** Search bar + category/difficulty/sort filter + FAB "Add word". Uses `ListView.builder`
- **Add/Edit:** Form with AI autofill (suggestMeaning + generateExamples), synonyms/antonyms chips input, category dropdown, notes
- **Detail:** Meaning, examples, SRS stats (success rate, reviews, next review), edit/archive/delete actions

### 9.4 Review Session (`/review`)
5-step flow:
1. **ShowWordStep:** Display word (or verb form), "Show Meaning" button
2. **RecallStep:** Type meaning (if typing mode enabled)
3. **RevealStep:** Show meaning, examples, synonyms, notes
4. **UsageStep:** Write an example sentence
5. **GradeStep:** 4 buttons (Forgot/Hard/Good/Easy) → SRS engine updates item

After session: `/review/summary` shows total reviewed, correct count, streak

### 9.5 Irregular Verbs (`/verbs`)
- **List:** Minimal `ListView.builder` (currently simplified for debugging), FAB "Add verb"
- **Add/Edit:** Form with baseForm/pastSimple/pastParticiple + difficulty + pattern group dropdown
- **Detail:** Three forms, meaning, pattern group, SRS stats
- **Review (5 modes):** Classic (show base → reveal forms), Missing Form (fill blank), Reverse Quiz (participle → base), Typing Mode (type all forms), Multiple Choice

### 9.6 Stories (`/stories`)
- **List:** "Daily Story Summary" prompt card + all stories with char count
- **Add:** Manual entry + "Generate with AI" button calls `AIService.generateStory()`
- **Detail:** Rich text reader with `_TappableStoryText` — long-press any word → vocabulary detail or add to vocabulary
- **Write Summary:** Write/edit a summary for a story on the current date

### 9.7 Test Mode (`/test`)
- **Mode Selection:** Vocabulary Quiz / Verb Test
- **VocabTest:** Mixed quiz (word→meaning or meaning→word) with AI correction + SRS grading
- **VerbTest:** Write 12 example sentences per verb across 10 tenses, AI-checked per sentence, SRS grading after completing 12

### 9.8 Settings (`/settings`)
- Hub → sub-screens: Notifications, Learning, AI (API key + provider + model), Data (export/import/reset)
- **DataSettingsScreen:** Export JSON, local backup (isar file copy), import, reset stats, erase all data

### 9.9 Statistics (`/stats`)
- Stat cards (total words, verbs, reviews, streak)
- Weekly bar chart (fl_chart) showing reviews per day
- Insights list

### 9.10 Archive (`/archive`)
- List of archived words with un-archive and permanent delete

---

## 10. Core Widgets

| Widget | Location | Purpose |
|--------|----------|---------|
| `WordTile` | `core/widgets/word_tile.dart` | Word list item with difficulty dot, meta info, popup menu |
| `StatCard` | `core/widgets/stat_card.dart` | Icon + value + label stat display |
| `SectionHeader` | `core/widgets/section_header.dart` | Section title with optional trailing action |
| `PrimaryButton` | `core/widgets/primary_button.dart` | Full-width button with loading state |
| `FormSection` | `core/widgets/form_section.dart` | Label + Card wrapper for forms |
| `ErrorBanner` | `core/widgets/error_banner.dart` | Material error banner with retry |
| `EmptyState` | `core/widgets/empty_state.dart` | Centered placeholder (icon, title, body, action) |
| `LoadingShimmer` | `core/widgets/empty_state.dart` | Shimmer loading placeholder |
| `AppBottomNav` | `core/widgets/app_bottom_nav.dart` | 6-tab bottom nav using GoRouter |

---

## 11. Data Flow & Relationships

### Entity Relationships
```
UserPreferences (1) ─── owns ───> settings, AI config, notification config

Word (N) ─── reviewed in ───> ReviewLog (N)
Verb (N) ─── reviewed in ───> ReviewLog (N)
Story (1) ─── has ───> StorySummary (N)
```

### Isar Schema Registration (order matters)
In `IsarService.init()`:
```dart
isar = await Isar.open([
  WordSchema,
  VerbSchema,
  ReviewLogSchema,
  UserPreferencesSchema,
  StorySchema,
  StorySummarySchema,
], ...)
```

### Startup Flow
```
main()
  └─> IsarService.init()
  └─> SeedService.seedIfEmpty()
  │     ├─ _seedVerbs()      (if verb count == 0)
  │     ├─ _seedStories()     (if story count == 0)
  │     └─ _seedAiConfig()    (if no API key set)
  └─> NotificationService.init()
  └─> NotificationService.requestPermissions()
  └─> runApp(ProviderScope(
        overrides: [isarServiceProvider, notificationServiceProvider],
        child: VocabTrainerApp
      ))
VocabTrainerApp
  └─> MaterialApp.router(routerConfig: routerProvider)
       └─> SplashScreen
            ├─ if onboarding not completed → /onboarding → ... → /
            └─ if onboarding completed → /
```

### Review Flow
```
ReviewSessionScreen
  └─ _sessionProvider fetches due words + verbs
  └─ 5 steps: ShowWord → Recall → Reveal → Usage → Grade
  └─ Grade calls SRSEngine.applyToWord/applyToVerb
      └─ updates Word/Verb SRS fields
      └─ creates ReviewLog
  └─ After all items: navigate to /review/summary
```

### AI Integration Points
- `AddWordScreen`: "AI Fill" → `suggestMeaning()` + `generateExamples()`
- `AddStoryScreen`: "Generate with AI" → `generateStory()`
- `VocabTestScreen` / `VerbTestScreen`: `checkAnswer()` for AI correction

---

## 12. Key Design Decisions

### Database: Isar 3.1.0+1
- Fast offline-first local DB with complex query support
- 6 collections with `@Index()` on UUID fields
- `.g.dart` files regenerate with `dart run build_runner build --delete-conflicting-outputs`
- `isar_flutter_libs` patched in pub cache (lost on `pub cache repair` or version upgrade)
- Core library desugaring added in `android/app/build.gradle.kts` (required by flutter_local_notifications)

### SRS Algorithm (custom SM-2)
- Fixed initial intervals: Forgot=1d, Hard=3d, Good=7d, Easy=15d
- After first review: transitions to adaptive formula
- Default `nextReviewAt = DateTime.now()` for new items (immediately reviewable)

### Navigation / Routes
- GoRouter with `StatefulShellRoute` for bottom nav tabs
- `NoTransitionPage` for onboarding routes + `context.replace()` — avoids `Offstage` wrapping that triggers overlay hit-test crashes
- FABs conditionally rendered only when `data.hasValue == true` (prevents hit-test crash during loading)

### Theme
- Material 3 with indigo seed color
- AppBar, inputs, buttons, cards, snackbar, divider, bottom nav all themed

### Onboarding (crash prevention)
- No `Scaffold` in `OnboardingScreen` — uses `ColoredBox` + `SafeArea`
- `Row + Spacer + FilledButton` replaced with separate `Align` widgets — eliminates BoxConstraints infinite-width crash

### Notifications
- `periodicallyShow()` with `RepeatInterval.hourly` — static message (word counts not computed in background)
- `requestPermissions()` called at startup in `main.dart`
- `scheduleHourlyReview()` called from `_homeDataProvider`

### AI Configuration
- API key stored in `UserPreferences` (single-row collection)
- Seeded with Gemini default on first launch (via `SeedService._seedAiConfig()`)
- Provider/model/key configurable in `/settings/ai`

### Known Constraints
- `analyzer 5.13.0` pinned by Isar (warning about SDK mismatch is benign)
- Gemini API key is visible in source (`SeedService`)
- Database auto-migration: adding new fields with defaults is handled by Isar; removing fields requires careful migration

---

## 13. Development Conventions

### Code Style
- No comments in source code unless explaining non-obvious logic
- Feature-first directory structure
- Private providers start with `_` and are file-scoped

### Build Commands
```bash
flutter pub get                           # Resolve dependencies
dart run build_runner build --delete-conflicting-outputs  # Regenerate Isar .g.dart
flutter analyze                           # Check for errors/warnings
flutter build apk --debug                 # Build debug APK
flutter build apk --release               # Build release APK
```

### Adding a New Feature
1. Create feature directory under `features/`
2. Add screen file(s)
3. Add screen-level Riverpod provider(s)
4. Add route in `app_router.dart`
5. Add to bottom nav if needed (6 tabs max)
6. Update APP_DOCUMENTATION.md

### State Management Rules
- `ref.watch()` for reactive data (rebuild on change)
- `ref.read()` for one-time access (inside callbacks)
- `autoDispose` for screen-scoped providers
- Repository providers are global singletons (no `autoDispose`)
- FABs must check `data.hasValue` before rendering

### Layout Guidelines
- No `Expanded`, `Flexible`, or `Spacer` inside scrollable views without explicit constraints
- Buttons in scroll views must have both `width` and `height` constraints (use `SizedBox`)
- `SingleChildScrollView` + `Column` is safer than nested `ListView` inside `CustomScrollView`
- Avoid nested scrollable widgets (horizontal inside vertical)
