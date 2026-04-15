---
name: xmlbuilder
description: xmlbuilder is a Node.js library for constructing XML trees using a fluent, chainable API. Use when user asks to generate configuration files, RSS feeds, data interchange formats, build XML trees, or convert JavaScript objects to XML.
homepage: https://github.com/oozcitak/xmlbuilder-js
metadata:
  docker_image: "quay.io/biocontainers/xmlbuilder:1.0--py35_0"
---

# xmlbuilder

## Overview

xmlbuilder is a specialized Node.js library for constructing XML trees through a fluent, chainable API. It eliminates the risks of manual string concatenation by automatically handling escaping, attribute formatting, and document prologues. Use this skill to generate configuration files, RSS feeds, or data interchange formats where XML structure and validity are required.

## Core Workflows

### Initialize the Document

Choose the appropriate entry point based on your requirements:

*   **Standard Creation**: Use `create(name, [xmldec], [doctype], [options])` to start with a root element and default XML declaration.
*   **Empty Document**: Use `begin([options])` to start without a root element or prologue.
*   **Streaming/Low Memory**: Use `begin(callback)` to process chunks as they are generated, preventing the entire tree from being stored in memory.

### Build the Tree

Use chainable methods to define the structure:

*   **Add Elements**: Use `.ele(name, [attributes], [text])` or `.node(name)`.
*   **Add Attributes**: Use `.att(name, value)` on any element.
*   **Add Text**: Use `.txt(content)` for escaped text or `.raw(content)` for unescaped data.
*   **Navigation**: Use `.up()` to move to the parent node or `.root()` to return to the top level.
*   **Special Nodes**: Use `.com(text)` for comments, `.dat(text)` for CDATA, and `.ins(target, value)` for processing instructions.

### Convert Objects to XML

Pass a JavaScript object to `create()` or `ele()` for rapid serialization:

*   **Attributes**: Prefix keys with `@` (e.g., `'@type': 'git'`).
*   **Text Nodes**: Use the `#text` key for element values.
*   **CDATA**: Use the `#cdata` key.
*   **Comments**: Use the `#comment` key.
*   **Functions**: Use functions as values to generate dynamic content during serialization.

### Finalize and Export

Call `.end(options)` to generate the final string:

*   **Pretty Printing**: Set `{ pretty: true }` for indented output.
*   **Indentation**: Customize with `indent` and `newline` options.
*   **Headless**: Set `headless: true` in the builder options to omit the XML declaration.

## Expert Tips

*   **Performance**: For very large XML files, always use the `begin(chunk => { ... })` callback pattern to avoid `RangeError: Invalid string length` or memory exhaustion.
*   **Validation**: By default, the builder performs basic validation. Disable it with `noValidation: true` in options if you are handling pre-validated data and need a performance boost.
*   **Custom Stringification**: Use the `stringify` option in the constructor to define custom logic for handling nulls or specific data types before they are written to the XML.
*   **Node Insertion**: Use `insertBefore(name)` and `insertAfter(name)` to manage element order when building non-sequential structures.

## Reference documentation

- [Main README](./references/github_com_oozcitak_xmlbuilder-js.md)
- [API and Wiki Details](./references/github_com_oozcitak_xmlbuilder-js_wiki.md)