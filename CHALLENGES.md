- H2 identity collisions: Initial `data.sql` seeded explicit IDs but left identity counters at 1, causing PK violations on new inserts. Fixed by appending `ALTER TABLE ... RESTART WITH` to bump sequences after seeding.
- View navigation froze: Intercepting `window.navigation` to trigger View Transitions prevented JSP content from updating. Removed the interception and left a lightweight helper, restoring normal page loads.
- Duplicate ISBN acceptance: `@Column(unique=true)` alone wasn’t enough because validation happened after insert. Added repository helpers + service checks that normalize ISBNs and block duplicates before persisting; surfaced the errors in controllers.
- Missing client/server validation: Emails and ISBNs accepted bogus values. Introduced Bean Validation annotations, HTML patterns, and improved error messaging to ensure clean data entry.
- Mockito inline agent failure on WSL: Byte Buddy couldn’t self-attach, breaking tests. Added `mockito-extensions/org.mockito.plugins.MockMaker` to force subclass mode so unit tests run reliably.

- CSS spilled into HTML: Multiple JSPs rendered literal CSS because styles leaked outside `<style>` tags. Removed the stray blocks and leaned on the modular `app.css`.
- Buttons lost their styling: Variant classes (`btn-primary`, `btn-secondary`) were used without the base `btn`, so the new design system never applied. Added the base class everywhere.
- Email form false positives: Over-escaped regex patterns (e.g., `^[^@\\s]+@...`) made browsers reject valid emails. Replaced with a standard pattern, trimmed inputs on blur, and added clear validation messages.
- Shared JS vanished: `app.js` and `transitions.js` were wiped, killing alerts and view transitions. Recreated both scripts from context to restore behavior.
