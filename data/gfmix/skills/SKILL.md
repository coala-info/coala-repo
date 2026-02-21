---
name: gfmix
description: The `gfmix` tool implements site-and-branch-heterogeneous phylogenetic models to provide more accurate evolutionary estimations than standard site-homogeneous models.
homepage: https://www.mathstat.dal.ca/~tsusko/doc/gfmix.pdf
---

# gfmix

## Overview
The `gfmix` tool implements site-and-branch-heterogeneous phylogenetic models to provide more accurate evolutionary estimations than standard site-homogeneous models. It is primarily used to fit models that account for complex amino acid frequency distributions across different parts of a phylogenetic tree. Use this skill when you need to refine phylogenetic likelihoods using the GFmix model, typically following a standard analysis in IQ-TREE.

## Command Line Usage

The basic syntax for running `gfmix` is:

```bash
gfmix -s <seqfile> -t <treefile> -i <iqtreefile> -f <frfile> -r <rootfile> [options]
```

### Required Arguments
- `-s <seqfile>`: Input sequence file in PHYLIP format.
- `-t <treefile>`: Newick tree file including edge-lengths.
- `-i <iqtreefile>`: The `.iqtree` output file from a previous IQ-TREE run.
- `-f <frfile>`: A file containing frequency classes (one per row).
- `-r <rootfile>`: A file containing 0-based integer labels of taxa on one side of the root split.

### Optional Arguments
- `-fclass <string>`: Amino acids in the F class (Default: 'FYMINK').
- `-gclass <string>`: Amino acids in the G class (Default: 'GARP').

## Best Practices and Expert Tips

### Sequence Formatting (PHYLIP)
- **Strict Naming**: Taxa names must be exactly 10 characters long, padded with trailing blanks if necessary.
- **Consistency**: Ensure names in the sequence file match the names in the tree file exactly.
- **Structure**: The first line must contain the number of taxa and sites. Subsequent lines must have the taxon name followed immediately by sequence data.

### Rooting and Taxa Indexing
- **0-Based Indexing**: The `rootfile` uses integers where `0` is the first sequence in the `-s` file, `1` is the second, and so on.
- **Root Split**: The `rootfile` only needs to list the taxa on *one* side of the root.

### IQ-TREE Integration
- **Model Selection**: `gfmix` currently assumes an LG exchangeability matrix. Run IQ-TREE with `LG` options.
- **Required Options**: IQ-TREE must be run with a class-frequency mixture (`+F`) and gamma rate variation (`+G`). `gfmix` extracts the mixture weights and alpha parameter from the `.iqtree` file.

### Frequency Files
- **C-Series**: For C10 through C60 models, use the provided `.aafreq.dat` files (e.g., `C20.aafreq.dat`).
- **Zero Frequencies**: The tool automatically adjusts frequencies lower than 1.0e-8 to 1.0e-8 and rescales them to ensure the sum is 1.

### Environment Management
- **Temporary Files**: `gfmix` generates files prefixed with `tmp.*`. Ensure no important files with this prefix exist in your working directory, as they may be overwritten or deleted.
- **Binary Path**: If `gfmix` is not in your system PATH, you must edit the `bindir` variable within the `gfmix` R script to point to the directory containing the helper binaries (`treecns`, `rert`, `alpha_est_mix_rt`).

## Reference documentation
- [gfmix: Phylogenetic analyses using the site-and-branch-heterogeneous GFmix model](./references/www_mathstat_dal_ca__tsusko_doc_gfmix.pdf.md)
- [gfmix - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_gfmix_overview.md)