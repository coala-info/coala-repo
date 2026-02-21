---
name: dice
description: DICE (Distance-based Inference of Copy-number Evolution) is a specialized tool for inferring the evolutionary history of cells using copy number profiles.
homepage: https://github.com/samsonweiner/DICE
---

# dice

## Overview
DICE (Distance-based Inference of Copy-number Evolution) is a specialized tool for inferring the evolutionary history of cells using copy number profiles. It excels in scalability and accuracy by utilizing distance-based methods rather than complex model-based approaches. The tool supports both allele-specific and total copy number data and integrates with the `fastme` package to generate phylogenetic trees using various minimum evolution and neighbor-joining algorithms.

## Command Line Usage

### Basic Execution (DICE-star)
The default method (DICE-star) uses standard root distance. To reconstruct a tree using the recommended Balanced Minimum Evolution (balME) algorithm:
```bash
dice -i input_profiles.tsv -o output_dir -m balME
```

### Breakpoint-based Reconstruction (DICE-bar)
To use breakpoint-root distances (DICE-bar), which can be more effective for certain evolutionary models, add the `-b` flag:
```bash
dice -i input_profiles.tsv -o output_dir -m balME -b
```

### Working with Total Copy Numbers
By default, DICE assumes allele-specific copy numbers (e.g., `1,1`). If your data contains only total copy numbers (e.g., `2`), use the `-t` flag:
```bash
dice -i input_profiles.tsv -t
```

### Saving Intermediate Data
To save the pairwise distance matrix in PHYLIP format for use with other phylogenetic software:
```bash
dice -i input_profiles.tsv -s
```

## Input File Requirements
The input must be a tab-separated values (TSV) file with the following mandatory headers:
- `CELL`: Unique identifier for the cell.
- `chrom`: Chromosome name (e.g., `chr1`).
- `start`: Starting genomic position.
- `end`: Ending genomic position.
- `CN states`: The copy number value. 
    - Allele-specific: `a,b` (e.g., `1,2`).
    - Total: A single integer (requires `-t` flag).

## Expert Tips and Best Practices
- **Algorithm Selection**: `balME` (Balanced Minimum Evolution) is generally preferred for accuracy. Other options include `olsME`, `NJ`, and `uNJ`.
- **Distance Metrics**: While `root` is the default and typically performs best, you can experiment with `log`, `euclidean`, or `manhattan` using the `-d` option.
- **Tree Search Strategy**: By default, DICE uses an SPR (Subtree Pruning and Regrafting) search. Use the `-n` flag to switch to an NNI (Nearest Neighbor Interchanges) search if a faster, though potentially less exhaustive, search is required.
- **Dependency Management**: Ensure `fastme` is installed and available in your system `$PATH`. If it is installed in a non-standard location, specify it using `-f /path/to/fastme`.
- **Reproducibility**: Always set a seed using `-z <seed_value>` when performing phylogenetic reconstruction to ensure consistent results across runs.

## Reference documentation
- [DICE GitHub Repository](./references/github_com_samsonweiner_DICE.md)
- [DICE Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dice_overview.md)