---
name: bioconductor-mbased
description: This tool detects allele-specific gene expression from RNA-seq count data using the MBASED algorithm. Use when user asks to perform one-sample allele-specific expression detection, conduct two-sample differential allelic analysis, or aggregate SNV information for pseudo-phasing.
homepage: https://bioconductor.org/packages/release/bioc/html/MBASED.html
---

# bioconductor-mbased

name: bioconductor-mbased
description: Detect allele-specific gene expression (ASE) from RNA-seq count data using the MBASED algorithm. Use this skill to perform one-sample ASE detection (within-sample deviation from 50/50) or two-sample differential ASE analysis (comparing allelic ratios between samples). It is particularly useful when phased haplotypes are unknown, as it provides pseudo-phasing and simulation-based p-values.

# bioconductor-mbased

## Overview

The `MBASED` (Meta-analysis-Based Allele-Specific Expression Detection) package identifies allele-specific expression by aggregating information across multiple heterozygous SNVs within a single unit (e.g., a gene). It supports both phased and unphased data. For unphased data, it employs a "pseudo-phasing" strategy and uses simulations to maintain accurate p-values.

## Data Preparation

MBASED requires input as a `RangedSummarizedExperiment` object.

1.  **Define SNVs**: Create a `GRanges` object where each row is an SNV. It must include an `aseID` column (e.g., gene name) to group SNVs.
2.  **Counts**: Provide two matrices of counts: `lociAllele1Counts` and `lociAllele2Counts`.
3.  **Construct Object**:
    ```R
    library(MBASED)
    library(SummarizedExperiment)

    mySNVs <- GRanges(
        seqnames = c('chr1', 'chr2', 'chr2'),
        ranges = IRanges(start = c(100, 1000, 1100), width = 1),
        aseID = c('gene1', 'gene2', 'gene2'),
        allele1 = c('G', 'A', 'C'),
        allele2 = c('T', 'C', 'T')
    )

    mySample <- SummarizedExperiment(
        assays = list(
            lociAllele1Counts = matrix(c(25, 10, 22), ncol = 1),
            lociAllele2Counts = matrix(c(20, 16, 15), ncol = 1)
        ),
        rowRanges = mySNVs
    )
    ```

## 1-Sample Analysis

Used to detect if a gene shows significant deviation from 50/50 allelic expression.

```R
results <- runMBASED(
    ASESummarizedExperiment = mySample,
    isPhased = FALSE, # Set TRUE if allele1/allele2 represent known haplotypes
    numSim = 10^6,    # Recommended for unphased data
    BPPARAM = SerialParam()
)

# Extract results
assays(results)$majorAlleleFrequency
assays(results)$pValueASE
```

## 2-Sample Analysis

Used to detect differences in allelic ratios between two samples (e.g., Tumor vs. Normal). The analysis is **not symmetric**; it detects ASE specific to Sample 1 (the first column).

```R
# Input must have 2 columns in assays
results_2s <- runMBASED(
    ASESummarizedExperiment = myTumorNormalExample,
    isPhased = FALSE,
    numSim = 10^6
)

# Extract results
assays(results_2s)$majorAlleleFrequencyDifference
assays(results_2s)$pValueASE
```

## Advanced Adjustments

### Pre-existing Allelic Bias
If your data has a known bias (e.g., reference allele preference), provide the `lociAllele1CountsNoASEProbs` assay. This represents the probability of observing allele 1 under the null hypothesis (no ASE).

```R
# Example: 60% reference bias
assays(mySample)$lociAllele1CountsNoASEProbs <- matrix(rep(0.6, 3), ncol = 1)
```

### Overdispersion
To account for extra-binomial variation, provide the `lociCountsDispersions` assay.

```R
# Example: dispersion of 0.02
assays(mySample)$lociCountsDispersions <- matrix(rep(0.02, 3), ncol = 1)
```

## Key Considerations

*   **Simulations**: For unphased data (`isPhased = FALSE`), `numSim` should be at least $10^6$ to get reliable p-values. If `numSim = 0`, MBASED uses a nominal p-value that often underestimates the true p-value.
*   **Heterogeneity**: The `pValueHeterogeneity` result indicates if SNVs within a gene show inconsistent ASE, which might suggest isoform-specific ASE.
*   **Filtering**: Only use heterozygous SNVs. Homozygous SNVs will incorrectly appear as 100% ASE. It is recommended to require at least 10 reads per SNV.
*   **Parallelization**: Use `BPPARAM = MulticoreParam()` to speed up calculations across genes.

## Reference documentation

- [MBASED Overview](./references/MBASED.md)