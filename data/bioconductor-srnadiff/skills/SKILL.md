---
name: bioconductor-srnadiff
description: This tool identifies and quantifies differentially expressed regions in small RNA-seq data using both annotation-based and de novo discovery methods. Use when user asks to detect novel differentially expressed genomic regions from BAM files, combine HMM and IR segmentation strategies, or visualize sRNA expression differences between conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/srnadiff.html
---

# bioconductor-srnadiff

name: bioconductor-srnadiff
description: Comprehensive analysis of small RNA-seq data to identify differentially expressed regions (DERs) without relying solely on existing annotations. Use when Claude needs to: (1) Detect novel differentially expressed genomic regions from BAM files, (2) Combine annotation-based and de novo discovery pipelines (HMM, IR, Naive), (3) Quantify and visualize sRNA expression differences between conditions.

# bioconductor-srnadiff

## Overview

The `srnadiff` package implements an "identify-then-annotate" methodology for sRNA-seq data. Unlike standard pipelines that only quantify known features (like miRNAs), `srnadiff` identifies contiguous genomic regions showing differential expression signal at base-resolution and then quantifies them. It combines four strategies:
1.  **Annotation**: Uses user-provided genomic features.
2.  **HMM**: A Hidden Markov Model that segments the genome based on nucleotide-level p-values.
3.  **IR (Irreducibility)**: Uses log-ratio levels and an irreducibility property algorithm.
4.  **Naive**: Identifies regions based on a fixed log-ratio threshold.

## Typical Workflow

### 1. Data Preparation
Create a `srnadiffExp` object. You need coordinate-sorted BAM files and a sample information data frame.

```r
library(srnadiff)

# sampleInfo must have: FileName, SampleName, Condition
sampleInfo <- data.frame(
    FileName = c("ctrl1.bam", "ctrl2.bam", "treat1.bam", "treat2.bam"),
    SampleName = c("C1", "C2", "T1", "T2"),
    Condition = c("control", "control", "treated", "treated")
)

# Set the reference condition (control) as the first level
sampleInfo$Condition <- factor(sampleInfo$Condition, levels = c("control", "treated"))

bamFiles <- file.path("/path/to/bams", sampleInfo$FileName)
srnaExp <- srnadiffExp(bamFiles, sampleInfo)
```

### 2. Adding Annotation (Optional)
You can load existing annotations (GTF/GFF) to include known features in the differential analysis.

```r
# Extract specific features, e.g., miRNAs from a GTF
annotReg <- readAnnotation("path/to/annotation.gtf", feature="gene", source="miRNA")
annotReg(srnaExp) <- annotReg
```

### 3. Running the Analysis
The `srnadiff` function performs the segmentation, quantification, and statistical testing.

```r
# Run with default settings (all methods, DESeq2)
srnaExp <- srnadiff(srnaExp)

# Or specify methods and differential testing engine
srnaExp <- srnadiff(srnaExp, 
                    segMethod = c("hmm", "IR"), 
                    diffMethod = "edgeR")
```

### 4. Extracting and Visualizing Results
Extract the Differentially Expressed Regions (DERs) as a `GRanges` object.

```r
# Extract regions with an adjusted p-value threshold
res <- regions(srnaExp, pvalue = 0.05)

# View results
mcols(res)

# Visualize a specific region
plotRegions(srnaExp, res[1])
```

## Advanced Configuration

### Tuning Parameters
Parameters are managed via a named list. Common parameters include:
*   `minDepth`: Minimum depth in the most expressed condition.
*   `minSize` / `maxSize`: Constraints on region length.
*   `cutoff`: Log-ratio threshold for the Naive method.
*   `noDiffToDiff` / `emissionThreshold`: HMM specific tuning.

```r
parameters(srnaExp) <- list(minDepth = 5, minSize = 18, maxSize = 200)
```

### Performance
For large datasets, use multiple cores to speed up quantification:

```r
srnaExp <- setNThreads(srnaExp, nThreads = 4)
```

## Reference documentation

- [Finding differentially expressed unannotated genomic regions from RNA-seq data with srnadiff](./references/srnadiff.md)