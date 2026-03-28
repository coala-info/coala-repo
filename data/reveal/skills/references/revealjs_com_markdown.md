[![reveal.js logo](/images/logo/reveal-white-text.svg) ![reveal.js logo](/images/logo/reveal-black-text.svg) ![reveal.js logo](/images/logo/reveal-symbol.svg)](/ "reveal.js home")

`⌘K`

* [English](/en/markdown) [繁體中文](/zh-Hant/markdown)
* [Twitter icon](https://twitter.com/revealjs)
* [GitHub icon](https://github.com/hakimel/reveal.js)

* [GitHub icon](https://github.com/hakimel/reveal.js)

* Languages
  + [English](/en/markdown)
  + [繁體中文](/zh-Hant/markdown)
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

# Markdown

It's possible and often times more convenient to write presentation content using Markdown. To create a Markdown slide, add the `data-markdown` attribute to your `<section>` element and wrap the contents in a `<textarea data-template>` like the example below.

```
<section data-markdown>
  <textarea data-template>
    ## Slide 1
    A paragraph with some text and a [link](https://hakim.se).
    ---
    ## Slide 2
    ---
    ## Slide 3
  </textarea>
</section>
```

Note that this is sensitive to indentation (avoid mixing tabs and spaces) and line breaks (avoid consecutive breaks).

## Markdown Plugin

This functionality is powered by the built-in Markdown plugin which in turn uses [marked](https://github.com/chjj/marked) for all parsing. The Markdown plugin is included in our default presentation examples. If you want to manually add it to a new presentation here's how:

```
<script src="dist/plugin/markdown.js"></script>
<script>
  Reveal.initialize({
    plugins: [RevealMarkdown],
  });
</script>
```

## External Markdown

You can write your content as a separate file and have reveal.js load it at runtime. Note the separator arguments which determine how slides are delimited in the external file: the `data-separator` attribute defines a regular expression for horizontal slides (defaults to `^\r?\n---\r?\n$`, a newline-bounded horizontal rule) and `data-separator-vertical` defines vertical slides (disabled by default). The `data-separator-notes` attribute is a regular expression for specifying the beginning of the current slide's speaker notes (defaults to `notes?:`, so it will match both "note:" and "notes:"). The `data-charset` attribute is optional and specifies which charset to use when loading the external file.

When used locally, this feature requires that reveal.js [runs from a local web server](/installation/#full-setup). The following example customizes all available options:

```
<section
  data-markdown="example.md"
  data-separator="^\n\n\n"
  data-separator-vertical="^\n\n"
  data-separator-notes="^Note:"
  data-charset="iso-8859-15"
>
  <!--
        Note that Windows uses `\r\n` instead of `\n` as its linefeed character.
        For a regex that supports all operating systems, use `\r?\n` instead of `\n`.
    -->
</section>
```

## Element Attributes

Special syntax (through HTML comments) is available for adding attributes to Markdown elements. This is useful for fragments, among other things.

```
<section data-markdown>
  <script type="text/template">
    - Item 1 <!-- .element: class="fragment" data-fragment-index="2" -->
    - Item 2 <!-- .element: class="fragment" data-fragment-index="1" -->
  </script>
</section>
```

## Slide Attributes

Special syntax (through HTML comments) is available for adding attributes to the slide `<section>` elements generated by your Markdown.

```
<section data-markdown>
  <script type="text/template">
    <!-- .slide: data-background="#ff0000" -->
      Markdown content
  </script>
</section>
```

## Syntax Highlighting

Powerful syntax highlighting features are built into reveal.js. Using the bracket syntax shown below, you can highlight individual lines and even walk through multiple separate highlights step-by-step. [Learn more about line highlights](/code/#line-numbers-highlights).

```
<section data-markdown>
  <textarea data-template>
    ```js [1-2|3|4]
    let a = 1;
    let b = 2;
    let c = x => 1 + 2 + x;
    c(3);
    ```
  </textarea>
</section>
```

```js [1-2|3|4]
let a = 1;
let b = 2;
let c = x => 1 + 2 + x;
c(3);
```

### Line Number Offset

You can add a [line number offset](/code/#line-number-offset-4.2.0) by adding a number and a colon at the beginning of your highlights.

```
<section data-markdown>
  <textarea data-template>
    ```js [712: 1-2|3|4]
    let a = 1;
    let b = 2;
    let c = x => 1 + 2 + x;
    c(3);
    ```
  </textarea>
</section>
```

```js [712: 1-2|3|4]
let a = 1;
let b = 2;
let c = x => 1 + 2 + x;
c(3);
```

## Configuring *marked*

We use [marked](https://github.com/chjj/marked) to parse Markdown. To customize marked's rendering, you can pass in options when [configuring Reveal](/config/):

```
Reveal.initialize({
  // Options which are passed into marked
  // See https://marked.js.org/using_advanced#options
  markdown: {
    smartypants: true,
  },
});
```

[Created by @hakimel](https://twitter.com/hakimel) [X (Twitter)](https://twitter.com/revealjs) [GitHub](https://github.com/hakimel/reveal.js) [Edit this page](https://github.com/reveal/revealjs.com/tree/master/./src/markdown.md)

[![](/images/slides-symbol-512x512.png)

Slides.com — the reveal.js presentation editor.

Try it for free arrow-right](https://slides.com)

[![](/images/docs/mastering.svg)

Become a reveal.js pro in the official video course.

Learn more arrow-right](/course)