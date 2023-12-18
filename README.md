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

Features
--------

-   JSON Handling
-   Data filter types compatible with the backend
-   Converting HTTP responses to various formats

Installation
------------

To install the package:

```zsh
flutter pub add truesight_core
```

How to Use
----------

### JSON Handling

The package defines the following JSON data types:

-   `JsonBoolean`: for `bool` type
-   `JsonDate`: for `DateTime` type
-   `JsonList`: for `List<Object>` type
-   `JsonNumber`: for `num` type
-   `JsonObject`: for `Object` type
-   `JsonString`: for `String` type

#### Model Definition

Example:

```dart
class User extends DataModel {
    //
    JsonBoolean isAdmin = JsonBoolean("isAdmin");

    JsonString username = JsonString("username");

    JsonDate dateOfBirth = JsonDate("dateOfBirth");
    //
}
```

Usage:


```dart
JsonType fieldName = JsonType("jsonFieldName");
```

To convert to and from JSON:

```dart
User.fromJSON(Map<String, dynamic> json);

final Map<String, dynamic> json = User.toJSON(); // Dart Map

final String jsonString = User.toString(); // JSON string
```

### AdvancedFilter

Filter types:

-   `DateFilter`: for date-type fields
-   `StringFilter`: for `string` type fields
-   `NumberFilter`: for numeric fields
-   `GuidFilter`: for key fields (primary | foreign) of Guid type
-   `IdFilter`: for key fields (primary | foreign) of integer Id type

Example filter class:

```dart
class UserFilter extends DataFilter {
    StringFilter username = StringFilter();

    DateFilter dateOfBirth = DateFilter();

    // Default fields:

    int skip;

    int take;

    String? orderBy;

    OrderType? orderType;
}
```

#### OrderType

There are 2 order types:

```dart
OrderType.asc; // Ascending

OrderType.desc; // Descending
```

### HTTPRepository

A repository is a class containing methods to call corresponding APIs for a Controller / API group at the backend.

Example of creating a repository:

```dart
@singleton // This is a GetIt annotation => Make the class singleton instance
class AccountRepository extends HttpRepository {
  // This tells the repository to use interceptor to transform every request
  @override
  bool get useInterceptor => true;

  // This is InterceptorsWrapper, used along with `useInterceptor = true`
  @override
  InterceptorsWrapper interceptorsWrapper = globalInterceptorsWrapper;

  // Base URL, for example: [https://example.com](https://example.com)
  // Should use `flutter_dotenv` to configure the apiBaseUrl,
  @override
  String get baseUrl => dotenv.apiBaseUrl;

  AccountRepository() : super("api/prefix");

  Future<AppUser> login(String username, String password) {
    return post(
      url("login"),
      data: {
        "username": username,
        "password": password,
      },
    ).then(
      (Response response) => response.body<AppUser>(AppUser),
    );
  }

  Future<AppUser> getProfile() {
    return post(
      url("get"),
      data: {},
    ).then(
      (Response response) => response.body<AppUser>(AppUser),
    );
  }

  Future<Map<String, dynamic>> refreshToken() {
    return post(
      url("refresh-token"),
      data: {},
    ).then(
      (Response response) => response.data,
    );
  }
}
```

This document outlines the core features of the Truesight package for Dart and Flutter, detailing its JSON handling capabilities, filter types, and methods for handling HTTP responses, along with installation and usage instructions.
