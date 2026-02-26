---
name: maf2synteny
description: maf2synteny transforms local genomic alignments into large-scale synteny blocks by filtering out small variations and noise. Use when user asks to generate synteny blocks from MAF files, perform multi-scale genomic analysis, or identify structural conservation between genomes.
homepage: https://github.com/fenderglass/maf2synteny
---


# maf2synteny

## Overview
`maf2synteny` is a comparative genomics tool that transforms fine-grained local alignments into larger, biologically significant synteny blocks. By applying graph simplification techniques, it filters out small-scale variations and noise to reveal the underlying structural conservation between genomes. This tool is a critical component for researchers performing chromosome-scale assembly or studying large-scale genomic rearrangements.

## Usage Instructions

### Basic Command Structure
The tool requires an alignment file as the primary argument.
```bash
maf2synteny [options] alignment_file
```

### Common CLI Patterns
- **Standard Run**: Generate synteny blocks using the default scale (5000bp).
  ```bash
  maf2synteny input_alignment.maf
  ```
- **Multi-scale Analysis**: Generate blocks at multiple resolutions simultaneously by providing a comma-separated list.
  ```bash
  maf2synteny -b 1000,5000,10000,50000 input_alignment.maf
  ```
- **Custom Output**: Direct the resulting block files to a specific directory.
  ```bash
  maf2synteny -o ./synteny_results input_alignment.maf
  ```

### Expert Tips and Best Practices
- **Input Requirements**: `maf2synteny` expects local alignments to be non-overlapping. While it is optimized for Cactus and SibeliaZ, alignments from other tools may fail or produce poor results if they contain overlapping coordinates for the same genomic region.
- **Custom Simplification**: To fine-tune the granularity beyond the `-b` parameter, use a simplification file (`-s`). This file should contain pairs of `min_block` and `max_gap` values per line.
  - `min_block`: The minimum size of a synteny block to be kept.
  - `max_gap`: The maximum distance allowed between two blocks to merge them.
- **Output Organization**: The tool creates subdirectories within the output folder for each scale specified in the `-b` argument (e.g., `blocks_5000/`, `blocks_10000/`).
- **Format Support**: If working with GFF files, ensure they follow the specific formatting conventions expected by the Kolmogorov lab tools, as standard GFFs from disparate sources may require pre-processing.

## Reference documentation
- [maf2synteny GitHub Repository](./references/github_com_mikolmogorov_maf2synteny.md)
- [maf2synteny Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_maf2synteny_overview.md)