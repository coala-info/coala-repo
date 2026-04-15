---
name: bioconductor-phastcons30way.ucsc.hg38
description: This tool provides access to human phastCons conservation scores derived from a 30-way mammal alignment for the hg38 genome build. Use when user asks to retrieve genomic conservation levels, query phastCons scores at specific coordinates, or download conservation data via AnnotationHub.
homepage: https://bioconductor.org/packages/release/data/annotation/html/phastCons30way.UCSC.hg38.html
---

# bioconductor-phastcons30way.ucsc.hg38

name: bioconductor-phastcons30way.ucsc.hg38
description: Access and retrieve human phastCons conservation scores (30-way mammal alignment) for the hg38 genome build. Use this skill when you need to query genomic conservation levels at specific coordinates or ranges using the GenomicScores API and AnnotationHub.

## Overview

The `phastCons30way.UCSC.hg38` package provides metadata and access to conservation scores derived from a multiple alignment of the human genome (hg38) with 29 other mammal genomes (26 of which are primates). These scores represent the probability that a nucleotide belongs to a conserved element.

The package primarily acts as a bridge to `AnnotationHub` resources, and users should interact with it using the `GenomicScores` Bioconductor package.

## Typical Workflow

### 1. Load the Resource
To use these scores, you must first retrieve the GScores object via `AnnotationHub`.

```r
library(GenomicScores)

# Check availability
# availableGScores() 

# Download/Load the phastCons 30-way hg38 resource
phast <- getGScores("phastCons30way.UCSC.hg38")
```

### 2. Querying Scores
Use the `gscores()` function to retrieve conservation values for specific genomic ranges.

```r
library(GenomicRanges)

# Define target regions (hg38 coordinates)
target_regions <- GRanges(seqnames="chr22", 
                          IRanges(start=50967020:50967025, width=1))

# Retrieve scores
scores <- gscores(phast, target_regions)
print(scores)
```

### 3. Offline Usage (Creating a Local Package)
If you need to work without an internet connection, you can convert the `AnnotationHub` resource into a standalone R package.

```r
makeGScoresPackage(phast, 
                   maintainer="Your Name <email@example.com>", 
                   author="Your Name", 
                   version="1.0.0",
                   destDir=".")
```
After running this, you must install the resulting directory using `R CMD INSTALL`.

## Tips and Best Practices
- **Coordinate System**: Ensure your input `GRanges` use the **hg38** assembly. Using hg19 coordinates will result in incorrect or missing data.
- **Caching**: The first call to `getGScores()` downloads a large dataset. Subsequent calls will use the local BiocFileCache.
- **GenomicScores API**: For advanced queries (e.g., populations, specific score transformations), refer to the `GenomicScores` package documentation.

## Reference documentation

- [phastCons30way.UCSC.hg38 AnnotationHub Resource Metadata](./references/phastCons30way.UCSC.hg38.md)