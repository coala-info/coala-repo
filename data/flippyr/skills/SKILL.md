---
name: flippyr
description: "flippyr aligns PLINK binary filesets to a reference genome by identifying and correcting strand-flipped variants and allele mismatches. Use when user asks to orient genomic data to a reference, identify strand-flipped SNPs, or prepare PLINK files for imputation."
homepage: https://github.com/BEFH/flippyr
---


# flippyr

## Overview
`flippyr` is a specialized tool for genomic data preprocessing that ensures PLINK binary filesets are correctly oriented and matched to a reference genome. It automates the tedious process of identifying variants on the reverse strand, swapped major/minor alleles, and problematic palindromic (ambiguous) SNPs. By default, it also filters out indels and multi-allelic sites to meet the strict requirements of most imputation pipelines.

## Usage Instructions

### Basic Command Line Interface
The primary way to use `flippyr` is via the command line. It requires a reference FASTA file and the `.bim` file from your PLINK fileset.

```bash
# Basic check (generates a new .bim-like table and log)
flippyr.py reference.fasta input_data.bim

# Run and automatically execute PLINK to create the corrected fileset
# Note: PLINK must be in your system PATH
flippyr.py -p reference.fasta input_data.bim -o aligned_output
```

### Common CLI Patterns
- **Pre-Imputation Cleanup**: Use the default settings to remove indels and multi-allelic sites, which are typically disallowed by imputation servers.
- **Preserving Variants**: If your downstream analysis supports them, use `-i` to keep indels and `-m` to keep multi-allelic sites.
- **Silent Operation**: Use `-s` in automated scripts to suppress stdout.
- **Custom Suffixes**: Use `--outputSuffix` to define a specific naming convention for the resulting PLINK files.

### Python API
You can integrate `flippyr` directly into Python workflows for more complex data processing:

```python
import flippyr

# Returns a pandas DataFrame of the bim file and a log object
bim_df, log = flippyr.run("ref.fasta", "data.bim", silent=True)

# To also trigger the PLINK command execution
bim_df, log, plink_cmd = flippyr.run("ref.fasta", "data.bim", plink=True)
```

## Expert Tips and Best Practices
- **FASTA Formatting**: Ensure your FASTA reference IDs start with the chromosome identifier (e.g., `1`, `22`, `X`, `MT`). The tool recognizes the `chr` prefix (e.g., `chr1`), but the chromosome number must be at the very beginning of the header line.
- **Ambiguous Alleles**: `flippyr` automatically removes palindromic SNPs (AT, TA, CG, GC). These are removed because it is mathematically impossible to determine if they are strand-flipped or correctly aligned based on the reference alone.
- **Memory Management**: When running with the `-p` (plink) flag, `flippyr` attempts to manage PLINK memory allocation. Ensure your environment has sufficient resources for the size of your `.bed` file.
- **Chromosome Support**: The tool supports autosomes (1-22) as well as X, Y, and Mitochondrial (M/MT) DNA, provided they are present in your FASTA reference.
- **File Dependencies**: While only the `.bim` file is passed as an argument for the analysis, the corresponding `.bed` and `.fam` files must reside in the same directory if you use the `-p` flag to generate a new fileset.

## Reference documentation
- [flippyr Overview](./references/anaconda_org_channels_bioconda_packages_flippyr_overview.md)
- [flippyr GitHub Documentation](./references/github_com_BEFH_flippyr.md)