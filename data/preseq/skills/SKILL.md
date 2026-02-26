---
name: preseq
description: Preseq predicts the complexity and genomic coverage of high-throughput sequencing libraries to estimate the yield of unique reads at higher sequencing depths. Use when user asks to estimate library complexity, predict future sequencing yield, calculate genomic coverage, or determine the total number of distinct molecules in a library.
homepage: https://github.com/smithlabcode/preseq
---


# preseq

## Overview

The `preseq` package provides a suite of tools for predicting the complexity and genomic coverage of high-throughput sequencing libraries. By analyzing a subset of sequencing data, `preseq` can extrapolate the expected yield of unique (distinct) reads at much higher sequencing depths. This allows researchers to identify "shallow" libraries that have reached a point of diminishing returns due to high duplication rates, ensuring that sequencing resources are allocated to the most complex and informative samples.

## Core Commands and Usage

### 1. Predicting Future Yield (lc_extrap)
Use `lc_extrap` to estimate the number of distinct reads you would obtain if you sequenced the library further.

*   **Basic usage (Mapped Reads):**
    `preseq lc_extrap -o yield_estimates.txt input.mr`
*   **BAM input:**
    `preseq lc_extrap -B -o yield_estimates.txt input.bam`
*   **Counts Histogram input:**
    `preseq lc_extrap -H -o yield_estimates.txt counts_hist.txt`

**Output Interpretation:** The output contains `TOTAL_READS` (the simulated sequencing depth) and `EXPECTED_DISTINCT` (the predicted number of unique reads at that depth), along with confidence intervals.

### 2. Complexity Curves (c_curve)
Use `c_curve` to observe the complexity of the library based on the data already generated. This is useful for assessing the current state of the library.

*   **Command:**
    `preseq c_curve -B -o complexity_curve.txt input.bam`

### 3. Estimating Population Size (pop_size & bound_pop)
These tools estimate the total number of distinct molecules in the original library.

*   **pop_size:** Uses a continued fraction approximation for a more accurate estimate of the total population.
    `preseq pop_size -H -o pop_estimate.txt counts_hist.txt`
*   **bound_pop:** Provides a reliable lower-bound estimate for species richness.
    `preseq bound_pop -B -o richness_bound.txt input.bam`

### 4. Predicting Genomic Coverage (gc_extrap)
Use `gc_extrap` to predict the fraction of the genome covered at least once as sequencing depth increases.

*   **Command:**
    `preseq gc_extrap -B -o coverage_predictions.txt input.bam`

## Input Format Specifications

*   **Mapped Reads (.mr):** A text format containing mapped locations.
*   **BAM/BED:** Standard alignment formats. BAM files must be sorted by coordinate.
*   **Counts Histogram (-H):** A two-column text file (no header).
    *   Column 1: The count (1, 2, 3...).
    *   Column 2: The number of unique species/reads appearing exactly that many times.
    *   *Note: Do not include a count for "0".*
*   **Raw Counts:** A single-column file where each line is the count for a specific species. `preseq` converts this to a histogram internally.

## Expert Tips and Best Practices

*   **Sorting Requirements:** When using BED files, ensure they are sorted by chromosome, start, end, and strand. BAM files should be sorted using `samtools sort`.
*   **HTSLib Support:** If working with BAM files, ensure the version of `preseq` was compiled with HTSlib support (standard in Bioconda versions).
*   **Extrapolation Limits:** While `lc_extrap` is powerful, predictions become less reliable as the extrapolation distance increases far beyond the original sample size. Always check the confidence intervals provided in the output.
*   **Library Screening:** Run `c_curve` or `lc_extrap` on a small "pilot" run (e.g., 1-5 million reads) to decide whether to proceed with full-scale deep sequencing.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_smithlabcode_preseq.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_preseq_overview.md)