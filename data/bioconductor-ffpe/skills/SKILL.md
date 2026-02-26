---
name: bioconductor-ffpe
description: This tool provides quality control and visualization for gene expression data derived from Formalin-Fixed Paraffin-Embedded tissues. Use when user asks to identify low-quality samples using IQR or Spearman correlation metrics, perform feature-level quality control, or generate Concordance at the Top plots to assess reproducibility.
homepage: https://bioconductor.org/packages/release/bioc/html/ffpe.html
---


# bioconductor-ffpe

name: bioconductor-ffpe
description: Quality control and visualization for gene expression data derived from Formalin-Fixed Paraffin-Embedded (FFPE) tissues. Use this skill to identify low-quality samples using intrinsic (IQR) and comparative (Spearman correlation) metrics, perform feature-level quality control, and generate Concordance at the Top (CAT) plots to assess reproducibility.

# bioconductor-ffpe

## Overview

The `ffpe` package provides specialized tools for the quality control (QC) of gene expression data from FFPE tissues, which are often noisier and more prone to artifacts than fresh-frozen samples. It focuses on identifying outlier samples that lack internal consistency or similarity to the rest of the study and provides methods to visualize probe-level reproducibility.

## Typical Workflow

### 1. Initial Data Inspection
Use `sortedIqrPlot` to visualize the distribution of expression intensities across samples. This is a simplified boxplot showing the 25th to 75th percentiles, making it scalable to hundreds or thousands of samples.

```r
library(ffpe)
# Assuming lumibatch is a LumiBatch or ExpressionSet object
sortedIqrPlot(lumibatch, dolog2 = TRUE)
```

### 2. Sample Quality Control
The `sampleQC` function identifies low-quality samples by comparing an intrinsic measure (default is Interquartile Range, IQR) against a comparative measure (default is Spearman correlation to a "pseudochip" or study median).

```r
# Identify outliers
QC <- sampleQC(lumibatch, 
               xaxis = "index", 
               cor.to = "pseudochip", 
               QCmeasure = "IQR")

# Access logical vector of rejected samples
rejected_samples <- QC$rejectQC

# Filter the dataset
lumibatch.QC <- lumibatch[, !rejected_samples]
```

### 3. Feature Quality Control
FFPE data often contains probes with low signal-to-noise ratios. A common practice is to filter out probes with low variance, as they are less likely to be reproducible.

```r
# Calculate variance per probe
probe.var <- apply(exprs(lumibatch.QC), 1, var)

# Keep probes with variance above the median
lumibatch.filtered <- lumibatch.QC[probe.var > median(probe.var), ]
```

### 4. Assessing Reproducibility (CAT-plots)
Concordance at the Top (CAT) plots measure the agreement between two ranked lists of genes (e.g., from technical replicates or different batches).

```r
# pvals.rep1 and pvals.rep2 are named vectors of p-values from two different runs
cat_data <- CATplot(pvals.rep1, pvals.rep2, 
                    maxrank = 1000, 
                    xlab = "Size of top-ranked gene lists", 
                    ylab = "Concordance")

# Add a legend to distinguish actual vs chance concordance
legend("topleft", lty = 1:2, 
       legend = c("Actual concordance", "Concordance expected by chance"))
```

## Key Functions

- `sortedIqrPlot()`: Visualizes sample intensity distributions sorted by a quality metric.
- `sampleQC()`: Performs multivariate outlier detection for samples.
- `CATplot()`: Creates Concordance at the Top plots to evaluate the stability of differentially expressed gene lists.

## Tips for FFPE Data
- **Intrinsic Metrics**: While IQR is the default for `sampleQC`, you can use other metrics like `log10(RNA concentration)` if available.
- **Comparative Metrics**: The "pseudochip" (median of all probes across all samples) is the standard reference for correlation, but you can specify a specific gold-standard sample if one exists.
- **CAT-boxplot**: If technical replicates are unavailable, you can use the CAT-boxplot method (setting `make.plot = FALSE` in `CATplot` logic) by randomly splitting samples into two groups and repeating the ranking process.

## Reference documentation

- [ffpe](./references/ffpe.md)