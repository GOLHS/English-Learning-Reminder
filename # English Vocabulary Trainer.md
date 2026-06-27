# English Vocabulary Trainer

# Detailed Feature Specification

Version: 1.0

Platform:

* Flutter Mobile Application
* Android First
* iOS Compatible

Architecture:

* Offline First
* Local Notifications
* Local Database Storage

Primary Objective:
Help users memorize English vocabulary and irregular verbs using active recall and spaced repetition.

---

# FEATURE 1 — APPLICATION ONBOARDING

# Goal

Allow the user to configure the learning system during first launch.

---

# Functional Flow

## First Launch

When the application opens for the first time:

* display welcome screens
* explain core concept
* configure learning preferences

---

# Welcome Screens

## Screen 1

Title:
Learn English Smarter

Description:
The app helps memorize vocabulary using daily reviews and repetition.

---

## Screen 2

Title:
Build Long-Term Memory

Description:
Words are reviewed automatically at the best time for memorization.

---

## Screen 3

Title:
Practice With Real Usage

Description:
Write examples and improve contextual understanding.

---

# Initial Configuration

## Review Frequency Selection

User chooses:

* light learning
* balanced learning
* intensive learning
* custom mode

---

## Custom Frequency Options

Fields:

* reviews per word
* review period
* max daily reviews

Example:
2 reviews per word every month.

---

## Notification Configuration

Fields:

* preferred hour
* allowed days
* enable/disable notifications

---

# Result

Configuration saved locally.

---

# FEATURE 2 — HOME DASHBOARD

# Goal

Provide quick access to learning activity and daily progress.

---

# Home Screen Sections

## Today Review Card

Displays:

* words waiting for review
* irregular verbs waiting
* estimated review duration

Buttons:

* Start Review
* Skip

---

## Learning Statistics Preview

Displays:

* current streak
* total words
* mastered words
* difficult words

---

## Quick Actions

Buttons:

* Add Word
* Add Verb
* Vocabulary List
* Irregular Verbs
* Statistics
* Settings

---

# FEATURE 3 — VOCABULARY MANAGEMENT

# Goal

Allow users to manage vocabulary entries.

---

# Add Word Flow

## Entry Screen Fields

### Required

* word
* meaning

### Optional

* examples
* notes
* category
* synonyms
* antonyms
* pronunciation

---

# Example

Word:
resilient

Meaning:
able to recover quickly after difficulty

Example:
She remained resilient after failure.

---

# Save Logic

When saving:

* generate unique ID
* calculate initial review date
* add to review engine
* update notification queue

---

# Validation Rules

## Word

* cannot be empty
* max length 100

## Meaning

* cannot be empty

## Examples

* optional
* max 10 examples

---

# Vocabulary List Screen

Displays:

* word
* difficulty
* next review date
* success rate

---

# Vocabulary Actions

Each word supports:

* edit
* delete
* archive
* review now
* mark difficult

---

# Search & Filtering

Filters:

* category
* difficulty
* forgotten words
* mastered words
* archived words

Sorting:

* newest
* oldest
* alphabetical
* most difficult

---

# FEATURE 4 — REVIEW ENGINE

# Goal

Reinforce memory using active recall.

---

# Daily Review Preparation

Every day the system:

* checks due words
* calculates priorities
* distributes review load
* prepares review session

---

# Review Priority Rules

Higher priority:

* forgotten words
* difficult words
* overdue reviews

Lower priority:

* mastered words

---

# Review Session Flow

## Step 1 — Show Word

Visible:

* word only

Hidden:

* meaning
* examples

Optional:

* pronunciation button

---

## Step 2 — Recall Phase

User mentally remembers:

* meaning
* usage

Optional:

* user types answer

---

## Step 3 — Reveal Answer

The app displays:

* meaning
* examples
* notes
* synonyms

---

## Step 4 — Usage Practice

Prompt:
“Write a new example sentence.”

The user example is saved.

---

## Step 5 — Review Result

Buttons:

* Easy
* Good
* Hard
* Forgot

---

# Scheduling Logic

## Easy

Increase interval significantly.

## Good

Increase interval normally.

## Hard

Small interval increase.

## Forgot

Reset interval.

---

# FEATURE 5 — SPACED REPETITION SYSTEM

# Goal

Optimize memorization timing.

---

# Scheduling Inputs

The engine uses:

* review history
* success rate
* difficulty
* overdue status
* user settings

---

# Example Intervals

| Result | Next Review |
| ------ | ----------- |
| Forgot | 1 day       |
| Hard   | 3 days      |
| Good   | 7 days      |
| Easy   | 15 days     |

---

# Adaptive Learning

If the user repeatedly forgets a word:

* difficulty increases
* review frequency increases

If the user consistently succeeds:

* difficulty decreases
* review frequency decreases

