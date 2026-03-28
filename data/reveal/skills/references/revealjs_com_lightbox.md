[![reveal.js logo](/images/logo/reveal-white-text.svg) ![reveal.js logo](/images/logo/reveal-black-text.svg) ![reveal.js logo](/images/logo/reveal-symbol.svg)](/ "reveal.js home")

`⌘K`

* [English](/en/lightbox) [繁體中文](/zh-Hant/lightbox)
* [Twitter icon](https://twitter.com/revealjs)
* [GitHub icon](https://github.com/hakimel/reveal.js)

* [GitHub icon](https://github.com/hakimel/reveal.js)

* Languages
  + [English](/en/lightbox)
  + [繁體中文](/zh-Hant/lightbox)
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

# Lightbox 5.2.0

A lightbox is a modal that displays an image or video in a full-screen overlay. It's great for things like clicking on thumbnails to view a larger [image](#image-lightbox) or [video](#video-lightbox).

## Image Lightbox

The simplest way to trigger a lightbox in reveal.js is to add the `data-preview-image` attribute to an `img` tag. Clicking on the image below, will open the same image in an overlay.

```
<img src="reveal.png" data-preview-image>
```

![](/images/logo/reveal-black-text-sticker.png)

Lightboxes aren't limited to opening the image src. You can open any image you like by assigning a value to the `data-preview-image` attribute.

```
<img src="reveal.png" data-preview-image="mastering.svg">
```

![](/images/logo/reveal-black-text-sticker.png)

## Video Lightbox

Video lightboxes work the same way as image lightboxes except you use the `data-preview-video` attribute instead.

```
<video src="video.mp4" data-preview-video></video>
<img src="reveal.png" data-preview-video="video.mp4">
```

[](https://static.slid.es/site/homepage/v1/homepage-video-editor.mp4)![](/images/logo/reveal-black-text-sticker.png)

## Lightbox Media Size

The sizing of media in the lightbox can be controlled using the `data-preview-fit` attribute. The following fit modes are supported:

| Value | Effect |
| --- | --- |
| scale-down (default) | Scale media down if needed to fit in the lightbox. |
| contain | Scale media up and down to fit the lightbox without cropping. |
| cover | Scale media to cover the entire lightbox, even if some of it is cut off. |

```
<img src="reveal.png" data-preview-image data-preview-fit="cover">
```

![](/images/logo/reveal-white-text.svg)

## Works on Any Element

Note that the lightbox feature works on any element, not just images and videos. For example, you can trigger an image or video lightbox from clicking a button or link.

```
<a data-preview-image="image.png">📸 Open Logo</a>
<button data-preview-video="video.mp4">🎥 Open Video</button>
```

📸 Open Logo

🎥 Open Video

## Iframe Lightbox

It's possible to preview links in iframe lightboxes using the `data-preview-link` attribute. When this attribute is added to an `<a>` tag, reveal.js will automatically open the link's `href` in an iframe.

If you want to open an iframe lightbox from another element, you can set the iframe source as a value to the `data-preview-link` attribute.

```
<a href="https://hakim.se" data-preview-link>Open Hakim's Website</a>
<img src="reveal.png" data-preview-link="https://hakim.se">
```

[Open Hakim's Website](https://hakim.se)

![](/images/logo/reveal-black-text-sticker.png)

Note that this will only work if the link allows for embedding. Many websites prevent embedding via `x-frame-options` or `Content-Security-Policy`.

[Created by @hakimel](https://twitter.com/hakimel) [X (Twitter)](https://twitter.com/revealjs) [GitHub](https://github.com/hakimel/reveal.js) [Edit this page](https://github.com/reveal/revealjs.com/tree/master/./src/lightbox.md)

[![](/images/slides-symbol-512x512.png)

Slides.com — the reveal.js presentation editor.

Try it for free arrow-right](https://slides.com)

[![](/images/docs/mastering.svg)

Become a reveal.js pro in the official video course.

Learn more arrow-right](/course)