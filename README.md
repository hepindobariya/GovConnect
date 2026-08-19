# GovConnect — Government Scheme Recommendation App (Product Workspace)

**GovConnect** (working title) is a Flutter-based Government Scheme Recommendation App for India that recommends only the Central & State welfare schemes a citizen is *actually eligible for* — replacing hours of portal-hopping with a single personalized feed. This workspace is the single source of truth for product, UX, and engineering.

> **Doc owner:** Hepin Dobariya · **Status:** Draft v1.0 · **Stack:** Flutter + Firebase · **Region:** India-first

---

## 📑 Table of Contents

1. Executive Summary
2. Problem Statement
3. Objectives
4. Target Users
5. User Personas
6. User Journey
7. Features
8. Functional Requirements
9. Non-Functional Requirements
10. App Architecture
11. Database Design
12. Recommendation Algorithm
13. UI Pages
14. Wireframes
15. Color Palette
16. Typography & UI Kit
17. Roadmap
18. Risks
19. Future Scope
20. Monetization

---

# 1. 🎯 Executive Summary

**The Problem.** India runs *hundreds* of Central and State welfare schemes across scholarships, pensions, farming subsidies, housing, healthcare, and business support. Yet most eligible citizens never claim their benefits — not because they don't qualify, but because they never discover the schemes, can't decode the eligibility rules, or can't navigate fragmented government portals.

**Target Audience.** Students, senior citizens, farmers, women, job seekers, MSME owners, disabled citizens, and low-income families — with a strong focus on rural, elderly, and first-time smartphone users.

**The Solution.** GovConnect asks a citizen a short, plain-language eligibility questionnaire (age, income, gender, occupation, state, category, etc.) and uses a **rule-based recommendation engine** to surface *only* the schemes they qualify for. Each scheme card explains benefits, documents required, and a direct link to the official application — in the user's own language.

**Market Gap.** Existing government portals (MyScheme, state portals) are *information repositories*, not *personalized advisors*. They are search-heavy, English/Hindi-dominant, and assume the user already knows what to look for. GovConnect flips this: it tells you what you're eligible for before you even ask.

**Vision.** *"Every Indian citizen discovers and claims every benefit they are entitled to — in their language, in under 5 minutes."* GovConnect aims to become the default benefits discovery layer for India, eventually assisting with document readiness and application tracking.

---

# 2. 🧩 Problem Statement

Access to welfare in India is limited less by *eligibility* and more by *discoverability and usability*.

| # | Problem | Why it matters |
|---|---------|----------------|
| 1 | India has **hundreds of welfare schemes** across Central + 28 States + 8 UTs | Sheer volume makes manual discovery impossible for a citizen |
| 2 | **Citizens don't know which schemes they qualify for** | Benefits go unclaimed; leakage of intended welfare |
| 3 | **Portals are information-heavy, not personalized** | Users must self-diagnose eligibility from dense legal text |
| 4 | **Rural & elderly users struggle to navigate** | Low digital literacy + English/Hindi-only UIs exclude them |
| 5 | **Users waste time across multiple websites** | Central, state, and departmental portals are fragmented |

> 📊 **Context (illustrative — verify before publishing):** India has 900M+ internet users and 750M+ smartphone users, yet a large share of eligible beneficiaries remain unaware of schemes meant for them. Awareness — not eligibility — is the primary barrier. *(Replace with cited figures from MyScheme / NITI Aayog / NSSO before any external use.)*

**Consequence:** Welfare that is *funded and available* never reaches the intended citizen. GovConnect closes the **awareness-to-application gap**.

---

# 3. 🎯 Objectives

### ⚙️ Functional Objectives
- Recommend schemes based on a rule-based eligibility engine
- Support Central + State scheme datasets with structured eligibility criteria
- Provide a short, plain-language eligibility questionnaire
- Enable search, filtering, and bookmarking of schemes
- Deliver scheme detail pages with benefits, documents, and official apply links
- Support multilingual UI (regional languages)
- Send deadline & new-scheme notifications

### 💼 Business Objectives
- Achieve high scheme-discovery-to-official-site conversion
- Build a maintainable, verifiable scheme database as a defensible asset
- Establish partnerships with government bodies, NGOs, and CSR sponsors
- Reach sustainable monetization without compromising free citizen access