---

# FEATURE 6 — NOTIFICATION SYSTEM

# Goal

Trigger learning sessions automatically.

---

# Notification Types

## Daily Review Reminder

“You have 7 words waiting for review.”

---

## Direct Recall

“What does ‘accurate’ mean?”

---

## Motivation

“You completed reviews for 5 consecutive days.”

---

# Notification Rules

The system must:

* avoid spam
* respect quiet hours
* batch reviews intelligently

---

# Notification Scheduling

Notifications generated:

* locally
* offline
* automatically rescheduled after reboot

---

# FEATURE 7 — IRREGULAR VERBS MODULE

# Goal

Help users memorize English irregular verbs through repetition and quizzes.

---

# Verb Data Structure

Each verb contains:

| Field           | Example      |
| --------------- | ------------ |
| Base Form       | go           |
| Past Simple     | went         |
| Past Participle | gone         |
| Meaning         | move/travel  |
| Examples        | I went home. |
| Difficulty      | Medium       |
| Review Score    | 0            |

---

# Verb Source Modes

## Built-In Library (Primary)

The app includes:

* common irregular verbs
* categorized verb groups

Examples:

* begin → began → begun
* speak → spoke → spoken

---

## Manual Addition (Optional)

The user may add custom verbs.

---

# Irregular Verb Home

Sections:

* today reviews
* difficult verbs
* mastered verbs
* recent mistakes

---

# Verb Review Modes

# Mode 1 — Classic Review

Display:
go

User recalls:
went / gone

---

# Mode 2 — Missing Form Quiz

Display:
go → went → ?

Expected:
gone

---

# Mode 3 — Reverse Quiz

Display:
gone

Expected:
go

---

# Mode 4 — Typing Mode

The user manually types answers.

Validation:

* exact match
* ignore case sensitivity

---

# Mode 5 — Multiple Choice

The app proposes:
eat → ?

* eaten
* eated
* eating
* ate

---

# Verb Difficulty Logic

If repeatedly forgotten:

* move to difficult list
* review frequency increases

---

# Verb Pattern Groups

The app groups similar verbs.

Examples:

* sing / sang / sung
* ring / rang / rung

This improves pattern recognition.

---

# FEATURE 8 — STATISTICS & PROGRESS

# Goal

Motivate users and visualize learning progress.

---

# Statistics Dashboard

Displays:

* total words
* mastered words
* difficult words
* review streak
* success rate
* total reviews

---

# Charts

Possible charts:

* weekly progress
* review consistency
* vocabulary growth
* difficult categories

---

# Insights

Examples:

* “You improve faster in Travel vocabulary.”
* “Irregular verbs remain your weakest area.”

---

# FEATURE 9 — SETTINGS

# Goal

Allow user customization.

---

# Notification Settings

Fields:

* notification time
* daily review limit
* quiet hours
* enable/disable reminders

---

# Learning Settings

Fields:

* review mode
* typing mode
* review intensity
* pronunciation options

---

# Data Settings

Actions:

* export data
* import data
* reset statistics
* backup

---

# FEATURE 10 — ARCHIVE SYSTEM

# Goal

Remove mastered words from active learning without deletion.

---

# Archive Behavior

Archived words:

* excluded from reviews
* preserved in database
* restorable anytime

---

# FEATURE 11 — FUTURE AI FEATURES

# AI Sentence Correction

The app analyzes:

* grammar
* vocabulary usage
* sentence naturalness

---

# AI Vocabulary Recommendation

The app suggests words based on:

* weak categories
* user activity
* forgotten words

---

# AI Conversation Practice

Interactive conversation sessions using learned vocabulary.

---

# FEATURE 12 — OFFLINE-FIRST REQUIREMENTS

# Core Rule

The application must fully work without internet.

---

# Offline Features

Available offline:

* vocabulary storage
* reviews
* notifications
* statistics
* irregular verbs

---

# Future Sync

If cloud sync added later:

* local-first synchronization required

---

# FEATURE 13 — PERFORMANCE REQUIREMENTS

# Requirements

The app must:

* launch quickly
* support thousands of words
* minimize battery consumption
* schedule notifications efficiently

---

# FEATURE 14 — UX REQUIREMENTS

# Design Philosophy

The app should feel:

* minimal
* calm
* distraction-free
* learning-focused

---

# UX Rules

Avoid:

* aggressive gamification
* overwhelming notifications
* complicated forms

Prefer:

* fast actions
* clean interfaces
* smooth review flow

---

# FEATURE 15 — MVP PRIORITIES

# Phase 1

* local database
* add/edit/delete words
* review engine
* notifications
* irregular verbs

---

# Phase 2

* statistics
* filters
* archive system

---

# Phase 3

* AI assistance
* cloud sync
* pronunciation
* advanced analytics

---
