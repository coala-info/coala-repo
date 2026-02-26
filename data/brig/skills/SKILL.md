---
name: brig
description: Brigadier is a command parsing and dispatching library for building complex command trees. Use when user asks to register commands, build command trees, define execution logic, or parse user input.
homepage: https://github.com/Mojang/brigadier
---


# brig

## Overview
Brigadier is a high-performance command parsing and dispatching library. It allows developers to build complex command trees where every node represents a piece of syntax, such as a literal keyword or a dynamic argument. This skill provides guidance on constructing these trees using the builder pattern, defining execution logic, and utilizing the parsing engine to handle user input efficiently.

## Command Registration Patterns
Brigadier uses a tree-based structure where commands are registered as a series of nodes.

*   **Root Nodes**: All commands must start with a `LiteralCommandNode` registered to the dispatcher's root.
*   **Literal Nodes**: Used for fixed keywords (e.g., `foo`).
*   **Argument Nodes**: Used for dynamic input (e.g., `<bar>` as an integer).
*   **Execution**: Any node can be an "exit point" by attaching an `.executes()` method.

### Example Structure
```java
dispatcher.register(
    literal("foo")
        .then(
            argument("bar", integer())
                .executes(c -> {
                    int value = getInteger(c, "bar");
                    return 1; // Success
                })
        )
        .executes(c -> 1)
);
```

## Best Practices and Expert Tips
*   **Prefer Builder Patterns**: Use `LiteralArgumentBuilder` and `RequiredArgumentBuilder` (via static imports `literal` and `argument`) to keep registration code readable.
*   **Ambiguity Management**: Ensure that sibling nodes are not ambiguous. While Brigadier handles branching, overlapping argument types can lead to unexpected parsing results.
*   **Contextual Source**: Use the generic type `<S>` in `CommandDispatcher<S>` to pass a custom "command source" object (like a User or Player). This object is available in the `CommandContext` during execution to determine permissions or state.
*   **Parsing vs. Execution**: For performance-critical applications, separate the `parse` and `execute` steps.
    ```java
    ParseResults<S> parse = dispatcher.parse("input", source);
    // Results can be cached or inspected before execution
    int result = dispatcher.execute(parse);
    ```
*   **Error Handling**: Brigadier throws `CommandSyntaxException` for parsing failures. Always wrap execution in a try-catch block if the input is untrusted.
*   **Smart Usage**: Use `getSmartUsage(node, source)` to generate human-readable documentation for your command tree automatically.

## Common Argument Types
*   **Integer**: `integer(min, max)`
*   **Bool**: `bool()`
*   **String**: 
    *   `word()`: Single word.
    *   `string()`: Quoted string if it contains spaces.
    *   `greedyString()`: Consumes the rest of the input.

## Reference documentation
- [Brigadier README](./references/github_com_Mojang_brigadier.md)