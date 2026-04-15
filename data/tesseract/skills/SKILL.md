---
name: tesseract
description: Tesseract is an open-source OCR engine that extracts text from images in over 100 languages. Use when user asks to extract text from images, create searchable PDFs, generate hOCR or TSV files, or perform OCR using specific page segmentation modes.
homepage: https://github.com/tesseract-ocr/tesseract
metadata:
  docker_image: "quay.io/biocontainers/tesseract:5.5.1"
---

# tesseract

## Overview

Tesseract is a versatile open-source OCR engine capable of recognizing text in over 100 languages and supporting various image formats including PNG, JPEG, and TIFF. It features a modern neural network (LSTM) engine for high-accuracy line recognition and a legacy engine for character pattern recognition. This skill provides the essential command-line workflows to extract text, manage page segmentation, and produce specialized output formats for document archival and data analysis.

## Core CLI Usage

The basic syntax for Tesseract is:
`tesseract imagename outputbase [-l lang] [--oem ocrenginemode] [--psm pagesegmode] [configfiles...]`

### Common Output Formats
Tesseract determines the output format based on the `configfiles` parameter or internal flags:
- **Plain Text**: `tesseract image.png output` (Default)
- **Searchable PDF**: `tesseract image.png output pdf`
- **hOCR (HTML)**: `tesseract image.png output hocr`
- **TSV (Tab-Separated Values)**: `tesseract image.png output tsv`
- **ALTO/PAGE (XML)**: `tesseract image.png output alto` or `tesseract image.png output page`

### Page Segmentation Modes (--psm)
Adjust the PSM if Tesseract fails to recognize the layout correctly:
- `0`: Orientation and script detection (OSD) only.
- `1`: Automatic page segmentation with OSD.
- `3`: Fully automatic page segmentation, but no OSD. (Default)
- `4`: Assume a single column of text of variable sizes.
- `6`: Assume a single uniform block of text.
- `7`: Treat the image as a single text line.
- `11`: Sparse text. Find as much text as possible in no particular order.

### OCR Engine Modes (--oem)
- `0`: Legacy engine only.
- `1`: Neural nets LSTM engine only.
- `2`: Legacy + LSTM engines.
- `3`: Default, based on what is available.

## Expert Tips and Best Practices

### Improving Accuracy
- **Image Quality**: Tesseract's performance is highly dependent on the quality of the input image. For best results, provide high-contrast, 300 DPI images.
- **Preprocessing**: Use external tools to scale, de-skew, or binarize images before passing them to Tesseract, as it relies on the Leptonica library for basic image handling.
- **Language Bundling**: You can specify multiple languages separated by a plus sign: `tesseract image.png output -l eng+osd+fra`.

### Working with LSTM vs. Legacy
- Tesseract 4 and 5 default to the LSTM engine. If you require the legacy Tesseract 3 engine (e.g., for specific character pattern matching), you must use `--oem 0` and ensure you have the compatible `traineddata` files from the `tessdata` repository (not `tessdata_best` or `tessdata_fast`).

### Configuration Files
You can combine multiple configuration outputs in a single command:
`tesseract image.png output pdf hocr tsv`
This will generate `output.pdf`, `output.hocr`, and `output.tsv` simultaneously.

## Reference documentation
- [Tesseract README](./references/github_com_tesseract-ocr_tesseract.md)
- [Tesseract Wiki Index](./references/github_com_tesseract-ocr_tesseract_wiki.md)