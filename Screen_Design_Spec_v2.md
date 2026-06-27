# English Vocabulary Trainer — Detailed Screen-by-Screen UI Specification

Version: 2.0
Platform: Flutter (Android-first, iOS-compatible), offline-first.
Purpose: For each screen, this document lists **everything visible on the page**: app bar, sections, fields, lists, buttons, dialogs, empty/loading/error states, validations, and navigation targets. An implementing agent should be able to build the screen directly from this spec.

Conventions:
- "FIELD" = input control. "BTN" = button. "LIST" = scrollable collection. "CARD" = grouped block. "NAV" = navigation target.
- All labels are English copy ready to paste.

---

## SCREEN 1 — Splash

**Purpose**: brand intro while DB and prefs initialize.

Layout (Stack, centered):
- App logo (120×120)
- App name text "Vocab Trainer" — H1
- Tagline "Learn smarter, remember longer" — Caption muted
- Bottom: CircularProgressIndicator (small)

Logic:
- If `prefs.onboardingCompleted == false` → NAV `/onboarding`.
- Else → NAV `/`.
- Max display 1.5s.

---

## SCREEN 2 — Onboarding Welcome (3-page carousel)

**AppBar**: none (immersive). Top-right: BTN "Skip" (text).

Body (PageView):

### Page 1
- Illustration (SVG, 240×240) — books / brain.
- Title (H1): "Learn English Smarter"
- Body: "The app helps you memorize vocabulary using daily reviews and repetition."

### Page 2
- Illustration: clock + brain.
- Title: "Build Long-Term Memory"
- Body: "Words are reviewed automatically at the best time for memorization."

### Page 3
- Illustration: notebook with sentence.
- Title: "Practice With Real Usage"
- Body: "Write examples and improve contextual understanding."

**Indicator**: SmoothPageIndicator (3 dots, indigo active).

**Bottom bar** (sticky, padding 16):
- BTN "Back" (text, hidden on page 1)
- BTN "Next" (PrimaryButton) — on page 3 becomes **"Get Started"** → NAV onboarding step 3.

---

## SCREEN 3 — Onboarding · Review Frequency

**AppBar**: BackButton, title "Choose your pace", stepper "1 of 3".

Body (ListView, padding 16):
- Subtitle text: "How often do you want to review each word?"
- Selectable cards (4) — radio behavior:
  1. CARD "Light" — subtitle "1 review per word per month" — icon leaf.
  2. CARD "Balanced" — subtitle "2 reviews per word per month" — badge "Recommended" — icon scale.
  3. CARD "Intensive" — subtitle "Daily reviews" — icon flame.
  4. CARD "Custom" — subtitle "Set your own rhythm" — icon sliders — tapping reveals SCREEN 4 fields inline.

Each card shows: title, subtitle, trailing Radio.

**Bottom sticky**: BTN "Continue" (PrimaryButton, disabled until one is selected).

---

## SCREEN 4 — Onboarding · Custom Frequency (conditional)

**AppBar**: title "Custom rhythm", stepper "1 of 3".

Body (Form, padding 16):
- FIELD Slider "Reviews per word" — range 1..10, default 2, suffix label.
- FIELD Dropdown "Review period" — options: Week, Month, Quarter (default Month).
- FIELD Slider "Max daily reviews" — range 5..100, default 20.
- CARD "Live summary" — example: "You'll see 2 reviews per word every month, up to 20 reviews per day."

**Bottom**: BTN "Back" · BTN "Continue".

---

## SCREEN 5 — Onboarding · Notifications

**AppBar**: title "Stay consistent", stepper "2 of 3".

Body (ListView):
- FIELD Switch "Enable daily reminders" (default ON).
- FIELD Tile "Preferred hour" → opens TimePicker (default 19:00). Trailing shows formatted time.
- FIELD Wrap of FilterChips for days: Mon Tue Wed Thu Fri Sat Sun (all selected).
- FIELD Tile "Quiet hours" → opens TimeRangePicker (default 22:00 – 08:00). Trailing shows "22:00 → 08:00".
- Helper text: "We never send more than one reminder per day."

**Bottom**: BTN "Back" · BTN "Finish" (PrimaryButton).

On Finish: save `UserPreferences`, schedule notifications, NAV `/`.

---

## SCREEN 6 — Home Dashboard `/`

**AppBar** (`SliverAppBar`, large):
- Title left: greeting "Good evening, learner" (time-of-day aware).
- Action right: streak chip — flame icon + "7" (current streak). Tap → NAV `/stats`.

