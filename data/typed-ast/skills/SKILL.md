---
name: typed-ast
description: The typed-ast tool transforms unstructured office files into a strictly-typed hierarchical Abstract Syntax Tree (AST), preserving their logical structure and metadata. Use when user asks to extract AST or plain text from office files, extract embedded attachments, perform OCR on document images, parse PDF or Excel files, handle PowerPoint speaker notes, or customize text output.
homepage: https://github.com/harshankur/officeParser
---


# typed-ast

## Overview

The `typed-ast` skill (utilizing the `officeParser` engine) provides a robust way to transform unstructured office files into a clean, strictly-typed hierarchical AST. Unlike standard text extractors, it preserves the logical structure of documents—including paragraphs, headings, tables, and lists—while providing rich metadata and support for embedded attachments. It is the preferred tool for Node.js-based document analysis, data migration, and content indexing.

## CLI Usage Patterns

The tool is primarily invoked via `npx officeparser`. By default, it outputs a JSON-formatted AST to the console.

### Basic Extraction
Extract the full hierarchical AST as JSON:
```bash
npx officeparser /path/to/document.docx
```

Extract only the plain text content:
```bash
npx officeparser /path/to/document.docx --toText=true
```

### Advanced Parsing Options
Handle PowerPoint speaker notes by either ignoring them or moving them to the end of the output:
```bash
# Ignore notes entirely
npx officeparser presentation.pptx --ignoreNotes=true

# Collect all notes at the end of the document
npx officeparser presentation.pptx --putNotesAtLast=true
```

Customize the text flow by changing the newline delimiter (default is `\n`):
```bash
npx officeparser spreadsheet.xlsx --newlineDelimiter=" | "
```

### Media and OCR
Extract embedded images and charts as Base64 strings within the AST:
```bash
npx officeparser document.docx --extractAttachments=true
```

Enable OCR for extracted images (requires Tesseract.js):
```bash
npx officeparser document.docx --extractAttachments=true --ocr=true
```

## Expert Tips and Best Practices

- **AST vs. Text**: Always prefer the AST output (default) when you need to programmatically process tables or headings. Use `--toText=true` only for simple search indexing or LLM context windows where structure is secondary.
- **Memory Management**: The parser extracts files in-memory (using `yauzl`). For extremely large files or batch processing, ensure your Node.js heap limit is adjusted accordingly.
- **PDF Parsing**: The tool uses a native implementation based on `pdf.js`. If you encounter complex PDF layouts, ensure you are using the latest version (v6.0.0+) which significantly improved PDF AST generation.
- **Excel Handling**: When parsing `.xlsx` files, the tool automatically handles shared strings and inline strings. If numbers are being parsed incorrectly, check if they represent indices in a shared string array or raw values.
- **Error Debugging**: Use `--outputErrorToConsole=true` during development to catch malformed XML or corruption issues within the office containers.

## Reference documentation
- [officeParser Overview](./references/github_com_harshankur_officeParser.md)
- [Commits and Version History](./references/github_com_harshankur_officeParser_commits_master.md)