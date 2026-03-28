[![reveal.js logo](/images/logo/reveal-white-text.svg) ![reveal.js logo](/images/logo/reveal-black-text.svg) ![reveal.js logo](/images/logo/reveal-symbol.svg)](/ "reveal.js home")

`⌘K`

* [English](/en/layout) [繁體中文](/zh-Hant/layout)
* [Twitter icon](https://twitter.com/revealjs)
* [GitHub icon](https://github.com/hakimel/reveal.js)

* [GitHub icon](https://github.com/hakimel/reveal.js)

* Languages
  + [English](/en/layout)
  + [繁體中文](/zh-Hant/layout)
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

# Layout

We provide a few different helper classes for controlling the layout and styling your content. We're aiming to add more of these in upcoming versions so keep an eye out for that.

If you're looking to change the sizing, scaling and centering of your presentation please see [Presentation Size](/presentation-size/).

## Stack

The `r-stack` layout helper lets you center and place multiple elements on top of each other. This is intended to be used together with [fragments](/fragments/) to incrementally reveal elements.

```
<div class="r-stack">
  <img
    class="fragment"
    src="https://picsum.photos/450/300"
    width="450"
    height="300"
  />
  <img
    class="fragment"
    src="https://picsum.photos/300/450"
    width="300"
    height="450"
  />
  <img
    class="fragment"
    src="https://picsum.photos/400/400"
    width="400"
    height="400"
  />
</div>
```

![](https://picsum.photos/450/300) ![](https://picsum.photos/300/450) ![](https://picsum.photos/400/400)

If you want to show each of the stacked elements individually you can adjust the fragment settings:

```
<div class="r-stack">
  <img
    class="fragment fade-out"
    data-fragment-index="0"
    src="https://picsum.photos/450/300"
    width="450"
    height="300"
  />
  <img
    class="fragment current-visible"
    data-fragment-index="0"
    src="https://picsum.photos/300/450"
    width="300"
    height="450"
  />
  <img
    class="fragment"
    src="https://picsum.photos/400/400"
    width="400"
    height="400"
  />
</div>
```

![](https://picsum.photos/450/300) ![](https://picsum.photos/300/450) ![](https://picsum.photos/400/400)

## Fit Text

The `r-fit-text` class makes text as large as possible without overflowing the slide. This is great when you want BIG text without having to manually find the right font size. Powered by [fitty](https://github.com/rikschennink/fitty) ❤️

```
<h2 class="r-fit-text">BIG</h2>
```

## BIG

```
<h2 class="r-fit-text">FIT TEXT</h2>
<h2 class="r-fit-text">CAN BE USED FOR MULTIPLE HEADLINES</h2>
```

## FIT TEXT

## CAN BE USED FOR MULTIPLE HEADLINES

## Stretch

The `r-stretch` layout helper lets you resize an element, like an image or video, to cover the remaining vertical space in a slide. For example, in the below example our slide contains a **title**, an **image** and a **byline**. Because the **image** has the `.r-stretch` class, its height is set to the slide height minus the combined height of the **title** and **byline**.

```
<h2>Stretch Example</h2>
<img class="r-stretch" src="/images/slides-symbol-512x512.png" />
<p>Image byline</p>
```

## Stretch Example

![](/images/slides-symbol-512x512.png)

Image byline

#### Stretch Limitations

* Only direct descendants of a slide section can be stretched
* Only one descendant per slide section can be stretched

## Frame

Decorate any element with `r-frame` to make it stand out against the background. If the framed element is placed inside an anchor, we'll apply a hover effect to the border.

```
<img src="logo.svg" width="200" />
<a href="#">
  <img class="r-frame" src="logo.svg" width="200" />
</a>
```

![](/images/logo/reveal-symbol.svg) ![](/images/logo/reveal-symbol.svg)

[Created by @hakimel](https://twitter.com/hakimel) [X (Twitter)](https://twitter.com/revealjs) [GitHub](https://github.com/hakimel/reveal.js) [Edit this page](https://github.com/reveal/revealjs.com/tree/master/./src/layout.md)

[![](/images/slides-symbol-512x512.png)

Slides.com — the reveal.js presentation editor.

Try it for free arrow-right](https://slides.com)

[![](/images/docs/mastering.svg)

Become a reveal.js pro in the official video course.

Learn more arrow-right](/course)