Body (CustomScrollView with RefreshIndicator, padding 16):

### Section A — Today's Review Card (elevated Card)
- Header row: H2 "Today's review" + small text "≈ 5 min".
- Row of 3 metric tiles (equal width):
  - "Words" → number (e.g. 7), caption "due".
  - "Verbs" → number (e.g. 3), caption "due".
  - "Time" → "5 min", caption "estimated".
- BTN "Start Review" (PrimaryButton, full width).
- BTN "Skip for today" (text, centered).
- Empty state: icon check_circle teal + "You're all caught up!" + BTN "Browse vocabulary".

### Section B — Statistics Preview (SectionHeader "Your progress" + trailing "See all" → /stats)
- GridView 2×2 of StatCards:
  - "Streak" — value "7 days" — icon flame amber.
  - "Total words" — value "142" — icon menu_book.
  - "Mastered" — value "58" — icon emoji_events teal.
  - "Difficult" — value "12" — icon warning rose.

### Section C — Quick Actions (SectionHeader "Quick actions")
- Wrap (3 columns on phones) of 6 tiles 100×100:
  1. "Add Word" → /vocabulary/add
  2. "Add Verb" → /verbs/add
  3. "Vocabulary" → /vocabulary
  4. "Irregular Verbs" → /verbs
  5. "Statistics" → /stats
  6. "Settings" → /settings

**Bottom navigation**: 5 destinations — Home (active), Vocabulary, Verbs, Stats, Settings.

States:
- Loading: shimmer placeholders on cards.
- Error: inline banner "Couldn't load today's data" + BTN "Retry".

---

## SCREEN 7 — Vocabulary List `/vocabulary`

**AppBar**:
- Title "Vocabulary"
- Actions: search icon, filter icon (badge dot when active).

Top sub-header (sticky):
- Counter chip "142 words"
- Horizontal scroll of category FilterChips ("All", "Travel", "Business", "Daily", "Custom…").

Body:
- **LIST** ListView.separated of WordTile:
  - Leading: colored dot (Easy=teal, Medium=indigo, Hard=amber) + small "★" if mastered.
  - Title: **word** (bold).
  - Subtitle line 1: meaning, single line, ellipsis.
  - Subtitle line 2: row of meta — "Next: in 3d" · "Success 82%" · category chip.
  - Trailing: PopupMenuButton with items: Edit, Mark difficult, Review now, Archive, Delete.

- Empty state: illustration + "No words yet" + BTN "Add your first word".

**FAB**: FloatingActionButton.extended icon=add label="Add word" → /vocabulary/add.

### Search Mode
- Top transforms into SearchBar (autofocus). Live filter on word + meaning + synonyms.
- "Cancel" closes.

### Filter Sheet (modal bottom sheet)
- Title "Filter & sort", close icon.
- Section "Category" — Wrap of ChoiceChips.
- Section "Difficulty" — ChoiceChips Easy / Medium / Hard.
- Section "Status" — Switches: Show forgotten, Show mastered, Show archived.
- Section "Sort by" — Radio list: Newest, Oldest, Alphabetical (A→Z), Most difficult.
- Sticky bottom: BTN "Reset" (outlined) · BTN "Apply" (filled).

---

## SCREEN 8 — Add / Edit Word `/vocabulary/add` · `/vocabulary/:id/edit`

**AppBar**: BackButton, title "Add word" or "Edit word", action BTN "Save" (disabled until valid).

Body (Form, ListView, padding 16, sections separated by SectionHeader):

### Required
- FIELD TextFormField "Word *" — max 100, autofocus, suffixCounter.
- FIELD TextFormField "Meaning *" — multiline 2..5.

### Pronunciation
- FIELD TextFormField "Pronunciation (IPA)" — placeholder "/rɪˈzɪljənt/".
- BTN icon speaker — preview TTS.

### Examples (max 10)
- Dynamic list. Each row:
  - TextFormField "Example sentence"
  - IconButton delete
- BTN "+ Add example" (outlined, full width, hidden when 10 reached).

### Categorization
- FIELD Autocomplete "Category" — suggestions from existing categories + free text.
- FIELD ChipsInput "Synonyms" — comma/enter to add.
- FIELD ChipsInput "Antonyms" — comma/enter to add.

### Notes
- FIELD TextFormField "Notes" — multiline 3..6, optional.

