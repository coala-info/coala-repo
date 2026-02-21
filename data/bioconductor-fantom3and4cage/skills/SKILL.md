---
name: bioconductor-fantom3and4cage
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/FANTOM3and4CAGE.html
---

# bioconductor-fantom3and4cage

## Overview

The `FANTOM3and4CAGE` package is a Bioconductor data-experiment package providing genome-wide, 1bp-resolution maps of transcription start sites (TSSs) and their expression levels. It contains data from the FANTOM3 and FANTOM4 projects, covering a wide range of tissues and several timecourse experiments for both human and mouse.

**Key Metadata:**
- **Human Genome:** hg18
- **Mouse Genome:** mm9
- **Data Type:** CAGE tag counts (measure of TSS usage/expression)

## Getting Started

Load the package to access the datasets:

```r
library(FANTOM3and4CAGE)
```

## Exploring Available Samples

The package provides metadata data frames to help identify available samples and the datasets they belong to.

```r
# For human samples
data(FANTOMhumanSamples)
head(FANTOMhumanSamples)

# For mouse samples
data(FANTOMmouseSamples)
head(FANTOMmouseSamples)
```

The metadata contains three columns:
- `dataset`: The name of the object to load via `data()`.
- `group`: The tissue or experiment group (e.g., "lung", "blood").
- `sample`: The specific sample identifier.

## Accessing Tissue-Specific Data

Tissue data is organized into named lists where each element is a data frame for a specific tissue group.

```r
# Load human tissue data
data(FANTOMtissueCAGEhuman)

# List available tissue groups
names(FANTOMtissueCAGEhuman)

# Access a specific tissue (e.g., lung)
lung_data <- FANTOMtissueCAGEhuman[["lung"]]
head(lung_data)
```

## Accessing Timecourse Data

Timecourse datasets are available for studying dynamic regulation during processes like induction.

```r
# Load mouse timecourse data
data(FANTOMtimecourseCAGEmouse)

# List available timecourses
names(FANTOMtimecourseCAGEmouse)

# Access a specific timecourse (e.g., adipogenic induction)
adipogenic <- FANTOMtimecourseCAGEmouse[["adipogenic_induction"]]
head(adipogenic)
```

## Data Structure and Interpretation

Every data frame retrieved from the tissue or timecourse lists follows a standard format:

1.  **chr**: Chromosome (e.g., "chr1").
2.  **pos**: 1bp genomic coordinate of the TSS.
3.  **strand**: DNA strand ("+" or "-").
4.  **Sample Columns**: Subsequent columns contain the number of CAGE tags supporting that TSS in specific samples.

**Usage Tip:** Because the data is mapped to older assemblies (hg18/mm9), use Bioconductor tools like `rtracklayer::liftOver` if you need to work with modern assemblies (hg38/mm10).

## Reference documentation

- [FANTOM3and4CAGE](./references/FANTOM3and4CAGE.md)