### 🤝 Social Objectives
- Increase welfare scheme awareness among underserved groups
- Reduce welfare leakage caused by lack of information
- Make benefits accessible to low-literacy, elderly, and rural users
- Promote digital and financial inclusion

---

# 4. 👥 Target Users

| Segment | 😣 Pain Points | 🎯 Goals | 📱 App Usage |
|---------|----------------|----------|--------------|
| **Students** | Don't know which scholarships apply; miss deadlines | Find & apply to scholarships, education loans | Eligibility quiz → scholarship feed → deadline alerts |
| **Senior Citizens** | Complex portals; unaware of pension schemes | Access pensions, healthcare, senior benefits | Simple guided flow, large fonts, voice assist |
| **Farmers** | Miss subsidies, PM-KISAN, crop insurance | Discover farming subsidies & insurance | State + category filter, regional language |
| **Women** | Unaware of maternity, safety, self-help schemes | Access women-focused welfare & loans | Gender-based recommendations, alerts |
| **Job Seekers** | Don't know skill/employment schemes | Find skilling, stipend, employment schemes | Occupation-based feed, apply links |
| **MSME Owners** | Miss business loans, subsidies, credit schemes | Discover MSME/business support | Business-owner filter, document checklist |
| **Disabled Citizens** | Hard to find disability-specific benefits | Access disability pensions, aids, reservations | Disability flag → tailored feed, accessible UI |
| **Low-income Families** | Unaware of ration, housing, health schemes | Access food security, PMAY, Ayushman | Income-based feed, offline access |
| **General Citizens** | Overwhelmed by scattered info | One place for all eligible schemes | Personalized home feed, search |

---

# 5. 🧑‍🤝‍🧑 User Personas

### Persona 1 — Ramesh (Farmer)
| Attribute | Detail |
|---|---|
| **Age** | 48 |
| **Occupation** | Small-scale farmer (2 acres) |
| **Income** | ₹1.2 LPA |
| **Tech Literacy** | Low — uses WhatsApp & YouTube only |
| **Goals** | Get PM-KISAN, crop insurance, fertilizer subsidy |
| **Frustrations** | Can't read English portals; relies on agents who charge fees |

### Persona 2 — Priya (Student)
| Attribute | Detail |
|---|---|
| **Age** | 19 |
| **Occupation** | Undergraduate student |
| **Income** | Family income ₹3 LPA |
| **Tech Literacy** | High — smartphone-native |
| **Goals** | Find scholarships, never miss deadlines |
| **Frustrations** | Too many portals; unclear eligibility; missed a scholarship deadline last year |

### Persona 3 — Lakshmi (Senior Citizen)
| Attribute | Detail |
|---|---|
| **Age** | 67 |
| **Occupation** | Retired homemaker |
| **Income** | ₹0 (dependent) |
| **Tech Literacy** | Very low — needs help operating phone |
| **Goals** | Old-age pension, free healthcare (Ayushman) |
| **Frustrations** | Small fonts, English UI, complex steps |

### Persona 4 — Anil (MSME Owner)
| Attribute | Detail |
|---|---|
| **Age** | 35 |
| **Occupation** | Owns a small manufacturing unit |
| **Income** | ₹8 LPA |
| **Tech Literacy** | Medium-high |
| **Goals** | Access MUDRA/CGTMSE loans, subsidies |
| **Frustrations** | Doesn't know which credit schemes apply; paperwork confusion |

### Persona 5 — Sunita (Woman / Job Seeker)
| Attribute | Detail |
|---|---|
| **Age** | 27 |
| **Occupation** | Unemployed graduate, seeking work |
| **Income** | ₹0 personal |
| **Tech Literacy** | Medium |
| **Goals** | Skilling programs, women's self-employment loans, stipends |
| **Frustrations** | Overwhelmed by scattered info; unsure what she qualifies for |

---

# 6. 🧭 User Journey

