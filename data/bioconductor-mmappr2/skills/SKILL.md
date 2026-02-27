---
name: bioconductor-mmappr2
description: MMAPPR2 identifies causative mutations from forward genetic screens by analyzing pooled RNA-seq data to map linkage peaks and rank candidate variants. Use when user asks to identify mutations from mutant and wild-type pools, calculate allele frequency distances, or rank candidate variants using VEP.
homepage: https://bioconductor.org/packages/3.10/bioc/html/MMAPPR2.html
---


# bioconductor-mmappr2

## Overview
MMAPPR2 (Mutation Mapping Analysis Pipeline for Pooled RNA-seq) is a Bioconductor package designed to identify causative mutations from forward genetic screens. It works by comparing a mutant pool to a wild-type pool, calculating the Euclidean distance of allele frequencies to identify genomic regions with significant linkage (peaks), and then identifying and ranking candidate variants within those peaks.

## Core Workflow

### 1. Setting Parameters
The `MmapprParam` object centralizes all configuration, including input files and species information.

```r
library(MMAPPR2)

# Define parameters
param <- MmapprParam(
    refFasta = "path/to/genome.fa",
    wtFiles = c("wt_rep1.bam", "wt_rep2.bam"),
    mutFiles = c("mut_rep1.bam", "mut_rep2.bam"),
    species = "danio_rerio",
    outputFolder = "results_folder",
    minDepth = 10
)
```

### 2. Running the Pipeline
The simplest way to run the analysis is using the wrapper function `mmappr()`.

```r
# Run full automated pipeline
mmapprData <- mmappr(param)
```

### 3. Step-by-Step Execution
For debugging or fine-tuning, the pipeline can be executed manually:

```r
md <- new('MmapprData', param = param)
md <- calculateDistance(md)    # Euclidean distance calculation
md <- loessFit(md)             # Fit Loess curves
md <- prePeak(md)              # Identify linkage regions
md <- peakRefinement(md)       # Refine peaks via SNP resampling
md <- generateCandidates(md)   # Identify and rank variants with VEP
outputMmapprData(md)           # Save plots and tables
```

## Advanced Configuration

### Configuring VEP (Variant Effect Predictor)
MMAPPR2 uses `ensemblVEP` to annotate variants. You can customize the `VEPFlags` object to change how candidates are filtered or ranked.

```r
library(ensemblVEP)
vepFlags <- VEPFlags(flags = list(
    format = 'vcf',
    vcf = FALSE,
    species = 'danio_rerio',
    cache = TRUE,
    coding_only = TRUE,
    pick = TRUE # Output only one consequence per variant
))

param <- MmapprParam(..., vepFlags = vepFlags)
```

### Parallel Processing
MMAPPR2 uses `BiocParallel`. Register a backend before running the pipeline to speed up computation.

```r
library(BiocParallel)
register(MulticoreParam(workers = 4, progressbar = TRUE))
```

## Interpreting Results

### Accessing Candidates
Candidates are stored in the `candidates` slot of the `MmapprData` object, organized by chromosome.

```r
# View top candidates for chromosome 18
head(candidates(mmapprData)$`18`)
```

### Output Files
The `outputFolder` will contain:
- `mmappr_data.RDS`: The full `MmapprData` object for reloading.
- `[chromosome].tsv`: Ranked list of candidate mutations.
- `genome_plots.pdf`: Visualization of Euclidean distance across the genome.
- `peak_plots.pdf`: Detailed view of identified linkage peaks.

## Tips and Troubleshooting
- **Dependency Check**: Ensure `samtools` and `VEP` are installed and available in your system's PATH.
- **Genome Consistency**: The `refFasta` used in `MmapprParam` must match the assembly version used for alignment and the VEP cache.
- **Recovery**: If a run fails, load the `.RDS` file from the output folder to inspect the `MmapprData` object and identify which step failed.

## Reference documentation
- [An Introduction to MMAPPR2](./references/MMAPPR2.md)
- [MMAPPR2 Rmd Source](./references/MMAPPR2.Rmd)