### Difficulty (edit mode only)
- Segmented "Easy | Medium | Hard".

**Bottom sticky**: BTN "Save" (PrimaryButton, full width, mirrors AppBar action).

Validation messages (inline):
- Word: "Required", "Max 100 characters".
- Meaning: "Required".
- Examples: enforce ≤ 10, disable add button.

On save (new): generate UUID, set nextReviewAt = now + 1d, snackBar "Word saved", pop.
On save (edit): update, snackBar "Updated", pop.

---

## SCREEN 9 — Word Detail `/vocabulary/:id`

**AppBar**: BackButton, title = word, actions: Edit icon, overflow (Archive, Delete).

Body (ScrollView, padding 16):

### Header card
- word (Display, 36, bold)
- Row: pronunciation text + BTN speaker (TTS)
- Chips row: difficulty chip + category chip + "Mastered" badge if applicable.

### Meaning block
- SectionHeader "Meaning"
- Paragraph text.

### Examples
- SectionHeader "Examples" + count.
- LIST bulleted, each italic; user-generated ones tagged "your example" small.

### Synonyms / Antonyms (two columns)
- Wrap of chips; empty placeholder "—".

### Notes
- SectionHeader "Notes"
- Paragraph or "No notes yet".

### Stats card
- Row of 3 mini-stats: Success rate %, Total reviews count, Next review (date · relative "in 3d").

### Bottom actions (sticky bar)
- BTN "Review now" (Primary) → starts single-word review session.
- BTN icon Edit → edit screen.
- BTN icon Archive → confirm → archive.
- BTN icon Delete (rose) → AlertDialog "Delete 'resilient'? This cannot be undone." Cancel / Delete.

---

## SCREEN 10 — Review Session `/review`

**No bottom nav. No back gesture without confirm.**

Top bar:
- Close icon (×) — confirm dialog if mid-session.
- Linear progress bar (current/total).
- Counter text "3 / 12" right.

Body — state machine:

### Step A · Show Word
- Centered word (Display 48).
- Below: small caption "Try to recall the meaning".
- Row of icon buttons: speaker (TTS), star (mark difficult), eye-off (skip card).
- Bottom BTN "Show meaning" (PrimaryButton).

### Step B · Recall typing (only if `typingMode` enabled)
- Centered TextField "Type the meaning…" (multiline 2).
- BTN "Reveal" + BTN "Skip" (text).

### Step C · Reveal Answer
- CARD scroll:
  - Meaning (H2 + body)
  - Examples list
  - Synonyms chips
  - Notes
- BTN "Continue" (PrimaryButton).

### Step D · Usage Practice
- Prompt H2 "Write a new example using this word."
- FIELD TextField multiline 3 — placeholder "She remained ___ after failure."
- BTN "Save & continue" (Primary) · BTN "Skip" (text).

### Step E · Result Buttons (Grade)
- Row of 4 full-width pill buttons stacked or 2×2:
  - "Forgot" rose · "Hard" amber · "Good" indigo · "Easy" teal.
- Each shows secondary line "see again in 1d / 3d / 7d / 15d".
- Tap → SRS update → animate next card (FadeThrough).

Exit confirm dialog:
- Title "End review?"
- Body "You've reviewed 3 of 12 words. Progress will be saved."
- BTN "Continue review" (text) · BTN "End now" (Primary).

---

## SCREEN 11 — Review Session Summary

Shown after last card. No app bar.

Body (centered, padding 24):
- Lottie confetti above.
- H1 "Great session!"
- Stats LIST:
  - "Words reviewed: 12"
  - "Correct: 9 (75%)"
  - "Time spent: 4 min 32 s"
  - "Streak: 8 days 🔥"
- Insights chip "Difficult: 'eloquent', 'perseverance'" tappable → opens filtered vocab list.

Bottom:
- BTN "Review mistakes" (outlined) — only if mistakes >0.
- BTN "Done" (Primary) → NAV `/`.

---

## SCREEN 12 — Irregular Verbs Home `/verbs`

**AppBar**: title "Irregular Verbs", actions: search, filter.

Body (CustomScrollView):

### Today's Verb Review CARD
- "5 verbs to review · ≈ 3 min"
- BTN "Start review" → opens SCREEN 13 (mode picker).

### Difficult Verbs (horizontal LIST)
- SectionHeader "Difficult" + "See all".
- Horizontal ListView of VerbChip cards (140 wide): base / past / participle stacked.

