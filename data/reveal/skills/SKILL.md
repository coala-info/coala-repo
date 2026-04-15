---
name: reveal
description: Reveal.js is an HTML framework for creating professional, interactive slide decks using web technologies. Use when user asks to create presentations, author slides in Markdown, set up a local development server, or export slide decks to PDF.
homepage: https://github.com/hakimel/reveal.js
metadata:
  docker_image: "quay.io/biocontainers/reveal:0.1--py27_1"
---

# reveal

## Overview
Reveal.js is a robust HTML presentation framework that enables the creation of professional, interactive slide decks using standard web technologies. It is particularly useful for developers and technical presenters who prefer version-controlling their content, using Markdown for slide authoring, or integrating live code and data visualizations directly into their presentations. This skill provides guidance on setting up the environment, managing slide structure, and utilizing advanced framework features via the command line and HTML attributes.

## Installation and Setup
To begin working with reveal.js locally, use the following npm commands:

1. **Install dependencies**:
   ```bash
   npm install
   ```
2. **Start the development server**:
   ```bash
   npm start
   ```
   This launches a local server (usually at `http://localhost:8000`) with live-reloading enabled.

## Core Presentation Structure
Reveal.js uses nested `<section>` elements to define the flow of the presentation.

- **Horizontal Slides**: Created by top-level `<section>` elements.
- **Vertical Slides**: Created by nesting `<section>` elements inside a parent `<section>`. This is useful for grouping sub-topics without cluttering the main horizontal timeline.
- **Fragments**: Use the `fragment` class on elements (e.g., `<p class="fragment">`) to introduce content step-by-step on a single slide.

## Markdown Integration
You can author slides in Markdown to keep content separate from layout.

- **External Markdown**: Use the `data-markdown` attribute to load a file:
  ```html
  <section data-markdown="example.md" 
           data-separator="^\n---\n$" 
           data-separator-vertical="^\n--\n$">
  </section>
  ```
- **Internal Markdown**: Wrap content in a `<script type="text/template">` tag inside a `<section data-markdown>`.

## Advanced Features and Best Practices
- **Auto-Animate**: Add the `data-auto-animate` attribute to two consecutive slides. Reveal.js will automatically animate elements with matching content or `data-id` attributes.
- **PDF Export**: To generate a PDF, open the presentation in Chrome with `?print-pdf` appended to the URL (e.g., `http://localhost:8000/?print-pdf`), then use the system print dialog to "Save as PDF".
- **Speaker Notes**: Add a `<aside class="notes">` element inside any slide. Press 'S' during the presentation to open the speaker view window.
- **Code Highlighting**: Use `<pre><code>` blocks. You can highlight specific lines using the `data-line-numbers` attribute (e.g., `data-line-numbers="3,8-10"`).

## Expert Tips
- **Slide Visibility**: Use `data-visibility="uncounted"` to keep a slide in the deck but exclude it from the progress bar, or `data-visibility="hidden"` to skip it entirely.
- **Backgrounds**: Customize individual slides using `data-background-color`, `data-background-image`, or `data-background-video`.
- **Keyboard Shortcuts**: 
  - `F`: Fullscreen mode.
  - `O` or `ESC`: Overview mode.
  - `B` or `.`: Pause/Blackout screen.



## Subcommands

| Command | Description |
|---------|-------------|
| reveal align | Construct a population graph from input genomes or other graphs. |
| reveal comp | Reverse complement the graph. |
| reveal convert | Convert gfa graph to gml. |
| reveal extract | Extract the input sequence from a graph. |
| reveal finish | Finish a draft assembly by ordering and orienting contigs with respect to a finished reference assembly. |
| reveal merge | Combine multiple gfa graphs into a single gfa graph. |
| reveal plot | Generate mumplot for two fasta files. |
| reveal realign | Realign between two nodes in the graph. |
| reveal subgraph | Extract subgraph from gfa by specified node ids. |
| reveal_bubbles | Extract all bubbles from the graph. |
| reveal_matches | Outputs all (multi) m(u/e)ms. |

## Reference documentation
- [Installation](./references/revealjs_com_installation.md)
- [Markdown Support](./references/revealjs_com_markdown.md)
- [Vertical Slides](./references/revealjs_com_vertical-slides.md)
- [Auto-Animate](./references/revealjs_com_auto-animate.md)
- [PDF Export](./references/revealjs_com_pdf-export.md)
- [Speaker View](./references/revealjs_com_speaker-view.md)