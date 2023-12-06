<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Core functions for TrueSight packages.

## Features

- Json serialization
- Repository pattern
- Backend-compatible data structures

## Getting started

This package can be installed in any Dart application.

Để cài đặt:

```bash
flutter pub add truesight_core
```

## Usage

### Json serialization

```dart
import 'package:truesight_core/truesight_core.dart';

class User extends DataModel {
    JsonNumber id = JsonNumber("id");

    JsonString name = JsonString("name");

    JsonBoolean isAdmin = JsonBoolean("isAdmin");

    JsonDate birthday = JsonDate("birthday");

    JsonList<User> members = JsonList<User>("members");

    JsonObject<User> manager = JsonObject<User>("manager");
}
```

### Repository pattern

```dart
import 'package:truesight_core/truesight_core.dart';

class UserRepository extends Repository {

}
```

### Backend-compatible data structures

```dart
class DataFilter {
    int skip = 0;

    int take = 10;

    String? orderBy;

    OrderType? orderType;
}

enum OrderType {
    asc,
    desc,
}
```

## Additional information

Nothing here.
