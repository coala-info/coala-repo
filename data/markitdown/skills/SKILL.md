---
name: markitdown
description: MarkItDown converts various unstructured file formats and media into structured Markdown while preserving semantic layout. Use when user asks to convert documents to Markdown, extract text from Office files or PDFs, transcribe YouTube videos, or prepare data for RAG workflows.
homepage: https://github.com/microsoft/markitdown
---


# markitdown

## Overview
MarkItDown is a lightweight Python utility that transforms unstructured or semi-structured files into clean, structured Markdown. While many tools perform raw text extraction, MarkItDown focuses on maintaining the semantic layout of the original document, making the output significantly more useful for Retrieval-Augmented Generation (RAG) and other AI-driven workflows. It supports a wide array of formats, including Office documents, ZIP archives, and even YouTube transcriptions.

## Installation
To ensure all features (OCR, audio transcription, and Office support) are available, install with the `all` extra:
```bash
pip install 'markitdown[all]'
```

## Common CLI Patterns

### Basic Conversion
Convert a file and redirect the output to a Markdown file:
```bash
markitdown document.pdf > document.md
```

### Explicit Output Path
Use the `-o` flag to specify the output destination directly:
```bash
markitdown presentation.pptx -o presentation.md
```

### Piping Content
MarkItDown supports standard input piping for integration into shell pipelines:
```bash
cat report.pdf | markitdown
```

### High-Fidelity OCR with Azure
For complex PDFs or images requiring advanced layout analysis, use Azure Document Intelligence:
```bash
markitdown scan.pdf -d -e "<your-endpoint>"
```

## Supported Formats & Features
- **Microsoft Office**: Word (.docx), PowerPoint (.pptx), Excel (.xlsx, .xls).
- **Fixed Layout**: PDF.
- **Web & Media**: HTML, YouTube URLs (transcription), Audio (transcription for .wav/.mp3).
- **Data Formats**: CSV, JSON, XML.
- **Archives**: ZIP files (the tool will iterate over and convert contents).
- **Images**: Extracts EXIF metadata and can use LLMs for visual descriptions.

## Expert Tips
- **Token Efficiency**: Markdown is more token-efficient than HTML or raw JSON for LLM context windows while retaining structural meaning.
- **LLM Integration**: When using the Python API, you can pass an `llm_client` (like OpenAI) to generate descriptive text for images embedded in documents.
- **Plugin System**: If a specific format isn't supported, check for third-party plugins using `markitdown --list-plugins`.
- **Stream Handling**: In Python scripts, `convert_stream()` requires a binary file-like object (e.g., `io.BytesIO`).

## Reference documentation
- [MarkItDown Main Documentation](./references/github_com_microsoft_markitdown.md)