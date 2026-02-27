---
name: bioconductor-wes.1kg.wugsc
description: This package provides processed Whole Exome Sequencing BAM files from the 1000 Genomes Project for a subset of chromosome 22. Use when user asks to access example exome sequencing data, test bioinformatics tools with BAM files, or calculate read depth over specific genomic regions.
homepage: https://bioconductor.org/packages/release/data/experiment/html/WES.1KG.WUGSC.html
---


# bioconductor-wes.1kg.wugsc

## Overview
The `WES.1KG.WUGSC` package is a Bioconductor experiment data package providing processed Whole Exome Sequencing (WES) data. It contains 46 samples from the 1000 Genomes Project, specifically those sequenced by the Washington University Genome Sequencing Center (WUGSC). To keep the package size manageable, the data is restricted to the 401st-500th exons of chromosome 22. The files are provided in sorted and indexed `.bam` format, making them ideal for testing R-based bioinformatics tools that require BAM input.

## Data Access and Usage

### Loading the Package
To use the data, first load the library in your R session:

```r
library(WES.1KG.WUGSC)
```

### Locating BAM Files
The BAM files are stored within the package's installation directory. You can retrieve the full file paths using `system.file`.

```r
# List all BAM files in the package
bam_files <- list.files(system.file("extdata", package = "WES.1KG.WUGSC"), 
                        pattern = "\\.bam$", 
                        full.names = TRUE)

# Check the number of files (should be 46)
length(bam_files)
```

### Accessing Sample Metadata
The package includes 46 samples from three populations:
- **CEU**: Utah Residents with Northern and Western European Ancestry
- **JPT**: Japanese in Tokyo, Japan
- **YRI**: Yoruba in Ibadan, Nigeria

The metadata (Sample ID, Population, and Gender) is typically used to organize comparative analyses.

### Typical Workflow: Coverage Calculation
A common use case for this data is calculating read depth/coverage over specific genomic ranges (e.g., using `Rsamtools` or `ExomeCopy`).

```r
library(Rsamtools)

# Define a region of interest on Chromosome 22
# Note: Data only exists for exons 401-500
target_region <- GRanges("22", IRanges(start = 30000000, end = 31000000))

# Calculate coverage for the first sample
bam_path <- bam_files[1]
selection <- ScanBamParam(which = target_region)
coverage_data <- pileup(bam_path, scanBamParam = selection)
```

## Tips for Success
- **Coordinate Range**: Remember that these BAM files are heavily subsetted. If you attempt to query regions outside of the 401st-500th exons on chromosome 22, you will retrieve zero reads.
- **Index Files**: The package includes the corresponding `.bai` files in the same `extdata` directory, so functions requiring indexed BAMs will work out-of-the-box.
- **Sample Mapping**: The filenames follow a specific convention (e.g., `NA06994.mapped...bam`). You can extract the Sample ID using string manipulation to match against the population metadata provided in the package documentation.

## Reference documentation
- [WES.1KG.WUGSC Vignette](./references/WES.1KG.WUGSC_vignettes.md)