[![reveal.js logo](/images/logo/reveal-white-text.svg) ![reveal.js logo](/images/logo/reveal-black-text.svg) ![reveal.js logo](/images/logo/reveal-symbol.svg)](/ "reveal.js home")

`⌘K`

* [English](/en/pdf-export) [繁體中文](/zh-Hant/pdf-export)
* [Twitter icon](https://twitter.com/revealjs)
* [GitHub icon](https://github.com/hakimel/reveal.js)

* [GitHub icon](https://github.com/hakimel/reveal.js)

* Languages
  + [English](/en/pdf-export)
  + [繁體中文](/zh-Hant/pdf-export)
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

# PDF Export

Presentations can be exported to PDF via a special print stylesheet. Here's an example of an exported presentation that's been uploaded to SlideShare: <https://slideshare.net/hakimel/revealjs-300>.

Note: This feature has only been confirmed to work in [Google Chrome](https://google.com/chrome) and [Chromium](https://www.chromium.org/Home).

## Instructions

1. Open your presentation with `print-pdf` included in the query string, for example: `http://localhost:8000/?print-pdf`. You can test this at [revealjs.com/demo?print-pdf](/demo/?print-pdf).
2. Open the in-browser print dialog (CTRL/CMD+P).
3. Change the **Destination** setting to **Save as PDF**.
4. Change the **Layout** to **Landscape**.
5. Change the **Margins** to **None**.
6. Enable the **Background graphics** option.
7. Click **Save** 🎉

![Chrome Print Settings](https://s3.amazonaws.com/hakim-static/reveal-js/pdf-print-settings-2.png)

## Speaker Notes

Your [speaker notes](/speaker-view/) can be included in the PDF export by enabling the `showNotes`.

```
Reveal.configure({ showNotes: true });
```

Notes are printed in an overlay box on top of the slide. If you'd rather print them on a separate page, after the slide, set `showNotes` to `"separate-page"`.

```
Reveal.configure({ showNotes: 'separate-page' });
```

## Page Numbers

If you want to number printed pages, make sure to enable [slide numbers](/slide-numbers/).

## Page Size

Export dimensions are inferred from the configured [presentation size](/presentation-size/). Slides that are too tall to fit within a single page will expand onto multiple pages. You can limit how many pages a slide may expand to using the `pdfMaxPagesPerSlide` config option. For example, to ensures that no slide ever grows to more than one printed page you can set it to 1.

```
Reveal.configure({ pdfMaxPagesPerSlide: 1 });
```

## Separate Pages for Fragments

[Fragments](/fragments/) are printed on separate slides by default. Meaning if you have a slide with three fragment steps, it will generate three separate slides where the fragments appear incrementally.

If you prefer printing all fragments in their visible states on the same slide you can use the `pdfSeparateFragments` config option.

```
Reveal.configure({ pdfSeparateFragments: false });
```

## Alternative Ways to Export

You can also use [decktape](https://github.com/astefanutti/decktape) to convert your presentation to PDF via the command line.

[Created by @hakimel](https://twitter.com/hakimel) [X (Twitter)](https://twitter.com/revealjs) [GitHub](https://github.com/hakimel/reveal.js) [Edit this page](https://github.com/reveal/revealjs.com/tree/master/./src/pdf-export.md)

[![](/images/slides-symbol-512x512.png)

Slides.com — the reveal.js presentation editor.

Try it for free arrow-right](https://slides.com)

[![](/images/docs/mastering.svg)

Become a reveal.js pro in the official video course.

Learn more arrow-right](/course)