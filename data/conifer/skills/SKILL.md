---
name: conifer
description: Conifer adds statistical depth to Kraken2 metagenomic classifications by evaluating the confidence of taxonomic assignments based on k-mer distributions. Use when user asks to calculate confidence scores for Kraken2 results, generate per-taxon summary reports, or analyze root-to-leaf scores for taxonomic lineages.
homepage: https://github.com/Ivarz/Conifer/
metadata:
  docker_image: "quay.io/biocontainers/conifer:1.0.3--h577a1d6_0"
---

# conifer

## Overview

Conifer is a high-performance tool designed to add statistical depth to Kraken2 metagenomic classifications. While Kraken2 assigns reads to taxa based on k-mer hits, Conifer evaluates the "confidence" of these assignments by analyzing the distribution of those k-mers within the taxonomic tree. It helps researchers distinguish between robust classifications and those that may be ambiguous or based on limited evidence. The tool can process individual reads or generate summarized reports containing percentiles (P25, P50, P75) for each taxon identified in a sample.

## Command Line Usage

### Core Requirements
To run conifer, you must provide two primary inputs:
1. The standard output file from a Kraken2 run (`-i`).
2. The taxonomy database file (`taxo.k2d`) associated with the Kraken2 database used for the classification (`-d`).

### Basic Scoring Patterns
By default, conifer outputs the original Kraken2 classification lines appended with the calculated scores.

*   **Calculate Confidence Scores:**
    `conifer -i kraken_output.txt -d taxo.k2d`
    *Output columns: Kraken standard fields | read1_conf | read2_conf | average_conf*

*   **Calculate RTL (Root-to-Leaf) Scores:**
    `conifer --rtl -i kraken_output.txt -d taxo.k2d`
    *RTL scores consider both descendants and ancestors of the assigned taxid.*

*   **Calculate Both Scores Simultaneously:**
    `conifer --both_scores -i kraken_output.txt -d taxo.k2d`

### Generating Summary Reports
Use the `-s` flag to generate a per-taxon summary instead of per-read scores. This is highly useful for sample-level quality control.

*   **Taxon Summary (Confidence):**
    `conifer -s -i kraken_output.txt -d taxo.k2d`
    *Provides: taxon_name, taxid, read_count, P25, P50, P75.*

*   **Taxon Summary (Both Scores):**
    `conifer --both_scores -s -i kraken_output.txt -d taxo.k2d`

## Expert Tips and Best Practices

*   **Paired-End Data:** Conifer automatically detects paired-end Kraken2 output (indicated by the `|:|` separator in the k-mer mapping field). It calculates scores for both mates and provides an average.
*   **Score Interpretation:**
    *   **Confidence Score:** Calculated as the fraction of k-mers assigned to the final taxonomy and its descendants. High scores indicate specific, well-supported assignments.
    *   **RTL Score:** Calculated from descendants and ancestors. This is often used to identify reads that are broadly consistent with a lineage even if not specific to a leaf node.
*   **Filtering:** Use the `-f` (or `--filter`) option to apply thresholds during processing, which can help reduce noise in large metagenomic datasets.
*   **Input Compression:** Conifer supports gzipped input files (`.gz`), allowing you to process large Kraken2 outputs without manual decompression.
*   **Database Consistency:** Ensure the `taxo.k2d` file exactly matches the database used by Kraken2. Using a different taxonomy file will result in incorrect score calculations or errors.

## Reference documentation
- [Conifer GitHub Repository](./references/github_com_Ivarz_Conifer.md)
- [Bioconda Conifer Overview](./references/anaconda_org_channels_bioconda_packages_conifer_overview.md)