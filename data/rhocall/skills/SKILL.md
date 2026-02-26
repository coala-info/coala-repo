---
name: rhocall
description: "rhocall processes and annotates regions of homozygosity to facilitate uniparental disomy detection and visualization. Use when user asks to annotate VCF files with ROH information, tally chromosome-wide homozygosity statistics, or visualize zygosity patterns."
homepage: https://github.com/dnil/rhocall
---


# rhocall

## Overview
The `rhocall` tool is a specialized suite for processing and annotating regions of homozygosity. It bridges the gap between raw ROH callers (like `bcftools roh`) and downstream analysis by providing utilities to aggregate windows, calculate chromosome-wide statistics for UPD detection, and visualize zygosity patterns. It is designed to work with VCF/BCF files and supports both modern (bcftools v1.4+) and legacy output formats.

## Core CLI Workflows

### Standard Annotation Workflow
The most common use case is taking ROH calls from `bcftools` and integrating them back into a VCF for filtering.

1.  **Generate ROH calls**:
    ```bash
    bcftools roh --AF-file popfreq.tab.gz -I sample.bcf > sample.roh
    ```
2.  **Annotate the VCF**:
    Use the `--v14` flag for modern bcftools outputs to ensure sample-specific calls are correctly mapped.
    ```bash
    rhocall annotate --v14 -r sample.roh -o sample.annotated.vcf sample.bcf
    ```

### UPD Screening and Tallying
To screen for Uniparental Disomy, use the `tally` command to calculate the fraction of the chromosome covered by homozygous blocks.

```bash
rhocall tally sample.roh -o sample.tally.tsv
```
*   **Expert Tip**: Look for chromosomes where the fraction of autozygosity is significantly higher than the rest of the genome, which may indicate UPD.

### Visualization
Generate chromosome-wide plots to inspect the distribution of homozygous SNVs and RHO regions.

```bash
rhocall viz --rho sample.roh --out_dir plots/ --wig sample.vcf
```
*   **Note**: The `--wig` flag is useful for creating browser tracks (Wiggle format) to view zygosity density in tools like IGV.

### Handling Legacy Data
If working with older `bcftools` (v1.2 or earlier) or specific BED-based workflows, use the aggregation step:

```bash
# Convert TSV calls to BED windows
rhocall aggregate sample.roh -o sample.roh.bed

# Annotate using the BED file
rhocall annotate -b sample.roh.bed -o sample.rho.vcf sample.bcf
```

## Command Reference & Best Practices

| Command | Primary Use Case | Key Parameter |
| :--- | :--- | :--- |
| `call` | Native ROH calling from VCF | `-m`: Max hets per Mb (default is strict) |
| `annotate` | Adding ROH info to VCF INFO/FILTER fields | `-u`: Flag UPD if fraction exceeds threshold |
| `aggregate` | Smoothing raw site-calls into genomic windows | `-q`: Quality threshold for window boundaries |
| `viz` | Visual QC of homozygosity distribution | `-w`: Window size for binning SNVs |

### Parameter Tuning for `rhocall call`
When using the internal caller instead of `bcftools`:
*   **Exome vs. Genome**: Adjust `-s` (block constant). Exome data requires different density expectations than WGS.
*   **Strictness**: Use `-f` (max het fraction) to control how many "leaky" heterozygotes are allowed within a homozygous block before it is broken.

## Reference documentation
- [rhocall GitHub Repository](./references/github_com_dnil_rhocall.md)
- [Bioconda rhocall Package Overview](./references/anaconda_org_channels_bioconda_packages_rhocall_overview.md)