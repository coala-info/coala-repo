---
name: bioconductor-fdb.fantom4.promoters.hg19
description: "This Bioconductor package provides promoter annotations and CpG content data derived from FANTOM4 CAGE experiments in THP-1 cells for the hg19 assembly. Use when user asks to access FANTOM4 promoter regions, extract genomic features from THP-1 cells, analyze CpG ratios, or perform hg18 to hg19 liftOver operations."
homepage: https://bioconductor.org/packages/release/data/annotation/html/FDb.FANTOM4.promoters.hg19.html
---


# bioconductor-fdb.fantom4.promoters.hg19

name: bioconductor-fdb.fantom4.promoters.hg19
description: Annotation package for FANTOM4 CAGE promoters from THP-1 cells (hg19). Use this skill when needing to access, extract, or analyze promoter regions and CpG content from the FANTOM4 dataset within the R Bioconductor environment.

# bioconductor-fdb.fantom4.promoters.hg19

## Overview
The `FDb.FANTOM4.promoters.hg19` package provides a `FeatureDb` object containing promoter annotations derived from FANTOM4 CAGE (Cap Analysis Gene Expression) data in THP-1 cells. While originally mapped to hg18, this package provides the coordinates lifted over to the hg19 (GRCh37) assembly. It is primarily used for genomic annotation, overlapping experimental data with known transcription start sites (TSS), and analyzing promoter-specific features like CpG ratios.

## Core Workflows

### Loading the Database
To access the promoter data, load the library and reference the primary object:
```r
library(FDb.FANTOM4.promoters.hg19)

# View object summary
FDb.FANTOM4.promoters.hg19
```

### Extracting Promoter Features
The data is stored as a `FeatureDb` object. Use the `features()` function to convert it into a `GRanges` object for standard genomic analysis:
```r
# Extract all features
fantom_promoters <- features(FDb.FANTOM4.promoters.hg19)

# Assign genome information to prevent assembly mismatch errors
met <- metadata(FDb.FANTOM4.promoters.hg19)
genome_val <- met[which(met[,'name'] == 'Genome'), 'value']
genome(fantom_promoters) <- genome_val
```

### Analyzing CpG Content
The package includes pre-calculated observed/expected CpG ratios (oecg) within 3kb windows around the promoters.
```r
# Access CpG ratio metadata
# Note: Values may need conversion to numeric after extraction
cpg_ratios <- as.numeric(values(fantom_promoters)$oecg)

# Visualize the distribution
hist(cpg_ratios, breaks=200, 
     xlab='Observed/expected CpG content (hg19)', 
     main='FANTOM4 Promoter CpG Content')
```

### LiftOver Utilities
The package includes the chain file used for the hg18 to hg19 conversion, which can be accessed directly if needed for related liftOver tasks:
```r
data(hg18ToHg19)
hg18ToHg19
```

## Usage Tips
- **FeatureDb Interface**: Since this package uses the `FeatureDb` class, you can use standard methods from the `GenomicFeatures` and `AnnotationDbi` packages to query it.
- **THP-1 Specificity**: Remember that these promoters are specifically derived from FANTOM4 CAGE data in THP-1 (human myeloid leukemia) cells; they may not represent all promoters active in other cell types.
- **Metadata**: Always check the `metadata(FDb.FANTOM4.promoters.hg19)` to confirm versioning and source information before merging with other datasets.

## Reference documentation
- [FDb.FANTOM4.promoters.hg19 Reference Manual](./references/reference_manual.md)