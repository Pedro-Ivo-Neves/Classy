![logo](./resources/classy.png)



[![pub package](https://img.shields.io/pub/v/classy.svg?color=blue)](https://pub.dev/packages/classy)
[![License: MIT](https://img.shields.io/badge/license-Apache-red.svg)](https://www.apache.org/licenses/LICENSE-2.0)


This is a package to simplify your dart code, specially classes and make your code more **_Classy_** and **_Elegant_** without the normal boilerplate

<br>

# ✨ Features

<br>

😎 `@data` calls the **@constructor**, **@toJson**, **@fromJson** and **@toString** to generate the complete class for you.

<br>

🏗️ `@constructor` it generates a constructor, and you can choose if you want **NamedConstructor** or **PositionConstructor**.

<br>

⬇️ `@fromJson` to instantiate the class from a json, that normally come from a server.

<br>

⬆️ `@toJson` to convert the class instance into a JSON map, which can be sent to a server or used elsewhere in your application.

<br>

📜 `@toString` for a readable string representation of the class.


<br><br>

# 🚀 How to Run?

1. Add `package:classy` to your `pubspec.yaml`

    - Run Command

    ```shell
    dart pub add classy
    ```

    - In `pubspec.yaml` file
    ```yaml
    dependencies:
        classy: any
    ```

2. Add the following code into your `analysis_options.yaml`

    ```yaml
    analyzer:
        enable-experiment:
            - macros
    ```

3. When you're gonna run the project:

    ```shell
    dart run --enable-experiment=macros path/main.dart
    ```


### ⚠️ Requires Dart SDK >= 3.5.0