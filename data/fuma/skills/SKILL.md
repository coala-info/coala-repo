---
name: fuma
description: FuMa (Fusion Matcher) is a specialized tool for harmonizing fusion gene detection results.
homepage: https://github.com/yhoogstrate/fuma/
---

# fuma

## Overview
FuMa (Fusion Matcher) is a specialized tool for harmonizing fusion gene detection results. Instead of relying solely on genomic coordinates—which can be inconsistent across different alignment algorithms—FuMa uses gene annotations to determine if fusion events are identical. It supports various matching strategies (overlap, subset, and exact gene matching) to account for the complexity of overlapping gene annotations in the human genome. Use this skill to merge multi-tool outputs, identify recurrent fusions across cohorts, or filter predictions based on specific gene sets.

## Command Line Usage

### 1. Preparing Annotations
FuMa requires a BED file for gene annotations. If you have a Gencode GTF, use the built-in utility to convert it:

```bash
fuma-gencode-gtf-to-bed input_annotation.gtf > annotation.bed
```

### 2. Basic Fusion Matching
To match fusions between two different tools for the same sample:

```bash
fuma -a annotation.bed \
     -s tool1_results.txt \
     -s tool2_results.txt \
     -l tool1_results.txt annotation.bed \
     -l tool2_results.txt annotation.bed \
     -m overlap \
     -f output_merged.txt
```

### 3. Core Arguments
- `-a <file.bed>`: Adds a gene annotation file.
- `-s <file>`: Adds a sample/tool output file.
- `-l <sample_file> <annotation_file>`: Links a specific input file to an annotation set.
- `-m <method>`: Sets the matching strategy. Options: `overlap` (default), `subset`, or `egm` (Exact Gene Matching).
- `-f <format>`: Specifies output format.
- `--strand-specific-matching`: Forces matching to consider the coding strand.
- `--acceptor-donor-order-specific-matching`: Distinguishes between GeneA-GeneB and GeneB-GeneA fusions.

## Matching Strategies & Best Practices

### Choosing a Matching Method
- **Overlap (Default):** Most lenient. Considers fusions identical if their gene sets share at least one common gene on both the left and right breakpoints. Best for discovery and cross-tool validation.
- **Subset:** More stringent. One fusion's gene set must be a subset of the other's.
- **Exact Gene Matching (EGM):** Most stringent. Requires the gene sets at both breakpoints to be identical.

### Handling "Set Shrinkage"
When using `overlap` matching, FuMa returns the **intersect** of the gene sets rather than the union. This prevents "set expansion" (where results change based on the order of files processed) but can result in a matched gene set that is smaller than the original input sets.

### Supported Input Formats
FuMa natively supports outputs from a wide range of callers. Ensure your input files match the expected format for:
- STAR-Fusion / STAR
- FusionCatcher
- deFuse
- EricScript
- JAFFA
- Chimera / ChimeraScan

## Expert Tips
- **Long Gene Bias:** Be aware that very long genes (e.g., TTN, NEB) are more likely to trigger "overlap" matches by chance. If you see suspicious clusters in long genes, consider switching to `-m subset`.
- **Custom Regions:** You can provide FuMa with custom BED files (e.g., only exonic regions) instead of full gene bodies to restrict matching to specific biological features.
- **Order Sensitivity:** Use `--acceptor-donor-order-specific-matching` if you are analyzing directional RNA-seq data where the orientation of the fusion (which gene is the 5' partner) is biologically significant.

## Reference documentation
- [FuMa GitHub Repository](./references/github_com_yhoogstrate_fuma.md)
- [Bioconda fuma Overview](./references/anaconda_org_channels_bioconda_packages_fuma_overview.md)