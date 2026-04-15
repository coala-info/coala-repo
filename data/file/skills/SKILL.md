---
name: file
description: This tool converts unstructured or complex binary files into structured Markdown text while preserving semantic elements like headings and tables. Use when user asks to convert documents to Markdown, extract text from images or audio, or process files for RAG workflows.
homepage: https://github.com/microsoft/markitdown
metadata:
  docker_image: "quay.io/biocontainers/file:5.39"
---

# file

## Overview
The `markitdown` tool is a specialized utility for transforming unstructured or complex binary files into structured Markdown text. Unlike simple text extractors, it prioritizes preserving the semantic structure of a document, such as headings, tables, lists, and links. This makes it a powerful asset for RAG (Retrieval-Augmented Generation) workflows where maintaining the relationship between data points is critical for model performance.

## CLI Usage and Best Practices

### Basic Conversion
The most common pattern is converting a single file and either redirecting the output or specifying a destination file.

- **Standard conversion**: `markitdown document.pdf > output.md`
- **Explicit output flag**: `markitdown document.docx -o output.md`
- **Piping content**: `cat document.pdf | markitdown > output.md`

### Handling Specialized Formats
`markitdown` supports a wide range of inputs beyond standard text documents:

- **Images and OCR**: When converting images or PDFs with embedded images, the tool can extract EXIF metadata. For high-fidelity OCR, it can be integrated with Azure Document Intelligence.
- **Audio**: Converts audio files (wav, mp3) into text via speech transcription.
- **Web Content**: Supports direct conversion of HTML and even YouTube URLs (via transcription).
- **Archives**: When pointed at a ZIP file, the tool iterates over the contents and converts supported files within the archive.

### Advanced CLI Patterns

- **Azure Document Intelligence**: To use cloud-based OCR for complex layouts or scanned PDFs, use the `-d` flag and provide your endpoint:
  `markitdown input.pdf -o output.md -d -e "<your_endpoint>"`
- **Plugin Integration**: If you have custom converters or 3rd-party plugins installed, enable them using:
  `markitdown --use-plugins input.file`
- **List Available Plugins**: `markitdown --list-plugins`

### Expert Tips for LLM Workflows

1. **Token Efficiency**: Markdown is significantly more token-efficient than raw HTML or JSON for LLM context windows while still providing enough structure for the model to understand hierarchy.
2. **Table Preservation**: Use this tool specifically when your source files contain complex tables. `markitdown` excels at converting Excel and Word tables into standard Markdown table syntax, which LLMs "speak" natively.
3. **Batch Processing**: While the CLI handles single files, you can combine it with standard shell commands for batch processing:
   `find ./docs -name "*.pdf" -exec sh -c 'markitdown "$1" > "${1%.pdf}.md"' _ {} \;`
4. **Installation Note**: Ensure you have the full feature set by installing with the `[all]` extra: `pip install 'markitdown[all]'`.

## Reference documentation
- [MarkItDown README](./references/github_com_microsoft_markitdown.md)