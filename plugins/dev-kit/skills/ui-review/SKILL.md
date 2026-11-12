---
name: ui-review
description: Reviews a running web interface the way a senior product designer would, ranks what to fix, then improves the screens the user picks. Use when the user says the UI looks basic, unpolished or confusing, asks for a design or UX review, or wants an existing screen redesigned.
---

# UI review

Judge the interface by what users see, not by the source alone. Review first, agree on scope with the user, then fix.

## 1. Look at the rendered result

1. Start the app (or ask for its URL) and list the screens that matter most: the entry screen, the main task flow, one form, one list or table, and one empty or error state.
2. With Playwright, capture each screen at **390x844 (phone)** and **1440x900 (desktop)**. Also capture hover/focus on primary controls and one validation error.
3. Read the components and styles behind each screen only after looking at the screenshots.

If the app cannot run, say so and review from code and any screenshots the user provides, stating that the rendered result was not verified.

## 2. Review against these lenses

For every finding record: screen, lens, what is wrong, why it matters to the user, and the concrete fix.

| Lens | What to check |
|---|---|
| Hierarchy | One clear primary action per screen; headings, weight and size show what matters first; nothing competes with the main task. |
| Layout and spacing | Consistent spacing scale; aligned edges; related items grouped, unrelated separated; sensible max width for text and forms. |
| Typography | Few sizes with clear steps; readable line length and height; numbers in tables aligned (tabular figures). |
| Color and contrast | Color carries meaning consistently (primary, danger, success); text contrast meets WCAG 2.2 AA (4.5:1 body, 3:1 large text and UI). |
| Components | Same pattern looks and behaves the same everywhere; buttons, inputs, tables, dialogs come from one component set, not one-off styles. |
| States | Loading, empty, error, success and disabled states exist and tell the user what to do next. |
| Forms | Labels visible (not placeholder-only), errors next to the field in plain language, sensible defaults, keyboard submit. |
| Accessibility | Keyboard reachable in logical order, visible focus ring, semantic elements, alt text, labels on icon-only buttons, no information by color alone. |
| Responsiveness | No horizontal scroll on phone; touch targets at least 44x44 px; tables have a phone strategy (cards, priority columns or horizontal scroll with sticky first column). |
| Copy | Short, specific labels; verbs on buttons ("Save customer", not "OK"); one language per screen; consistent terms. |

## 3. Report, ranked

Group findings into **Fix first** (blocks or misleads users, accessibility failures), **Fix next** (inconsistency, weak hierarchy) and **Polish**. Keep each item to one or two lines with its fix. Show before screenshots next to the list.

Then ask which items to fix. Do not start a redesign the user has not agreed to.

## 4. Fix the chosen items

- For visual direction (type scale, color, layout, distinctive look), apply the `frontend-design` skill (dependency of this kit). Keep the product's existing identity unless the user asks for a new one.
- Follow the project's stack. For Ituran React products the Compass Tech Radar baseline is React + Tailwind CSS + shadcn/ui on Radix (Base UI only on greenfield trials): centralize tokens (color, spacing, radius, type) in the Tailwind theme / CSS variables and turn repeated patterns into components instead of repeating utility combinations.
- Change the shared component or token when a problem repeats, not every page.
- Do not add a new UI library or dependency to fix looks; if one is truly needed, it follows the kit's dependency rules (Tech Radar, ADR, Trivy).

## 5. Verify

- Capture the same screens at both sizes again and show before/after.
- Re-check keyboard navigation and contrast on the changed screens.
- Run the existing tests; for changed flows, add or update Playwright acceptance tests.
- Close with the kit's completion report, listing anything not verified.
