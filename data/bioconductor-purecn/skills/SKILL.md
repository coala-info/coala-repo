---
name: bioconductor-purecn
description: PureCN performs purity and ploidy aware copy number calling and SNV classification for cancer samples using targeted sequencing data. Use when user asks to estimate tumor purity, infer integer copy number, classify variants as germline or somatic, and normalize coverage against a pool of normals.
homepage: https://bioconductor.org/packages/release/bioc/html/PureCN.html
---


# bioconductor-purecn

name: bioconductor-purecn
description: Purity and ploidy aware copy number calling and SNV classification for cancer samples. Use this skill when analyzing targeted sequencing data (hybrid capture) to estimate tumor purity, infer integer copy number, and classify variants as germline vs. somatic or clonal vs. sub-clonal.

# bioconductor-purecn

## Overview

PureCN is a specialized R package for copy number calling and variant classification in cancer samples, particularly optimized for targeted sequencing without matched normals (though matched normals are supported). It jointly utilizes target-level coverage data and allelic fractions of SNVs to provide a purity/ploidy-aware model of the tumor genome.

## Core Workflow

### 1. Pre-processing Intervals
Before analysis, optimize the capture kit's target intervals (BED file). This step splits large targets and annotates them with GC-content and mappability.

```r
library(PureCN)
reference.file <- "path/to/reference.fa"
bed.file <- "path/to/targets.bed"
mappability.file <- "path/to/mappability.bigWig"

intervals <- import(bed.file)
preprocessIntervals(intervals, reference.file, 
                    mappability = mappability.file, 
                    output.file = "targets_gc.txt")
```

### 2. Coverage Calculation and Normalization
Calculate coverage from BAM files and normalize against a pool of normals (PON) to remove assay-specific biases.

```r
# Calculate coverage for a single BAM
calculateBamCoverageByInterval(bam.file = "tumor.bam", 
                               interval.file = "targets_gc.txt", 
                               output.file = "tumor_coverage.txt")

# Create a Normal Database (PON)
normal.coverage.files <- c("norm1_cov.txt", "norm2_cov.txt")
normalDB <- createNormalDatabase(normal.coverage.files)
saveRDS(normalDB, file = "normalDB.rds")
```

### 3. Mapping Bias Estimation
Use a VCF containing variants from the normal samples to learn position-specific mapping biases.

```r
bias <- calculateMappingBiasVcf("normal_panel.vcf.gz", genome = "hg19")
saveRDS(bias, "mapping_bias.rds")
```

### 4. Main Analysis Run
The `runAbsoluteCN` function is the primary entry point. It performs the joint likelihood estimation of purity, ploidy, and copy number.

```r
ret <- runAbsoluteCN(tumor.coverage.file = "tumor_coverage.txt",
                     vcf.file = "variants.vcf.gz",
                     genome = "hg19",
                     sampleid = "Sample1",
                     interval.file = "targets_gc.txt",
                     normalDB = normalDB,
                     args.setMappingBiasVcf = list(mapping.bias.file = "mapping_bias.rds"),
                     post.optimize = TRUE)
```

## Interpreting Results

### Visualizing Solutions
PureCN generates multiple candidate solutions. The first one is the maximum likelihood solution.

```r
# Plot the overview of local optima
plotAbs(ret, type = "overview")

# Plot the copy number fit (histogram and BAF) for the top solution
plotAbs(ret, 1, type = "hist")
plotAbs(ret, 1, type = "BAF")
```

### Extracting Data
*   **Somatic Status:** Use `predictSomatic(ret)` to get posterior probabilities for somatic vs. germline status and cellular fraction.
*   **Gene-level Calls:** Use `callAlterations(ret)` to identify amplifications and deletions.
*   **LOH:** Use `callLOH(ret)` to find genomic regions with loss of heterozygosity.

## Best Practices

*   **Pool of Normals:** Always use a PON for coverage normalization, even if a matched normal is available. A PON of 10-50 samples is ideal.
*   **Off-target Reads:** For targeted panels, including off-target coverage can significantly improve segmentation, especially in "quiet" genomes.
*   **Curation:** Always manually curate the results using `createCurationFile(file.rds)`. Check if the log-ratio peaks align with integer copy number states in the histogram.
*   **Low Purity:** For samples with <10% purity (e.g., cfDNA), use `callAmplificationsInLowPurity` which employs a z-score approach.

## Reference documentation

- [PureCN: Copy number calling and SNV classification](./references/PureCN.md)
- [PureCN Best Practices](./references/Quick.md)