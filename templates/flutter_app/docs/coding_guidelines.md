# Coding Guidelines

## General Rules

1. **Avoid massive files** — Break into small, focused files
2. **No business logic in UI** — Use Bloc/UseCases
3. **No static global states** — Use DI (GetIt)
4. **Immutable states** — Use `@freezed` or `equatable`
5. **Keep widgets small** — Extract reusable widgets
6. **Repository abstraction** — Always define interfaces
7. **No duplicate models** — Convert DTO → Entity via mappers

## Naming Conventions

| Item | Convention | Example |
|------|------------|---------|
| Files | `snake_case` | `auth_bloc.dart` |
| Classes | `PascalCase` | `AuthBloc` |
| Variables | `camelCase` | `accessToken` |
| Constants | `camelCase` | `defaultTimeout` |
| Private | `_camelCase` | `_handleLogin()` |

## Bloc Naming

- `auth_bloc.dart` — Bloc class
- `auth_event.dart` — Event classes
- `auth_state.dart` — State classes

## Folder Structure Per Feature

```
feature_name/
├── data/
│   ├── datasources/remote/
│   ├── datasources/local/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── bloc/
│   ├── pages/
│   └── widgets/
└── di/
```

## Code Rules

- Use `const` constructors where possible
- Prefer `@freezed` for immutable models
- Use `Either<Failure, T>` for repository returns
- Keep `build()` methods clean — extract widgets
- Write unit tests for use cases and repositories
- Use `LoggerService` instead of `print()`
- Handle all loading, error, and empty states