### Mastered Verbs (horizontal LIST)
- Same shape, teal accent.

### Recent Mistakes (LIST, max 3)
- Each row: verb forms + last mistake date + BTN "Practice".

### All Verbs by Pattern (ExpansionPanelList)
- Each panel = pattern group, e.g. "i → a → u (sing/sang/sung)":
  - LIST of verbs inside.

**FAB**: BTN "+ Add verb" → /verbs/add.

Empty: "No verbs yet" + BTN "Use built-in library" (loads 100 common verbs).

---

## SCREEN 13 — Verb Review Mode Picker (modal bottom sheet)

Title "Choose review mode", close icon.

5 large ListTiles, each with icon + title + subtitle:
1. **Classic Review** — "Show base form, recall past + participle."
2. **Missing Form Quiz** — "Fill the missing verb form."
3. **Reverse Quiz** — "Show participle, guess the base."
4. **Typing Mode** — "Type all forms exactly."
5. **Multiple Choice** — "Pick the correct form out of four."

Tap → NAV `/verbs/review?mode=…`.

---

## SCREEN 14 — Verb Review Session `/verbs/review`

Shared shell: × close, progress bar, counter.

### Mode: Classic
- Centered base form (Display).
- BTN "Show answer" → reveals "went · gone".
- Grade buttons (Forgot/Hard/Good/Easy).

### Mode: Missing Form
- Display "go → went → ___"
- FIELD TextField centered.
- BTN "Check" → flash teal/rose → grade buttons.

### Mode: Reverse
- Centered participle.
- FIELD or BTN "Show base".

### Mode: Typing
- Three FIELDS stacked: Base / Past / Past participle (one shown, rest as inputs).
- BTN "Check" → result per field (✓/✗) → grade buttons.

### Mode: Multiple Choice
- Prompt "eat → ___ (past participle)"
- 4 ChoiceChip-like big buttons stacked: eaten / eated / eating / ate.
- Correct flashes teal, wrong rose; reveal correct.
- Auto-advance after 1s OR grade buttons appear.

---

## SCREEN 15 — Add / Edit Verb `/verbs/add` · `/verbs/:id/edit`

**AppBar**: title "Add verb" / "Edit verb", BTN "Save".

Body (Form):
- FIELD TextFormField "Base form *" — placeholder "go".
- FIELD TextFormField "Past simple *" — placeholder "went".
- FIELD TextFormField "Past participle *" — placeholder "gone".
- FIELD TextFormField "Meaning" — optional.
- Dynamic Examples list (max 5) — same pattern as words.
- Segmented "Difficulty" Easy / Medium / Hard.
- Optional FIELD Autocomplete "Pattern group" — suggestions from existing groups.

Validation: 3 forms required, each ≤ 50 chars.

---

## SCREEN 16 — Verb Detail `/verbs/:id`

**AppBar**: BackButton, title base form, actions Edit, Delete.

Body:
- Three-column header (large):
  - Base "go" | Past "went" | Participle "gone"
- Meaning paragraph.
- Examples LIST.
- Pattern group chip → NAV pattern list.
- Stats row: Success %, Reviews, Next review.
- Bottom actions: BTN "Review now", icons Edit, Delete.

---

## SCREEN 17 — Statistics `/stats`

**AppBar**: title "Progress", action icon download (export PNG).

Body (ScrollView, padding 16):

### Range selector
- SegmentedButton: Week | Month | All (default Month).

### KPI strip (horizontal scroll of StatCards)
- Total words · Mastered · Difficult · Streak · Success % · Total reviews.

### Chart 1 — Weekly Progress
- SectionHeader "Reviews per day"
- BarChart (fl_chart) — last 7/30 days, indigo bars.

### Chart 2 — Review Consistency
- SectionHeader "Consistency"
- Heatmap grid 7×12 (weekday × week) — color intensity = reviews count. Tap cell → tooltip date + count.

### Chart 3 — Vocabulary Growth
- SectionHeader "Vocabulary growth"
- LineChart cumulative count over time.

### Chart 4 — Difficult Categories
- SectionHeader "Where you struggle"
- Horizontal BarChart by category, sorted desc.

### Insights CARD
- Up to 3 bullets, each with icon:
  - "You improve faster in Travel vocabulary."
  - "Irregular verbs remain your weakest area."
  - "Best review time for you: 19:00 – 20:00."

Empty (under 7 days data): illustration + "Keep learning — insights appear after a week."

