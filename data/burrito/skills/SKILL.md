---
name: burrito
description: Burritos is a Swift library that provides property wrappers to reduce boilerplate for common data handling tasks like thread safety, validation, and persistence. Use when user asks to implement atomic writes, clamp numeric values, manage undo/redo history, or persist data via UserDefaults.
homepage: https://github.com/guillermomuntaner/Burritos
---


# burrito

## Overview
Burritos is a specialized Swift library that provides a robust set of property wrappers designed to reduce boilerplate code. By using these wrappers, you can declaratively handle complex property behaviors like atomic writes, environment variable access, and undo/redo history. This skill helps you select the right wrapper for your specific data handling needs and implement it according to Swift 5 best practices.

## Installation and Setup

### Swift Package Manager (Recommended)
Add the dependency to your `Package.swift` file:
```swift
dependencies: [
    .package(url: "https://github.com/guillermomuntaner/Burritos", from: "0.0.3")
]
```

### CocoaPods
You can install the entire library or specific submodules to keep your binary lean:
```ruby
pod 'Burritos/Copying'
pod 'Burritos/UndoRedo'
pod 'Burritos/UserDefault'
```

## Core Property Wrappers and Usage

### Thread Safety with @AtomicWrite
Use this to ensure write access to a property is synchronized.
- **Best Practice**: For read-modify-write operations (like increments), always use the `mutate` method via the projected value (the underscore prefix) to ensure the entire operation is atomic.
```swift
@Atomic var count = 0
_count.mutate { $0 += 1 }
```

### Validation with @Clamping and @Trimmed
- **@Clamping**: Automatically constrains a numeric value within a defined range.
- **@Trimmed**: Automatically removes whitespace and newlines from strings during initialization and reassignment.
```swift
@Clamping(range: 0...1) var alpha: Double = 0.0
@Trimmed var username: String = "  user123  "
```

### State Management with @UndoRedo
This wrapper maintains a history of values, allowing you to revert changes.
- **Tip**: Use the projected value to check if an undo is possible before calling the method.
```swift
@UndoRedo var text = ""
if _text.canUndo { _text.undo() }
```

### Resource Optimization with @Lazy and @Expirable
- **@Lazy**: Delays instantiation until the first access. Unlike the native `lazy` keyword, this wrapper allows you to `reset()` the value to an uninitialized state.
- **@Expirable**: Automatically invalidates a value after a specific duration or date, returning `nil` once expired. Ideal for API tokens or temporary caches.

### Persistence and Environment
- **@UserDefault**: Bridges a property directly to `UserDefaults` for lightweight persistence.
- **@EnvironmentVariable**: Provides a clean interface for getting and setting system environment variables.

## Expert Tips
- **Projected Values**: Most Burritos wrappers use the projected value (accessed via the `$` prefix or `_` for the wrapper itself) to expose utility methods like `reset()`, `mutate()`, or `undo()`.
- **UI Support**: Use `@DynamicUIColor` for seamless Dark Mode support on iOS 13+, providing separate closures for light and dark traits.
- **Initialization**: When using `@LateInit`, ensure the property is set before access to avoid a runtime fatal error, similar to implicitly unwrapped optionals.

## Reference documentation
- [Burritos README](./references/github_com_guillermomuntaner_Burritos.md)