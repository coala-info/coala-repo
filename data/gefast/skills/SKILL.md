---
name: gefast
description: GeFaST (Generalised Fastidious Swarming Tool) is a bioinformatics utility for clustering nucleotide sequences into OTUs.
homepage: https://github.com/romueller/gefast
---

# gefast

## Overview
GeFaST (Generalised Fastidious Swarming Tool) is a bioinformatics utility for clustering nucleotide sequences into OTUs. It extends the iterative clustering strategy popularized by Swarm by allowing for a broader range of distance notions and refinement methods. The tool is particularly useful for processing large datasets where sequence quality and abundance must be considered to achieve high-resolution clustering while minimizing the impact of sequencing errors.

## Installation
The most efficient way to install GeFaST is via Bioconda:
```bash
conda install bioconda::gefast
```

## Command Line Usage
GeFaST follows a strict positional argument structure:
```bash
GeFaST <mode> <input> <config> [options]
```

### Mandatory Arguments
1.  **mode**: The clustering technique or distance metric to use.
2.  **input**: A comma-separated list of file paths (e.g., `file1.fastq,file2.fastq`).
3.  **config**: Path to a configuration file containing basic execution parameters.

### Available Modes
- **lev**: Levenshtein distance (edit operations in optimal pairwise alignments).
- **as**: Alignment score based clustering.
- **qlev**: Quality-aware Levenshtein distance.
- **qas**: Quality-aware alignment score.
- **cons**: Consistency-based clustering (considers quality and abundance).
- **derep**: Dereplication (grouping by exact sequence equality).

## Best Practices and Expert Tips
- **Priority of Options**: If an option is defined in both the configuration file and the command line, the command line value always takes priority.
- **Dereplication First**: Use the `derep` mode as an initial step to group identical sequences. This significantly reduces the computational load for subsequent clustering modes like `lev` or `qlev`.
- **Quality-Aware Clustering**: When working with FASTQ data, prefer `qlev` or `qas` over standard `lev` or `as`. These modes utilize quality scores to better distinguish between true biological variation and sequencing artifacts.
- **Input Formatting**: Ensure multiple input files are separated by commas without spaces to avoid shell parsing errors.
- **Memory Management**: For extremely large datasets, ensure you are using the latest version (2.0.1+), which includes performance improvements and better handling of quality-weighted cost functions.

## Reference documentation
- [GeFaST GitHub Repository](./references/github_com_romueller_gefast.md)
- [Bioconda GeFaST Overview](./references/anaconda_org_channels_bioconda_packages_gefast_overview.md)