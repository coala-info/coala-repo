---
name: bioformats2raw
description: bioformats2raw converts proprietary microscopy image formats into chunked, multi-scale OME-Zarr structures. Use when user asks to convert microscopy files to Zarr, create pyramidal image representations, or generate OME-NGFF compliant datasets.
homepage: https://github.com/glencoesoftware/bioformats2raw
---


# bioformats2raw

## Overview

bioformats2raw is a Java-based command-line utility that leverages the Bio-Formats library to read a wide array of proprietary microscopy formats and write them into a chunked, compressed, and multi-scale Zarr structure. This structure follows the OME-NGFF (Next Generation File Format) specification. It is particularly useful for handling "pyramidal" images where high-resolution data needs to be accessible at multiple zoom levels without loading the entire file into memory.

## Installation and Environment Setup

Before running the tool, ensure the environment is correctly configured, as it relies on native libraries for compression.

- **Java Requirements**: Java 8 or later.
- **Blosc Dependency**: `libblosc` (1.9.0+) must be installed.
- **Library Path**: If the tool cannot find Blosc, set the library path via `JAVA_OPTS`:
  - Linux/macOS: `export JAVA_OPTS="-Djna.library.path=/usr/local/lib"`
  - Windows: `set JAVA_OPTS="-Djna.library.path=C:\path\to\blosc\folder"`
- **Temporary Directory**: If your `/tmp` directory is mounted with `noexec`, native library extraction will fail. Redirect it using:
  `JAVA_OPTS="-Djava.io.tmpdir=/path/to/exec-allowed/tmp"`

## Common CLI Patterns

### Basic Conversion
The simplest usage requires an input file and an output directory:
```bash
bioformats2raw /path/to/input.svs /path/to/output.zarr
```

### Controlling Pyramid Levels
By default, the tool creates resolutions until the smallest is no larger than 256x256.
- **Set specific minimum size**:
  ```bash
  bioformats2raw input.mrxs output.zarr --target-min-size 128
  ```
- **Set exact number of resolutions**:
  ```bash
  bioformats2raw input.mrxs output.zarr --resolutions 6
  ```

### Handling Multi-Series Files
If an input (like a .scn or .czi file) contains multiple images (series), you can select specific ones:
```bash
# Convert only series 0, 2, and 3
bioformats2raw input.scn output.zarr --series 0,2,3
```

### Performance and Tiling
Tile sizes impact both conversion speed and downstream viewing performance.
- **Adjust tile dimensions**:
  ```bash
  bioformats2raw input.tiff output.zarr --tile-width 512 --tile-height 512
  ```
  *Note: Smaller than default tile sizes are generally not recommended unless specifically required by the viewer.*

## Expert Tips and Troubleshooting

- **Zarr v3 Support**: For newer workflows requiring Zarr v3/NGFF 0.5, use the `--ngff-version` flag (available in recent versions):
  ```bash
  bioformats2raw input.svs output.zarr --ngff-version 0.5
  ```
- **Logging and Debugging**: If a conversion fails or produces unexpected results, increase the log level:
  ```bash
  bioformats2raw input.mrxs output.zarr --log-level DEBUG
  # Or for maximum verbosity
  bioformats2raw input.mrxs output.zarr --log-level TRACE
  ```
- **Memory Management**: For very large datasets, you may need to increase the Java heap size:
  ```bash
  export JAVA_OPTS="-Xmx8g"
  bioformats2raw input.ndpi output.zarr
  ```
- **Extra Readers**: The tool includes experimental readers (e.g., for Mirax). You can explicitly include or exclude them using `--extra-readers`. To use only standard Bio-Formats readers:
  ```bash
  bioformats2raw input.mrxs output.zarr --extra-readers ""
  ```

## Reference documentation
- [Bio-Formats to Raw README](./references/github_com_glencoesoftware_bioformats2raw.md)
- [Commit History (Feature Flags)](./references/github_com_glencoesoftware_bioformats2raw_commits_master.md)