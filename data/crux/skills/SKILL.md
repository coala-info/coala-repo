---
name: crux
description: Crux is a framework designed to centralize application business logic and behavior in a single, side-effect-free Rust "Core." By strictly separating pure logic from platform-specific side effects, Crux allows developers to write complex behavior once and project it onto thin, native "Shells" (SwiftUI, Jetpack Compose, React).
homepage: https://github.com/redbadger/crux
---

# crux

## Overview

Crux is a framework designed to centralize application business logic and behavior in a single, side-effect-free Rust "Core." By strictly separating pure logic from platform-specific side effects, Crux allows developers to write complex behavior once and project it onto thin, native "Shells" (SwiftUI, Jetpack Compose, React). The architecture follows a unidirectional data flow where the Core processes events, updates state, and requests effects that the Shell executes.

## Core Implementation Patterns

### Defining the Component Types

Every Crux application requires four primary types to define its state machine:

1.  **Event**: An enum representing all possible user interactions or external notifications.
2.  **Model**: A struct representing the internal state of the application.
3.  **Effect**: An enum describing the side-effects the Core needs the Shell to perform.
4.  **ViewModel**: A simplified representation of the state optimized for the UI to display.

### The Update Function

The `update` function is the heart of the logic. It must remain pure and side-effect-free.

```rust
fn update(&self, msg: Event, model: &mut Model) -> Command<Effect, Event> {
    match msg {
        Event::Increment => {
            model.count += 1;
            Command::done()
        }
        Event::FetchData => {
            // Request a side effect via a Capability
            self.http.get("https://api.example.com").expect_json().handle(Event::DataReceived)
        }
        // ... other events
    }
}
```

## Managed Effects and Capabilities

Crux uses "Capabilities" to provide ergonomic APIs for side effects. The Core requests an effect, and the Shell performs the actual work.

*   **Render**: Built-in to `crux_core`. Use it to tell the Shell to refresh the UI after a state change.
*   **Http**: Full HTTP implementation (based on Surf API). Supports request/response cycles.
*   **KeyValue**: Basic persistent storage (Get/Set).
*   **Time**: Accessing current time or setting durations/instants.
*   **Platform**: Querying information about the host environment.

### Custom Capabilities

If a specific side effect is not covered, you can implement custom capabilities for streaming (e.g., SSE) or specialized hardware access. These should always return an `Effect` to be handled by the Shell.

## FFI and Type Generation

Crux relies on static type checking across the language boundary.

1.  **Type Generation**: Use `serde-generate` to create types and serialization code for Swift, Kotlin, and TypeScript.
2.  **Mobile (iOS/Android)**: Uses Mozilla's UniFFI to create the bridge.
3.  **Web**: Uses `wasm-pack` to compile the core to WebAssembly.

### The Core API Interface

The Shell interacts with the Core through three primary functions:
*   `process_event(Event) -> Vec<Request>`: Sends a user action to the Core.
*   `handle_response(uuid, Response) -> Vec<Request>`: Sends the result of a side-effect back to the Core.
*   `view() -> ViewModel`: Retrieves the current state for rendering.

## Best Practices

*   **Keep Shells Thin**: The Shell should contain zero business logic. If you find yourself writing `if` statements in the Shell, move that logic into the Core's `update` function or `ViewModel` projection.
*   **Test the Core**: Since the Core is pure Rust and side-effect-free, you can run high-level user journey tests in milliseconds using standard `cargo test` without mocks or stubs.
*   **Managed Effects**: Always use the `Command` API for complex workflows. It allows for fire-and-forget, request/response, and streaming semantics.
*   **Serialization**: Ensure all types passed across the FFI boundary implement `Serialize` and `Deserialize`.

## Reference documentation

- [Crux GitHub Repository](./references/github_com_redbadger_crux.md)
- [Crux Documentation/Book](./references/github_com_redbadger_crux_tree_master_docs.md)