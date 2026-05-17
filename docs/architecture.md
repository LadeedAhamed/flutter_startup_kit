# Architecture Guide

## Clean Architecture + Bloc

This startup kit follows Clean Architecture with three main layers per feature:

### Layer Overview

```
┌─────────────────────────────┐
│     Presentation Layer      │
│  (Bloc/Cubit, Pages, Widgets)│
├─────────────────────────────┤
│       Domain Layer          │
│  (Entities, Use Cases, Repos)│
├─────────────────────────────┤
│        Data Layer           │
│  (Models, Data Sources, Repos)│
└─────────────────────────────┘
```

### Presentation Layer

- Contains UI code (Pages, Widgets)
- Bloc/Cubit for state management
- UI dispatches events to Bloc
- Bloc emits states that UI consumes
- UI never calls repositories directly

### Domain Layer

- Contains business logic
- Use Cases encapsulate business rules
- Repository interfaces (abstractions)
- Entities (business objects)
- Independent of frameworks and UI

### Data Layer

- Repository implementations
- Data sources (remote/local)
- DTO models (json_serializable)
- Mappers convert DTOs to Entities

### Data Flow

```
UI → Bloc → UseCase → Repository → DataSource
                                            
UI ← Bloc ← UseCase ← Repository ← DataSource
```

### State Flow

```
Event → Bloc → State → UI (rebuilds)
```
