---
name: bioconductor-aneufinder
description: Bioconductor-aneufinder analyzes copy number variations in whole-genome single-cell sequencing data using various calling algorithms and quality control methods. Use when user asks to perform CNV calling, apply mappability correction, create genomic blacklists, or visualize single-cell karyotype heterogeneity.
homepage: https://bioconductor.org/packages/3.8/bioc/html/AneuFinder.html
---


# bioconductor-aneufinder

name: bioconductor-aneufinder
description: Use for analyzing copy number variations (CNV) in whole-genome single-cell sequencing (WGSCS) data. This skill includes methods for CNV calling (HMM, edivisive, or DNAcopy), mappability correction, blacklisting, quality control, and visualization of genomic profiles.

# bioconductor-aneufinder

## Overview
AneuFinder is a bioinformatics package designed for the study of copy number variations (CNV) in whole-genome single-cell sequencing (WGSCS) data. It allows users to perform CNV calling using various algorithms (Hidden Markov Models, changepoint-algorithms, or the edivisive-algorithm) on binned read counts. The package also provides extensive tools for quality control, karyotype heterogeneity analysis, and visualization through heatmaps, karyograms, and PCA.

## Installation
To install the package from Bioconductor:
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("AneuFinder")
```

## Quickstart
The primary function `Aneufinder()` automates the pipeline from aligned reads (BAM or BED) to final results. The "edivisive" method is generally recommended.

```R
library(AneuFinder)

# Run the full pipeline
Aneufinder(inputfolder='path/to/bam_files', 
           outputfolder='output_results',
           numCPU=2, 
           method='edivisive')
```

## Detailed Workflow

### 1. Mappability Correction and Blacklisting
To improve accuracy, you can use a euploid reference for mappability correction (variable-width binning) and create a blacklist to exclude repetitive or problematic regions.

```R
# Create a blacklist from a euploid reference
library(AneuFinder)
bedfile <- "path/to/euploid_reference.bed.gz"
bins <- binReads(bedfile, assembly='hg19', binsizes=100e3, chromosomes=c(1:22,'X'))[[1]]

# Define thresholds for blacklisting
lcutoff <- quantile(bins$counts, 0.05)
ucutoff <- quantile(bins$counts, 0.999)
blacklist <- bins[bins$counts <= lcutoff | bins$counts >= ucutoff]
blacklist <- reduce(blacklist)

# Export for use in Aneufinder()
exportGRanges(blacklist, filename="my_blacklist.bed", header=FALSE)
```

### 2. Running the Analysis
Execute the main function with specific parameters like GC correction and blacklisting.

```R
library(BSgenome.Hsapiens.UCSC.hg19)

Aneufinder(inputfolder = 'data_folder', 
           outputfolder = 'output_folder', 
           assembly = 'hg19',
           numCPU = 4, 
           binsizes = c(5e5, 1e6), 
           variable.width.reference = 'reference.bam',
           blacklist = 'my_blacklist.bed', 
           correction.method = 'GC',
           GC.BSgenome = BSgenome.Hsapiens.UCSC.hg19,
           method = 'edivisive')
```

### 3. Loading and Visualizing Results
Results are stored as `.RData` files in the `MODELS` subfolder.

```R
# Load models
files <- list.files('output_folder/MODELS/method-edivisive', full.names=TRUE)
models <- loadFromFiles(files)

# Plot a single cell profile
plot(models[[1]], type='profile')

# Plot a genome-wide heatmap for all cells
heatmapGenomewide(models)
```

### 4. Quality Control
Use `clusterByQuality()` to identify and filter out low-quality libraries based on metrics like spikiness, entropy, and the number of segments.

```R
# Cluster cells by quality
cl <- clusterByQuality(models)

# View clusters (usually the last cluster contains failed libraries)
plot(cl$Mclust, what='classification')

# Select high-quality cells for further analysis
selected_models <- unlist(cl$classification[1:2])
```

### 5. Karyotype Measures and PCA
Quantify aneuploidy and heterogeneity across different samples or conditions.

```R
# Calculate scores
k_stats <- karyotypeMeasures(selected_models)
print(k_stats$genomewide)

# Compare heterogeneity between groups
plotHeterogeneity(hmms.list = list(GroupA = models_A, GroupB = models_B))

# Perform PCA
plot_pca(selected_models, colorBy=sample_labels)
```

## Reference documentation
- [AneuFinder](./references/AneuFinder.md)