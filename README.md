## State Management Comparison: Authentication Flow

This sample app shows different approaches to managing state in Flutter:

### [`setState`](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#setstate) vs [`BLoC`](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#bloc--rx) vs [`ValueNotifier`](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html)/[`ChangeNotifier`](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html) with [Provider](https://pub.dev/packages/provider)

**Use case: Setting a loading state while an authentication request is in progress**

### Preview

![](media/preview.gif)

### Overview

Flutter offers [various state management approaches](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options#bloc--rx).

This sample project takes a simple use case, and shows how to implement it in various ways.

This serves both as an **introduction** and a **comparison** of different approaches.

### Curretly supported

- [x] setState
- [x] BLoC with Provider
- [x] ValueNotifier with Provider

### YouTube video walk-through

[![Flutter State Management: setState, BLoC, ValueNotifier, ChangeNotifier + Provider](media/firebase-auth-banner-youtube.png)](https://youtu.be/TODO)

## Reference

- [Flutter Docs: List of state management approaches](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options)

## [License: MIT](LICENSE.md)
