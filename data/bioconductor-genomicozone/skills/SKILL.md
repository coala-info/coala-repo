---
name: bioconductor-genomicozone
description: The package clusters gene activity along chromosome into zones, detects differential zones as outstanding, and visualizes maps of outstanding zones across the genome. It enables characterization of effects on multiple genes within adaptive genomic neighborhoods, which could arise from genome reorganization, structural variation, or epigenome alteration. It guarantees cluster optimality, linear runtime to sample size, and reproducibility. One can apply it on genome-wide activity measurements such as copy number, transcriptomic, proteomic, and methylation data.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicOZone.html
---

# bioconductor-genomicozone

name: bioconductor-genomicozone
description: Clustering gene activity into genomic zones and detecting differential/outstanding zones across conditions. Use this skill when analyzing genome-wide activity measurements (transcriptomic, proteomic, methylation, or copy number data) to identify adaptive genomic neighborhoods or co-regulated gene clusters.

## Overview

GenomicOZone is a Bioconductor package designed to identify "genomic zones"—clusters of genes along a chromosome that exhibit similar activity patterns. It is particularly useful for detecting large-scale genomic changes such as those caused by genome reorganization, structural variations, or epigenetic alterations. The package provides a robust, linear-runtime method to find optimal clusters and identify "outstanding zones" that differ significantly across experimental conditions.

## Core Workflow

### 1. Data Preparation
The package requires three main components to create a `GOZDataSet`:
- **Expression Data**: A matrix of activity measurements (e.g., RPKM, FPKM).
- **ColData**: A data frame describing samples and experimental conditions.
- **RowData (GRanges)**: A `GRanges` object containing gene coordinates (chromosome, start, end) and gene names.

```r
library(GenomicOZone)
library(GenomicRanges)

# Create GOZDataSet
GOZ.ds <- GOZDataSet(data = activity_matrix,
                     colData = sample_metadata,
                     design = ~ Condition,
                     rowData.GRanges = gene_annotations)
```

### 2. Running the Analysis
The main analysis is performed by the `GenomicOZone()` function, which clusters genes into zones and performs statistical testing to identify differential activity.

```r
# Execute clustering and differential zone analysis
GOZ.ds <- GenomicOZone(GOZ.ds)
```

### 3. Extracting Results
Use auxiliary functions to retrieve specific data from the processed object:

- `extract_genes(GOZ.ds)`: Returns a GRanges object mapping genes to their assigned zones.
- `extract_zones(GOZ.ds)`: Returns a GRanges object of all identified zones with p-values and effect sizes.
- `extract_outstanding_zones(GOZ.ds, alpha, min.effect.size)`: Filters for zones meeting significance and effect size thresholds.
- `extract_zone_expression(GOZ.ds)`: Returns the expression matrix aggregated at the zone level.

### 4. Visualization
The package offers three levels of visualization:

- **Genome-wide**: `plot_genome(GOZ.ds, ...)` provides an overview of all chromosomes.
- **Chromosome-level**: `plot_chromosomes(GOZ.ds, ...)` shows heatmaps of zones within specific chromosomes.
- **Zone-level**: `plot_zones(GOZ.ds, ...)` displays detailed expression patterns for specific zones of interest.

## Tips for Success

- **Effect Size Selection**: When extracting outstanding zones, the `min.effect.size` parameter is critical. A common heuristic is to use the minimum of the top 5% of effect size values calculated by the package.
- **Genome Annotation**: Ensure the `seqlengths` are set on your `rowData.GRanges` object to accurately define the boundaries of the genome during clustering.
- **Data Types**: While often used for transcriptomics, the package is equally effective for copy number variation (CNV) data or methylation levels to find co-localized genomic changes.

## Reference documentation

- [GenomicOZone](./references/GenomicOZone.md)