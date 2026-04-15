---
name: bioconductor-huexexonprobesetlocationhg19
description: This package provides exon-level chromosome location data for Affymetrix Human Exon microarrays mapped to the hg19 genome build. Use when user asks to map HuEx probeset IDs to genomic coordinates, identify gene-level associations, or filter probesets by annotation level for genomic analysis in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/HuExExonProbesetLocationHg19.html
---

# bioconductor-huexexonprobesetlocationhg19

name: bioconductor-huexexonprobesetlocationhg19
description: Provides exon-level chromosome location data for Affymetrix Human Exon (HuEx) microarrays mapped to the hg19 genome build. Use this skill when you need to map HuEx probeset IDs to genomic coordinates (CHR, START, END, STRAND), identify gene-level associations (GPROBESETID), or filter probesets by annotation level (ANNLEVEL) for downstream genomic analysis in R.

# bioconductor-huexexonprobesetlocationhg19

## Overview
The `HuExExonProbesetLocationHg19` package is a Bioconductor annotation data package containing the mapping of exon-level probesets for Human Exon microarrays to the hg19 (GRCh37) reference genome. It provides a large data frame (`HuExExonProbesetLocation`) containing over 1.4 million rows of positional information, which is essential for visualizing exon-level expression data or performing overlap analysis with other genomic features.

## Usage and Workflows

### Loading the Data
The package contains a single primary dataset. Load the library and then use the `data()` function to bring the object into the environment.

```r
library(HuExExonProbesetLocationHg19)
data(HuExExonProbesetLocation)
```

### Data Structure
The `HuExExonProbesetLocation` object is a data frame with the following columns:
- **EPROBESETID**: Exon-level probeset identifier.
- **CHR**: Chromosome.
- **STRAND**: Chromosome strand.
- **START**: Start position of the Probe Selection Region (PSR).
- **END**: End position of the Probe Selection Region (PSR).
- **GPROBESETID**: Gene-level probeset identifier.
- **ANNLEVEL**: Annotation level (e.g., core, extended, full).

### Common Operations

**1. Inspecting the data:**
```r
# View the first few rows
head(HuExExonProbesetLocation)

# Check the dimensions
dim(HuExExonProbesetLocation)
```

**2. Filtering by Chromosome:**
```r
# Extract all probesets on Chromosome 1
chr1_probesets <- HuExExonProbesetLocation[HuExExonProbesetLocation$CHR == "1", ]
```

**3. Mapping Exon Probesets to Gene Probesets:**
```r
# Find all exon probesets associated with a specific gene-level ID
gene_id <- "2315251" # Example ID
exon_map <- HuExExonProbesetLocation[HuExExonProbesetLocation$GPROBESETID == gene_id, ]
```

**4. Filtering by Annotation Level:**
```r
# Filter for 'core' annotation level probesets (if applicable)
core_probesets <- HuExExonProbesetLocation[HuExExonProbesetLocation$ANNLEVEL == "core", ]
```

## Tips
- **Memory Management**: This dataset is large (1.4M+ rows). If you only need specific chromosomes or annotation levels, filter the data frame immediately after loading to save memory.
- **Coordinate System**: Ensure your other genomic data (e.g., BAM files or BED files) are also based on the **hg19** assembly to maintain consistency.
- **Integration**: This package is often used in conjunction with `oligo` or `exonmap` for high-level exon array analysis.

## Reference documentation
- [HuExExonProbesetLocationHg19 Reference Manual](./references/reference_manual.md)