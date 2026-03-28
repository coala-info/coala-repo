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

# [Overview](#overview)

Crux is a framework for building cross-platform applications
with better testability, higher code and behavior reuse, better safety,
security, and more joy from better tools.

It splits the application into two distinct parts, a Core built in Rust, which
drives as much of the business logic as possible, and a Shell, built in the
platform native language (Swift, Kotlin, TypeScript), which provides all
interfaces with the external world, including the human user, and acts as a
platform on which the core runs.

![Crux](./crux.png)

The interface between the two is a native FFI (Foreign Function Interface) with
cross-language type checking and message passing semantics, where simple data
structures are passed across the boundary.

Get to know Crux

To get playing with Crux quickly, follow the [Getting Started](./getting_started/core.html) steps. If you prefer to read more about how apps are built in Crux first, read the [Development Guide](./guide/hello_world.html). And if you'd like to know what possessed us to try this in the first place, read about our [Motivation](./motivation.html).

There are two places to find API documentation: the latest published version on docs.rs, and we also have the very latest master docs if you too like to live dangerously.

* **crux\_core** - the main Crux crate: [latest release](https://docs.rs/crux_core/latest/crux_core/) | [latest master](https://redbadger.github.io/crux/master_api_docs/crux_core/)
* **crux\_http** - HTTP client capability: [latest release](https://docs.rs/crux_http/latest/crux_http/) | [latest master](https://redbadger.github.io/crux/master_api_docs/crux_http/)
* **crux\_kv** - Key-value store capability: [latest release](https://docs.rs/crux_kv/latest/crux_kv/) | [latest master](https://redbadger.github.io/crux/master_api_docs/crux_kv/)
* **crux\_time** - Time capability: [latest release](https://docs.rs/crux_time/latest/crux_time/) | [latest master](https://redbadger.github.io/crux/master_api_docs/crux_time/)

You can see the latest version of this book (generated from the master branch) on [Github Pages](https://redbadger.github.io/crux/latest_master/).

Crux is open source on [Github](https://github.com/redbadger/crux). A good way to learn Crux is to explore the code, play with the [examples](https://github.com/redbadger/crux/tree/master/examples), and raise issues or pull requests. We'd love you to get involved.

You can also join the friendly conversation on our [Zulip channel](https://crux-community.zulipchat.com).

## [Design overview](#design-overview)

![Logical architecture](./architecture.svg)

The architecture is event-driven, based on
[event sourcing](https://martinfowler.com/eaaDev/EventSourcing.html). The Core
holds the majority of state, which is updated in response to events happening in
the Shell. The interface between the Core and the Shell is message-based.

The user interface layer is built natively, with modern declarative UI
frameworks such as Swift UI, Jetpack Compose and React/Vue or a WASM based
framework on the web. The UI layer is as thin as it can be, and all other
application logic is performed by the shared Core. The one restriction is that
the Core is side–effect free. This is both a technical requirement (to be able
to target WebAssembly), and an intentional design goal, to separate logic from
effects and make them both easier to test in isolation.

The core requests side-effects from the Shell through common
[capabilities](./guide/capabilities.html). The basic concept is that instead of
*doing* the asynchronous work, the core *describes* the intent for the work with
data, and passes this to the Shell to be performed. The Shell performs the work,
and returns the outcomes back to the Core. This approach is inspired by
[Elm](https://elm-lang.org/), and similar to how other purely functional
languages deal with effects and I/O (e.g. the IO monad in Haskell). It is also
similar to how iterators work in Rust.

The Core exports types for the messages it can understand. The Shell can call
the Core and pass one of the messages. In return, it receives a set of
side-effect requests to perform. When the work is completed, the Shell sends the
result back into the Core, which responds with further requests if necessary.

Updating the user interface is considered one of the side-effects the Core can
request. The entire interface is strongly typed and breaking changes in the core
will result in build failures in the Shell.

## [Goals](#goals)

We set out to find a better way of building apps
across platforms. You can read more [about our motivation](./motivation.html). The
overall goals of Crux are to:

* Build the majority of the application code once, in Rust
* Encapsulate the *behavior* of the app in the Core for reuse
* Follow the Ports and Adapters pattern, also known as
  [Hexagonal Architecture](https://alistair.cockburn.us/hexagonal-architecture/)
  to facilitate pushing side-effects to the edge, making behavior easy to test
* Separate the behavior from the look and feel and interaction design
* Use the native UI tool kits to create user experience that is the best fit for
  a given platform

## [Path to 1.0](#path-to-10)

Crux is used in production apps today, and we consider it production ready. However, we still have a number of things to work on to call it 1.0, with a stable API, and other things one would expect from a mature framework.

Below is a list of some of the things we know we want to do before 1.0:

* Improved documentation, code examples, and example apps for newcomers
* Improved onboarding experience, with less boilerplate code that end users have
  to deal with
* Better FFI code generation to enable support for more languages (e.g. C#, Dart, even C++...)
  and in trurn more Shells (e.g. .NET, Flutter) which will also enable Desktop apps for Windows
* Revised capabilities and effects to allow for better, more natural
  [app composition](./guide/composing.html) in larger apps, for composing capabilities,
  and generally for a more ergonomic effect API overall

Until then, we hope you will work with us on the rough edges, and adapt to the necessary
API updates as we evolve. We strive to minimise the impact of changes as much as we can, but before 1.0, some breaking changes will be unavoidable.

# [Motivation](#motivation)

We set out to prove this approach to building apps largely because we've seen
the drawbacks of all the other approaches in real life, and thought "there must
be a better way". The two major available approaches to building the same
application for iOS and Android are:

1. Build a native app for each platform, effectively doing the work twice.
2. Use React Native or Flutter to build the application once[1](#footnote-once) and produce
   native looking and feeling apps which behave nearly identically.

The drawback of the first approach is doing the work twice. In order to build
every feature for iOS and Android at the same time, you need twice the number of
people, either people who happily do Swift and Kotlin (and they are very rare),
or more likely a set of iOS engineers and another set of Android engineers. This
typically leads to forming two separate, platform-focused teams. We have
witnessed situations first-hand, where those teams struggle with the same design
problems, and despite one encountering and solving the problem first, the other
one can learn nothing from their experience (and that's *despite* long design
discussions).

We think such experiences with the platform native approach are common, and the
reason why people look to React Native and Flutter. The issues with React Native
are two fold

* Only *mostly* native user interface
* In the case of React Native, the JavaScript ecosystem tooling disaster

React Native effectively takes over, and works hard to insulate the engineer
from the native platform underneath and pretend it doesn't really exist, but of
course, inevitably, it does and the user interface ends up being built in a
combination of 90% JavaScript/TypeScript and 10% Kotlin/Swift. This was still a
major win when React Native was first introduced, because the platform native UI
toolkits were imperative, following a version of MVC architecture, and generally
made it quite difficult to get UI state management right. React on the other
hand is declarative, leaving much less space for errors stemming from the UI
getting into an undefined state. This benefit was clearly recognised by iOS and
Android, and both introduced their own declarative UI toolkit - Swift UI and
Jetpack Compose. Both of them are quite good, matching that particular advantage
of React Native, and leaving only building things once (in theory). But in
exchange, they have to be written in JavaScript (and adjacent tools and
languages).

The main issue with the JavaScript ecosystem is that it's built on sand. The
underlying language is quite loose and has a
[lot of inconsistencies](https://www.destroyallsoftware.com/talks/wat). It came
with no package manager originally, now [it](https://www.npmjs.com/)
[has](https://yarnpkg.com/) [three](https://pnpm.io/). To serve code to the
browser, it gets bundled, and the list of bundlers is too long to include here.
[Webpack](https://webpack.js.org/), the most popular one, is famously difficult
to configure. JavaScript was built as a dynamic language which leads to a lot of
basic human errors, which are made while writing the code, only being discovered
when running the code. Static type systems aim to solve that problem and
[TypeScript](https://www.typescriptlang.org/) adds this onto JavaScript, but the
types only go so far (until they hit an `any` type, or dependencies with no type
definitions), and they disappear at runtime.

In short, upgrading JavaScript to something modern takes a lot of tooling.
Getting all this tooling set up and ready to build things is an all day job, and
so more tooling, like [Next.js](https://nextjs.org/) has popped up providing
this configuration in a box, batteries included. Perhaps the final admission of
this problem is the recent [Biome](https://biomejs.dev/blog/annoucing-biome/)
toolchain (formerly the Rome project), attempting to bring all the various tools
under one roof (and Biome itself is built in Rust...).

It's no wonder that even a working setup of all the tooling has sharp edges, and
cannot afford to be nearly as strict as tooling designed with strictness in
mind, such as Rust's. The heart of the problem is that computers are strict and
precise instruments, and humans are sloppy creatures. With enough humans (more
than 10, being generous) and no additional help, the resulting code will be
sloppy, full of unhandled edge cases, undefined behaviour being relied on,
circular dependencies preventing testing in isolation, etc. (and yes, these are
not hypotheticals).

Contrast that with Rust, which is as strict as it gets, and generally backs up
the claim that if it compiles it will work (and if you struggle to get it past
the compiler, it's probably a bad idea). The tooling and package management is
built in with `cargo`. There are fewer decisions to make when setting up a Rust
project.

In short, we think the JS ecosystem has jumped the shark, the "complexity
toothpaste" is out of the tube, and it's time to stop. But there's no real
viable alternative. Crux is our attempt to provide one.

---

---

1. In reality it's more like 1.4x effort build the same app for two platforms. [↩](#fr-once-1)

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
edition.workspac