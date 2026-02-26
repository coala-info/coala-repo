---
name: dedup
description: DeDup removes PCR duplicates from DNA sequencing data by utilizing both start and end coordinates for merged fragments. Use when user asks to remove PCR duplicates, process ancient DNA fragments, or deduplicate a mixture of merged and unmerged reads.
homepage: https://github.com/apeltzer/dedup
---


# dedup

## Overview
DeDup is a specialized PCR duplicate removal tool designed for ultra-short DNA fragments. While standard deduplication tools typically only consider the 5' start position of a read, DeDup utilizes both the 5' and 3' coordinates for merged reads. This approach is significantly more precise for ancient DNA workflows, as it prevents the over-deduplication of unique fragments that happen to share a start position but have different lengths. It handles a mixture of merged and unmerged reads within the same library by using a specific naming convention.

## Usage Guidelines

### Read Name Prefixes
DeDup identifies the type of sequencing data based on read name prefixes. You must ensure your BAM file contains these prefixes before running the tool:
- `M_`: Merged reads (DeDup will use both start and end positions).
- `F_`: Forward unmerged reads (DeDup will use only the start position).
- `R_`: Reverse unmerged reads (DeDup will use only the start position).

If your reads are merged using `AdapterRemoval` but lack these prefixes, use the companion tool `AdapterRemovalFixPrefix` to prepend them before running DeDup.

### Deduplication Logic
- **Merged Reads (`M_`)**: Two reads are considered duplicates only if both their start and end genomic positions match. The read with the highest quality score is retained.
- **Unmerged Reads (`F_` or `R_`)**: Only the start position is considered.
- **Mixed Reads**: If an `M_` read and an `F_` read share the same start position, DeDup prefers the `M_` read, assuming it provides higher quality and more complete fragment information.

### Command Line Best Practices
- **Input Format**: DeDup operates on BAM files. Ensure your input is properly sorted and indexed if required by your specific version.
- **Single-End Data Warning**: Avoid using DeDup for exclusively single-end data. If you must use it with the `--merged` flag on single-end data, be aware that it will sub-optimally deduplicate because the "end" of a single-end read does not necessarily represent the true end of the DNA molecule.
- **Installation**: The recommended way to manage the environment is via Bioconda:
  ```bash
  conda install bioconda::dedup
  ```

## Reference documentation
- [DeDup GitHub Repository](./references/github_com_apeltzer_DeDup.md)
- [Bioconda DeDup Overview](./references/anaconda_org_channels_bioconda_packages_dedup_overview.md)