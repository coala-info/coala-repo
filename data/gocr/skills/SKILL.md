---
name: gocr
description: GOCR is an open-source engine that extracts text and barcodes from images using a lightweight command-line interface. Use when user asks to extract text from images, decode barcodes, convert scans to XML or HTML formats, or perform OCR on Netpbm files.
homepage: https://jocr.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/gocr:0.52--h7b50bb2_0"
---

# gocr

## Overview
GOCR (also known as JOCR) is an open-source OCR engine that excels at processing simple, clean scans and specific image formats like the Netpbm family. It is particularly useful for command-line based text extraction where a lightweight footprint is preferred over heavy neural-network based engines. It supports various output formats and includes specialized modes for barcodes and different character sets.

## Common CLI Patterns

### Basic Text Extraction
The most common usage is converting an image to a text file:
```bash
gocr -i input.pnm -o output.txt
```

### Handling Different Image Formats
GOCR natively supports PNM, PBM, PGM, and PPM. For other formats (like JPEG or PNG), use a converter like `netpbm` or `ImageMagick` to pipe the data:
```bash
convert input.jpg pnm:- | gocr -
```

### Improving Recognition Quality
If the default recognition is poor, use these flags to tune the engine:
- **Thresholding**: Adjust the grey-level threshold (0-255). A value of 0 enables internal calculation.
  ```bash
  gocr -i input.pgm -l 150
  ```
- **Dust Removal**: Remove small artifacts (clusters of pixels) that might be mistaken for noise.
  ```bash
  gocr -i input.pnm -d 10
  ```
- **Certainty Threshold**: Only output characters with a high probability of correctness (0-100).
  ```bash
  gocr -i input.pnm -a 95
  ```

### Specialized Modes
- **Barcode Recognition**: GOCR has a specific mode for detecting and decoding barcodes within images.
  ```bash
  gocr -i barcode_image.pnm -b
  ```
- **Numerical Only**: Restrict output to numbers, useful for processing forms or data tables.
  ```bash
  gocr -i table.pnm -C "0-9"
  ```

### Output Formatting
- **XML Output**: For structured data that includes positional information of characters.
  ```bash
  gocr -i input.pnm -f XML
  ```
- **TeXML/HTML**: Useful if you intend to preserve some layout or formatting.
  ```bash
  gocr -i input.pnm -f HTML
  ```

## Expert Tips
- **Pre-processing**: GOCR performs best on high-contrast, 300 DPI images. If recognition fails, try increasing the contrast or scaling the image before passing it to the tool.
- **Inverted Text**: If you are processing white text on a black background, ensure you are using a version (0.43+) that supports automatic detection, or manually invert the image using `pamflip` or `convert` before processing.
- **Space Detection**: Use the `-v 1` (verbose) flag to debug how GOCR is segmenting lines and boxes if the text layout in the output is scrambled.

## Reference documentation
- [GOCR Index](./references/jocr_sourceforge_net_index.md)
- [GOCR API and Features](./references/jocr_sourceforge_net_api.md)
- [GOCR Support and Usage](./references/jocr_sourceforge_net_support.html.md)