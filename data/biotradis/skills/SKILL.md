---
name: biotradis
description: Bio-Tradis is a specialized toolkit designed for the processing and analysis of transposon insertion sequencing data.
homepage: https://github.com/sanger-pathogens/Bio-Tradis
---

# biotradis

## Overview
Bio-Tradis is a specialized toolkit designed for the processing and analysis of transposon insertion sequencing data. While optimized for the Sanger TraDIS protocol, it is compatible with various transposon-based methods that produce similar data formats. The toolset manages the entire pipeline from raw sequence data (FastQ) to the generation of insertion site plots and statistical analysis of gene essentiality or comparative growth conditions.

## Core CLI Workflows

### 1. Complete Analysis Pipeline
The `bacteria_tradis` script is the primary entry point for a full analysis. It handles mapping, tag detection, and plot generation.

```bash
# Run complete analysis on a list of FastQ files
bacteria_tradis -f fastq_list.txt -r reference.fa -t TAG_SEQUENCE
```

*   **Input List**: The `-f` flag requires a text file containing the paths to FastQ files, one per line.
*   **Tags**: If tags are already present in the BAM/FastQ, the script can be run without the `-t` option.
*   **Output**: Produces mapped BAM files and `.plot.gz` insertion site files.

### 2. Tag Management and Filtering
If manual preprocessing is required before running the full pipeline:

*   **Detect Tags**: Check if TraDIS tags exist in a BAM file.
    ```bash
    check_tradis_tags -b input.bam
    ```
*   **Filter by Tag**: Extract reads matching a specific transposon tag.
    ```bash
    filter_tradis_tags -f reads.fastq -t TAAGAGACAG -m 0 -o filtered.fastq
    ```
*   **Remove Tags**: Strip tags from sequences before mapping.
    ```bash
    remove_tradis_tags -f filtered.fastq -t TAAGAGACAG -o clean.fastq
    ```

### 3. Generating Insertion Site Plots
To create a gzipped insertion site plot from a mapped BAM file:
```bash
tradis_plot -b mapped.bam
```

### 4. Downstream Gene Analysis
After generating plot files, use these scripts to quantify insertions per gene and determine essentiality.

*   **Quantify Insertions**: Requires a genome annotation in EMBL format.
    ```bash
    tradis_gene_insert_sites -f annotation.embl -p sample.plot.gz -o gene_counts.tab
    ```
*   **Determine Essentiality**: Uses the R-based analysis script on the output from the previous step.
    ```bash
    tradis_essentiality.R gene_counts.tab
    ```
*   **Comparative Analysis**: Compare two conditions (requires replicates) using edgeR.
    ```bash
    tradis_comparison.R condition1_reps.tab condition2_reps.tab
    ```

## Expert Tips and Best Practices

*   **Parameter Tuning**: Default parameters in `bacteria_tradis` are optimized for comparative experiments. For gene essentiality studies, parameters (such as mapping stringency or insertion thresholds) may need manual adjustment.
*   **Mapping Logic**: The pipeline uses SMALT or BWA. When using SMALT, the tool automatically calculates `-sk` and `-ss` parameters based on read length:
    *   Reads < 70bp: `-sk 13 -ss 4`
    *   Reads 70-100bp: `-sk 13 -ss 6`
    *   Reads > 100bp: `-sk 20 -ss 13`
*   **Memory Management**: When using `filter_tradis_tags` on gzipped files, the tool creates a temporary unzipped version. Ensure sufficient disk space is available in the working directory.
*   **Annotation Format**: `tradis_gene_insert_sites` specifically requires **EMBL** format for annotations. Convert GFF or GenBank files to EMBL before running this step.

## Reference documentation
- [Bio-Tradis GitHub Repository](./references/github_com_sanger-pathogens_Bio-Tradis.md)
- [Bio-Tradis Binaries and Scripts](./references/github_com_sanger-pathogens_Bio-Tradis_tree_master_bin.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_biotradis_overview.md)