---
name: pandoc
description: Pandoc is a command-line utility that converts files between different markup and document formats. Use when user asks to convert documents between formats like Markdown, PDF, and DOCX, generate slide decks, or process academic citations and metadata.
homepage: https://github.com/jgm/pandoc
metadata:
  docker_image: "quay.io/biocontainers/pandoc:2.1.3--0"
---

# pandoc

## Overview
Pandoc is a powerful command-line utility designed to translate one markup format into another. It functions by parsing input into an intermediate Abstract Syntax Tree (AST) and then writing that AST into a target format. This skill provides the necessary CLI patterns and expert configurations to handle complex conversions, manage document metadata, and produce high-quality outputs while preserving structural elements like tables, citations, and math.

## Core CLI Usage
The basic syntax for pandoc is `pandoc [options] [input-files]`.

### Basic Conversion
If no output file is specified with `-o`, pandoc sends the result to stdout.
- **Auto-detect formats**: `pandoc input.md -o output.pdf`
- **Explicit formats**: `pandoc -f markdown -t html input.md -o output.html`
- **Standalone document**: Use `-s` or `--standalone` to include necessary headers and footers (e.g., `<head>` in HTML or a LaTeX preamble).

### Common Output Options
- **Table of Contents**: Add `--toc` and control depth with `--toc-depth=N`.
- **Custom Variables**: Pass variables to templates using `-V` or `--variable`, e.g., `-V geometry:margin=1in`.
- **Metadata**: Set document metadata via the CLI using `--metadata title="My Document"`.
- **Syntax Highlighting**: Change the code block style with `--highlight-style=monochrome`.

## Expert Workflows

### Working with Microsoft Word (DOCX)
Pandoc can both read and write `.docx` files.
- **Styling Output**: Use a reference document to define styles (fonts, margins, headers) for the output:
  `pandoc input.md --reference-doc=template.docx -o output.docx`
- **Extracting Media**: When converting from DOCX to Markdown, extract images into a folder:
  `pandoc input.docx -t gfm --extract-media=./images -o output.md`

### PDF Generation
Pandoc produces PDFs via an intermediary engine.
- **LaTeX (Default)**: Requires a TeX distribution (like TeX Live or MiKTeX).
- **Alternative Engines**: Use `--pdf-engine=xelatex` (better font support) or `--pdf-engine=weasyprint` (HTML/CSS based).

### Academic and Technical Writing
- **Citations**: Use the `--citeproc` flag to process bibliographies. You must provide a bibliography file:
  `pandoc input.md --citeproc --bibliography=refs.bib -o output.pdf`
- **Math Rendering**: For HTML output, use `--mathjax` or `--katex` to ensure formulas render correctly in browsers.

### Slide Shows
Convert Markdown into interactive slide decks:
- **Reveal.js**: `pandoc slides.md -t revealjs -s -o slides.html`
- **PowerPoint**: `pandoc slides.md -o presentation.pptx`
- **Beamer (LaTeX)**: `pandoc slides.md -t beamer -o presentation.pdf`

## Format Reference
Pandoc supports a vast array of formats. Key identifiers for `-f` (from) and `-t` (to) include:
- **Markdown**: `markdown` (Pandoc), `commonmark`, `gfm` (GitHub-flavored), `markdown_strict`.
- **Web**: `html`, `html5`, `epub`, `epub3`.
- **Office**: `docx`, `pptx`, `odt`, `rtf`.
- **Technical**: `latex`, `man`, `rst`, `asciidoc`, `ipynb` (Jupyter).
- **Wiki**: `mediawiki`, `vimwiki`, `dokuwiki`.

## Reference documentation
- [Pandoc Formats and Features](./references/github_com_jgm_pandoc.md)
- [Pandoc Wiki and User Tips](./references/github_com_jgm_pandoc_wiki.md)