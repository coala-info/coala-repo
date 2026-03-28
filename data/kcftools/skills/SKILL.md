---
name: kcftools
description: kcftools identifies genomic variations by analyzing k-mer presence or absence between a reference genome and query samples. Use when user asks to detect variants using k-mers, merge sample data into cohorts, or convert k-mer identity scores into genotype and PLINK formats.
homepage: https://github.com/sivasubramanics/kcftools
---


# kcftools

## Overview

kcftools is a Java-based toolset designed to identify genomic variations by analyzing the presence or absence of k-mers between a reference genome and query samples. By leveraging fast k-mer counting databases (KMC3), it calculates identity scores based on k-mer ratios and gap distances (inner and tail distances). This approach is particularly useful for large-scale comparative genomics, population genetics, and identifying regions of high similarity or divergence across cohorts.

## Core Workflows and CLI Patterns

### 1. Variant Detection (getVariations)
The primary entry point for analyzing a single sample against a reference. It splits the reference into windows (fixed-length or feature-based) and screens them against a KMC database.

```bash
# Basic usage with fixed windows
kcftools getVariations -r reference.fasta -i query_kmc_db -w 100 -o sample.kcf

# Using a GTF file for feature-based windows (genes/transcripts)
kcftools getVariations -r reference.fasta -i query_kmc_db -g features.gtf -o sample_features.kcf
```

**Expert Tips:**
* **KMC Compatibility**: Ensure your KMC database was built with KMC version 3.0.0 or higher.
* **Sliding Windows**: Use the sliding window option added in v0.3.0 for higher resolution analysis of transition boundaries.
* **Weights**: You can adjust the identity score calculation by tuning weights for k-mer ratio ($W_o$), inner distance ($W_i$), and tail distance ($W_t$).

### 2. Cohort Management
Once individual `.kcf` files are generated, they can be merged into a single matrix for population-level analysis.

```bash
# Merge multiple sample KCF files into a cohort
kcftools cohort -i sample1.kcf sample2.kcf sample3.kcf -o population.kcf
```

### 3. Downstream Analysis and Conversion
kcftools provides several utilities to format data for external tools like Tassel, GAPIT, or PLINK.

* **Genotype Table**: Convert KCF data to a genotype matrix.
  ```bash
  kcftools kcf2gt -i population.kcf -o genotype_table.txt
  ```
* **PLINK Format**: Export to PED/MAP format for association studies.
  ```bash
  kcftools kcf2plink -i population.kcf -o study_prefix
  ```
* **TSV Export**: Replicate IBSpy-like output for manual inspection or R/Python analysis.
  ```bash
  kcftools kcf2tsv -i sample.kcf -o sample.tsv
  ```

### 4. Refinement and Statistics
* **scoreRecalc**: If you decide to change the importance of k-mer counts vs. gap distances after the initial run, use `scoreRecalc` to update the identity scores without re-running the k-mer screening.
* **getAttributes**: Use this to generate summary statistics and metadata about the KCF files.
* **increaseWindow**: Compose larger genomic windows from fine-grained KCF data (e.g., moving from 100bp windows to 1kb windows).

## Identity Score Formula
The tool calculates similarity using:
$Identity Score = W_o \cdot (\frac{obs}{total}) + W_i \cdot (1 - \frac{inner}{eff}) + W_t \cdot (1 - \frac{tail}{eff}) \cdot 100$

Where:
* **obs/total**: Ratio of reference k-mers found in the query.
* **inner dist**: Bases not covered by k-mers between hits.
* **tail dist**: Uncovered bases at window edges.



## Subcommands

| Command | Description |
|---------|-------------|
| kcf2gt | Convert KCF to Genotype Table |
| kcf2plink | Convert KCF windows to PED format |
| kcftools getVariations | Screen for reference kmers that are not present in the KMC database, and detect variation |
| kcftools kcf2tsv | Convert KCF file to TSV file (IBSpy like) |
| kcftools_cohort | Create a cohort of samples kcf files |
| kcftools_findIBS | Find IBS windows in a KCF file |
| kcftools_getAttributes | Extract attributes from KCF files |
| kcftools_increaseWindow | Increase the window size of a KCF file by merging windows |
| kcftools_scoreRecalc | Recalculate scores in a KCF file |
| kcftools_splitKCF | Split KCF file for each chromosome |

## Reference documentation
- [KCFTOOLS Main README](./references/github_com_sivasubramanics_kcftools_blob_main_README.md)
- [Changelog and Plugin Updates](./references/github_com_sivasubramanics_kcftools_blob_main_CHANGELOG.md)