---

## SCREEN 18 — Settings `/settings`

**AppBar**: title "Settings".

Body (ListView, sectioned):

### Profile
- ListTile leading avatar, title display name (editable via dialog), subtitle "Local profile".

### Learning
- ListTile "Notifications" → /settings/notifications, trailing chevron.
- ListTile "Learning preferences" → /settings/learning.
- ListTile "Archive" → /archive.

### Data
- ListTile "Data & backup" → /settings/data.

### Appearance
- ListTile "Theme" → bottom sheet (System / Light / Dark).
- ListTile "Language" → bottom sheet (English).

### About
- ListTile "App version" — trailing "1.0.0".
- ListTile "Open-source licenses" → showLicensePage.
- ListTile "Privacy policy" → in-app webview / static page.

---

## SCREEN 19 — Notification Settings `/settings/notifications`

**AppBar**: title "Notifications".

Body (ListView):
- Switch "Enable reminders".
- Tile "Reminder time" → TimePicker.
- Tile "Quiet hours" → TimeRangePicker.
- Tile "Allowed days" → opens dialog with Mon–Sun FilterChips.
- Slider "Daily review limit" 5..100.
- Switch "Direct recall notifications" ("What does 'X' mean?").
- Switch "Motivation messages".
- BTN "Send test notification" (outlined, full width).

---

## SCREEN 20 — Learning Settings `/settings/learning`

Body:
- Tile "Review intensity" → opens frequency sheet (reuses SCREEN 3/4).
- Switch "Typing mode during review".
- Switch "Show examples during recall".
- Tile "Default verb review mode" → bottom sheet (5 modes).
- Tile "Text-to-speech voice" → opens TTS picker (voice, speed Slider 0.5..1.5).
- Switch "Auto-play pronunciation".

---

## SCREEN 21 — Data Settings `/settings/data`

Body, grouped tiles:

### Backup
- BTN tile "Export data (JSON)" → share_plus sheet.
- BTN tile "Create local backup" → saves to Downloads, shows snackBar with path.

### Restore
- BTN tile "Import from file" → file_picker → diff dialog "Adds 23 words, updates 4. Continue?" Cancel / Import.

### Reset
- BTN tile "Reset statistics" (amber) → confirm dialog.
- BTN tile "Erase all data" (rose) → double confirm with typed word "DELETE".

---

## SCREEN 22 — Archive `/archive`

**AppBar**: title "Archive", action filter.

Body:
- Subheader "23 archived words".
- LIST identical to Vocabulary List, but trailing menu:
  - BTN "Restore" → returns to active list.
  - BTN "Delete permanently" → confirm.

Empty: "No archived words yet."

---

## SCREEN 23 — Search (full-screen, optional)

Triggered from any list search icon.
- TextField autofocus with clear icon.
- Tabs "Words" | "Verbs".
- LIST of matches, grouped by relevance, highlight matched substring.
- Tap result → corresponding detail screen.

---

## SCREEN 24 — Error / 404 (in-app)

- Icon error_outline 64.
- H2 "Something went wrong".
- Body of error message (debug build only).
- BTN "Retry" · BTN "Go home".

---

## Component Reference (used across screens)

### WordTile
- Leading: Container 10×10 colored dot (difficulty) + optional star.
- Title: Text(word, weight 600).
- Subtitle: meaning line + meta row.
- Trailing: PopupMenuButton (Edit · Mark difficult · Review now · Archive · Delete).

### VerbChip
- Container 140×96, radius 16, soft surface color.
- Three lines: base (bold), past, participle.
- Bottom-right small difficulty dot.

### StatCard
- Padding 16, radius 16.
- Caption label (muted) + Value (H1 bold) + optional delta (e.g. "+3 this week").

### PrimaryButton
- FilledButton, height 52, radius 12, full width.

### SectionHeader
- Row: H2 + optional trailing TextButton "See all".

### EmptyState
- Centered: icon 56 muted, H2 title, body caption, optional CTA button.

---

## Global Acceptance Rules (every screen)

- Light + dark themes render correctly.
- All taps ≥ 48×48.
- Every list defines: loading shimmer, empty state, error state.
- Every form defines: required field markers (*), inline errors, disabled Save until valid.
- Every destructive action requires confirm dialog.
- Every successful action shows a SnackBar with optional Undo where reversible.
- Works fully offline.
- After any DB mutation, notifications are rescheduled.

End of detailed UI specification.
