---
name: convert
description: The convert tool transforms various binary and proprietary file formats into structured Markdown text using the markitdown utility. Use when user asks to extract text from office documents, convert PDFs to Markdown, or process media files for LLM analysis.
homepage: https://github.com/microsoft/markitdown
---


# convert

## Overview

The `convert` skill utilizes the `markitdown` utility to bridge the gap between binary office formats and text-based processing pipelines. Unlike traditional text extractors that often lose context, this tool prioritizes the preservation of document hierarchy and formatting. Markdown is the preferred output because it is natively understood by LLMs and is highly token-efficient. Use this skill to extract clean, structured text from messy or proprietary file formats for further analysis or RAG (Retrieval-Augmented Generation) workflows.

## Command Line Usage

The primary interface for conversion is the `markitdown` command.

### Basic Conversion
To convert a file and output to the console:
```bash
markitdown path/to/document.pdf
```

To save the output directly to a file:
```bash
markitdown path/to/document.docx -o output.md
```

### Piping and Redirection
`markitdown` supports standard Unix piping, allowing it to fit into larger automation scripts:
```bash
cat document.pdf | markitdown > output.md
```

### Advanced Conversion Features

**Azure Document Intelligence**
For high-fidelity conversions of complex PDFs or forms, use the Azure Document Intelligence integration. This requires an endpoint:
```bash
markitdown document.pdf -d -e "<your_endpoint_url>"
```

**Using Plugins**
If specialized 3rd-party plugins are installed to handle unique file types, enable them with the following flag:
```bash
markitdown --use-plugins document.ext
```

## Supported Formats
- **Office**: Word (.docx), PowerPoint (.pptx), Excel (.xlsx, .xls)
- **Documents**: PDF, EPub
- **Web/Text**: HTML, CSV, JSON, XML, YouTube URLs
- **Media**: Images (EXIF and OCR), Audio (EXIF and transcription)
- **Archives**: ZIP files (iterates over contents)

## Expert Tips

- **Token Efficiency**: Markdown is significantly more token-efficient for LLM prompts than raw HTML or plain text with lost formatting. Always prefer Markdown conversion before feeding large documents into a model.
- **Installation Groups**: If you are setting up the environment, use `pip install 'markitdown[all]'` to ensure all optional dependencies (like PDF and Excel support) are available.
- **OCR and Layout**: For scanned PDFs that lack a text layer, the standard converter may struggle. In these cases, the Azure Document Intelligence (`-d`) flag is necessary for accurate extraction.
- **Structured Data**: When converting Excel or CSV files, `markitdown` attempts to preserve table structures, which is critical for LLMs to understand data relationships.

## Reference documentation
- [MarkItDown README](./references/github_com_microsoft_markitdown.md)