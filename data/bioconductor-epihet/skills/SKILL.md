---
name: bioconductor-epihet
description: This tool analyzes epigenetic heterogeneity in cancer cells by calculating diversity metrics and identifying differential loci from DNA methylation data. Use when user asks to calculate heterogeneity metrics like PDR or Shannon entropy, identify differential epigenetic heterogeneity loci, or construct co-epigenetic heterogeneity networks.
homepage: https://bioconductor.org/packages/3.9/bioc/html/epihet.html
---


# bioconductor-epihet

name: bioconductor-epihet
description: Analysis of epigenetic heterogeneity in cancer cells using DNA methylation data. Use this skill to calculate heterogeneity metrics (PDR, Epipolymorphism, Shannon Entropy), identify differential epigenetic heterogeneity (DEH) loci, and construct co-epigenetic heterogeneity networks from methclone output files.

# bioconductor-epihet

## Overview
The `epihet` package is designed to analyze epigenetic heterogeneity by processing phased DNA methylation patterns (epialleles) from bisulfite sequencing data. It calculates three primary metrics:
1. **Proportion of Discordant Reads (PDR):** The ratio of discordant reads to total reads at a locus.
2. **Epipolymorphism:** The probability that two randomly sampled epialleles differ.
3. **Shannon Entropy:** A measure of epiallele diversity/uncertainty at a locus.

The package provides a complete pipeline from raw data ingestion to statistical analysis, visualization, and network construction.

## Core Workflow

### 1. Data Ingestion and Matrix Building
The package starts with compressed text files from `methclone`.

```r
library(epihet)

# Define file paths and sample IDs
files <- c("sample1.methClone_out.gz", "sample2.methClone_out.gz")
ids <- c("Sample1", "Sample2")

# Step 1: Create a list of GenomicRanges objects
GR.List <- makeGR(files = files, ids = ids, cores = 1)

# Step 2: Generate a comparison matrix of shared loci
# p = 1 means loci must be present in 100% of samples
comp.Matrix <- compMatrix(epi.gr = GR.List, readNumber = 60, p = 1)
```

### 2. Exploratory Data Analysis
Visualize the distribution and clustering of heterogeneity metrics.

```r
# Define sample annotations (required for most plots)
subtype <- data.frame(Type = c("Cancer", "Normal"), row.names = ids)

# Boxplots of heterogeneity values
epiBox(compare.matrix = comp.Matrix, value = 'epipoly', type = subtype)

# Heatmap of top variable loci
epiMap(compare.matrix = comp.Matrix, value = 'epipoly', annotate = subtype, loci.percent = 0.05)

# Dimensionality Reduction
epiPCA(compare.matrix = comp.Matrix, value = 'epipoly', type = subtype)
epiTSNE(compare.matrix = comp.Matrix, value = 'epipoly', type = subtype)
```

### 3. Differential Epigenetic Heterogeneity (DEH)
Identify loci where heterogeneity significantly differs between groups.

```r
# Identify DEH loci
diff.het.matrix <- diffHet(compare.matrix = comp.Matrix, 
                           value = 'epipoly', 
                           group1 = 'Cancer', 
                           group2 = 'Normal', 
                           subtype = subtype,
                           het.dif.cutoff = 0.20)

# Visualize results with an MA plot
epiMA(pval.matrix = diff.het.matrix, padjust.cutoff = 0.05)
```

### 4. Network Construction (WGCNA-based)
Construct co-epigenetic heterogeneity networks to identify modules of co-varying loci or genes.

```r
# Construct network based on genes annotated by DEH loci
# Requires a promoter/annotation object
epi.network <- epiNetwork(node.type = "gene", 
                          DEH = diff.het.matrix, 
                          sharedmatrix = comp.Matrix, 
                          value = "epipoly", 
                          group = "Cancer", 
                          subtype = subtype, 
                          annotation.obj = promoter_granges)

# Visualize module topology
module.topology <- moduleVisual(TOM, 
                                value.matrix = epi.network$epimatrix, 
                                moduleColors = epi.network$module$color, 
                                mymodule = "turquoise")
```

## Key Functions Reference
- `makeGR()`: Converts methclone files to GenomicRanges.
- `compMatrix()`: Creates the master matrix for downstream analysis.
- `summarize()`: Quick correlation check between two samples.
- `diffHet()`: Performs t-tests or permutation tests (via EntropyExplorer) for differential analysis.
- `epiPathway()`: Performs pathway enrichment on network modules.
- `moduleSim()`: Compares module similarity between different cancer subtypes using Jaccard scores.

## Reference documentation
- [epihet](./references/epihet.md)