```text
Splash Screen
   ↓
Language Selection   (English / Hindi / regional)
   ↓
Login / Guest        (phone OTP or continue as guest)
   ↓
Eligibility Questionnaire   (age, income, gender, state, occupation, category...)
   ↓
Recommendation Engine   (rule-based match → eligible schemes)
   ↓
Scheme Details       (benefits, documents, eligibility, deadlines)
   ↓
Bookmark             (save for later)
   ↓
Official Website     (deep link to gov portal)
   ↓
Apply                (user applies on official portal)
```

**Journey notes**
- **Guest mode** lets users get recommendations without signup (reduces drop-off); bookmarks/notifications prompt for login.
- The questionnaire is **progressive** — each answer narrows results; users can edit answers anytime from Profile.
- GovConnect **does not submit applications itself** (v1) — it routes users to the official portal to maintain trust and legal safety.

---

# 7. ✨ Features

### 🚀 MVP Features
- Language selection (English, Hindi + 1–2 regional to start)
- Phone OTP login + Guest mode
- Eligibility questionnaire
- Rule-based recommendation engine
- Scheme feed (personalized home)
- Scheme search + filters
- Scheme detail page (benefits, docs, apply link)
- Bookmarks
- Basic push notifications (deadlines, new schemes)
- Profile with editable eligibility answers
- Admin panel to manage scheme data

### 🔮 Future Features
- Full multilingual coverage (10+ languages)
- Deadline reminder engine with calendar sync
- Document checklist per scheme with readiness tracking
- Application status tracking
- Family profile (manage benefits for multiple members)
- In-app scheme comparison

### 💡 Nice-to-Have Features
- AI chatbot assistant
- Voice-based navigation for low-literacy users
- OCR document checker
- Offline mode with cached schemes
- Share scheme via WhatsApp
- Dark mode

---

# 8. 📋 Functional Requirements

| ID | Requirement | Description | Priority |
|---|---|---|---|
| **FR-001** | User Registration & Auth | Phone OTP login via Firebase Auth; guest mode; session persistence | High |
| **FR-002** | Language Selection | Select UI language at first launch; changeable from settings | High |
| **FR-003** | Eligibility Questionnaire | Collect age, income, gender, state, occupation, category, education, disability, minority, farmer, business-owner flags | High |
| **FR-004** | Recommendation Engine | Match user profile against scheme eligibility rules; return only eligible schemes ranked by relevance | High |
| **FR-005** | Scheme Search | Keyword search across scheme name, category, description | High |
| **FR-006** | Filters | Filter by state, category, benefit type, target group | High |
| **FR-007** | Scheme Detail | Show benefits, eligibility, documents, deadline, official link | High |
| **FR-008** | Bookmark | Save/unsave schemes; view bookmarked list (login required) | Medium |
| **FR-009** | Notifications | Push alerts for new schemes & approaching deadlines | Medium |
| **FR-010** | Profile Management | View/edit eligibility answers; language & notification prefs | High |
| **FR-011** | Feedback | Submit feedback / report incorrect scheme data | Medium |
| **FR-012** | Admin Panel | CRUD schemes, states, categories; manage eligibility rules; review feedback | High |
| **FR-013** | Official Apply Redirect | Deep-link/open official government portal in browser | High |
| **FR-014** | Offline Cache | Cache last-fetched schemes for offline viewing | Low |

---

# 9. 🛡️ Non-Functional Requirements

| Category | Requirement |
|---|---|
| **⚡ Performance** | Home feed & recommendations load < 2s on 3G/4G; questionnaire results in < 1s; lazy-load scheme lists |
| **🔐 Security** | Firebase Auth; Firestore security rules; encrypted data in transit (HTTPS); minimal PII stored; consent for sensitive fields (caste, disability); comply with India DPDP Act |
| **♿ Accessibility** | WCAG AA contrast; scalable fonts; screen-reader labels; large tap targets; voice support (future); simple guided flows for low-literacy users |
| **📴 Offline Support** | Cache schemes & bookmarks locally; graceful offline messaging; sync on reconnect |
| **📈 Scalability** | Firestore + Cloud Functions auto-scale; paginated queries; indexed scheme collection to handle 1000s of schemes & high read volume |
| **🌐 Localization** | Full i18n framework; RTL-safe; regional language content for scheme data & UI strings |
| **🧰 Maintainability** | Clean architecture, modular Flutter code, documented scheme data schema |
| **🕓 Availability** | Target 99.5% uptime; graceful degradation when gov links are down |

