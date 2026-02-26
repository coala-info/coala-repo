---
name: bioconductor-hitc
description: This package provides tools for the analysis and visualization of high-throughput chromosome conformation capture data such as Hi-C and 5C. Use when user asks to import contact maps, perform genomic binning, normalize interaction data using ICE or LGF methods, visualize interaction heatmaps, or detect topological domains.
homepage: https://bioconductor.org/packages/release/bioc/html/HiTC.html
---


# bioconductor-hitc

name: bioconductor-hitc
description: Expert guidance for the HiTC Bioconductor package to analyze High-Throughput 'C' (Hi-C, 5C) data. Use this skill when processing contact maps, performing normalization (ICE, LGF), binning genomic data, visualizing interaction heatmaps, or detecting topological domains (TADs) in R.

## Overview
The HiTC package is a Bioconductor tool designed for the exploration and analysis of chromosome conformation capture experiments. It provides S4 classes (`HTCexp` for single maps, `HTClist` for collections) to handle large-scale interaction matrices efficiently using sparse matrix representations. Key capabilities include data import from HiC-Pro or my5C formats, genomic binning, normalization of sequencing biases, and visualization of cis/trans interactions.

## Core Workflows

### 1. Data Import and Structure
HiTC works with processed contact maps rather than raw reads.
```R
library(HiTC)

# Import from HiC-Pro or list format (Interactors + Counts)
# Requires a list file and BED files for x/y intervals
hiC <- importC("contacts.txt", xgi.bed="bins_x.bed", ygi.bed="bins_y.bed")

# Import from my5C matrix format
hiC_map <- import.my5C("matrix_file.txt")

# Objects are typically HTClist (list of HTCexp objects)
detail(hiC$chr6chr6) # Get summary statistics for a specific map
```

### 2. Data Transformation and Binning
Adjust resolution by binning genomic intervals.
```R
# Binning to 500kb resolution
# method can be "sum", "mean", or "median"
hiC_500 <- binningC(hiC, binsize=500000, method="sum")

# Extract a specific genomic region
hox_region <- extractRegion(hiC$chr6chr6, chr="chr6", from=50e6, to=58e6)
```

### 3. Normalization
HiTC supports several normalization strategies to remove experimental biases.

**Iterative Correction (ICE):**
Assumes equal visibility of genomic loci.
```R
# Apply ICE normalization to an HTClist
hiC_ice <- normICE(hiC_500, max_iter=10)
```

**Local Genomic Feature (LGF) Normalization:**
Corrects for GC content, mappability, and effective length.
```R
# 1. Get annotated restriction sites (requires BSgenome)
cutSites <- getAnnotatedRestrictionSites(resSite="AAGCTT", chromosomes="chr6", genomePack="BSgenome.Hsapiens.UCSC.hg18")

# 2. Set features and normalize
hiC_annot <- setGenomicFeatures(hiC$chr6chr6, cutSites)
hiC_lgf <- normLGF(hiC_annot)
```

**Distance-based Normalization:**
```R
# Normalize by expected counts based on genomic distance (Loess)
hiC_norm <- normPerExpected(hiC_500, method="loess")
```

### 4. Visualization
Generate heatmaps and compare samples.
```R
# Basic triangle plot for HTCexp
mapC(hiC$chr6chr6)

# Full genome/multi-chromosome heatmap for HTClist
mapC(hiC_500, maxrange=200)

# Compare two samples with genomic tracks (e.g., CTCF, Genes)
mapC(E14_binned, MEF_binned, tracks=list(RefSeq=gene_gr, CTCF=ctcf_gr))
```

### 5. Topological Domain Analysis
Identify structural features like TADs.
```R
# Calculate Directionality Index (DI)
di <- directionalityIndex(hox_region)

# Visualize DI to identify domain boundaries
barplot(di, col=ifelse(di > 0, "darkred", "darkgreen"))
```

## Best Practices
- **Memory Management:** For high-resolution data (e.g., <40kb), use `optimize.by="memory"` in functions like `binningC` to leverage sparse matrices.
- **Symmetry:** Use `forceSymmetric` or `forcePairwise` to ensure intrachromosomal maps are correctly handled for visualization.
- **Quality Control:** Use `CQC(hiC)` to check the ratio of intra/inter-chromosomal interactions and the relationship between frequency and genomic distance.

## Reference documentation
- [Analyzing Hi-C data with the HiTC BioC package](./references/HiC_analysis.md)
- [HiTC - Exploration of High Throughput 'C' experiments](./references/HiTC.md)