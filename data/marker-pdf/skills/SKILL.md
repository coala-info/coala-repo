---
name: marker-pdf
description: Marker-pdf extracts text, structural metadata, and markdown from digital PDF documents with high speed and accuracy. Use when user asks to extract text from PDFs, convert PDFs to markdown, identify document structure like headings and tables, or process PDF content for RAG applications.
homepage: https://github.com/intercepted16/fibrumpdf
---


# marker-pdf

## Overview
This tool (FibrumPDF) is a high-performance PDF extractor designed for speed and structural accuracy. It serves as a middle ground between basic text extractors and resource-intensive OCR tools. It extracts text blocks with rich metadata—including bounding boxes, font sizes, and styles—allowing for sophisticated document analysis and RAG (Retrieval-Augmented Generation) preprocessing at scale.

## Installation
Install the package via pip:
```bash
pip install fibrum-pdf
```

## Command Line Usage
For simple batch processing or quick extraction:
```bash
python -m fibrum_pdf.main <input.pdf> [output_dir]
```
- If `output_dir` is omitted, it defaults to creating a `.json` file in the same directory as the input.

## Python API Integration

### Basic Extraction
Convert a PDF to a JSON structure on disk:
```python
from fibrum_pdf import to_json

result = to_json("document.pdf", output="output.json")
print(f"Extracted to: {result.path}")
```

### Memory-Efficient Streaming
For large PDFs, iterate page-by-page to prevent memory exhaustion:
```python
result = to_json("large_report.pdf")

for page in result:
    for block in page:
        if block.type == "heading":
            print(f"Found Heading: {block.markdown}")
```

### Markdown Conversion
Access pre-formatted markdown at different granularities:
```python
result = to_json("document.pdf")
pages = result.collect()

# Full document
full_md = pages.markdown

# Specific page or block
page_md = pages[0].markdown
block_md = pages[0][0].markdown
```

## Extraction Metadata
The tool categorizes content into specific block types, each containing a `bbox` (bounding box `[x0, y0, x1, y1]`) and `font_size`:
- **text/paragraph/code**: Standard text blocks.
- **heading**: Includes a `level` attribute (e.g., Level 1, 2).
- **list**: Contains `items` with `list_type` (bulleted/numbered) and `indent`.
- **table**: Provides `row_count`, `col_count`, and cell-specific spans.

## Expert Tips & Best Practices
- **Semantic Chunking**: Use `font_size` changes to identify section headers and `y-gap` distances between bounding boxes to detect logical topic breaks.
- **Digital vs. Scanned**: This tool is optimized for digital PDFs. It does not perform OCR; if a PDF is image-heavy or scanned, extraction quality will be low.
- **Memory Management**: Always use the streaming iterator (`for page in result`) for documents exceeding 100 pages to avoid RAM crashes.
- **Style Detection**: Check the `spans` within a block for boolean flags like `bold`, `italic`, or `monospace` to preserve semantic meaning during LLM preprocessing.

## Reference documentation
- [FibrumPDF Main Documentation](./references/github_com_intercepted16_fibrumpdf.md)