---

# 10. 🏗️ App Architecture

```text
┌─────────────────────────────┐
│        Flutter App          │  UI, state mgmt (Riverpod/BLoC), i18n
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│       Firebase Auth         │  Phone OTP, guest, session
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│         Firestore           │  Users, Schemes, Bookmarks, etc.
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│      Cloud Functions        │  Recommendation logic, notifications, admin ops
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│      Firebase Storage       │  Scheme images, icons, docs
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│    Notification Service     │  FCM push (deadlines, new schemes)
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│  Government API / Manual DB  │  Scheme source data (curated + verified)
└─────────────────────────────┘
```

**Architecture decisions**
- **Client:** Flutter (single codebase, Android-first for India), Riverpod or BLoC for state, `intl`/`easy_localization` for i18n.
- **Recommendation:** Runs as a **Cloud Function** (or client-side for simple rules in MVP) so rules can change without app updates.
- **Scheme data:** Curated **manual database** in v1 (government APIs are inconsistent); designed to swap in official APIs later.
- **Notifications:** FCM triggered by scheduled Cloud Functions checking deadlines.

---

# 11. 🗄️ Database Design (Firestore Collections)

### `users`
| Field | Type | Description |
|---|---|---|
| `uid` | string | Firebase Auth UID |
| `phone` | string | Phone number |
| `name` | string | Optional display name |
| `language` | string | Preferred language code |
| `age` | number | Age |
| `gender` | string | male / female / other |
| `income` | number | Annual income (₹) |
| `state` | string | State code |
| `occupation` | string | Occupation category |
| `category` | string | General / OBC / SC / ST |
| `education` | string | Education level |
| `isDisabled` | boolean | Disability flag |
| `isMinority` | boolean | Minority flag |
| `isFarmer` | boolean | Farmer flag |
| `isBusinessOwner` | boolean | Business-owner flag |
| `createdAt` | timestamp | Created |
| `updatedAt` | timestamp | Last profile update |

### `schemes`
| Field | Type | Description |
|---|---|---|
| `schemeId` | string | Unique ID |
| `title` | map | Localized name |
| `description` | map | Localized summary |
| `category` | string | Ref to categories |
| `level` | string | central / state |
| `state` | string | State code (null if central) |
| `benefits` | string | Benefit description |
| `documents` | array | Required documents |
| `eligibility` | map | Rule object (see §12) |
| `officialUrl` | string | Apply/official link |
| `deadline` | timestamp | Application deadline (nullable) |
| `iconUrl` | string | Storage image URL |
| `isActive` | boolean | Visible or archived |
| `updatedAt` | timestamp | Last verified/updated |

### `bookmarks`
| Field | Type | Description |
|---|---|---|
| `bookmarkId` | string | Unique ID |
| `uid` | string | Owner |
| `schemeId` | string | Ref to scheme |
| `createdAt` | timestamp | Saved at |

### `notifications`
| Field | Type | Description |
|---|---|---|
| `notificationId` | string | Unique ID |
| `uid` | string | Target user (null = broadcast) |
| `title` | string | Notification title |
| `body` | string | Message |
| `type` | string | deadline / new_scheme / general |
| `schemeId` | string | Related scheme (nullable) |
| `isRead` | boolean | Read state |
| `createdAt` | timestamp | Created |

### `feedback`
| Field | Type | Description |
|---|---|---|
| `feedbackId` | string | Unique ID |
| `uid` | string | Author (nullable for guest) |
| `schemeId` | string | Related scheme (nullable) |
| `type` | string | bug / data_error / suggestion |
| `message` | string | Feedback text |
| `status` | string | open / reviewed / resolved |
| `createdAt` | timestamp | Created |

### `states`
| Field | Type | Description |
|---|---|---|
| `stateCode` | string | e.g. GJ, MH |
| `name` | map | Localized state name |
| `isActive` | boolean | Active flag |

### `categories`
| Field | Type | Description |
|---|---|---|
| `categoryId` | string | Unique ID |
| `name` | map | Localized name (e.g. Education, Agriculture) |
| `iconUrl` | string | Icon |
| `order` | number | Display order |

---

