---
name: bioconductor-methylsig
description: "bioconductor-methylsig provides a beta-binomial framework for testing differential methylation in WGBS and RRBS experiments. Use when user asks to filter methylation loci by coverage or location, aggregate CpG data into tiles, and perform differential methylation testing for group comparisons or complex experimental designs."
homepage: https://bioconductor.org/packages/release/bioc/html/methylSig.html
---


# bioconductor-methylsig

## Overview

The `methylSig` package provides a robust framework for testing differential methylation in whole-genome bisulfite sequencing (WGBS) and reduced representation bisulfite sequencing (RRBS) experiments. It utilizes a beta-binomial model to account for both biological variation among replicates and the sampling variation inherent in bisulfite sequencing. The package is designed to work seamlessly with `BSseq` objects from the `bsseq` package.

## Typical Workflow

### 1. Reading Data
Data should be read using `bsseq::read.bismark()`. This function supports Bismark coverage files, cytosine reports, and MethylDackel bedGraphs.

```r
library(methylSig)
library(bsseq)

files = c('sample1.cov', 'sample2.cov')
pData = data.frame(Type = c('cancer', 'normal'), row.names = c('s1', 's2'))

bs = bsseq::read.bismark(
    files = files,
    colData = pData,
    rmZeroCov = FALSE,
    strandCollapse = FALSE
)
```

### 2. Filtering Loci
Filtering is essential to remove low-confidence sites and potential artifacts.

*   **By Coverage:** Remove sites with too few reads (low power) or too many reads (potential PCR duplicates).
    ```r
    bs = filter_loci_by_coverage(bs, min_count = 5, max_count = 500)
    ```
*   **By Location:** Remove known SNPs (e.g., C-to-T or G-to-A) that confound bisulfite conversion.
    ```r
    remove_gr = GenomicRanges::GRanges(seqnames = 'chr21', ranges = IRanges::IRanges(9411552, 9411552))
    bs = filter_loci_by_location(bs = bs, gr = remove_gr)
    ```
*   **By Group Coverage:** Ensure a minimum number of samples per group have sufficient coverage before testing.
    ```r
    bs = filter_loci_by_group_coverage(bs, group_column = 'Type', c('cancer' = 2, 'normal' = 2))
    ```

### 3. Aggregating Data (Tiling)
To increase power or identify DMRs, aggregate CpG-level data into windows or specific regions.

*   **Windows:** `tile_by_windows(bs, win_size = 500)`
*   **Regions:** `tile_by_regions(bs, gr = promoters_gr)`

### 4. Differential Methylation Testing
`methylSig` provides three primary testing approaches:

#### MethylSig Test (Beta-Binomial)
Best for group-versus-group comparisons without complex covariates.
```r
diff_gr = diff_methylsig(
    bs = bs,
    group_column = 'Type',
    comparison_groups = c('case' = 'cancer', 'control' = 'normal'),
    disp_groups = c('case' = TRUE, 'control' = TRUE),
    t_approx = TRUE
)
```

#### DSS Test (General Linear Models)
Best for complex designs (e.g., paired samples, continuous covariates). This is a two-step process: fit then test.
```r
# 1. Fit the model
diff_fit = diff_dss_fit(bs = bs, design = pData(bs), formula = ~ Type + Pair)

# 2. Define contrast and test
# Example: testing the second coefficient in the model matrix
contrast = matrix(c(0, 1, 0), ncol = 1)
diff_gr = diff_dss_test(
    bs = bs,
    diff_fit = diff_fit,
    contrast = contrast,
    methylation_group_column = 'Type',
    methylation_groups = c('case' = 'cancer', 'control' = 'normal')
)
```

#### Binomial Test
A basic test that does not account for biological variance (primarily for benchmarking).
```r
diff_gr = diff_binomial(bs = bs, group_column = 'Type', comparison_groups = c('case' = 'cancer', 'control' = 'normal'))
```

## Tips for Success
*   **Object Types:** Always ensure your input is a `BSseq` object. Use `bsseq::getCoverage(bs, type = 'Cov')` and `bsseq::getCoverage(bs, type = 'M')` to inspect raw counts.
*   **Dispersion:** In `diff_methylsig`, setting `disp_groups` allows for group-specific variance estimation, which is more flexible than a pooled estimate.
*   **Continuous Covariates:** When testing continuous variables with `diff_dss_test`, omit the `methylation_groups` parameter. The function will automatically group samples by the top/bottom 25th percentiles to calculate a representative methylation difference.
*   **Legacy Code:** If updating code from `methylSig` < 0.99.0, replace `methylSigReadData()` with `bsseq::read.bismark()` and `methylSigCalc()` with `diff_methylsig()`.

## Reference documentation
- [Updating methylSig code](./references/updating-methylSig-code.md)
- [Using methylSig](./references/using-methylSig.md)