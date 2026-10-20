# Product Explorer

A Flutter mobile app that browses products from the [DummyJSON](https://dummyjson.com) public API using **BLoC**, **clean architecture**, **Dio**, **Freezed**, and **GetIt + Injectable**.

## Features

- Paginated product listing (`limit=10`) with infinite scroll
- Pull-to-refresh on the list screen
- Product details screen with images, pricing, rating, and stock
- Loading, error, and empty UI states
- Clean architecture: `domain` → `data` → `presentation`

## Architecture

```text
lib/
├── core/                 # constants, errors, Dio client, theme
├── injection/            # GetIt + Injectable DI setup
└── features/products/
    ├── data/
    │   ├── datasources/  # remote API access
    │   ├── models/       # Freezed + json_serializable DTOs
    │   ├── mappers/      # model ↔ entity mapping
    │   └── repositories/
    ├── domain/           # entities, repository contract, use cases
    └── presentation/     # BLoC, pages, widgets
```

## Stack

| Concern | Package |
| --- | --- |
| HTTP | `dio` |
| Models | `freezed` + `json_serializable` |
| Mapping | dedicated mapper classes |
| DI | `get_it` + `injectable` |
| State | `flutter_bloc` |

## API

```text
GET https://dummyjson.com/products?limit=10&skip={offset}
GET https://dummyjson.com/products/{id}
```

## Getting started

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Regenerate Freezed / Injectable code after model or DI changes:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## State management

- `ProductListBloc` loads the first page, refreshes, and appends pages on scroll
- `ProductDetailBloc` loads a single product by id with retry support
