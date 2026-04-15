---
name: leptonica
description: Leptonica is a high-performance image processing and analysis library optimized for document images and OCR preprocessing. Use when user asks to deskew scanned pages, binarize images, perform morphological operations, or extract connected components and metadata from raster images.
homepage: https://github.com/DanBloomberg/leptonica
metadata:
  docker_image: "quay.io/biocontainers/leptonica:1.73--1"
---

# leptonica

## Overview
Leptonica is a powerful C library designed for efficient image processing and analysis, particularly optimized for document images. It serves as the primary image processing engine for Tesseract OCR. This skill provides guidance on using Leptonica's utility programs and core concepts to manipulate images, extract data, and prepare documents for downstream analysis. It is best used when you need high-performance operations on raster images, such as bitblt (Rasterop), affine transforms, or complex image binarization.

## Core Concepts and Data Structures
Leptonica operations revolve around a few primary data structures. Understanding these is essential for using the library's utility programs:
- **Pix**: The fundamental object representing an image (pixels, depth, resolution).
- **Pixa**: An array of Pix objects, often used for storing image segments or font characters.
- **Box/Boxa**: A rectangle or an array of rectangles, used for defining regions of interest (ROIs) or bounding boxes.
- **Sarray**: An array of strings, used for file paths or text data.

## Common CLI Patterns and Utilities
Leptonica includes a `prog/` directory containing over 140 utility programs. While many are regression tests, several serve as high-utility CLI tools.

### Image Inspection
Use `fileinfo` to extract metadata and validate image headers.
```bash
# Basic image information (depth, dimensions, resolution, format)
fileinfo input_image.png
```

### Document Preprocessing
Leptonica is the industry standard for preparing document images. Key workflows include:
- **Deskewing**: Finding and correcting the tilt of a scanned page.
- **Binarization**: Converting grayscale or color images to 1-bpp (black and white). Use adaptive background normalization for unevenly lit scans.
- **Segmentation**: Separating text from images or identifying baselines.

### Format Conversion and I/O
Leptonica supports a wide range of formats. It is particularly strong in handling multi-page TIFFs and generating device-independent PDF/PostScript output.
- **Supported Formats**: JPG, PNG, TIFF, WebP, JP2, BMP, PNM, GIF, PS, PDF.
- **PDF Generation**: Supports G4 (binary), DCT (JPEG), and FLATE compression.

## Expert Tips and Best Practices
- **Memory Efficiency**: Leptonica packs binary data into 32-bit words. When processing large batches of images, prefer 1-bpp (binary) representations where possible to minimize memory footprint.
- **Thresholding**: For document images, avoid simple global thresholding. Use adaptive binarization (e.g., `pixAdaptThreshold`) to handle shadows and gradients in scanned documents.
- **Morphology**: Use binary morphology (dilation, erosion, opening, closing) to remove noise or join fragmented text characters before OCR.
- **Connected Components**: Use `pixConnComp` to identify and extract individual glyphs or image elements. This is significantly faster than pixel-by-pixel scanning.
- **Thread Safety**: Leptonica uses atomic operations for reference counting, making it safe for multi-threaded image processing pipelines.

## Reference documentation
- [Leptonica Library Overview](./references/github_com_DanBloomberg_leptonica.md)
- [Leptonica Wiki and Build Guide](./references/github_com_DanBloomberg_leptonica_wiki.md)