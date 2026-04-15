---
name: bioconductor-epigenomix
description: Bioconductor-epigenomix integrates gene transcription and histone modification data to identify genes with significant regulatory differences across conditions. Use when user asks to map ChIP-seq reads to promoters, normalize expression and epigenetic data, calculate integration scores, or fit mixture models to classify gene regulatory patterns.
homepage: https://bioconductor.org/packages/release/bioc/html/epigenomix.html
---

# bioconductor-epigenomix

name: bioconductor-epigenomix
description: Integrative analysis of gene transcription (RNA-seq/microarray) and histone modification (ChIP-seq) data. Use this skill to: (1) Preprocess ChIP-seq data and map it to gene promoters, (2) Normalize count data, (3) Calculate integration scores between transcription and epigenetic data, and (4) Fit Bayesian or ML mixture models to identify genes with significant differences in both data types.

# bioconductor-epigenomix

## Overview
The `epigenomix` package facilitates the integration of epigenetic data (specifically histone modification ChIP-seq) with gene transcription data. It provides a workflow to map ChIP-seq reads to promoter regions, calculate a standardized correlation score between the two data types, and use Bayesian or Maximum Likelihood mixture models to classify genes based on their regulatory patterns.

## Data Preprocessing and Mapping
Before integration, ChIP-seq reads must be summarized into genomic regions corresponding to transcription data (e.g., promoters).

1. **Map Probes to Promoters**: Use `matchProbeToPromoter` to define genomic windows around Transcription Start Sites (TSS).
   ```r
   # probeToTrans: list mapping probes to transcript IDs
   # transToTSS: data.frame with TSS coordinates
   promoters <- matchProbeToPromoter(probeToTrans, transToTSS, promWidth=4000, mode="union")
   ```

2. **Summarize Reads**: Count reads within the defined regions to create a `ChIPseqSet`.
   ```r
   # reads: GRangesList of aligned reads
   chipSet <- summarizeReads(reads, promoters, summarize="add")
   ```

3. **Normalization**: Normalize `ChIPseqSet` or `ExpressionSet` objects.
   ```r
   # Methods: "tmm", "quantile", "scale", "scaleMedianRegion"
   normChipSet <- normalize(chipSet, method="tmm")
   ```

4. **Quality Control**: Use `calculateCrossCorrelation` to estimate fragment size and `getAlignmentQuality` for BAM statistics.

## Data Integration
The `integrateData` function calculates a score ($Z$) representing the product of standardized differences between two conditions for both data types.

```r
# expr: ExpressionSet; chipseq: ChIPseqSet
# factor: column name in phenoData; reference: the control level
intData <- integrateData(expr, chipSet, factor="condition", reference="WT")
# Result is a matrix where the 5th column is the integration score
z_scores <- intData[, 5]
```

## Mixture Modeling
Fit mixture models to the integration scores to identify components (e.g., genes with no change, positive correlation, or negative correlation).

### Bayesian Mixture Model (Recommended)
Uses MCMC to estimate posterior distributions. Supports normal, exponential, and gamma components.
```r
# Example: 2 null normal components, 1 negative gamma, 1 positive gamma
mmBayes <- bayesMixModel(z_scores, normNull=1:2, gamNeg=3, gamPos=4,
                         itb=1000, nmc=5000, thin=10)

# Check convergence (Crucial)
plotChains(mmBayes, chain="pi")
plotComponents(mmBayes)
```

### Maximum Likelihood Model
Uses the EM algorithm for faster but less flexible fitting (Normal and Exponential only).
```r
mmML <- mlMixModel(z_scores, normNull=1:2, expNeg=3, expPos=4)
```

## Results and Classification
Extract classifications to identify genes belonging to specific mixture components.

```r
# List available methods (e.g., "maxDens", "median", "mode")
listClassificationMethods(mmBayes)

# Get classification results
res <- as.data.frame(mmBayes)
# Visualize assignments
plotClassification(mmBayes)
```

## Reference documentation
- [epigenomix Reference Manual](./references/reference_manual.md)