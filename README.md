<div>
    <img src="https://github.com/Pedro-Ivo-Neves/Classy/blob/main/assets/%7B%20Classy%20%7D.png?raw=true"/>
</div>

This is a package to simplify your dart code, specially classes and make your code more **_Classy_** and Cleaner without the normal boilerplate

# How to Run?

1. Add the following code into your `analysis_options.yaml`

    ```yaml
    analyzer:
    enable-experiment:
    - macros
    ```

2. When you're gonna run the project:
    - In a Flutter project
    ```shell
    flutter run --enable-experiment=macros
    ```
    
    - In a Dart project
    ```shell
    dart run --enable-experiment=macros
    ```

<br><br>

# Todos:

### Data
- [] Data (All Contructors at once and Getters and Setters)

### Constructors
- [x] Constructor
- [x] ToJson
- [x] FromJson

### Constructors Helpers
- [] Value (value[Initilization of the field like 0 or ""],jsonName[The field name in Json], ignore[t/f], level[public/private])
- [] JsonValue
- [] Ignore

### Methods
- [] Getters
- [] Setters
- [] ToString
- [] EqualTo
- [] HashCode
- [] CopyWith

### Utils

#### Classes
- [] Omit
- [] Exclude
- [] Pick
- [] Extract
- [] Required
- [] Partial

#### Methods
- [] Awaited
- [] ReturnType
- [] Parameters
