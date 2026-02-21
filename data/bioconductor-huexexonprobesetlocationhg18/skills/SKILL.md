---
name: bioconductor-huexexonprobesetlocationhg18
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/HuExExonProbesetLocationHg18.html
---

# bioconductor-huexexonprobesetlocationhg18

## Overview
The `HuExExonProbesetLocationHg18` package is a Bioconductor annotation data package providing genomic location information for probesets on the Affymetrix Human Exon 1.0 ST Array. It contains a large data frame mapping exon-level and gene-level probeset IDs to specific chromosomal positions on the hg18 assembly.

## Usage and Workflows

### Loading the Data
The package contains a single primary data object named `HuExExonProbesetLocation`.

```r
# Load the library
library(HuExExonProbesetLocationHg18)

# Load the data object into the environment
data(HuExExonProbesetLocation)
```

### Data Structure
The `HuExExonProbesetLocation` object is a data frame with over 1.4 million rows. Each row represents a Probe Selection Region (PSR).

Key columns include:
- `EPROBESETID`: Exon-level probeset ID.
- `CHR`: Chromosome.
- `STRAND`: Chromosome strand.
- `START`: Start position of the Probe Selection Region.
- `END`: End position of the Probe Selection Region.
- `GPROBESETID`: Gene-level probeset ID.
- `ANNLEVEL`: Annotation level (e.g., core, extended, full).

### Common Operations

**Viewing a subset of the data:**
```r
# View the first few rows
head(HuExExonProbesetLocation)

# Convert to a standard data frame for specific manipulation if needed
df <- as.data.frame(HuExExonProbesetLocation[1:10, ])
```

**Filtering by Gene-level Probeset ID:**
```r
# Find all exon probesets associated with a specific gene probeset
target_gene <- "2315251" # Example ID
gene_sub <- HuExExonProbesetLocation[HuExExonProbesetLocation$GPROBESETID == target_gene, ]
```

**Filtering by Genomic Region:**
```r
# Find probesets within a specific range on Chromosome 1
chr1_subset <- HuExExonProbesetLocation[HuExExonProbesetLocation$CHR == "chr1" & 
                                        HuExExonProbesetLocation$START >= 1000000 & 
                                        HuExExonProbesetLocation$END <= 2000000, ]
```

## Tips
- **Memory Management**: This dataset is large (1.4M+ rows). When performing complex joins or filters, ensure your R session has sufficient memory.
- **Genome Build**: This package is specific to **hg18**. If your analysis uses hg19 (GRCh37) or hg38 (GRCh38), you will need to use liftover tools or the corresponding updated annotation packages.
- **Annotation Levels**: Use the `ANNLEVEL` column to filter for high-confidence "core" probesets versus "extended" or "full" sets depending on your experimental stringency.

## Reference documentation
- [HuExExonProbesetLocationHg18 Reference Manual](./references/reference_manual.md)