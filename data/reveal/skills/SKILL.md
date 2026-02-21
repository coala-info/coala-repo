---
name: reveal
description: The reveal.js skill enables the creation of professional, high-performance presentations using standard web technologies.
homepage: https://github.com/hakimel/reveal.js
---

# reveal

## Overview
The reveal.js skill enables the creation of professional, high-performance presentations using standard web technologies. It transforms structured HTML or Markdown into interactive slides featuring nested navigation, auto-animation, and LaTeX support. Use this skill to guide the setup of the presentation boilerplate, manage the development server, and implement advanced features like speaker notes and PDF exports.

## Installation and Setup
The framework requires Node.js for the development environment to enable features like live reloading and Markdown processing.

1. **Clone/Download**: Obtain the source code from the repository.
2. **Install Dependencies**:
   ```bash
   npm install
   ```
3. **Start Development Server**:
   ```bash
   npm start
   ```
   This starts a local server (usually at `http://localhost:8000`) that automatically refreshes when files are modified.

## Core CLI Patterns
While reveal.js is a frontend framework, its lifecycle is managed via npm scripts:

- **`npm start`**: Runs the local development server.
- **`npm run build`**: Minifies CSS and JS for production deployment.
- **`npm test`**: Runs the test suite to validate framework integrity.

## Presentation Structure
A standard presentation is defined in `index.html`. The hierarchy must follow this pattern:

```html
<div class="reveal">
  <div class="slides">
    <section>Horizontal Slide</section>
    <section>
      <section>Vertical Slide 1</section>
      <section>Vertical Slide 2</section>
    </section>
  </div>
</div>
```

## Expert Tips and Best Practices

### Markdown Integration
To write slides in Markdown, ensure the `RevealMarkdown` plugin is initialized. Use the `data-markdown` attribute on a `<section>` to load external files or write inline:
- Use `data-separator` for horizontal slides (e.g., `^\n---\n$`).
- Use `data-separator-vertical` for vertical stacks (e.g., `^\n--\n$`).

### PDF Export
Reveal.js uses a specific print stylesheet. To export to PDF:
1. Open the presentation in Chrome or Chromium.
2. Append `?print-pdf` to the URL (e.g., `http://localhost:8000/?print-pdf`).
3. Open the Print dialog (Ctrl/Cmd + P).
4. Set the **Destination** to "Save as PDF" and ensure **Background graphics** is enabled.

### Auto-Animate
For seamless transitions between slides with matching elements, add the `data-auto-animate` attribute to consecutive `<section>` tags. Reveal.js will automatically interpolate changes in position, size, and color.

### Fragments
Use the `fragment` class to introduce elements sequentially on a single slide.
- **Step-by-step**: `<p class="fragment">First</p><p class="fragment">Second</p>`
- **Styles**: Use classes like `fade-up`, `grow`, or `highlight-red` to change the entrance effect.

### Speaker Notes
Add speaker notes by including an `<aside class="notes">` element inside any slide. Press 'S' on the keyboard during the presentation to open the Speaker View window, which displays notes, a timer, and upcoming slide previews.

## Reference documentation
- [reveal.js README](./references/github_com_hakimel_reveal.js.md)
- [reveal.js Wiki](./references/github_com_hakimel_reveal.js_wiki.md)