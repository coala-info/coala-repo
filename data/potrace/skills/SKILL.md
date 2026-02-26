---
name: potrace
description: This tool traces bitmaps into smooth, scalable vector graphics. Use when user asks to convert raster images to vector formats.
homepage: https://github.com/kilobtye/potrace
---


# potrace

A tool for tracing bitmaps into smooth, scalable vector graphics. Use when you need to convert raster images (like PNG, JPG) into vector formats (like SVG, EPS) for further editing or use in design software. This is particularly useful for logo creation, icon design, or when a low-resolution bitmap needs to be scaled without losing quality.
---
## Overview

Potrace is a command-line utility designed to convert bitmap images into smooth, scalable vector graphics. It excels at transforming pixel-based images into paths, making them ideal for applications requiring scalability and clean lines, such as logo design, illustration, and technical diagrams.

## Usage

Potrace operates by taking a bitmap image as input and producing a vector output. The primary command-line interface involves specifying input and output files, along with various parameters to control the tracing process.

### Basic Conversion

The most straightforward use case is converting a bitmap to an SVG file:

```bash
potrace input.bmp -s -o output.svg
```

- `input.bmp`: The input bitmap image file. Potrace typically works best with black and white images, but can handle grayscale.
- `-s`: Specifies SVG output format.
- `-o output.svg`: Specifies the output file name.

### Common Output Formats

Potrace supports several vector output formats:

*   **SVG (`-s`)**: Scalable Vector Graphics.
*   **EPS (`-e`)**: Encapsulated PostScript.
*   **PDF (`-p`)**: Portable Document Format.
*   **PBM/PGM/PPM (`-b`)**: Portable Bitmap/Graymap/Pixmap formats (for intermediate raster formats).

### Key Tracing Parameters

Potrace offers numerous parameters to fine-tune the tracing process. Here are some of the most impactful:

*   **`--turdsize <float>`**: Sets the minimum area of a speck to be considered a "turd" and removed. Smaller values keep more detail, larger values remove more noise. Default is 2.0.
    ```bash
    potrace input.bmp -s -o output.svg --turdsize 5.0
    ```

*   **`--alphamax <float>`**: Controls the maximum difference between the direction of the curve and the direction of the tangent. Smaller values result in straighter lines, larger values allow for more curves. Default is 1.0.
    ```bash
    potrace input.bmp -s -o output.svg --alphamax 2.0
    ```

*   **`--opttolerance <float>`**: The optimization level for curve fitting. Higher values lead to more simplification and fewer control points. Default is 0.2.
    ```bash
    potrace input.bmp -s -o output.svg --opttolerance 0.5
    ```

*   **`--longcurve <boolean>`**: If true, curves are allowed to be longer than 180 degrees. Default is true.

*   **`--fillpath <boolean>`**: If true, paths are filled. Default is true.

*   **`--joinpaths <boolean>`**: If true, paths are joined. Default is true.

### Preprocessing for Best Results

Potrace generally performs best on clean, black-and-white images. For color or grayscale images, consider preprocessing them into a binary (black and white) format before using potrace. Tools like ImageMagick can be used for this:

```bash
convert input.png -colorspace Gray -threshold 50% input_bw.pgm
potrace input_bw.pgm -s -o output.svg
```

In this example:
1.  `convert input.png -colorspace Gray -threshold 50% input_bw.pgm` converts the PNG to grayscale and then to a binary PGM image using a 50% threshold.
2.  `potrace input_bw.pgm -s -o output.svg` then traces the binary PGM image.

## Expert Tips

*   **Experiment with parameters**: The optimal settings for `turdsize`, `alphamax`, and `opttolerance` are highly dependent on the input image. Always experiment with different values to achieve the desired result.
*   **Use PGM for intermediate steps**: When preprocessing, using the PGM format for intermediate binary images can be beneficial as it's a simple, uncompressed format that potrace handles efficiently.
*   **Check the license**: Potrace is distributed under the GPL license. Ensure your usage complies with its terms.

## Reference documentation
- [Potrace Overview](https://bioconda.github.io/recipes/potrace/README.html)
- [Potrace GitHub Repository](https://github.com/kilobtye/potrace)