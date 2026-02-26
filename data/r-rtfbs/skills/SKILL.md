---
name: r-rtfbs
description: The r-rtfbs tool identifies transcription factor binding sites in genomic sequences using the rtfbs R package. Use when user asks to identify transcription factor binding sites, score sequences against position weight matrices, calculate false discovery rates, or threshold identified sites.
homepage: https://cran.r-project.org/web/packages/rtfbs/index.html
---


# r-rtfbs

name: r-rtfbs
description: Identify transcription factor binding sites (TFBS) in genomic sequences using the rtfbs R package. Use this skill for data pre-processing, scoring sequences against Position Weight Matrices (PWMs), calculating False Discovery Rates (FDR), and thresholding identified sites.

# r-rtfbs

## Overview
The rtfbs package is a specialized tool for identifying transcription factor binding sites within the R statistical environment. It provides a complete workflow for genomic sequence analysis, including data pre-processing, site scoring, and statistical validation through FDR calculation.

## Installation
Install the package from CRAN using the following command:
install.packages("rtfbs")

## Core Workflow
The package follows a sequential pipeline for TFBS identification:

1. Data Input: Load genomic sequence data and Position Weight Matrices (PWMs).
2. Pre-processing: Prepare sequences and background models for accurate scoring.
3. Site Identification & Scoring: Scan sequences with PWMs to generate binding scores for potential sites.
4. FDR Calculation: Determine the False Discovery Rate for the generated scores.
5. Thresholding: Apply score or FDR-based thresholds to filter and identify significant binding sites.

## Usage Tips
- Ensure sequence data is in a compatible format (e.g., DNAStringSet or similar genomic structures).
- PWMs should be properly formatted as matrices representing the frequency or probability of nucleotides at each position.
- Use the FDR calculation functions to distinguish true binding sites from background noise effectively.

## Reference documentation
- [RTFBS Home Page](./references/home_page.md)