---
name: expat
description: The `node-expat` library is a Node.js binding for the `libexpat` C library, providing one of the fastest XML SAX (Simple API for XML) parsers available for the Node ecosystem.
homepage: https://github.com/xmppo/node-expat
---

# expat

## Overview
The `node-expat` library is a Node.js binding for the `libexpat` C library, providing one of the fastest XML SAX (Simple API for XML) parsers available for the Node ecosystem. This skill enables efficient, event-based parsing where the document is processed as a stream, triggering callbacks for elements, text, and declarations rather than loading a full tree into memory.

## Usage Patterns

### Basic Parser Setup
Initialize the parser with a specific encoding (usually 'UTF-8') and attach listeners to the relevant XML events.

```javascript
const expat = require('node-expat');
const parser = new expat.Parser('UTF-8');

parser.on('startElement', (name, attrs) => {
  // Handle opening tag
});

parser.on('text', (text) => {
  // Handle character data
});

parser.on('endElement', (name) => {
  // Handle closing tag
});

parser.write('<root>Hello World</root>');
```

### Event Reference
- `startElement(name, attrs)`: Triggered at the start of a tag. `attrs` is an object of attributes.
- `endElement(name)`: Triggered at the end of a tag.
- `text(text)`: Triggered for character data between tags.
- `processingInstruction(target, data)`: For `<?target data?>` instructions.
- `comment(s)`: For `<!-- s -->` comments.
- `xmlDecl(version, encoding, standalone)`: For the XML declaration header.
- `startCdata()` / `endCdata()`: For CDATA sections.
- `error(e)`: Triggered when using the Stream interface or when an error occurs during `write()`.

### Stream Integration
The `Parser` object can be used as a standard Node.js writable stream, allowing you to pipe data directly from files or network requests.

```javascript
const fs = require('fs');
const parser = new expat.Parser();

parser.on('startElement', (name) => {
  console.log('Found tag:', name);
});

const readStream = fs.createReadStream('large-file.xml');
readStream.pipe(parser);
```

### Error Handling
When not using the Stream interface (i.e., calling `.parse()` directly), `node-expat` does not emit an error event. Instead, you must check the return value of the parse method.

```javascript
if (!parser.parse(xmlChunk)) {
  console.error('Parser Error:', parser.getError());
}
```

## Expert Tips
- **Performance**: `node-expat` is significantly faster than pure JS parsers like `sax-js`. Use it when processing high-volume XML streams.
- **Flow Control**: Use `parser.stop()` to pause parsing and `parser.resume()` to continue. This is useful for throttling or waiting for asynchronous operations during a parse event.
- **Namespaces**: As a bare SAX parser, `node-expat` does not provide specialized namespace resolution logic. You must handle `xmlns` attributes manually within the `startElement` callback if your application logic requires namespace awareness.
- **Memory Management**: Because it is a SAX parser, it is highly memory-efficient for large files. Avoid building large temporary objects inside the `text` or `startElement` handlers to maintain this advantage.

## Reference documentation
- [node-expat README](./references/github_com_xmppo_node-expat.md)