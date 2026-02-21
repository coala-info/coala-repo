---
name: skewer
description: Skewer transforms Emacs into a live development environment for the web by establishing a bridge between the editor and one or more browser tabs.
homepage: https://github.com/skeeto/skewer-mode
---

# skewer

## Overview

Skewer transforms Emacs into a live development environment for the web by establishing a bridge between the editor and one or more browser tabs. It functions similarly to an inferior Lisp process, allowing you to send snippets of JavaScript, CSS rules, or HTML tags directly to a live browser instance. This enables rapid prototyping and debugging without the need for manual page refreshes, making it ideal for fine-tuning UI components or inspecting application state in real-time.

## Usage Instructions

### Setup and Connection
- **Start Skewer**: Run `M-x run-skewer`. This starts the internal HTTP server (via `simple-httpd`) and opens your default browser to a blank "skewered" page.
- **Manual Integration**: To skewer an existing project not hosted by Emacs, include the Skewer script in your HTML:
  `<script src="http://localhost:8080/skewer"></script>`
- **CORS Support**: Skewer supports Cross-Origin Resource Sharing, allowing you to interact with pages hosted on different local or remote servers as long as the script is injected.

### JavaScript Interaction (`skewer-mode`)
Enable `skewer-mode` in your JavaScript buffers (works best with `js2-mode`).
- `C-x C-e`: Evaluate the expression immediately before the point. The result appears in the minibuffer.
- `C-M-x`: Evaluate the top-level form (function or object) around the point.
- `C-c C-k`: Load the entire current buffer into the browser.
- `C-u C-x C-e`: Evaluate and insert the result directly into the current Emacs buffer.

### CSS and HTML Interaction
Enable `skewer-css-mode` or `skewer-html-mode` in respective buffers.
- **CSS**:
  - `C-x C-e`: Load the specific declaration at the point.
  - `C-M-x`: Load the entire CSS rule surrounding the point.
  - `C-c C-k`: Load the entire buffer as a stylesheet, replacing previous Skewer-managed styles.
- **HTML**:
  - `C-M-x`: Evaluate the HTML tag immediately around the point, updating it in the browser DOM.

### The REPL
- **Open REPL**: Run `M-x skewer-repl` or use `C-c C-z` from a skewer-enabled buffer.
- **Logging**: Use `skewer.log(msg)` in your JavaScript code to send output to the Emacs REPL buffer instead of the browser console.
- **Multiple Clients**: Use `M-x list-skewer-clients` to manage multiple attached browsers or tabs. Expressions are sent to all attached clients simultaneously.

## Expert Tips
- **Reconnecting**: If the browser loses connection after long periods of inactivity, call `skewer()` in the browser's developer console to reconnect without reloading the page.
- **Bower Integration**: Use `M-x skewer-bower-load` to quickly inject common libraries (like jQuery) into the current page for testing, even if they aren't part of the project source.
- **Bookmarklet**: For quick debugging on any website, use a bookmarklet to inject the script:
  `javascript:(function(){var d=document;var s=d.createElement('script');s.src='http://localhost:8080/skewer';d.body.appendChild(s);})()`

## Reference documentation
- [Skewer Mode README](./references/github_com_skeeto_skewer-mode.md)