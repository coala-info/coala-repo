---
name: bioconductor-ballgown
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ballgown.html
---

# bioconductor-ballgown

## Overview
The `ballgown` package is designed for the analysis of transcript-level expression data. It bridges the gap between transcriptome assembly (via tools like StringTie or Cufflinks) and statistical analysis. It allows for differential expression testing of transcripts, exons, and introns using flexible linear models, and provides specialized visualization tools for genomic structures.

## Core Workflow

### 1. Loading Data
Data must first be processed by the `Tablemaker` command-line tool to generate `.ctab` files.
```R
library(ballgown)

# Option A: Load from a directory containing sample subfolders
data_dir <- "path/to/data"
bg <- ballgown(dataDir = data_dir, samplePattern = 'sample', meas = 'all')

# Option B: Load from specific paths
sample_paths <- c("path/to/sample01", "path/to/sample02")
bg <- ballgown(samples = sample_paths, meas = 'all')
```
*Note: For large datasets, load the object in a non-interactive script and save as an `.rda` file.*

### 2. Managing Phenotype Data
It is critical that the `pData` (phenotype data) rows match the order of the samples in the ballgown object.
```R
# Check sample order
sampleNames(bg)

# Assign phenotype data
pData(bg) <- data.frame(id = sampleNames(bg), 
                        group = rep(c(1, 0), each = 10))
```

### 3. Accessing Expression and Structure
Use the `*expr` family of functions to extract data:
- `texpr(bg, 'FPKM')`: Transcript-level FPKM.
- `eexpr(bg, 'rcount')`: Exon-level read counts.
- `iexpr(bg)`: Intron-level expression.
- `gexpr(bg)`: Gene-level expression (aggregated from transcripts).

Access genomic ranges:
- `structure(bg)$exon`: GRanges of exons.
- `structure(bg)$trans`: GRangesList of transcripts.

### 4. Differential Expression Testing
The `stattest` function performs a parametric F-test comparing nested linear models.

**Two-group or Multi-group comparison:**
```R
results <- stattest(bg, feature = 'transcript', meas = 'FPKM', covariate = 'group')
```

**Timecourse analysis:**
Uses natural splines to model expression over a continuous covariate.
```R
results_time <- stattest(bg, feature = 'transcript', meas = 'FPKM', 
                         covariate = 'time', timecourse = TRUE, df = 4)
```

**Adjusting for confounders:**
```R
results_adj <- stattest(bg, feature = 'transcript', covariate = 'group', 
                        adjustvars = c('age', 'sex'))
```

### 5. Visualization
Visualize transcript structures colored by expression level:
```R
# Plot single sample
plotTranscripts(gene = 'XLOC_000454', gown = bg, samples = 'sample01', 
                meas = 'FPKM', colorby = 'transcript')

# Compare group means
plotMeans('XLOC_000454', bg, groupvar = 'group', meas = 'FPKM', colorby = 'transcript')
```

### 6. Transcript Clustering
To handle unreliable expression estimates in highly similar transcripts, you can cluster them:
```R
# Cluster transcripts for a gene
clusters <- clusterTranscripts(gene = 'XLOC_000454', gown = bg, k = 2, method = 'kmeans')

# Collapse and test clusters
agg <- collapseTranscripts(gene = 'XLOC_000454', gown = bg, k = 2, method = 'kmeans')
cluster_results <- stattest(gowntable = agg$tab, pData = pData(bg), 
                            feature = 'transcript_cluster', covariate = 'group')
```

## Tips and Best Practices
- **Memory Management**: If memory is an issue, load only specific measurements using the `meas` argument in `ballgown()` (e.g., `meas = 'FPKM'`).
- **External Tools**: You can export expression matrices from `*expr` functions to use with other packages like `limma`, `DESeq2`, or `edgeR`.
- **Gene IDs**: Ballgown uses `XLOC` identifiers by default if data comes from Cufflinks/Tablemaker. Use the `indexes(bg)$t2g` table to map transcripts to genes.

## Reference documentation
- [Flexible isoform-level differential expression analysis with Ballgown](./references/ballgown.Rmd)
- [Ballgown Vignette (Markdown)](./references/ballgown.md)