---
name: bioconductor-manta
description: The manta package extends edgeR to support comparative metatranscriptomics by managing taxonomic meta-information alongside gene counts to control for compositional bias. Use when user asks to identify differential expression in environmental shotgun sequence data, assess taxonomic compositional bias, or generate RA plots with taxonomic overlays.
homepage: https://bioconductor.org/packages/3.5/bioc/html/manta.html
---

# bioconductor-manta

## Overview

The `manta` package extends `edgeR` to support comparative metatranscriptomics. It manages taxonomic meta-information alongside gene counts to identify and control for compositional bias—where shifts in species proportions might confound differential expression analysis. It is particularly useful for environmental shotgun sequence data where users need to subset transcript collections by taxa before performing statistical tests.

## Core Workflow

### 1. Object Initialization

The `manta` object is a derivative of `edgeR::DGEList`. You can instantiate it from various sources:

```R
library(manta)

# From raw counts and annotation tables
# a.merge.clmn links the counts to the annotation
obj <- counts2manta(cts, annotation=cts.annot, 
                    a.merge.clmn='query_seq', 
                    agg.clmn='what_def',
                    gene.clmns=c('what_def'),
                    meta.clmns=c('pathway', 'family', 'genus_sp'))

# From alignment data (e.g., BLAST tabular output)
obj <- align2manta(annot.df, cond.clmn='treatment', 
                   agg.clmn='pathway',
                   gene.clmns=c('what_def'),
                   meta.clmns=c('family', 'genus_sp'))
```

Other input functions include `seastar2manta()` for SEASTaR format and `pplacer2manta()` for phylogenetic placement directories.

### 2. Assessing Compositional Bias

Before DE analysis, check if specific taxa are biasing the community-level results.

```R
# Visual check: Look for outlier distributions in taxonomic subsets
compbiasPlot(obj, pair=c("control", "treatment"), meta.lev='genus_sp')

# Statistical check: F-test for significant differences in subset distributions
compbiasTest(obj, meta.lev='genus_sp')
```

If the test is significant (p < 0.05), subset the data to remove the "misinforming" species and re-run the test to ensure a homogenous response in the remaining subset.

### 3. Normalization and DE Analysis

Once a valid subset is defined, use standard `edgeR` workflows integrated with `manta`.

```R
# Normalization
obj.sub <- calcNormFactors(obj.sub)

# Dispersion estimation (use GLM method if no replicates exist, though not ideal)
obj.sub <- estimateGLMCommonDisp(obj.sub, method="deviance", robust=TRUE)

# Differential Expression Test
test <- exactTest(obj.sub)

# Identify outliers
topTags(test, n=10)
out <- outGenes(test) # manta-specific helper for fold-change/abundance outliers
```

### 4. Visualization

`manta` uses Ratio-Average (RA) plots, which are similar to MA plots but include "wings" for library-unique observations.

```R
# Generate RA plot with taxonomic pie-chart overlays
obj.sub$nr <- nf2nr(x=obj.sub, pair=c("control", "treatment"))
plot(obj.sub, meta.lev='genus_sp', pair=c("control", "treatment"))

# Interactive scatterplot with hover text
caroline::hyperplot(obj, annout=out)
```

## Tips for Success

*   **Taxonomic Levels**: When using `compbiasPlot` or `compbiasTest`, ensure the `meta.lev` matches a column name provided during object initialization in `meta.clmns`.
*   **Housekeeping Genes**: The compositional bias test assumes that the majority of genes (or specified housekeeping genes) should not change across conditions; significant deviations suggest taxonomic shifts rather than just expression changes.
*   **Replicates**: While `manta` can run on single-replicate data using `estimateGLMCommonDisp`, biological replicates are strongly recommended for valid inferential statistics.

## Reference documentation

- [MANTA: Microbial Assemblage Normalized Transcript Analysis](./references/manta.md)