# 12. 🧮 Recommendation Algorithm (Rule-Based Filtering)

GovConnect uses **deterministic rule-based matching** — transparent, explainable, and easy to audit (critical for government data trust).

### How it works
1. Build a **user profile object** from questionnaire answers.
2. Each scheme stores an **eligibility rule object** with constraints.
3. The engine evaluates every active scheme against the profile; a scheme is **eligible only if ALL its rules pass**.
4. Eligible schemes are ranked (state match, deadline proximity, category relevance).

### Eligibility criteria evaluated
| Criterion | Rule Example |
|---|---|
| **Income** | `income <= 250000` |
| **Age** | `age >= 18 && age <= 35` |
| **Gender** | `gender == 'female'` |
| **Occupation** | `occupation in ['farmer','student']` |
| **State** | `state == 'GJ' || level == 'central'` |
| **Category** | `category in ['SC','ST','OBC']` |
| **Education** | `education == 'undergraduate'` |
| **Caste (optional)** | Only if user consents to share |
| **Disability** | `isDisabled == true` |
| **Minority** | `isMinority == true` |
| **Farmer** | `isFarmer == true` |
| **Business Owner** | `isBusinessOwner == true` |

### Example eligibility rule (scheme document)
```json
{
  "eligibility": {
    "minAge": 18,
    "maxAge": 40,
    "maxIncome": 250000,
    "gender": ["female"],
    "states": ["ALL"],
    "categories": ["SC", "ST", "OBC", "GENERAL"],
    "requiresFarmer": false,
    "requiresDisability": false
  }
}
```

### Matching pseudocode
```dart
bool isEligible(User u, Scheme s) {
  final e = s.eligibility;
  if (u.age < e.minAge || u.age > e.maxAge) return false;
  if (u.income > e.maxIncome) return false;
  if (e.gender.isNotEmpty && !e.gender.contains(u.gender)) return false;
  if (!e.states.contains('ALL') && !e.states.contains(u.state)) return false;
  if (e.categories.isNotEmpty && !e.categories.contains(u.category)) return false;
  if (e.requiresFarmer && !u.isFarmer) return false;
  if (e.requiresDisability && !u.isDisabled) return false;
  if (e.requiresMinority && !u.isMinority) return false;
  if (e.requiresBusinessOwner && !u.isBusinessOwner) return false;
  return true;
}
// Rank: state-specific first, then nearest deadline, then category match.
```

> ✅ **Why rule-based (not ML) for v1:** explainable ("you qualify because income < ₹2.5L"), no training data needed, easy for admins to verify, and legally safer for government data.

---

# 13. 🖼️ UI Pages

| Page | Purpose |
|---|---|
| **Splash** | Branding + load config/session; route to language or home |
| **Language Selection** | Pick UI language on first launch |
| **Login / Guest** | Phone OTP auth or continue as guest |
| **Eligibility Quiz** | Collect profile answers to power recommendations |
| **Home** | Personalized feed of eligible schemes + categories + search entry |
| **Search** | Keyword search across schemes |
| **Filters** | Refine by state, category, benefit type, target group |
| **Scheme Detail** | Full scheme info: benefits, eligibility, documents, deadline, apply link |
| **Bookmarks** | Saved schemes for the logged-in user |
| **Notifications** | Deadline & new-scheme alerts |
| **Profile** | View/edit eligibility answers, language, notification prefs |
| **Settings** | Language, notifications, theme, about, logout |
| **Admin Panel** | Manage schemes, states, categories, eligibility rules, feedback (web/admin build) |

---

# 14. 📐 Wireframes (Low-Fidelity)

### Home
```text
┌───────────────────────────────┐
│ ☰   GovConnect        🔔  👤   │
│ ┌───────────────────────────┐ │
│ │ 🔍 Search schemes...      │ │
│ └───────────────────────────┘ │
│ Categories                     │
│ [🎓][🌾][👵][👩][💼][♿]        │
│                                │
│ Recommended for you            │
│ ┌───────────────────────────┐ │
│ │ 🌾 PM-KISAN               │ │
│ │ ₹6,000/yr · Central       │ │
│ │ ✅ You are eligible   🔖  │ │
│ └───────────────────────────┘ │
│ ┌───────────────────────────┐ │
│ │ 🎓 Post-Matric Scholarship│ │
│ │ State · Deadline 30 Aug   │ │
│ └───────────────────────────┘ │
│ [🏠 Home][🔍][🔖][🔔][👤]     │
└───────────────────────────────┘
```

