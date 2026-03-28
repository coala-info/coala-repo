[![reveal.js logo](/images/logo/reveal-white-text.svg) ![reveal.js logo](/images/logo/reveal-black-text.svg) ![reveal.js logo](/images/logo/reveal-symbol.svg)](/ "reveal.js home")

`⌘K`

* [English](/en/installation) [繁體中文](/zh-Hant/installation)
* [Twitter icon](https://twitter.com/revealjs)
* [GitHub icon](https://github.com/hakimel/reveal.js)

* [GitHub icon](https://github.com/hakimel/reveal.js)

* Languages
  + [English](/en/installation)
  + [繁體中文](/zh-Hant/installation)
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

# Installation

We provide three different ways to install reveal.js depending on your use case and technical experience.

1. The [basic setup](#basic-setup) is the easiest way to get started. No need to set up any build tools.
2. The [full setup](#full-setup) gives you access to the build tools needed to make changes to the reveal.js source code. It includes a web server which is required if you want to load external Markdown files (the basic setup paired with your own choice of local web server works too).
3. If you want to use reveal.js as a dependency in your project, you can [install from npm](#installing-from-npm).

#### Next Steps

Once reveal.js is installed, we recommend checking out the [Markup](/markup/) and [Config Option](/config/) guides.

## Basic Setup

We make a point of distributing reveal.js in a way that it can be used by as many people as possible. The basic setup is our most broadly accessible way to get started and only requires that you have a web browser. There's no need to go through a build process or install any dependencies.

1. Download the latest reveal.js version <https://github.com/hakimel/reveal.js/archive/master.zip>
2. Unzip and replace the example contents in index.html with your own
3. Open index.html in a browser to view it

That's it 🚀

## Full Setup - Recommended

Some reveal.js features, like external Markdown, require that presentations run from a local web server. The following instructions will set up such a server as well as all of the development tasks needed to make edits to the reveal.js source code.

1. Install [Node.js](https://nodejs.org/) (20.19.0 or later)
2. Clone the reveal.js repository

   ```
   $ git clone https://github.com/hakimel/reveal.js.git
   ```
3. Move to the reveal.js folder and install dependencies

   ```
   $ cd reveal.js && npm install
   ```
4. Serve the presentation and monitor source files for changes

   ```
   $ npm start
   ```
5. Open <http://localhost:8000> to view your presentation

### Development Server Port

The development server defaults to port 8000. You can use the `port` argument to switch to a different one:

```
npm start -- --port=8001
```

## Installing From npm

The framework is published to, and can be installed from, [npm](https://www.npmjs.com/package/reveal.js).

```
npm install reveal.js
# or
yarn add reveal.js
```

Once installed, you can include reveal.js as an ES module:

```
import Reveal from 'reveal.js';
import Markdown from 'reveal.js/plugin/markdown';

let deck = new Reveal({
  plugins: [Markdown],
});
deck.initialize();
```

You'll also need to include the reveal.js styles and a [presentation theme](/themes/).

```
import 'reveal.js/reveal.css';
import 'reveal.js/theme/black.css';
```

[Created by @hakimel](https://twitter.com/hakimel) [X (Twitter)](https://twitter.com/revealjs) [GitHub](https://github.com/hakimel/reveal.js) [Edit this page](https://github.com/reveal/revealjs.com/tree/master/./src/installation.md)

[![](/images/slides-symbol-512x512.png)

Slides.com — the reveal.js presentation editor.

Try it for free arrow-right](https://slides.com)

[![](/images/docs/mastering.svg)

Become a reveal.js pro in the official video course.

Learn more arrow-right](/course)