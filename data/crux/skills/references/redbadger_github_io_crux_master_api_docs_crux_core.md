## Crate crux\_core

## [crux\_core](../crux_core/index.html)0.15.0

* [All Items](all.html)

### Sections

* [Getting Started](#getting-started "Getting Started")
* [Integrating with a Shell](#integrating-with-a-shell "Integrating with a Shell")

### [Crate Items](#reexports)

* [Re-exports](#reexports "Re-exports")
* [Modules](#modules "Modules")
* [Macros](#macros "Macros")
* [Structs](#structs "Structs")
* [Enums](#enums "Enums")
* [Traits](#traits "Traits")

# Crate crux\_core Copy item path

[Source](../src/crux_core/lib.rs.html#1-229)

Expand description

Cross-platform app development in Rust

Crux helps you share your app’s business logic and behavior across mobile (iOS and Android) and web,
as a single, reusable core built with Rust.

Unlike React Native, the user interface layer is built natively, with modern declarative UI frameworks
such as Swift UI, Jetpack Compose and React/Vue or a WASM based framework on the web.

The UI layer is as thin as it can be, and all other work is done by the shared core.
The interface with the core has static type checking across languages.

### [§](#getting-started)Getting Started

Crux applications are split into two parts: a Core written in Rust and a Shell written in the platform
native language (e.g. Swift or Kotlin). It is also possible to use Crux from Rust shells.
The Core architecture is based on [Elm architecture](https://guide.elm-lang.org/architecture/).

Quick glossary of terms to help you follow the example:

* Core - the shared core written in Rust
* Shell - the native side of the app on each platform handling UI and executing side effects
* App - the main module of the core containing the application logic, especially model changes
  and side-effects triggered by events. An App can delegate to child apps, mapping Events and Effects.
* Event - main input for the core, typically triggered by user interaction in the UI
* Model - data structure (typically tree-like) holding the entire application state
* View model - data structure describing the current state of the user interface
* Effect - A side-effect the core can request from the shell. This is typically a form of I/O or similar
  interaction with the host platform. Updating the UI is considered an effect.
* Capability - A user-friendly API used to request effects and provide events that should be dispatched
  when an effect is completed. For example, a HTTP client is a capability.
* Command - A description of a side-effect to be executed by the shell. Commands can be combined
  (synchronously with combinators, or asynchronously with Rust async) to run
  sequentially or concurrently, or any combination thereof.

Below is a minimal example of a Crux-based application Core:

```
// src/app.rs
use crux_core::{render::{self, Render}, App, macros::Effect, Command};
use serde::{Deserialize, Serialize};

// Model describing the application state
#[derive(Default)]
struct Model {
   count: isize,
}

// Event describing the actions that can be taken
#[derive(Serialize, Deserialize)]
pub enum Event {
   Increment,
   Decrement,
   Reset,
}

// Capabilities listing the side effects the Core
// will use to request side effects from the Shell
#[cfg_attr(feature = "typegen", derive(crux_core::macros::Export))]
#[derive(Effect)]
pub struct Capabilities {
   pub render: Render<Event>,
}

#[derive(Default)]
struct Hello;

impl App for Hello {
   // Use the above Event
   type Event = Event;
   // Use the above Model
   type Model = Model;
   type ViewModel = String;
   // Use the above Capabilities
   type Capabilities = Capabilities;
   // Use the above generated Effect
   type Effect = Effect;

   fn update(&self, event: Event, model: &mut Model, caps: &Capabilities) -> Command<Effect, Event> {
       match event {
           Event::Increment => model.count += 1,
           Event::Decrement => model.count -= 1,
           Event::Reset => model.count = 0,
       };

       // Request a UI update
       render::render()
   }

   fn view(&self, model: &Model) -> Self::ViewModel {
       format!("Count is: {}", model.count)
   }
}
```

### [§](#integrating-with-a-shell)Integrating with a Shell

To use the application in a user interface shell, you need to expose the core interface for FFI.
This “plumbing” will likely be simplified with macros in the future versions of Crux.

ⓘ

```
// src/lib.rs
pub mod app;

use lazy_static::lazy_static;
use wasm_bindgen::prelude::wasm_bindgen;

pub use crux_core::bridge::{Bridge, Request};
pub use crux_core::Core;
pub use crux_http as http;

pub use app::*;

uniffi_macros::include_scaffolding!("hello");

lazy_static! {
    static ref CORE: Bridge<Effect, App> = Bridge::new(Core::new::<Capabilities>());
}

#[wasm_bindgen]
pub fn process_event(data: &[u8]) -> Vec<u8> {
    CORE.process_event(data)
}

#[wasm_bindgen]
pub fn handle_response(id: u32, data: &[u8]) -> Vec<u8> {
    CORE.handle_response(id, data)
}

#[wasm_bindgen]
pub fn view() -> Vec<u8> {
    CORE.view()
}
```

You will also need a `hello.udl` file describing the foreign function interface:

ⓘ

```
// src/hello.udl
namespace hello {
  sequence<u8> process_event([ByRef] sequence<u8> msg);
  sequence<u8> handle_response([ByRef] sequence<u8> res);
  sequence<u8> view();
};
```

Finally, you will need to set up the type generation for the `Model`, `Message` and `ViewModel` types.
See [typegen](https://docs.rs/crux_core/latest/crux_core/typegen/index.html) for details.

## Re-exports[§](#reexports)

`pub use capability::[Capability](capability/trait.Capability.html "trait crux_core::capability::Capability");`

`pub use capability::[WithContext](capability/trait.WithContext.html "trait crux_core::capability::WithContext");`

`pub use command::[Command](command/struct.Command.html "struct crux_core::command::Command");`

`pub use [crux_macros](../crux_macros/index.html "mod crux_macros") as macros;`

## Modules[§](#modules)

[bridge](bridge/index.html "mod crux_core::bridge")

[capability](capability/index.html "mod crux_core::capability")
:   Capabilities provide a user-friendly API to request side-effects from the shell.

[command](command/index.html "mod crux_core::command")
:   Command represents one or more side-effects, resulting in interactions with the shell.
    Core creates Commands and returns them from the `update` function in response to events.
    Commands can be created directly, but more often they will be created and returned
    by capability APIs.

[compose](compose/index.html "mod crux_core::compose")
:   A capability which can spawn tasks which orchestrate across other capabilities. This
    is useful for orchestrating a number of different effects into a single transaction.

[render](render/index.html "mod crux_core::render")
:   Built-in capability used to notify the Shell that a UI update is necessary.

[testing](testing/index.html "mod crux_core::testing")
:   Testing support for unit testing Crux apps.

## Macros[§](#macros)

[assert\_effect](macro.assert_effect.html "macro crux_core::assert_effect")
:   Panics if the pattern doesn’t match an `Effect` from the specified `Update`

## Structs[§](#structs)

[Core](struct.Core.html "struct crux_core::Core")
:   The Crux core. Create an instance of this type with your App type as the type parameter

[Request](struct.Request.html "struct crux_core::Request")
:   Request represents an effect request from the core to the shell.

## Enums[§](#enums)

[ResolveError](enum.ResolveError.html "enum crux_core::ResolveError")

## Traits[§](#traits)

[App](trait.App.html "trait crux_core::App")
:   Implement [`App`](trait.App.html "trait crux_core::App") on your type to make it into a Crux app. Use your type implementing [`App`](trait.App.html "trait crux_core::App")
    as the type argument to [`Core`](struct.Core.html "struct crux_core::Core") or [`Bridge`](bridge/struct.Bridge.html "struct crux_core::bridge::Bridge").

[Effect](trait.Effect.html "trait crux_core::Effect")
:   Implemented automatically with the Effect macro from `crux_macros`.
    This is used by the [`Bridge`](bridge/struct.Bridge.html "struct crux_core::bridge::Bridge") to serialize effects going across the
    FFI boundary.