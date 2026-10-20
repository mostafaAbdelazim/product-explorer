# Product Explorer

A Flutter mobile app that browses products from the [DummyJSON](https://dummyjson.com) public API using **BLoC** state management and **clean architecture**.

## Features

- Paginated product listing (`limit=10`) with infinite scroll
- Pull-to-refresh on the list screen
- Product details screen with images, pricing, rating, and stock
- Loading, error, and empty UI states
- Clean architecture: `domain` → `data` → `presentation`

## Architecture

```text
lib/
├── core/                 # constants, errors, networking, theme
├── injection/            # lightweight dependency wiring
└── features/products/
    ├── data/             # models, remote data source, repository impl
    ├── domain/           # entities, repository contract, use cases
    └── presentation/     # BLoC, pages, widgets
```

## API

```text
GET https://dummyjson.com/products?limit=10&skip={offset}
GET https://dummyjson.com/products/{id}
```

## Getting started

```bash
flutter pub get
flutter run
```

## State management

- `ProductListBloc` loads the first page, refreshes, and appends pages on scroll
- `ProductDetailBloc` loads a single product by id with retry support
