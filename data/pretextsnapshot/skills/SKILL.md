---
name: pretextsnapshot
description: The `pretextsnapshot` tool is a specialized utility designed to convert Pretext Hi-C contact maps into static image formats.
homepage: https://github.com/wtsi-hpag/PretextSnapshot
---

# pretextsnapshot

## Overview
The `pretextsnapshot` tool is a specialized utility designed to convert Pretext Hi-C contact maps into static image formats. It is essential for researchers working with genomic proximity data who need to share or publish visual representations of chromosome interactions without requiring a dedicated Hi-C viewer. This skill provides the necessary syntax for targeting specific sequences, defining regions of interest, and managing hardware resources during image generation.

## Command Line Usage

### Basic Syntax
The core command requires a Pretext map file and a sequence specification:
```bash
PretextSnapshot -m map.pretext --sequences "specification" [options]
```

### Sequence Specification Patterns
The `--sequences` flag is highly flexible, allowing for targeted visualization:

*   **Full Map**: Use `=full` to generate a single image of the entire contact map.
    ```bash
    PretextSnapshot -m map.pretext --sequences "=full"
    ```
*   **All Sequences**: Use `=all` to generate individual images for every sequence defined in the map.
    ```bash
    PretextSnapshot -m map.pretext --sequences "=all"
    ```
*   **Specific Sequence**: Provide the exact name of a sequence (e.g., a chromosome).
    ```bash
    PretextSnapshot -m map.pretext --sequences "chr1"
    ```
*   **Sequence Range**: Use the `>` operator to image a range of sequences.
    ```bash
    PretextSnapshot -m map.pretext --sequences "chr1 > chr5"
    ```
*   **Inter-sequence Regions**: Use curly braces `{}` to image the interaction region between two specific sequences.
    ```bash
    PretextSnapshot -m map.pretext --sequences "{chr1, chr2}"
    ```

### Expert Tips and Best Practices

*   **Resource Calculation**: Memory usage is tied to output resolution. The formula is approximately `(30 * width * height) + 6MB`. For a standard 1K (1024px) image, expect to use ~36MB of RAM.
*   **Format Selection**: While PNG is the default for lossless quality, check `--help` for flags to toggle between BMP or JPEG if file size or compatibility is a priority.
*   **Help Flags**: 
    *   Use `PretextSnapshot --help` for a full list of rendering options (colors, resolution, etc.).
    *   Use `PretextSnapshot --sequenceHelp` for advanced string formatting rules for complex sequence selections.

## Reference documentation
- [PretextSnapshot GitHub Repository](./references/github_com_sanger-tol_PretextSnapshot.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pretextsnapshot_overview.md)