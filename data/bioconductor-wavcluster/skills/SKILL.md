---
name: bioconductor-wavcluster
description: "The package provides an integrated pipeline for the analysis of PAR-CLIP data. PAR-CLIP-induced transitions are first discriminated from sequencing errors, SNPs and additional non-experimental sources by a non- parametric mixture model. The protein binding sites (clusters) are then resolved at high resolution and cluster statistics are estimated using a rigorous Bayesian framework. Post-processing of the results, data export for UCSC genome browser visualization and motif search analysis are provided. In addition, the package allows to integrate RNA-Seq data to estimate the False Discovery Rate of cluster detection. Key functions support parallel multicore computing. Note: while wavClusteR was designed for PAR-CLIP data analysis, it can be applied to the analysis of other NGS data obtained from experimental procedures that induce nucleotide substitutions (e.g. BisSeq)."
homepage: https://bioconductor.org/packages/release/bioc/html/wavClusteR.html
---

# bioconductor-wavcluster

## Overview

Use the Bioconductor R package **wavClusteR** for: The package provides an integrated pipeline for the analysis of PAR-CLIP data. PAR-CLIP-induced transitions are first discriminated from sequencing errors, SNPs and additional non-experimental sources by a non- parametric mixture model. The protein binding sites (clusters) are then resolved at high resolution and cluster statistics are estimated using a rigorous Bayesian framework. Post-processing of the results, data export for UCSC genome browser visualization and motif search analysis are provided. In addition, the package allows to integrate RNA-Seq data to estimate the False Discovery Rate of cluster detection. Key functions support parallel multicore computing. Note: while wavClusteR was designed for PAR-CLIP data analysis, it can be applied to the analysis of other NGS data obtained from experimental procedures that induce nucleotide substitutions (e.g. BisSeq).

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("wavClusteR")
```

## Reference documentation

See files in `references/` for vignettes and tutorials.