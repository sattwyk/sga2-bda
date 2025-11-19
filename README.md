# Library Management (Books & Authors)

Spring Boot 3 web application that manages authors and their books using JSP views, layered architecture, and an in-memory H2 database. It was built for the SGA-2 assignment to demonstrate CRUD operations, joins, validation, and testing.

## Key Features
- Two JPA entities (`Author`, `Book`) with one-to-many relationship and pre-loaded data via `data.sql`.
- Full CRUD flows with `AuthorController` and `BookController`, including edit pages and a join view (`/books/with-authors`).
- Server- and client-side validation (Bean Validation + HTML/JS) to enforce unique email/ISBN, proper formats, and safe numeric values.
- Service layer encapsulates business rules (e.g., duplicate ISBN detection) while repositories provide custom projections.
- JSP views styled via shared CSS, with JS helpers for filtering and UI polish.

## Tests
- `AuthorServiceTest` / `BookServiceTest`: cover service logic with Mockito.
- `AuthorRepositoryTest` / `BookRepositoryTest`: run against H2 with seeded data.
- `BookServiceIntegrationTest`: verifies duplicate ISBN behavior end-to-end.

Run all tests with:
```bash
mvn test
```

## Running the App
```bash
mvn spring-boot:run
```
Then open `http://localhost:8080` and navigate between Authors and Books using the header links. The H2 console is available at `/h2-console` (user `sa`, blank password).
