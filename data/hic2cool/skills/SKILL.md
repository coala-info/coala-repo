---
name: hic2cool
description: hic2cool converts Hi-C contact matrices from the .hic format into .cool or .mcool formats for use with the Cooler API and HiGlass. Use when user asks to convert .hic files to cooler format, update legacy cooler files, or extract normalization vectors from .hic files.
homepage: https://github.com/4dn-dcic/hic2cool
---


# hic2cool

## Overview

hic2cool is a specialized utility designed to provide interoperability between the Juicer and Cooler ecosystems. It facilitates the conversion of Hi-C contact matrices from the proprietary `.hic` format into the HDF5-based `.cool` or `.mcool` formats. This conversion is a prerequisite for using the `cooler` Python API for downstream analysis or the `HiGlass` platform for interactive web-based visualization.

## Command Line Interface (CLI) Usage

The tool is primarily used via the `hic2cool` command followed by a specific mode: `convert`, `update`, or `extract-norms`.

### 1. Converting Files

The `convert` command is the most common entry point.

*   **Single-Resolution Conversion**:
    ```bash
    hic2cool convert input.hic output.cool -r 10000
    ```
    *Note: The resolution must exist within the original .hic file.*

*   **Multi-Resolution Conversion (for HiGlass)**:
    ```bash
    hic2cool convert input.hic output.mcool -r 0
    ```
    *Setting resolution to 0 triggers the creation of a multi-resolution file containing all resolutions present in the source.*

*   **Parallel Processing**:
    ```bash
    hic2cool convert input.hic output.mcool -r 0 -p 8
    ```
    *Use the `-p` flag to specify the number of processes. This is most effective for large, high-resolution matrices.*

### 2. Updating Legacy Files
If you have cooler files generated with hic2cool versions earlier than 0.5.0, they use an outdated normalization logic. Update them to ensure compatibility with modern 4DN pipelines:
```bash
hic2cool update legacy_input.cool updated_output.cool
```

### 3. Extracting Normalization Vectors
To add normalization vectors from a `.hic` file to an existing `.cool` file (provided they share the same resolutions):
```bash
hic2cool extract-norms input.hic target.cool
```
*   Use the `-e` flag to exclude mitochondrial chromosomes (MT/chrM) during extraction.

## Python API Usage

You can integrate the conversion directly into Python workflows:

```python
from hic2cool import hic2cool_convert

# Convert to multi-res
hic2cool_convert('input.hic', 'output.mcool', 0)

# Convert to specific single-res
hic2cool_convert('input.hic', 'output.cool', 25000)
```

## Expert Tips and Best Practices

*   **HiGlass Compatibility**: HiGlass requires multi-resolution files. Always use `-r 0` if the end goal is visualization. Single-resolution `.cool` files created with a specific `-r` value will not work in HiGlass.
*   **Normalization Handling**: Starting with version 0.5.0, hic2cool preserves the divisive normalization values used by Juicer. When viewing in HiGlass, you must manually apply these transforms (Right-click tileset -> Configure Series -> Transforms -> Select Norm).
*   **Resolution Constraints**: You cannot "create" new resolutions during conversion. The value passed to `-r` must be one of the resolutions already baked into the `.hic` file.
*   **Silent Mode**: When running in automated scripts or pipelines, use the `-s` flag to suppress console output.
*   **Memory and CPU**: While the tool is lightweight, high-resolution conversions (e.g., 1kb or 5kb) of large genomes can be resource-intensive. Ensure sufficient RAM and use `-p` to speed up the HDF5 writing process.



## Subcommands

| Command | Description |
|---------|-------------|
| hic2cool convert | convert a hic file to a cooler file |
| hic2cool extract-norms | extract normalization vectors from a cooler file and add them to a cooler file |
| hic2cool update | update a cooler file produced by hic2cool |

## Reference documentation
- [hic2cool GitHub README](./references/github_com_4dn-dcic_hic2cool_blob_master_README.md)