### Eligibility Quiz
```text
┌───────────────────────────────┐
│ ← Eligibility Check     3/8    │
│ ▓▓▓░░░░░                        │
│                                │
│ What is your annual income?    │
│ ( ) Below ₹1,00,000            │
│ ( ) ₹1L – ₹2.5L                │
│ ( ) ₹2.5L – ₹5L                │
│ ( ) Above ₹5L                  │
│                                │
│         [   Next →   ]         │
└───────────────────────────────┘
```

### Scheme Detail
```text
┌───────────────────────────────┐
│ ←  PM-KISAN            🔖  ↗   │
│ 🌾 Agriculture · Central       │
│ ✅ You are eligible            │
│───────────────────────────────│
│ Benefits                       │
│ • ₹6,000/year in 3 instalments │
│ Eligibility                    │
│ • Small/marginal farmer        │
│ Documents                      │
│ • Aadhaar • Land record • Bank │
│ Deadline: Open                 │
│───────────────────────────────│
│ [ 🌐 Apply on Official Portal ]│
└───────────────────────────────┘
```

### Admin Panel (web)
```text
┌──────────────────────────────────────────────┐
│ GovConnect Admin      Schemes | States | Feed  │
│ ┌────────────┐ ┌─────────────────────────────┐ │
│ │ + New      │ │ Search schemes...           │ │
│ └────────────┘ └─────────────────────────────┘ │
│ Title            Level    State   Active  Edit │
│ PM-KISAN         Central   —       ✅     ✏️🗑 │
│ Post-Matric Sch  State     GJ      ✅     ✏️🗑 │
│ Old Age Pension  State     MH      ✅     ✏️🗑 │
└──────────────────────────────────────────────┘
```

---

# 15. 🎨 Color Palette

Government-inspired (trust, India tricolor cues), modern, and WCAG-accessible.

| Role | Name | Hex | Usage |
|---|---|---|---|
| **Primary** | Ashoka Blue | `#0B5FA5` | App bar, primary buttons, links |
| **Secondary** | Deep Saffron | `#F4811F` | Highlights, active states, CTAs |
| **Accent** | India Green | `#138808` | "Eligible" badges, positive accents |
| **Success** | Success Green | `#2E7D32` | Success messages, confirmations |
| **Warning** | Amber | `#F9A825` | Deadlines approaching, cautions |
| **Error** | Error Red | `#C62828` | Errors, ineligible/invalid |
| **Neutral Dark** | Ink | `#1F2933` | Primary text |
| **Neutral Mid** | Slate | `#616E7C` | Secondary text |
| **Neutral Light** | Cloud | `#F5F7FA` | Backgrounds, cards |
| **White** | Surface | `#FFFFFF` | Surfaces |

> ♿ Ensure text/background pairs meet **WCAG AA (4.5:1)**. Do not rely on color alone for the "eligible" state — pair with an icon + label.

---

# 16. 🔤 Typography & UI Kit

### Fonts (Google Fonts)
| Use | Font | Notes |
|---|---|---|
| **Headings** | Poppins | Modern, friendly, strong hierarchy |
| **Body** | Inter | Highly legible at small sizes |
| **Indic scripts** | Noto Sans (Devanagari/Gujarati/Tamil…) | Full regional-language coverage |

### Font Hierarchy
| Token | Size / Weight | Usage |
|---|---|---|
| H1 | 28 / Bold | Page titles |
| H2 | 22 / SemiBold | Section headers |
| H3 | 18 / SemiBold | Card titles |
| Body | 16 / Regular | Primary content |
| Caption | 13 / Regular | Meta, labels |
| Button | 16 / SemiBold | CTAs |

### Spacing
- Base unit **8px**; scale: 4 / 8 / 16 / 24 / 32.
- Screen padding **16px**; card padding **16px**; min tap target **48×48px**.

### Icons
- **Material Symbols** (rounded) for consistency; category icons as emoji/custom SVGs.

