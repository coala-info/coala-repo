---
name: pbwt
description: "pbwt provides a high-performance environment for managing and analyzing aligned haplotype data using the Positional Burrows-Wheeler Transform. Use when user asks to convert genetic formats to PBWT, find maximal haplotype matches, calculate site frequency spectra, or perform local ancestry inference through painting algorithms."
homepage: https://github.com/richarddurbin/pbwt
---


# pbwt

## Overview

The `pbwt` tool provides a high-performance environment for the Positional Burrows-Wheeler Transform, a data structure specifically designed for aligned haplotype data. It is the preferred choice for geneticists needing to compress massive variation datasets while maintaining the ability to perform fast, linear-time matching queries. This skill enables the management of haplotype data, calculation of site frequency spectra, and advanced fine-scale local ancestry inference using the "painting" algorithms.

## Core CLI Patterns

### Data Import and Conversion
The most common entry point is converting standard genetic formats into the optimized `.pbwt` format.

*   **From VCF (Genotypes only):**
    `pbwt -readVcfGT data.vcf -writeAll data`
    *Note: `-writeAll` creates `.pbwt`, `.sites`, and `.samples` files.*
*   **From MACS Simulation:**
    `pbwt -readMacs simulation.macs -write out.pbwt -writeSites out.sites`
*   **Handling Large Files:**
    Always use the `-checkpoint` flag during long conversions to save progress every $N$ sites.
    `pbwt -checkpoint 10000 -readVcfGT large.vcf -writeAll large_data`

### Data Manipulation and Inspection
*   **Loading Datasets:**
    Use `-readAll` to automatically load the `.pbwt` file and its associated metadata (sites/samples).
    `pbwt -readAll data_prefix [commands]`
*   **Subsampling:**
    Extract a subset of haplotypes (e.g., start at index 0, take 1000).
    `pbwt -read data.pbwt -subsample 0 1000 -write subset.pbwt`
*   **Exporting Haplotypes:**
    `pbwt -read data.pbwt -haps data.haps`

### Matching and Analysis
*   **Maximal Matches Within a Dataset:**
    Find all maximal matches for each sequence against all others in the same file.
    `pbwt -read data.pbwt -maxWithin > matches.max`
*   **Query Matching:**
    Find maximal matches for sequences in a query file against a reference file.
    `pbwt -read reference.pbwt -matchDynamic query.pbwt > results.max`
*   **Site Frequency Spectrum (SFS):**
    `pbwt -read data.pbwt -sfs > data.sfs`

### Local Ancestry Inference (Painting)
For fine-scale ancestry or Haplotype Component (HC) extraction:
*   **Standard Painting:**
    `pbwt -read data.pbwt -paint [ploidy] > output.paint`
*   **Sparse Painting:**
    Used for large-scale inference as described in Yang et al. (2025).
    `pbwt -read data.pbwt -paintSparse > output.sparse`

## Expert Tips

*   **Memory Efficiency:** PBWT compression is significantly better than generic compression for large numbers of haplotypes. Search algorithms are linear in the query size and independent of the reference size.
*   **File Suffixes:** When using `-readAll` or `-writeAll`, the tool expects or creates files with `.pbwt`, `.sites`, and `.samples` extensions. Ensure these stay together in the working directory.
*   **Scaling:** The implementation is optimized for up to 1,000,000 haplotypes. For datasets of this scale, always prioritize `-paintSparse` over standard `-paint`.

## Reference documentation

- [Implementation of Positional Burrows-Wheeler Transform for genetic data](./references/github_com_richarddurbin_pbwt.md)