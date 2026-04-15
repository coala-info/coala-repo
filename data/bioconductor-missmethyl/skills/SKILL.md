---
name: bioconductor-missmethyl
description: This tool provides specialized functions for analyzing Illumina HumanMethylation450 and MethylationEPIC beadchip data. Use when user asks to perform SWAN normalization, remove unwanted variation using RUVm, conduct differential variability analysis, or run gene set enrichment analysis that accounts for probe number bias.
homepage: https://bioconductor.org/packages/release/bioc/html/missMethyl.html
---

# bioconductor-missmethyl

name: bioconductor-missmethyl
description: Analysis of Illumina HumanMethylation450 and MethylationEPIC beadchip data. Use this skill for SWAN normalization, differential methylation analysis using RUVm to remove unwanted variation, differential variability analysis (DiffVar), and gene set enrichment analysis (GSEA) that accounts for probe number and multi-gene bias.

## Overview
The `missMethyl` package provides specialized tools for analyzing Illumina methylation arrays (450k, EPIC, and EPIC v2.0). It addresses technical challenges unique to these platforms, such as the bias between Infinium I and II probe designs and the inherent bias in gene set testing caused by varying numbers of probes per gene.

## Core Workflows

### 1. Normalization with SWAN
Subset-quantile within array normalization (SWAN) reduces technical variability between Infinium I and II assays.
```R
library(missMethyl)
library(minfi)

# Assuming rgSet is an RGChannelSet from minfi
mSet <- preprocessRaw(rgSet)
set.seed(10) # SWAN uses random sampling
mSetSw <- SWAN(mSet, verbose=TRUE)
```

### 2. Differential Methylation with RUVm
RUVm (Removing Unwanted Variation for methylation) uses negative control probes to estimate and remove technical noise/batch effects.

**Stage 1: Empirical Control Probe (ECP) Identification**
```R
# Extract Illumina Negative Controls (INCs)
INCs <- getINCs(rgSet)
Mc <- rbind(Mval, INCs)
ctl1 <- rownames(Mc) %in% rownames(INCs)

# Initial fit to find non-significant probes
rfit1 <- RUVfit(Y = Mc, X = group_factor, ctl = ctl1)
rfit2 <- RUVadj(Y = Mc, fit = rfit1)
top1 <- topRUV(rfit2, num=Inf)

# Define ECPs (e.g., p > 0.5)
ctl2 <- rownames(Mval) %in% rownames(top1[top1$p.BH_X1.1 > 0.5,])
```

**Stage 2: Final Adjustment**
```R
rfit3 <- RUVfit(Y = Mval, X = group_factor, ctl = ctl2)
rfit4 <- RUVadj(Y = Mval, fit = rfit3)
results <- topRUV(rfit4)
```

### 3. Differential Variability (DiffVar)
Tests for differences in variance between groups rather than means.
```R
# coef should include intercept and group of interest
fitvar <- varFit(Mval, design = design, coef = c(1, 4))
topDV <- topVar(fitvar, coef = 4)
```
*Note: For RNA-Seq data, `varFit` accepts a `DGEList` and applies a voom transformation automatically.*

### 4. Gene Set Enrichment Analysis
`gometh` and `goregion` account for "probe number bias" (genes with more probes are more likely to be flagged) and "multi-gene bias".

**CpG Level (GO/KEGG):**
```R
# sig.cpg: vector of significant CpG IDs
# all.cpg: background vector of all tested CpGs
gst <- gometh(sig.cpg = sigCpGs, all.cpg = allCpGs, collection = "GO", plot.bias = TRUE)
topGSA(gst, n = 10)
```

**Region Level (DMRs):**
```R
# results.ranges: GRanges object from DMRcate or similar
gst.region <- goregion(results.ranges, all.cpg = allCpGs, collection = "KEGG")
```

## EPIC v2.0 Specifics
When using the MethylationEPIC v2.0 array:
1. Manually set annotation: `annotation(rgSet) <- c(array = "IlluminaHumanMethylationEPICv2", annotation = "20a1.hg38")`.
2. Filter replicate probes (using `DMRcate`) and non-cg probes (`grepl("^cg", rownames(Mval))`) before analysis.

## Tips
- **M-values vs. Beta-values**: Use M-values for statistical testing (limma, RUVm, DiffVar) and Beta-values for visualization and calculating Delta-Beta.
- **Visualizing RUVm**: Use `getAdj(Mval, rfit)` to get adjusted values for MDS plots to verify batch effect removal. Do not use these adjusted values for downstream statistical testing.
- **Genomic Features**: In `gometh`, use the `genomic.features` argument (e.g., `c("TSS200", "TSS1500")`) to restrict GSEA to specific gene regions like promoters.

## Reference documentation
- [missMethyl: Analysing Illumina HumanMethylation BeadChip Data](./references/missMethyl.md)