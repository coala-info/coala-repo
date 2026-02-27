---
name: bioconductor-methimpute
description: Bioconductor-methimpute performs methylation status calling and missing value imputation for DNA methylation data using Hidden Markov Models. Use when user asks to call methylation status, impute missing methylation values, or estimate context-specific conversion rates in BS-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/methimpute.html
---


# bioconductor-methimpute

name: bioconductor-methimpute
description: Methylation status calling and imputation using Hidden Markov Models (HMM). Use this skill when analyzing DNA methylation data (BS-seq) to call methylation status (Methylated/Unmethylated) for individual cytosines or binned data, especially when imputation of missing values or context-specific conversion rates are required.

## Overview

The `methimpute` package implements a binomial HMM to call methylation status. Unlike simple binomial tests, it borrows information from neighboring cytosines to improve accuracy and impute status for sites with zero coverage. It supports separate-context models (CG, CHG, CHH treated independently) and interacting-context models (considering correlations between different contexts).

## Core Workflow

### 1. Data Import and Preparation

The package requires data containing cytosine positions, sequence context, and counts (methylated vs. total).

```R
library(methimpute)

# Import from BSSeeker format
file <- system.file("extdata", "arabidopsis_bsseeker.txt.gz", package="methimpute")
bsseeker.data <- importBSSeeker(file)

# Inflate methylome to include all genomic cytosines (required for HMM imputation)
fasta.file <- system.file("extdata", "arabidopsis_sequence.fa.gz", package="methimpute")
cytosine.positions <- extractCytosinesFromFASTA(fasta.file, contexts = c('CG','CHG','CHH'))
methylome <- inflateMethylome(bsseeker.data, cytosine.positions)
```

### 2. Estimating Correlation Parameters

Before calling methylation, you must estimate how methylation correlates over distance.

```R
# For separate contexts
distcor <- distanceCorrelation(methylome, separate.contexts = TRUE)
fit <- estimateTransDist(distcor)

# For interacting contexts (single HMM for all contexts)
distcor.int <- distanceCorrelation(methylome, separate.contexts = FALSE)
fit.int <- estimateTransDist(distcor.int)
```

### 3. Methylation Status Calling

Choose between the separate-context model (faster, robust for low coverage) or the interacting-context model (more accurate with sufficient data).

```R
# Separate-context model
model <- callMethylationSeparate(data = methylome, transDist = fit$transDist)

# Interacting-context model
model.int <- callMethylation(data = methylome, transDist = fit.int$transDist)

# Binned data (e.g., 100bp bins)
binnedMethylome <- binMethylome(methylome, binsize = 100, contexts = c('total','CG'))
binnedModel <- callMethylation(data = binnedMethylome$CG)
```

## Interpreting Results

The output is a `GRanges` object with several metadata columns:
- `status`: The called methylation state (Methylated/Unmethylated).
- `posteriorMax`: Confidence score (0 to 1). High confidence is typically >= 0.98.
- `rc.meth.lvl`: Recalibrated methylation level based on the HMM.
- `counts`: Original methylated and total read counts.

To extract bisulfite conversion rates:
```R
# Conversion rate = 1 - emission probability of Unmethylated state
1 - model$params$emissionParams$Unmethylated
```

## Visualization and Export

```R
# Diagnostic plots
plotConvergence(model)
plotTransitionProbs(model)
plotHistogram(model, total.counts = 10)

# Enrichment analysis (e.g., around genes)
data(arabidopsis_genes)
plotEnrichment(model$data, annotation=arabidopsis_genes, range = 2000)

# Export to TSV
exportMethylome(model, filename = "results.tsv")
```

## Tips
- **Imputation**: `methimpute` automatically assigns a status to cytosines with 0 reads. Check `posteriorMax` to distinguish these; imputed sites usually have lower confidence than covered sites.
- **Model Selection**: Use `callMethylationSeparate` if you observe that CHH/CHG contexts are incorrectly "bleeding" into CG patterns due to very low coverage.
- **Memory**: For large genomes, ensure you have sufficient RAM when inflating the methylome to include all cytosine positions.

## Reference documentation
- [Methylation status calling with METHimpute](./references/methimpute.md)