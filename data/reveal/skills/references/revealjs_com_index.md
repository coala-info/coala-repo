![reveal.js](https://static.slid.es/reveal/logo-v1/reveal-white-text.svg)

### The HTML Presentation Framework

Created by [Hakim El Hattab](https://twitter.com/hakimel) and [contributors](https://github.com/hakimel/reveal.js/graphs/contributors)

Sponsored by [![](https://d1835mevib0k1p.cloudfront.net/reveal-js/sponsors/slides-mono-white.png)](https://slides.com)

## Hello There

reveal.js enables you to create beautiful interactive slide decks using HTML. This presentation will show you examples of what it can do.

## Vertical Slides

Slides can be nested inside of each other.

Use the *Space* key to navigate through all slides.

![Down arrow](https://static.slid.es/reveal/arrow.png)

## Basement Level 1

Nested slides are useful for adding additional detail underneath a high level horizontal slide.

## Basement Level 2

That's it, time to go back up.

[![Up arrow](https://static.slid.es/reveal/arrow.png)](#/2)

## Slides

Not a coder? Not a problem. There's a fully-featured visual editor for authoring these, try it out at <https://slides.com>.

## Pretty Code

```
                import React, { useState } from 'react';

                function Example() {
                  const [count, setCount] = useState(0);

                  return (
                    ...
                  );
                }
```

Code syntax highlighting courtesy of [highlight.js](https://highlightjs.org/usage/).

## Even Prettier Animations

```
                import React, { useState } from 'react';

                function Example() {
                  const [count, setCount] = useState(0);

                  return (
                    <div>
                      <p>You clicked {count} times</p>
                      <button onClick={() => setCount(count + 1)}>
                        Click me
                      </button>
                    </div>
                  );
                }

                function SecondExample() {
                  const [count, setCount] = useState(0);

                  return (
                    <div>
                      <p>You clicked {count} times</p>
                      <button onClick={() => setCount(count + 1)}>
                        Click me
                      </button>
                    </div>
                  );
                }
```

## Point of View

Press **ESC** to enter the slide overview.

Hold down the **alt** key (**ctrl** in Linux) and click on any element to zoom towards it using [zoom.js](https://lab.hakim.se/zoom-js). Click again to zoom back out.

(NOTE: Use ctrl + click in Linux.)

## Auto-Animate

Automatically animate matching elements across slides with [Auto-Animate](https://revealjs.com/auto-animate/).

## Auto-Animate

## Auto-Animate

## Touch Optimized

Presentations look great on touch devices, like mobile phones and tablets. Simply swipe through your slides.

Add the `r-fit-text` class to auto-size text

## FIT TEXT

## Fragments

Hit the next arrow...

... to step through ...

... a fragmented slide.

This slide has fragments which are also stepped through in the notes window.

## Fragment Styles

There's different types of fragments, like:

grow

shrink

fade-out

fade-right, up, down, left

fade-in-then-out

fade-in-then-semi-out

Highlight red blue green

## Transition Styles

You can select from different transitions, like:
[None](?transition=none#/transitions) - [Fade](?transition=fade#/transitions) - [Slide](?transition=slide#/transitions) - [Convex](?transition=convex#/transitions) - [Concave](?transition=concave#/transitions) - [Zoom](?transition=zoom#/transitions)

## Slide Backgrounds

Set `data-background="#dddddd"` on a slide to change the background color. All CSS color formats are supported.

![Down arrow](https://static.slid.es/reveal/arrow.png)

## Image Backgrounds

```
<section data-background="image.png">
```

## Tiled Backgrounds

```
<section data-background="image.png" data-background-repeat="repeat" data-background-size="100px">
```

## Video Backgrounds

```
<section data-background-video="video.mp4,video.webm">
```

## ... and GIFs!

## Background Transitions

Different background transitions are available via the backgroundTransition option. This one's called "zoom".

```
Reveal.configure({ backgroundTransition: 'zoom' })
```

## Background Transitions

You can override background transitions per-slide.

```
<section data-background-transition="zoom">
```

## Iframe Backgrounds

Since reveal.js runs on the web, you can easily embed other web content. Try interacting with the page in the background.

## Marvelous List

* No order here
* Or here
* Or here
* Or here

## Fantastic Ordered List

1. One is smaller than...
2. Two is smaller than...
3. Three!

## Tabular Tables

| Item | Value | Quantity |
| --- | --- | --- |
| Apples | $1 | 7 |
| Lemonade | $2 | 18 |
| Bread | $3 | 2 |

## Clever Quotes

These guys come in two forms, inline: "The nice thing about standards is that there are so many to choose from" and block:

> “For years there has been a theory that millions of monkeys typing at random on millions of typewriters would reproduce the entire works of Shakespeare. The Internet has proven this theory to be untrue.”

## Intergalactic Interconnections

You can link between slides internally, [like this](#/2/3).

## Speaker View

There's a [speaker view](https://revealjs.com/speaker-view/). It includes a timer, preview of the upcoming slide as well as your speaker notes.

Press the *S* key to try it out.

Oh hey, these are some notes. They'll be hidden in your presentation, but you can see them if you open the speaker notes window (hit 's' on your keyboard).

## Export to PDF

Presentations can be [exported to PDF](https://revealjs.com/pdf-export/), here's an example:

## Global State

Set `data-state="something"` on a slide and `"something"` will be added as a class to the document element when the slide is open. This lets you apply broader style changes, like switching the page background.

## State Events

Additionally custom events can be triggered on a per slide basis by binding to the `data-state` name.

```
Reveal.on( 'customevent', function() {
  console.log( '"customevent" has fired' );
} );
```

## Take a Moment

Press B or . on your keyboard to pause the presentation. This is helpful when you're on stage and want to take distracting slides off the screen.

## Much more

* Right-to-left support
* [Extensive JavaScript API](https://revealjs.com/api/)
* [Auto-progression](https://revealjs.com/auto-slide/)
* [Parallax backgrounds](https://revealjs.com/backgrounds/#parallax-background)
* [Custom keyboard bindings](https://revealjs.com/keyboard/)

# THE END

- [Try the online editor](https://slides.com)
- [Source code & documentation](https://github.com/hakimel/reveal.js)

[![reveal.js logo](/images/logo/reveal-white-text.svg) ![reveal.js logo](/images/logo/reveal-black-text.svg) ![reveal.js logo](/images/logo/reveal-symbol.svg)](/ "reveal.js home")

`⌘K`

* [English](/en/) [繁體中文](/zh-Hant/)
* [Twitter icon](https://twitter.com/revealjs)
* [GitHub icon](https://github.com/hakimel/reveal.js)

* [GitHub icon](https://github.com/hakimel/reveal.js)

* Languages
  + [English](/en/)
  + [繁體中文](/zh-Hant/)
* Getting Started
  + [Home](/)
  + [Demo](/?demo)
  + [Installation](/installation/)
  + [React NEW](/react/)
* Support
  + [Video Course](/course)
  + [Sponsor reveal.js arrow-right](https://github.com/sponsors/hakimel)
* Content
  + [Markup](/markup/)
  + [Markdown](/markdown/)
  + [Backgrounds](/backgrounds/)
  + [Media](/media/)
  + [Lightbox NEW](/lightbox/)
  + [Code](/code/)
  + [Math](/math/)
  + [Fragments](/fragments/)
  + [Links](/links/)
  + [Layout](/layout/)
  + [Slide Visibility](/slide-visibility/)
* Customization
  + [Themes](/themes/)
  + [Transitions](/transitions/)
  + [Config Options](/config/)
  + [Presentation Size](/presentation-size/)
* Features
  + [Vertical Slides](/vertical-slides/)
  + [Auto-Animate](/auto-animate/)
  + [Auto-Slide](/auto-slide/)
  + [Speaker View](/speaker-view/)
  + [Scroll View NEW](/scroll-view/)
  + [Slide Numbers](/slide-numbers/)
  + [Jump to Slide](/jump-to-slide/)
  + [Touch Navigation](/touch-navigation/)
  + [PDF Export](/pdf-export/)
  + [Overview Mode](/overview/)
  + [Fullscreen Mode](/fullscreen/)
* API
  + [Initialization](/initialization/)
  + [API Methods](/api/)
  + [Events](/events/)
  + [Keyboard](/keyboard/)
  + [Presentation State](/presentation-state/)
  + [postMessage](/postmessage/)
* Initialization
  + [Using Plugins](/plugins/)
  + [Built-in Plugins](/plugins/#built-in-plugins)
  + [Creating a Plugin](/creating-plugins/)
  + [Multiplex](/multiplex/)
  + [Third Party Plugins arrow-right](https://github.com/hakimel/reveal.js/wiki/Plugins%2C-Tools-and-Hardware)
* Other
  + [Upgrade Instructions](/upgrading/)
  + [Changelog arrow-right](https://github.com/hakimel/reveal.js/releases)
  + [React (Manual Setup)](/react-legacy/)

# Create Stunning Presentations on the Web

reveal.js is an open source HTML presentation framework. It's a tool that enables anyone with a web browser to create fully-featured and beautiful presentations for free.

Presentations made with reveal.js are built on open web technologies. That means anything you can do on the web, you can do in your presentation. Change styles with CSS, include an external web page using an `<iframe>` or add your own custom behavior using our [JavaScript API](/api).

The framework comes with a broad range of features including [nested slides](/vertical-slides/), [Markdown support](/markdown/), [Auto-Animate](/auto-animate/), [PDF export](/pdf-export/), [speaker notes](/speaker-view/), [LaTeX support](/math/) and [syntax highlighted code](/code/).

## Ready to Get Started?

It only takes a minute to get set up. Learn how to create your first presentation in the [installation instructions](/installation/)!

## Online Editor

If you want the benefits of reveal.js without having to write HTML or Markdown try [https://slides.com](https://slides.com?ref=github). It's a fully-featured visual editor and platform for reveal.js, by the same creator.

## Supporting reveal.js

This project was started and is maintained by [@hakimel](https://github.com/hakimel/) with the help of many [contributions from the community](https://github.com/hakimel/reveal.js/graphs/contributors). The best way to support the project is to [become a paying member of Slides.com](https://slides.com/pricing)—the reveal.js presentation platform that Hakim is building.

[Created by @hakimel](https://twitter.com/hakimel) [X (Twitter)](https://twitter.com/revealjs) [GitHub](https://github.com/hakimel/reveal.js) [Edit this page](https://github.com/reveal/revealjs.com/tree/master/./src/index.md)

[![](/images/slides-symbol-512x512.png)

Slides.com — the reveal.js presentation editor.

Try it for free arrow-right](https://slides.com)

[![](/images/docs/mastering.svg)

Become a reveal.js pro in the official video course.

Learn more arrow-right](/course)