---
name: tesseract
description: Tesseract is an open-source OCR engine that extracts text from images in over 100 languages and multiple output formats. Use when user asks to perform optical character recognition, convert images to searchable PDFs or structured data, specify OCR languages, or optimize text extraction through image preprocessing and page segmentation modes.
homepage: https://github.com/tesseract-ocr/tesseract
metadata:
  docker_image: "jitesoft/tesseract-ocr:5-5.5.2"
---


# tesseract

## Overview

Tesseract is a powerful open-source OCR engine that supports over 100 languages and multiple output formats. Since version 4.0, it utilizes a neural network (LSTM) based engine for superior line recognition, while maintaining a legacy engine for character pattern recognition. This skill provides the procedural knowledge to execute OCR tasks via the command line, optimize image preprocessing for better accuracy, and manage language data files.

## Command Line Usage

The basic syntax for Tesseract is:
`tesseract imagename outputbase [-l lang] [--oem ocrenginemode] [--psm pagesegmode] [configfiles...]`

### Common Patterns

- **Basic OCR to Text**:
  `tesseract image.png output`
  (Creates `output.txt`)

- **Specify Language**:
  `tesseract image.jpg output -l eng+fra`
  (Uses both English and French models)

- **Generate Searchable PDF**:
  `tesseract image.tiff output pdf`
  (Creates `output.pdf` with an invisible text layer)

- **Structured Data Output (TSV)**:
  `tesseract image.png output tsv`
  (Provides bounding box coordinates, confidence scores, and text)

### Page Segmentation Modes (--psm)

Adjust the PSM based on the layout of your input image:

| Mode | Description |
| :--- | :--- |
| 1 | Automatic page segmentation with OSD (Orientation and Script Detection) |
| 3 | Fully automatic page segmentation, but no OSD (Default) |
| 4 | Assume a single column of text of variable sizes |
| 6 | Assume a single uniform block of text |
| 7 | Treat the image as a single text line |
| 11 | Sparse text. Find as much text as possible in no particular order |

### OCR Engine Modes (--oem)

| Mode | Description |
| :--- | :--- |
| 0 | Legacy engine only |
| 1 | Neural nets LSTM engine only |
| 2 | Legacy + LSTM engines |
| 3 | Default, based on what is available |

## Expert Tips for Accuracy

### Image Preprocessing
Tesseract performs internal image processing, but manual preprocessing significantly improves results:
- **Resolution**: Ensure the image has at least 300 DPI.
- **Binarization**: Convert images to high-contrast black and white (1-bit depth).
- **Denoising**: Remove "salt and pepper" noise or scanning artifacts.
- **Rotation/Deskewing**: Ensure text lines are horizontal.

### Language Data Management
Tesseract requires `.traineddata` files, usually stored in a `tessdata` directory.
- **tessdata_fast**: Best for speed/integer-based engines.
- **tessdata_best**: Best for accuracy/float-based engines.
- **tessdata**: Standard models supporting both legacy and LSTM engines.

Set the `TESSDATA_PREFIX` environment variable to point to your data directory if Tesseract cannot find your language files.

## Troubleshooting Common Errors

- **"Empty page!!"**: Often caused by low resolution or incorrect PSM. Try `--psm 11`.
- **"Actual height of symbol is too small"**: The text is likely too small for the engine to recognize. Upscale the image by 2x or 4x.
- **Garbage output**: Ensure the correct language is specified with `-l`. If the font is highly stylized, Tesseract may require custom training.



## Subcommands

| Command | Description |
|---------|-------------|
| tesseract | Tesseract Open Source OCR Engine |

## Reference documentation

- [Tesseract README](./references/github_com_tesseract-ocr_tesseract_blob_main_README.md)
- [Command Line Usage Guide](./references/tesseract-ocr_github_io_tessdoc_Command-Line-Usage.html.md)
- [Improving OCR Quality](./references/tesseract-ocr_github_io_tessdoc_ImproveQuality.html.md)
- [Data Files Overview](./references/tesseract-ocr_github_io_tessdoc_Data-Files.html.md)
- [FAQs](./references/tesseract-ocr_github_io_tessdoc_FAQ.html.md)