---
name: xcftools
description: xcftools provides command-line utilities for processing GIMP's XCF file format. Use when user asks to inspect XCF file metadata, convert XCF files to PNG or PNM, extract specific layers, flatten images with a background color, or extract an alpha map.
homepage: https://github.com/j-jorge/xcftools
metadata:
  docker_image: "quay.io/biocontainers/xcftools:1.0.7--0"
---

# xcftools

## Overview

xcftools is a collection of fast, scriptable command-line utilities designed to handle GIMP's native XCF file format without requiring the GIMP engine or installation. These tools are ideal for automated build systems (like `make`) or headless environments where you need to process layered images. The suite primarily consists of `xcfinfo` for metadata inspection, and `xcf2png` or `xcf2pnm` for image conversion and layer flattening.

## Command Line Usage

### Inspecting XCF Files
Use `xcfinfo` to view the image dimensions, color mode, and a list of all layers (including their visibility and dimensions).

```bash
xcfinfo image.xcf
```

### Converting to PNG
`xcf2png` is the most common tool for converting XCF files while preserving transparency.

*   **Basic conversion (flattened):**
    ```bash
    xcf2png image.xcf -o output.png
    ```
*   **Extract a specific layer:**
    ```bash
    xcf2png image.xcf "Layer Name" -o layer.png
    ```
*   **Flatten against a specific background color:**
    Use the `-b` flag with a color name or hex code to replace transparency.
    ```bash
    xcf2png -b white image.xcf -o output.png
    ```

### Converting to PNM (PPM/PGM/PBM)
`xcf2pnm` is used for Netpbm formats. Note that PNM does not support transparency in a single file.

*   **Basic conversion:**
    ```bash
    xcf2pnm image.xcf -o output.ppm
    ```
*   **Extracting an alpha map:**
    Use the `-A` flag to write the transparency channel to a separate file.
    ```bash
    xcf2pnm -A alpha.pgm image.xcf -o image.ppm
    ```

## Expert Tips and Best Practices

*   **Layer Naming:** If an XCF file has multiple layers with the same name, `xcftools` may have difficulty targeting them. Always use `xcfinfo` first to verify the exact strings used for layer names.
*   **Automation:** Because these tools are lightweight and don't load a GUI, they are significantly faster than using GIMP scripts for simple conversion tasks in CI/CD pipelines.
*   **Transparency Handling:** When converting to formats that don't support alpha (like standard PPM), always specify a background color (`-b`) to avoid unpredictable results in the flattened output.
*   **GIMP Version Compatibility:** This version of `xcftools` supports newer XCF features including Zlib compression (v8), variable-width pointers (v11), and layer groups introduced in GIMP 2.8.

## Reference documentation
- [Xcftools GitHub Repository](./references/github_com_j-jorge_xcftools.md)
- [Bioconda xcftools Overview](./references/anaconda_org_channels_bioconda_packages_xcftools_overview.md)