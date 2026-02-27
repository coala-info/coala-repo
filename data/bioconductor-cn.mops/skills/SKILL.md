---
name: bioconductor-cn.mops
description: bioconductor-cn.mops detects copy number variations (CNVs) from next-generation sequencing data by modeling read depths across multiple samples simultaneously using a mixture of Poissons. Use when user asks to detect CNVs in WGS or exome data, calculate integer copy numbers, or identify genomic gains and losses across multiple samples.
homepage: https://bioconductor.org/packages/release/bioc/html/cn.mops.html
---


# bioconductor-cn.mops

## Overview

The `cn.mops` package (Mixture of Poissons) is a robust tool for CNV detection that models the depths of coverage across multiple samples simultaneously. Unlike methods that normalize along a single chromosome, `cn.mops` builds a local model at each genomic position across samples. This approach effectively handles read count biases and provides integer copy number calls with a low False Discovery Rate (FDR). It is applicable to Whole Genome Sequencing (WGS), Targeted/Exome Sequencing (ES), and haploid genomes.

## Core Workflow

### 1. Data Input and Preprocessing

`cn.mops` accepts BAM files, `GRanges` objects, or numeric read count matrices.

**From BAM files (WGS):**
```R
library(cn.mops)
bam_files <- list.files(pattern=".bam$")
# WL is window length; default is 25000. Adjust based on coverage.
bamDataRanges <- getReadCountsFromBAM(bam_files, WL=25000)
```

**From BAM files (Exome/Targeted):**
For exome data, you must provide the target regions (baits/exons).
```R
segments <- read.table("targets.bed", sep="\t")
gr <- GRanges(segments[,1], IRanges(segments[,2], segments[,3]))
# Count reads specifically in target regions
X <- getSegmentReadCountsFromBAM(bam_files, GR=gr)
```

### 2. Running the CNV Detection

Choose the function based on your study design:

*   **Standard (WGS, Multi-sample):** `res <- cn.mops(bamDataRanges)`
*   **Exome Sequencing:** `res <- exomecn.mops(X)`
*   **Haploid Genomes:** `res <- haplocn.mops(X)`
*   **Case-Control / Tumor-Normal:** 
    ```R
    res <- referencecn.mops(cases=X[,1], controls=rowMeans(X))
    ```

### 3. Post-processing and Integer Copy Numbers

After running the initial model, calculate the actual integer copy numbers:
```R
res <- calcIntegerCopyNumbers(res)
```

### 4. Interpreting and Exporting Results

The result object contains detected CNVs and merged CNV regions.

```R
# Extract individual CNV calls
individual_cnvs <- cnvs(res)

# Extract merged CNV regions (where multiple samples overlap)
cnv_regions <- cnvr(res)

# Export to CSV
write.csv(as.data.frame(individual_cnvs), file="detected_cnvs.csv")
```

## Visualization

`cn.mops` provides built-in plotting functions to inspect calls:

*   **CNV Region Plot:** `plot(res, which=1)` (Shows read counts and calls for a specific region).
*   **Chromosome Segment Plot:** `segplot(res, sampleIdx=1)` (Visualizes log ratios and segments across a chromosome).

## Advanced Adjustments

*   **Sensitivity/Specificity:** Adjust `upperThreshold` (default ~0.6) for gains and `lowerThreshold` (default ~ -0.9) for losses.
*   **Prior Impact:** The `priorImpact` parameter (default 1) controls the strength of the "copy number 2" assumption. Increase this to reduce false positives in noisy data.
*   **Ploidy/Heterosomes:** For X/Y chromosomes, use `normalizeChromosomes` with the `ploidy` parameter to account for gender differences before running `cn.mops`.
    ```R
    # Example: 10 males (ploidy 1), 30 females (ploidy 2)
    X_norm <- normalizeChromosomes(X, ploidy=c(rep(1,10), rep(2,30)))
    res <- cn.mops(X_norm, norm=FALSE)
    ```

## Reference documentation

- [cn.mops Manual](./references/cn.mops.md)