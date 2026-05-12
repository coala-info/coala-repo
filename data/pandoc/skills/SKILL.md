---
name: pandoc
description: Pandoc is a versatile command-line tool used for converting documents between dozens of different markup formats. Use when user asks to convert files between formats like Markdown and PDF, generate ebooks, create standalone documents with metadata, or apply custom styling using reference files and filters.
homepage: https://github.com/jgm/pandoc
metadata:
  docker_image: "pandoc/latex:latest-ubuntu"
---


# pandoc

## Overview

Pandoc is the industry-standard tool for document conversion, acting as a "Swiss-army knife" for markup formats. It works by parsing an input format into an Abstract Syntax Tree (AST) and then writing that AST into a target format. This skill enables precise control over document structure, metadata, and styling across dozens of formats, allowing for professional-grade publishing workflows from simple text sources.

## Core CLI Patterns

### Basic Conversion
The simplest form of conversion guesses formats based on file extensions:
```bash
pandoc input.md -o output.pdf
```

### Standalone Documents
By default, pandoc produces document fragments (e.g., HTML without `<head>` or `<body>`). Use `-s` or `--standalone` to create a complete, valid file:
```bash
pandoc -s input.md -o output.html
```

### Explicit Format Specification
When extensions are ambiguous or input comes from stdin:
```bash
# -f (from), -t (to)
pandoc -f markdown -t latex input.txt -o output.tex
```

### Combining Multiple Inputs
Pandoc can concatenate multiple files into a single output:
```bash
pandoc chapter1.md chapter2.md chapter3.md -o book.docx
```

## Expert Workflows

### Creating Ebooks (EPUB)
Pandoc automatically handles metadata and local image embedding for EPUBs:
```bash
pandoc mybook.md -o mybook.epub --metadata title="My Book" --metadata author="Author Name"
```

### PDF Generation Engines
Pandoc requires an external engine for PDF creation. While LaTeX is the default, you can specify others:
```bash
# Using wkhtmltopdf for HTML-based PDF
pandoc input.md -t html --pdf-engine=wkhtmltopdf -o output.pdf

# Using WeasyPrint
pandoc input.md --pdf-engine=weasyprint -o output.pdf
```

### Using Reference Documents (DOCX/PPTX)
To apply specific styles (fonts, margins, headers) to Word or PowerPoint files, use a reference document as a template:
```bash
pandoc input.md --reference-doc=template.docx -o output.docx
```

### Applying Lua Filters
Modify the document AST programmatically during conversion without external dependencies:
```bash
pandoc input.md --lua-filter=wordcount.lua -o output.txt
```

### Managing Variables and Metadata
Inject data into templates at runtime:
```bash
pandoc input.md -V fontsize=12pt -V margin-left=2cm -o output.pdf
```

## Best Practices

- **Character Encoding**: Pandoc assumes UTF-8. If using other encodings, pipe through `iconv` before processing.
- **Media Handling**: When converting to HTML, use `--self-contained` to embed images as base64 data into a single file.
- **Debugging**: If a conversion fails (especially PDF), output to an intermediate format like LaTeX (`-t latex -s -o debug.tex`) to inspect the generated code.
- **Math Rendering**: For HTML output, use `--mathjax` or `--katex` to ensure mathematical formulas render correctly in browsers.
- **Table of Contents**: Use `--toc` and `--toc-depth=N` to automatically generate and control the granularity of the table of contents.



## Subcommands

| Command | Description |
|---------|-------------|
| pandoc | Pandoc is a Haskell library for converting from one markup format to another, and a command-line tool that uses this library. |

## Reference documentation

- [Pandoc User's Guide](./references/pandoc_org_MANUAL.html.md)
- [Creating an ebook with pandoc](./references/github_com_jgm_pandoc_blob_main_doc_epub.md)
- [Customizing Pandoc](./references/github_com_jgm_pandoc_blob_main_doc_customizing-pandoc.md)
- [Lua Filters](./references/github_com_jgm_pandoc_blob_main_doc_lua-filters.md)