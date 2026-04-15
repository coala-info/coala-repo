---
name: enhjoerning
description: Enhjoerning extracts high-resolution statistics and metagenomic metrics from short-read alignments to evaluate reference coverage and taxonomic composition. Use when user asks to calculate ANI and breadth of coverage, aggregate alignment data by taxonomic ID, resolve multi-mapped reads using EM reassignment, or generate global BAM summary statistics.
homepage: https://github.com/GeoGenetics/unicorn
metadata:
  docker_image: "quay.io/biocontainers/enhjoerning:2.4.0--h577a1d6_0"
---

# enhjoerning

## Overview

`enhjoerning` (also known as Unicorn) is a specialized tool for extracting high-resolution statistics from short-read alignments. Unlike standard tools that focus on simple counts, `enhjoerning` provides metrics critical for metagenomics, such as Average Nucleotide Identity (ANI), Breadth of Coverage, and evenness coefficients (Gini and Entropy). It is designed to handle large-scale metagenomic datasets where distinguishing between closely related reference sequences or accurately assigning multi-mapped reads is essential.

## Command-Line Usage

The tool is invoked via the `unicorn` executable (or `enhjoerning` if installed via conda) followed by a specific subcommand.

### 1. Per-Reference Statistics (`refstats`)
Use this to evaluate the quality and quantity of alignments for every reference sequence in your BAM file.

*   **Basic usage:**
    `unicorn refstats -b input.bam > ref_metrics.tsv`
*   **Filtering on the fly:**
    Exclude low-quality hits by setting minimum read counts or reference lengths.
    `unicorn refstats -b input.bam --minreads 10 --minrefl 1000 --outstat filtered_stats.txt`
*   **Simultaneous Filtering:**
    Generate a filtered BAM file containing only the alignments that pass your criteria while computing statistics.
    `unicorn refstats -b input.bam --minreads 50 --outbam high_confidence.bam`

### 2. Taxonomic Statistics (`tidstats`)
Use this to aggregate alignment data by Taxonomic ID. This requires NCBI-style taxonomy files.

*   **Standard Taxonomic Summary:**
    `unicorn tidstats -b input.bam -a acc2tax.txt -n names.dmp -d nodes.dmp --rank species`
*   **Performance Tip:** Use a `.khash` file for the accession-to-taxid mapping (`-a`) for significantly faster lookups compared to flat text files.

### 3. Multi-mapping Reassignment (`reassign`)
Use this to resolve reads that map to multiple locations using an Expectation-Maximization (EM) algorithm.

*   **Requirement:** The input BAM must be **query-grouped** (sorted or collated by name, not coordinate).
*   **Execution:**
    `unicorn reassign -b input.bam -o reassigned.bam --threads 8`
*   **Scaling:** Use `--scale-type LENGTH` (default) to weight subjects by their length during reassignment.

### 4. Global Summary (`bamstats`)
Use this for a quick high-level overview of the entire BAM file.

*   **Usage:**
    `unicorn bamstats -b input.bam`
*   **Distributions:** Add `--printdists` to generate supplementary files containing distributions for read lengths and alignment lengths.

## Expert Tips and Best Practices

*   **Metagenomic Quality Control:** When assessing if a species is truly present, look at the `breath_ratio` and `evenness_cov` columns in the `refstats` output. A high read count with very low breadth or poor evenness often indicates mapping artifacts or conserved regions rather than true presence.
*   **ANI Calculations:** `enhjoerning` calculates `m_alnani` (Mean Alignment ANI). This is a powerful metric for verifying that reads are actually derived from the reference they mapped to, helping to identify potential cross-mapping between sister species.
*   **Memory Management:** For `tidstats`, the taxonomy database is loaded into memory. Ensure your environment has sufficient RAM when using the full NCBI taxonomy.
*   **Threading:** Most commands support `-t` or `--threads`. For `refstats` and `reassign`, increasing threads significantly reduces processing time for deep-sequenced metagenomes.
*   **Output Interpretation:** The `refstats` output contains 28 columns. Key columns for filtering include `tad80` (Truncated Average Depth at 80%), which provides a more robust depth estimate by removing the top and bottom 10% of coverage outliers.

## Reference documentation
- [enhjoerning - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_enhjoerning_overview.md)
- [GitHub - GeoGenetics/unicorn: Tool repositiory for bam files](./references/github_com_GeoGenetics_unicorn.md)