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

# [Hello world](#hello-world)

As the first step, we will build a simple application, starting with a classic
Hello World, adding some state, and finally a remote API call. We will focus on
the core, rely on tests to tell us things work, and return to the shell a little
later, so unfortunately there won't be much to see until then.

If you want to follow along, you should start by following the
[Shared core and types](../getting_started/core.html), guide to set up the
project.

## [Creating an app](#creating-an-app)

Example

You can find the full code for this part of the guide [here](https://github.com/redbadger/crux/blob/master/examples/hello_world/shared/src/app.rs)

To start with, we need a `struct` to be the root of our app.

```
#[derive(Default)]
pub struct Hello;
```

We need to implement `Default` so that Crux can construct the app for us.

To turn it into an app, we need to implement the `App` trait from the
`crux_core` crate.

```
use crux_core::App;

impl App for Hello {}
```

If you're following along, the compiler is now screaming at you that you're
missing five associated types for the trait — `Event`, `Model`, `ViewModel`,
`Capabilities`, (which will be deprecated soon, and can be set to `()`) and `Effect`.

The `Effect` associated type is worth understanding further, but in order to do that we need to talk about what makes Crux different from most UI frameworks.

## [Side-effects and capabilities](#side-effects-and-capabilities)

One of the key design choices in Crux is that the Core is free of side-effects
(besides its internal state). Your application can never *perform* anything that
directly interacts with the environment around it - no network calls, no
reading/writing files, and (somewhat obviously) not even updating the screen.
Actually *doing* all those things is the job of the Shell, the core can only
*ask* for them to be done.

This makes the core portable between platforms, and, importantly, really easy to
test. It also separates the intent, the "functional" requirements, from the
implementation of the side-effects and the "non-functional" requirements (NFRs).
For example, your application knows it wants to store data in a SQL database,
but it doesn't need to know or care whether that database is local or remote.
That decision can even change as the application evolves, and be different on
each platform. If you want to understand this better before we carry on, you can
read a lot more about how side-effects work in Crux in the chapter on
[Managed Effects](./effects.html).

To *ask* the Shell for side effects, it will need to know what side effects it
needs to handle, so we will need to declare them (as an enum). *Effects* are
simply messages describing what should happen, and for more complex side-effects
(e.g. HTTP), they would be too unwieldy to create by hand, so to help us create
them, Crux provides *capabilities* - reusable libraries which give us a nice API
for requesting side-effects. We'll look at them in a lot more detail later.

Let's start with the basics:

```
use crux_core::{
    macros::effect,
    render::RenderOperation,
};

#[effect]
pub enum Effect {
    Render(RenderOperation),
}
```

As you can see, for now, we will use a single capability, `crux_core::render`, which declares an `Operation` named `RenderOperation`, is built into Crux and is available from the `crux_core` crate. It simply tells the shell to update the screen using the latest information.

That means the core can produce a single `Effect`. It will soon be more than one, so we'll wrap it in an enum to give ourselves space. We'll also annotate our `Effect` enum with the `crux_core::macros::effect` attribute, which produces a *real* `Effect` enum (which is very similar), one for FFI across the boundary to the shell, and various trait implementations and test helpers.

We also need to link the effect to our app. We'll go into the detail of why that is in the [Managed Effects](effects.html) section, but the basic reason is that capabilities need to be able to send the outcomes of their work back into the app.

You probably also noticed the `Event` type, which defines messages that can be sent back to the app. The same type is also used by the Shell to forward any user interactions to the Core, and in order to pass across the FFI boundary, it needs to be serializable. The resulting code will end up looking like this:

```
use crux_core::{App, macros::effect, render::RenderOperation};
use serde::{Deserialize, Serialize};

#[effect]
pub enum Effect {
    Render(RenderOperation),
}

#[derive(Serialize, Deserialize)]
pub enum Event {
    None, // we can't instantiate an empty enum, so let's have a dummy variant for now
}

#[derive(Default)]
pub struct Hello;

impl App for Hello {}
```

Okay, that took a little bit of effort, but with this short detour out of the
way and foundations in place, we can finally create an app and start
implementing some behavior.

## [Implementing the `App` trait](#implementing-the-app-trait)

We now have almost all the building blocks to implement the `App` trait. We're
just missing two simple types. First, a `Model` to keep our app's state, it
makes sense to make that a struct. It needs to implement `Default`, which gives
us an opportunity to set up any initial state the app might need. Second, we
need a `ViewModel`, which is a representation of what the user should see on
screen. It might be tempting to represent the state and the view with the same
type, but in more complicated cases it will be too constraining, and probably
non-obvious what data are for internal bookkeeping and what should end up on
screen, so Crux separates the concepts. Nothing stops you using the same type
for both `Model` and `ViewModel` if your app is simple enough.

We'll start with a few simple types for events, model and view model.

Now we can finally implement the trait with its two methods, `update` and
`view`.

```
use crux_core::{
    macros::effect,
    render::{render, RenderOperation},
    App, Command,
};
use serde::{Deserialize, Serialize};

#[effect]
pub enum Effect {
    Render(RenderOperation),
}

#[derive(Serialize, Deserialize)]
pub enum Event {
    None,
}

#[derive(Default)]
pub struct Model;

#[derive(Serialize, Deserialize)]
pub struct ViewModel {
    pub data: String,
}

#[derive(Default)]
pub struct Hello;

impl App for Hello {
    type Effect = Effect;
    type Event = Event;
    type Model = Model;
    type ViewModel = ViewModel;
    type Capabilities = (); // will be deprecated, so use unit type for now

    fn update(
        &self,
        _event: Self::Event,
        _model: &mut Self::Model,
        _caps: &(), // will be deprecated, so prefix with underscore for now
    ) -> Command<Effect, Event> {
        render()
    }

    fn view(&self, _model: &Self::Model) -> Self::ViewModel {
        ViewModel {
            data: "Hello World".to_string(),
        }
    }
}
```

The `update` function is the heart of the app. It responds to events by
(optionally) updating the state and requesting some effects by using the
capability's APIs.

All our `update` function does is ignore all its arguments and ask the Shell to
render the screen. It's a hello world after all.

The `view` function returns the representation of what we want the Shell to show
on screen. And true to form, it returns an instance of the `ViewModel` struct
containing `Hello World!`.

That's a working hello world done, lets try it. As we said at the beginning, for
now we'll do it from tests. It may sound like a concession, but in fact, this is
the intended way for apps to be developed with Crux - from inside out, with unit
tests, focusing on behavior first and presentation later, roughly corresponding
to doing the user experience first, then the visual design.

Here's our test:

```
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn hello_says_hello_world() {
        let hello = Hello;
        let mut model = Model;

        // Call 'update' and request effects
        let mut cmd = hello.update(Event::None, &mut model, &());

        // Check update asked us to `Render`
        cmd.expect_one_effect().expect_render();

        // Make sure the view matches our expectations
        let actual_view = &hello.view(&model).data;
        let expected_view = "Hello World";
        assert_eq!(actual_view, expected_view);
    }
}
```

It is a fairly underwhelming test, but it should pass (check with `cargo test`).
The test uses a testing helper from `crux_core::testing` that lets us easily
interact with the app, inspect the effects it requests and its state, without
having to set up the machinery every time. It's not exactly complicated, but
it's a fair amount of boiler plate code.

## [Counting up and down](#counting-up-and-down)

Example

You can find the full code for this part of the guide
[here](https://github.com/redbadger/crux/blob/master/examples/simple_counter/shared/src/app.rs)

Let's make things more interesting and add some behaviour. We'll teach the app
to count up and down. First, we'll need a model, which represents the state. We
could just make our model a number, but we'll go with a struct instead, so that
we can easily add more state later.

```
#[derive(Default)]
pub struct Model {
    count: isize,
}
```

We need `Default` implemented to define the initial state. For now we derive it,
as our state is quite simple. We also update the app to show the current count:

```
impl App for Hello {
// ...

    type Model = Model;

// ...

    fn view(&self, model: &Self::Model) -> Self::ViewModel {
        ViewModel {
            count: format!("Count is: {}", model.count),
        }
    }
}
```

We'll also need a simple `ViewModel` struct to hold the data that the Shell will
render.

```
#[derive(Serialize, Deserialize)]
pub struct ViewModel {
    count: String,
}
```

Great. All that's left is adding the behaviour. That's where `Event` comes in:

```
#[derive(Serialize, Deserialize)]
pub enum Event {
    Increment,
    Decrement,
    Reset,
}
```

The event type covers all the possible events the app can respond to. "Will that
not get massive really quickly??" I hear you ask. Don't worry about that, there
is [a nice way to make this scale](./composing.html) and get reuse as well. Let's
carry on. We need to actually handle those messages.

```
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
// ...
```

Pretty straightforward, we just do what we're told, update the state, and then
tell the Shell to render. Lets update the tests to check everything works as
expected.

```
#[cfg(test)]
mod test {
    use super::*;
    use crux_core::assert_effect;

    #[test]
    fn renders() {
        let app = Counter;
        let mut model = Model::default();

        let mut cmd = app.update(Event::Reset, &mut model, &());

        // Check update asked us to `Render`
        assert_effect!(cmd, Effect::Render(_));
    }

    #[test]
    fn shows_initial_count() {
        let app = Counter;
        let model = Model::default();

        let actual_view = app.view(&model).count;
        let expected_view = "Count is: 0";
        assert_eq!(actual_view, expected_view);
    }

    #[test]
    fn increments_count() {
        let app = Counter;
        let mut model = Model::default();

        let mut cmd = app.update(Event::Increment, &mut model, &());

        let actual_view = app.view(&model).count;
        let expected_view = "Count is: 1";
        assert_eq!(actual_view, expected_view);

        // Check update asked us to `Render`
        assert_effect!(cmd, Effect::Render(_));
    }

    #[test]
    fn decrements_count() {
        let app = Counter;
        let mut model = Model::default();

        let mut cmd = app.update(Event::Decrement, &mut model, &());

        let actual_view = app.view(&model).count;
        let expected_view = "Count is: -1";
        assert_eq!(actual_view, expected_view);

        // Check update asked us to `Render`
        assert_effect!(cmd, Effect::Render(_));
    }

    #[test]
    fn resets_count() {
        let app = Counter;
        let mut model = Model::default();

        let _ = app.update(Event::Increment, &mut model, &());
        let _ = app.update(Event::Reset, &mut model, &());

        let actual_view = app.view(&model).count;
        let expected_view = "Count is: 0";
        assert_eq!(actual_view, expected_view);
    }

    #[test]
    fn counts_up_and_down() {
        let app = Counter;
        let mut model = Model::default();

        let _ = app.update(Event::Increment, &mut model, &());
        let _ = app.update(Event::Reset, &mut model, &());
        let _ = app.update(Event::Decrement, &mut model, &());
        let _ = app.update(Event::Increment, &mut model, &());
        let _ = app.update(Event::Increment, &mut model, &());

        let actual_view = app.view(&model).count;
        let expected_view = "Count is: 1";
        assert_eq!(actual_view, expected_view);
    }
}
```

Hopefully those all pass. We are now sure that when we build an actual UI for
this, it will *work*, and we'll be able to focus on making it looking
delightful.

In more complicated cases, it might be helpful to inspect the `model` directly.
It's up to you to make the call of which one is more appropriate, in some sense
it's the difference between black-box and white-box testing, so you should
probably be doing both to get the confidence you need that your app is working.

## [Remote API](#remote-api)

Before we dive into the thinking behind the architecture, let's add one more
feature - a remote API call - to get a better feel for how side-effects and
capabilities work.

Example

You can find the full code for this part of the guide [here](https://github.com/redbadger/crux/blob/master/examples/counter/shared/src/app.rs)

We'll add a simple integration with a counter API we've prepared at
<https://crux-counter.fly.dev>. All it does is count up and down like our local
counter. It supports three requests

* `GET /` ret