### Buttons
| Type | Style |
|---|---|
| Primary | Filled Ashoka Blue, white text, radius 12 |
| Secondary | Outlined blue, blue text |
| CTA (Apply) | Filled Saffron, white text |
| Text/Ghost | Blue text only |

### Cards
- Radius **16px**, subtle shadow (elevation 1–2), 16px padding, eligibility badge top-right, bookmark toggle inline.

---

# 17. 🗺️ Roadmap

| Phase | Focus | Key Deliverables | Status |
|---|---|---|---|
| **Phase 1** | 🔍 Research | Scheme data model, eligibility rules research, competitor analysis, user interviews | ⬜ |
| **Phase 2** | 🗄️ Database | Firestore schema, seed 50–100 verified schemes, states & categories, admin panel | ⬜ |
| **Phase 3** | 🎨 Frontend | Flutter UI (all MVP screens), i18n, auth, navigation | ⬜ |
| **Phase 4** | 🧮 Recommendation Engine | Rule engine, questionnaire, personalized feed, ranking | ⬜ |
| **Phase 5** | 🧪 Testing | Unit + widget tests, eligibility accuracy QA, accessibility & device testing, beta with real users | ⬜ |
| **Phase 6** | 🚀 Deployment | Play Store release, analytics, crash reporting, feedback loop, data-maintenance process | ⬜ |

### Phase checklist
- [ ] Phase 1 — Research complete
- [ ] Phase 2 — Database & admin ready
- [ ] Phase 3 — Frontend MVP built
- [ ] Phase 4 — Recommendation engine live
- [ ] Phase 5 — Tested & beta validated
- [ ] Phase 6 — Deployed to Play Store

---

# 18. ⚠️ Risks

| Risk | Impact | Mitigation |
|---|---|---|
| **Incorrect scheme data** | Users misled about eligibility → loss of trust | Verification workflow, updatedAt per scheme, feedback/report button, source citations |
| **Changing government rules** | Schemes/eligibility go stale | Scheduled re-verification, admin alerts, versioned rules |
| **Data maintenance burden** | Manual curation doesn't scale | Structured admin tools, part-time curators, move toward official APIs |
| **Scalability** | High reads spike costs/latency | Firestore indexing, pagination, caching, cost monitoring |
| **User trust** | Users doubt a non-government app | "Unofficial, info only" disclaimer, link to official portals, transparency on eligibility reasons |
| **Privacy/legal (sensitive fields)** | Caste/disability data is sensitive | Explicit consent, minimal storage, DPDP compliance |
| **Language quality** | Poor translations reduce usability | Professional/native review of regional content |

---

# 19. 🔭 Future Scope

- [ ] 🤖 **AI Chatbot** — conversational scheme discovery & Q&A
- [ ] 🗣️ **Voice Assistant** — voice navigation for low-literacy/elderly users
- [ ] 🌐 **Regional Languages** — expand to 10+ Indian languages
- [ ] 📄 **OCR Document Checker** — scan Aadhaar/income proof to auto-verify readiness
- [ ] 🔮 **Eligibility Prediction** — ML-assisted likely-eligible suggestions
- [ ] ⏰ **Scheme Deadline Alerts** — smart reminders + calendar sync
- [ ] 👨‍👩‍👧 **Family Profile** — manage benefits for multiple household members
- [ ] 🤝 **NGO Integration** — partner NGOs assist users with applications

---

# 20. 💰 Monetization

> Core citizen access stays **free**. Monetization targets institutions, not vulnerable users.

| Model | Description |
|---|---|
| **Premium Alerts** | Optional paid tier for advanced reminders, priority notifications, document tracking |
| **Government Partnerships** | Paid integrations/sponsored placement for verified official programs |
| **CSR Sponsorship** | Corporates fund the app as a CSR/digital-inclusion initiative |
| **Analytics Dashboard** | Aggregated, anonymized scheme-interest insights for policymakers |
| **NGO Dashboard** | Paid tools for NGOs to help beneficiaries at scale |
| **White-Label Version** | License the platform to state governments / institutions under their brand |

---

> ⚠️ *Statistics in §2 are illustrative placeholders — cite verified sources (MyScheme, NITI Aayog, NSSO) before any external/investor use.*
