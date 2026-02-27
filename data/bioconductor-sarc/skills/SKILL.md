---
name: bioconductor-sarc
description: SARC performs statistical ratification and confidence flagging of Copy Number Variations (CNVs) detected from NGS pipelines. Use when user asks to evaluate CNV calls, filter false positive variants, or perform statistical analysis of read depth coverage across genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/SARC.html
---


# bioconductor-sarc

name: bioconductor-sarc
description: Statistical Analysis of Regions with CNVs (SARC). Use this skill to flag the confidence of Copy Number Variations (CNVs) detected from NGS pipelines (WES/WGS). It provides downstream ratification using statistical tests (Mean, Quantiles, ANOVA) and visualization of coverage across genes and exons to distinguish true variants from false positives.

# bioconductor-sarc

## Overview

SARC is a downstream ratification tool for Copy Number Variation (CNV) analysis. It is not a detection tool; rather, it evaluates existing CNV calls by comparing normalized read depth coverage across a cohort. By using statistical distributions and ANOVA, it flags CNVs as high or low confidence, helping to filter out false positives common in WES and WGS pipelines.

## Data Requirements

SARC requires two primary inputs as data frames:

1.  **CNV File**: Contains detected CNVs. Required columns: `SAMPLE`, `CHROM`, `START`, `END`, `TYPE` (Deletion/Duplication), and `VALUE`.
2.  **Coverage (COV) File**: Normalized read depth. First four columns must be `ID`, `Chromosome`, `Start`, and `End`. Subsequent columns are sample names matching the CNV file.

**Note**: Coverage should be normalized by library size (e.g., Reads Per Million) before processing.

## Workflow

### 1. Initialization
Load the data into a `RaggedExperiment` object and prepare the regions.

```r
library(SARC)
library(RaggedExperiment)

# Initialize the SARC object
SARC_obj <- regionSet(cnv = my_cnv_df, cov = my_cov_df)

# Split coverage into CNV-specific regions
SARC_obj <- regionSplit(RE = SARC_obj, 
                        cnv = metadata(SARC_obj)[['CNVlist']][[1]], 
                        startlist = metadata(SARC_obj)[[2]], 
                        endlist = metadata(SARC_obj)[[3]])
```

### 2. Statistical Analysis
SARC uses a multi-step statistical approach to evaluate confidence.

```r
# Calculate mean coverage for regions
SARC_obj <- regionMean(RE = SARC_obj, cnv = my_cnv_df, splitcov = metadata(SARC_obj)[[4]])

# Calculate quantile distributions (flagging outliers)
SARC_obj <- regionQuantiles(RE = SARC_obj, 
                            cnv = metadata(SARC_obj)[['CNVlist']][[2]], 
                            meancov = metadata(SARC_obj)[[5]], 
                            q1 = 0.1, q2 = 0.9)

# Perform ANOVA to identify rare read depths relative to the cohort
SARC_obj <- prepAnova(RE = SARC_obj, 
                      start = metadata(SARC_obj)[[2]], 
                      end = metadata(SARC_obj)[[3]], 
                      cnv = metadata(SARC_obj)[['CNVlist']][[3]])

SARC_obj <- anovaOnCNV(RE = SARC_obj, 
                       cnv = metadata(SARC_obj)[['CNVlist']][[3]], 
                       anovacov = metadata(SARC_obj)[[8]])
```

### 3. Flagging Confidence
Finalize the analysis by assigning confidence flags.

```r
SARC_obj <- cnvConfidence(RE = SARC_obj, cnv = metadata(SARC_obj)[['CNVlist']][[4]])
# Results are stored in the latest CNVlist entry
final_results <- metadata(SARC_obj)[['CNVlist']][[5]]
```

## Visualization

SARC provides tools to visualize coverage across specific genes and exons, which is useful for clinical validation.

```r
# Requires genome-specific TxDb (e.g., hg38)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(Homo.sapiens)

# Prepare plotting objects
SARC_obj <- plotCovPrep(RE = SARC_obj, cnv = metadata(SARC_obj)[['CNVlist']][[4]], 
                        startlist = metadata(SARC_obj)[[2]], endlist = metadata(SARC_obj)[[3]])
SARC_obj <- regionGrangeMake(RE = SARC_obj, covprepped = metadata(SARC_obj)[[9]])
SARC_obj <- addExonsGenes(RE = SARC_obj, covgranges = metadata(SARC_obj)[[10]], 
                          txdb = TxDb.Hsapiens.UCSC.hg38.knownGene, txgene = txgene)
SARC_obj <- setupCNVplot(RE = SARC_obj, namedgranges = metadata(SARC_obj)[[11]], 
                         covprepped = metadata(SARC_obj)[[9]])

# Plot a specific CNV (e.g., the first one in the list)
plotCNV(cnv = metadata(SARC_obj)[['CNVlist']][[4]], 
        setup = metadata(SARC_obj)[[12]], 
        FilteredCNV = 1)
```

## Tips and Best Practices

*   **Cohort Size**: ANOVA and Quantile tests become more powerful as the number of samples in the coverage file increases.
*   **Metadata Navigation**: The `SARC` object (RaggedExperiment) stores successive versions of the CNV data frame in `metadata(SARC)[['CNVlist']]`. Always use the most recent index for the next function.
*   **Dunnet Test**: For cohorts smaller than 100 samples, consider using `phDunnetonCNV` for a more rigorous (though slower) comparison between the "suspected" sample and the rest of the cohort.
*   **Species Support**: While defaults often target human (hg38), you can swap `TxDb` and `Org` packages to support other species like Mouse (mm10).

## Reference documentation
- [Tutorial of the SARC R Package](./references/SARC_guide.Rmd)