## Keyboard shortcuts

Press `←` or `→` to navigate between chapters

Press `S` or `/` to search in the book

Press `?` to show this help

Press `Esc` to hide this help

[ ]

* Auto
* Light
* Rust
* Coal
* Navy
* Ayu

# Crux: Cross-platform app development in Rust

# [Shared core and types](#shared-core-and-types)

These are the steps to set up the two crates forming the shared core – the core
itself, and the shared types crate which does type generation for the foreign
languages.

Sharp edge

We're hoping to automate some of these steps in future tooling. For now the set up includes some copy & paste from one of the [example projects](https://github.com/redbadger/crux/tree/master/examples).

## [Install the tools](#install-the-tools)

This is an example of a
[`rust-toolchain.toml`](https://rust-lang.github.io/rustup/overrides.html#the-toolchain-file)
file, which you can add at the root of your repo. It should ensure that the
correct rust channel and compile targets are installed automatically for you
when you use any rust tooling within the repo.

```
[toolchain]
channel = "stable"
components = ["rustfmt", "rustc-dev"]
targets = [
    "aarch64-apple-darwin",
    "aarch64-apple-ios",
    "aarch64-apple-ios-sim",
    "aarch64-linux-android",
    "wasm32-unknown-unknown",
    "x86_64-apple-ios",
]
profile = "minimal"
```

## [Create the core crate](#create-the-core-crate)

### [The shared library](#the-shared-library)

The first library to create is the one that will be shared across all platforms,
containing the *behavior* of the app. You can call it whatever you like, but we
have chosen the name `shared` here. You can create the shared rust library, like
this:

```
cargo new --lib shared
```

### [The workspace and library manifests](#the-workspace-and-library-manifests)

We'll be adding a bunch of other folders into the monorepo, so we are choosing
to use Cargo Workspaces. Edit the workspace `/Cargo.toml` file, at the monorepo
root, to add the new library to our workspace. It should look something like
this:

```
# /Cargo.toml
[workspace]
members = ["shared"]
resolver = "1"

[workspace.package]
authors = ["Red Badger Consulting Limited"]
edition = "2021"
repository = "https://github.com/redbadger/crux/"
license = "Apache-2.0"
keywords = ["crux", "crux_core", "cross-platform-ui", "ffi", "wasm"]
rust-version = "1.80"

[workspace.dependencies]
anyhow = "1.0.95"
crux_core = "0.12.0"
serde = "1.0.217"
```

The library's manifest, at `/shared/Cargo.toml`, should look something like the
following, but there are a few things to note:

* the `crate-type`
  + `lib` is the default rust library when linking into a rust binary, e.g. in
    the `web-yew`, or `cli`, variant
  + `staticlib` is a static library (`libshared.a`) for including in the Swift
    iOS app variant
  + `cdylib` is a C-ABI dynamic library (`libshared.so`) for use with JNA when
    included in the Kotlin Android app variant
* we need to declare a feature called `typegen` that depends on the feature with
  the same name in the `crux_core` crate. This is used by this crate's sister
  library (often called `shared_types`) that will generate types for use across
  the FFI boundary (see the section below on generating shared types).
* the uniffi dependencies and `uniffi-bindgen` target should make sense after
  you read the next section

```
# /shared/Cargo.toml
[package]
name = "shared"
version = "0.1.0"
authors.workspace = true
repository.workspace = true
edition.workspace = true
license.workspace = true
keywords.workspace = true
rust-version.workspace = true

[lib]
crate-type = ["lib", "staticlib", "cdylib"]
name = "shared"

[features]
typegen = ["crux_core/typegen"]

[dependencies]
crux_core.workspace = true
serde = { workspace = true, features = ["derive"] }
uniffi = "0.29.2"
wasm-bindgen = "0.2.100"

[target.uniffi-bindgen.dependencies]
uniffi = { version = "0.29.2", features = ["cli"] }

[build-dependencies]
uniffi = { version = "0.29.2", features = ["build"] }
```

### [FFI bindings](#ffi-bindings)

Crux uses Mozilla's [Uniffi](https://mozilla.github.io/uniffi-rs/) to generate
the FFI bindings for iOS and Android.

#### [Generating the `uniffi-bindgen` CLI tool](#generating-the-uniffi-bindgen-cli-tool)

Since version `0.23.0` of Uniffi, we need to also generate the
binary that generates these bindings. This avoids the possibility of getting a
version mismatch between a separately installed binary and the crate's Uniffi
version. You can read more about it
[here](https://mozilla.github.io/uniffi-rs/tutorial/foreign_language_bindings.html).

Generating the binary is simple, we just add the following to our crate, in a
file called `/shared/src/bin/uniffi-bindgen.rs`.

```
fn main() {
    uniffi::uniffi_bindgen_main();
}
```

And then we can build it with cargo.

```
cargo run -p shared --bin uniffi-bindgen

# or

cargo build
./target/debug/uniffi-bindgen
```

The `uniffi-bindgen` executable will be used during the build in XCode and in
Android Studio (see the following pages).

#### [The interface definitions](#the-interface-definitions)

We will need an interface definition file for the FFI bindings. Uniffi has its
own file format (similar to WebIDL) that has a `.udl` extension. You can create
one at `/shared/src/shared.udl`, like this:

```
namespace shared {
  bytes process_event([ByRef] bytes msg);
  bytes handle_response(u32 id, [ByRef] bytes res);
  bytes view();
};
```

There are also a few additional parameters to tell Uniffi how to create bindings
for Kotlin and Swift. They live in the file `/shared/uniffi.toml`, like this
(feel free to adjust accordingly):

```
# /shared/uniffi.toml
[bindings.kotlin]
package_name = "com.example.simple_counter.shared"
cdylib_name = "shared"

[bindings.swift]
cdylib_name = "shared_ffi"
omit_argument_labels = true
```

Finally, we need a `build.rs` file in the root of the crate
(`/shared/build.rs`), to generate the bindings:

```
// /shared/build.rs
fn main() {
    uniffi::generate_scaffolding("./src/shared.udl").unwrap();
}
```

### [Scaffolding](#scaffolding)

Soon we will have macros and/or code-gen to help with this, but for now, we need
some scaffolding in `/shared/src/lib.rs`. You'll notice that we are re-exporting
the `Request` type and the capabilities we want to use in our native Shells, as
well as our public types from the shared library.

```
// /shared/src/lib.rs
pub mod app;

use std::sync::LazyLock;

pub use crux_core::{bridge::Bridge, Core, Request};

pub use app::*;

// TODO hide this plumbing

#[cfg(not(target_family = "wasm"))]
uniffi::include_scaffolding!("shared");

static CORE: LazyLock<Bridge<Counter>> = LazyLock::new(|| Bridge::new(Core::new()));

/// Ask the core to process an event
/// # Panics
/// If the core fails to process the event
#[cfg_attr(target_family = "wasm", wasm_bindgen::prelude::wasm_bindgen)]
#[must_use]
pub fn process_event(data: &[u8]) -> Vec<u8> {
    match CORE.process_event(data) {
        Ok(effects) => effects,
        Err(e) => panic!("{e}"),
    }
}

/// Ask the core to handle a response
/// # Panics
/// If the core fails to handle the response
#[cfg_attr(target_family = "wasm", wasm_bindgen::prelude::wasm_bindgen)]
#[must_use]
pub fn handle_response(id: u32, data: &[u8]) -> Vec<u8> {
    match CORE.handle_response(id, data) {
        Ok(effects) => effects,
        Err(e) => panic!("{e}"),
    }
}

/// Ask the core to render the view
/// # Panics
/// If the view cannot be serialized
#[cfg_attr(target_family = "wasm", wasm_bindgen::prelude::wasm_bindgen)]
#[must_use]
pub fn view() -> Vec<u8> {
    match CORE.view() {
        Ok(view) => view,
        Err(e) => panic!("{e}"),
    }
}
```

### [The app](#the-app)

Now we are in a position to create a basic app in `/shared/src/app.rs`. This is
from the
[simple Counter example](https://github.com/redbadger/crux/blob/master/examples/simple_counter/shared/src/counter.rs)
(which also has tests, although we're not showing them here).

```
// /shared/src/app.rs
use crux_core::{
    macros::effect,
    render::{render, RenderOperation},
    App, Command,
};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Clone, Debug)]
pub enum Event {
    Increment,
    Decrement,
    Reset,
}

#[effect(typegen)]
pub enum Effect {
    Render(RenderOperation),
}

#[derive(Default)]
pub struct Model {
    count: isize,
}

#[derive(Serialize, Deserialize, Clone, Default)]
pub struct ViewModel {
    pub count: String,
}

#[derive(Default)]
pub struct Counter;

impl App for Counter {
    type Event = Event;
    type Model = Model;
    type ViewModel = ViewModel;
    type Capabilities = (); // will be deprecated, so use unit type for now
    type Effect = Effect;

    fn update(
        &self,
        event: Self::Event,
        model: &mut Self::Model,
        _caps: &(), // will be deprecated, so prefix with underscore for now
    ) -> Command<Effect, Event> {
        match event {
            Event::Increment => model.count += 1,
            Event::Decrement => model.count -= 1,
            Event::Reset => model.count = 0,
        }

        render()
    }

    fn view(&self, model: &Self::Model) -> Self::ViewModel {
        ViewModel {
            count: format!("Count is: {}", model.count),
        }
    }
}
```

Note the #[effect] macro

The [`#[effect]`](https://docs.rs/crux_macros/latest/crux_macros/macro.effect.html) macro can be used to annotate an enum to represent our effects. The enum has a variant for each effect, which carries the [`Operation`](https://docs.rs/crux_core/latest/crux_core/capability/trait.Operation.html) type.

The real effect type generated by the macro is a little more complicated, with some plumbing to support the foreign function interface into Swift, Kotlin and other languages. You can read more about the effect system in the [Managed Effects](../guide/effects.html) chapter of the guide.

The Capabilities associated type

The `Capabilities` associated type in the code above is an artifact of a migration of the effect API from
previous versions of Crux. You can use the unit type `()` and everything will work fine. We will
eventually remove this type and the last argument to the `update` function.

If you've got an existing app or you're simply curious about what this looked like before, you can read about it
at the end of the [Managed Effects](../guide/effects.html) chapter of the guide.

Make sure everything builds OK

```
cargo build
```

## [Create the shared types crate](#create-the-shared-types-crate)

This crate serves as the container for type generation for the foreign
languages.

Work is being done to remove the need for this crate, but for now, it is needed
in order to drive the generation of the types that cross the FFI boundary.

* Copy over the
  [shared\_types](https://github.com/redbadger/crux/tree/master/examples/simple_counter/shared_types)
  folder from the simple\_counter example.
* Add the shared types crate to `workspace.members` in the `/Cargo.toml` file at the
  monorepo root.
* Edit the `build.rs` file and make sure that your app type is registered. In
  our example, the app type is `Counter`, so make sure you include this
  statement in your `build.rs`

```
 gen.register_app::<Counter>()?;
```

The `build.rs` file should now look like this:

```
use crux_core::typegen::TypeGen;
use shared::Counter;
use std::path::PathBuf;

fn main() -> anyhow::Result<()> {
    println!("cargo:rerun-if-changed=../shared");

    let mut gen = TypeGen::new();

    gen.register_app::<Counter>()?;

    let output_root = PathBuf::from("./generated");

    gen.swift("SharedTypes", output_root.join("swift"))?;

    gen.java("com.crux.example.simple_counter", output_root.join("java"))?;

    gen.typescript("shared_types", output_root.join("typescript"))?;

    Ok(())
}
```

If you are using the latest versions of the
`crux_http` (>= `v0.10.0`), `crux_kv` (>= `v0.5.0`) or `crux_time` (>= `v0.5.0`)
capabilities, you will need to add a build dependency to the capability crate,
with the `typegen` feature enabled — so your `Cargo.toml` file may end up looking something like this
(from the [`cat_facts`](https://github.com/redbadger/crux/tree/master/examples/cat_facts) example):

```
[package]
name = "shared_types"
version = "0.1.0"
authors.workspace = true
repository.workspace = true
edition.workspace = true
license.workspace = true
keywords.workspace = true
rust-version.workspace = true

[dependencies]

[build-dependencies]
anyhow.workspace = true
crux_core = { workspace = true, features = ["typegen"] }
crux_http = { workspace = true, features = ["typegen"] }
crux_kv = { workspace = true, features = ["typegen"] }
crux_time = { workspace = true, features = ["typegen"] }
shared = { path = "../shared", features = ["typegen"] }
```

Tip

Due to a current limitation with the reflection library,
you may need to manually register nested enum types in your `build.rs` file.
(see <https://github.com/zefchain/serde-reflection/tree/main/serde-reflection#supported-features>)

*Note, you don't have to do this for the latest versions of the
`crux_http` (>= `v0.10.0`), `crux_kv` (>= `v0.5.0`) or `crux_time` (>= `v0.5.0`)
capabilities, which now do this registration for you — although you will need to add
a build dependency to the capability crate, with the `typegen` feature enabled.*

If you *do* end up needing to register a type manually (you should get a helpful error to tell you this),
you can use the `register_type` method (e.g. `gen.register_type::<TextCursor>()?;`) as
shown in this
[`build.rs`](https://github.com/redbadger/crux/blob/master/examples/notes/shared_types/build.rs)
file from the `shared_types` crate of the
[notes example](https://github.com/redbadger/crux/tree/master/examples/notes):

```
use crux_core::typegen::TypeGen;
use shared::{NoteEditor, TextCursor};
use std::path::PathBuf;

fn main() -> anyhow::Result<()> {
    println!("cargo:rerun-if-changed=../shared");

    let mut gen = TypeGen::new();

    gen.register_app::<NoteEditor>()?;

    // Note: currently required as we can't find enums inside enums, see:
    // https://github.com/zefchain/serde-reflection/tree/main/serde-reflection#supported-features
    gen.register_type::<TextCursor>()?;

    let output_root = PathBuf::from("./generated");

    gen.swift("SharedTypes", output_root.join("swift"))?;

    // TODO these are for later
    //
    // gen.java("com.example.counter.shared_types", output_root.join("java"))?;

    gen.typescript("shared_types", output_root.join("typescript"))?;

    Ok(())
}
```

### [Building your app](#building-your-app)

Make sure everything builds and foreign types get generated into the
`generated` folder.

(If you're generating TypeScript, you may need `pnpm` to be installed and in your `$PATH`.)

```
cargo build
```

Tip

If you have a `Capabilities` struct (i.e. you are not using the new [`#[effect]`](https://docs.rs/crux_macros/latest/crux_macros/macro.effect.html) macro), and are having problems buildin