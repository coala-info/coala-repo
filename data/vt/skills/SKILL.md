---
name: vt
description: vt is a toolset for the preprocessing, normalization, and decomposition of genetic variants in VCF files. Use when user asks to normalize variants, decompose multiallelic sites or block substitutions, filter variants, and remove duplicate records.
homepage: https://genome.sph.umich.edu/wiki/Vt
---


# vt

## Overview
The `vt` (Variant Toolset) skill provides a specialized workflow for the preprocessing and normalization of genetic variants stored in VCF files. It is primarily used to ensure that variants are represented in a parsimonious and consistent manner, which is a prerequisite for accurate variant calling, annotation, and comparison across different datasets.

## Core Workflows and CLI Patterns

### 1. Variant Normalization
Normalization ensures that variants are left-aligned and represented by the shortest possible alleles. This is critical for Indels.
```bash
vt normalize input.vcf.gz -r reference.fa -o normalized.vcf.gz
```
*   **Tip**: Always provide the matching reference genome (`-r`) used for the original alignment.

### 2. Decomposing Multi-allelic Variants
Many tools output multiple alternative alleles on a single VCF line. Decomposing them into individual biallelic records simplifies filtering and annotation.
```bash
vt decompose input.vcf.gz -o decomposed.vcf.gz
```
*   **Note**: Use the `-s` flag if you wish to smart-decompose (splitting genotypes correctly).

### 3. Decomposing Block Substitutions
To break down complex variants (MNPs) into individual SNPs:
```bash
vt decompose_blocksub input.vcf.gz -o decomposed_blocks.vcf.gz
```

### 4. Filtering Variants
Filter variants based on specific criteria like quality, depth, or type.
```bash
# Filter for SNPs only
vt peek input.vcf.gz

# Subset or filter by expression (if supported by your build)
vt subset input.vcf.gz -f "QUAL>30" -o filtered.vcf.gz
```

### 5. Recommended Preprocessing Pipeline
For the most consistent results, execute these commands in sequence:
1.  **Decompose**: Split multi-allelic sites.
2.  **Normalize**: Left-align and parsimonize.
3.  **Unique**: Remove duplicate variants.

```bash
vt decompose input.vcf.gz | vt normalize - -r ref.fa | vt uniq - -o processed.vcf.gz
```

## Expert Tips
*   **Streaming**: `vt` supports piping (`-` for stdin/stdout), which saves disk space and I/O time when chaining multiple transformation steps.
*   **Indexing**: Ensure your input VCF is compressed with `bgzip` and indexed with `tabix` for tools that require random access, though `vt` generally processes files linearly.
*   **Reference Consistency**: If normalization results in unexpected changes, verify that the chromosome naming (e.g., "chr1" vs "1") in your VCF matches your reference FASTA exactly.



## Subcommands

| Command | Description |
|---------|-------------|
| vt annotate_1000g | annotates variants that are present in 1000 Genomes variant set |
| vt annotate_regions | annotates regions in a VCF file |
| vt compute_concordance | Compute Concordance. |
| vt decompose | decomposes multiallelic variants into biallelic in a VCF file. |
| vt discover | Discovers variants from reads in a BAM file. |
| vt genotype | Genotypes variants for each sample. |
| vt multi_partition | partition variants from any number of data sets. |
| vt normalize | normalizes variants in a VCF file |
| vt partition | partition variants from two data sets. |
| vt paste | Pastes VCF files like the unix paste functions. This is used after the per sample genotyping step in vt. |
| vt_annotate_variants | annotates variants in a VCF file |
| vt_cat | Concatenate VCF files. Individuals must be in the same order. |
| vt_compute_features | Compute features for variants. |
| vt_index | Indexes a VCF.GZ or BCF file. |
| vt_peek | Summarizes the variants in a VCF file |
| vt_sort | Sorts a VCF or BCF or VCF.GZ file. |
| vt_subset | Subsets a VCF file to a set of variants that are polymorphic on a selected set of individuals. |
| vt_uniq | Drops duplicate variants that appear later in the the VCF file. |
| vt_view | Views a VCF or BCF or VCF.GZ file. |

## Reference documentation
- [vt Overview](./references/anaconda_org_channels_bioconda_packages_vt_overview.md)