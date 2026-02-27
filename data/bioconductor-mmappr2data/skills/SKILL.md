---
name: bioconductor-mmappr2data
description: This package provides example datasets and utility functions to support the MMAPPR2 mutation mapping pipeline. Use when user asks to access sample zebrafish BAM files, retrieve reference genome paths for testing, or practice the MMAPPR2 workflow.
homepage: https://bioconductor.org/packages/3.10/data/experiment/html/MMAPPR2data.html
---


# bioconductor-mmappr2data

## Overview

The `MMAPPR2data` package is an experiment data package designed to support the `MMAPPR2` pipeline. It provides small, manageable example datasets—specifically focusing on the *golden* (slc24a5) gene in zebrafish—to allow users to verify their installation and practice the mutation mapping workflow.

## Loading Data Resources

The package provides four primary functions to retrieve paths to the example data files. These files are essential for configuring the `MmapprParam` object in the main `MMAPPR2` workflow.

```r
library(MMAPPR2data)

# Get BamFile objects for Wild-Type and Mutant pools
wt_bam <- exampleWTbam()
mut_bam <- exampleMutBam()

# Get file paths for reference genome and annotations
fasta_path <- goldenFasta()
gff_path <- goldenGFF()
```

## Typical Workflow with MMAPPR2

The data from this package is typically used to initialize a mapping run.

### 1. Configure Parameters
Use the data accessors to populate the `MmapprParam` object.

```r
library(MMAPPR2)

param <- MmapprParam(
    refFasta = goldenFasta(),
    wtFiles = exampleWTbam(),
    mutFiles = exampleMutBam(),
    species = "danio_rerio",
    outputFolder = "mmappr_results"
)
```

### 2. Execute the Pipeline
You can run the entire automated pipeline or step-by-step for debugging.

**Automated:**
```r
results <- mmappr(param)
```

**Step-by-Step:**
```r
md <- new("MmapprData", param = param)
md <- calculateDistance(md)
md <- loessFit(md)
md <- prePeak(md)
md <- peakRefinement(md)
md <- generateCandidates(md)
```

## Interpreting Results

Once the pipeline completes using the example data, you can inspect the identified mutation candidates.

```r
# View top candidates for a specific chromosome (e.g., chromosome 18)
head(candidates(results)$`18`)
```

## Tips for Success

- **System Dependencies**: Ensure `samtools` and `Ensembl VEP` are installed and in your system PATH, as `MMAPPR2` relies on them to process the data provided by this package.
- **Parallelization**: By default, the pipeline uses `BiocParallel`. If you encounter issues on specific systems, register a `SerialParam()` for debugging: `BiocParallel::register(BiocParallel::SerialParam())`.
- **Reference Matching**: Always ensure the `refFasta` provided by `MMAPPR2data` matches the version used in your VEP configuration (typically the latest Ensembl assembly for the species).

## Reference documentation
- [An Introduction to MMAPPR2](./references/MMAPPR2.Rmd)
- [Using MMAPPR2data Resources](./references/MMAPPR2data.md)