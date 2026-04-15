---
name: bioconductor-atena
description: The atena package quantifies transposable element expression from sequencing data using specialized alignment and filtering methods. Use when user asks to quantify transposable element expression, fetch and parse RepeatMasker annotations, reconstruct fragmented TE insertions, or apply ERVmap, Telescope, and TEtranscripts quantification methods.
homepage: https://bioconductor.org/packages/release/bioc/html/atena.html
---

# bioconductor-atena

## Overview

The `atena` package provides a Bioconductor-native implementation of three popular methods for quantifying transposable element (TE) expression: **ERVmap**, **Telescope**, and **TEtranscripts**. It addresses the challenge of multi-mapping reads—common in repetitive TE sequences—by providing specialized EM algorithms and filtering strategies. The package also includes robust tools for fetching and parsing RepeatMasker annotations to reconstruct fragmented TE insertions into functional units.

## TE Annotations

### Retrieving and Parsing
Use `annotaTEs()` to fetch RepeatMasker data. The `parsefun` argument determines how fragments are handled:
- `rmskidentity`: No modification.
- `rmskbasicparser`: Filters non-TEs and assigns unique IDs by repeat name.
- `rmskatenaparser`: (Recommended) Fast reconstruction of fragmented TEs and LTR structures.
- `OneCodeToFindThemAll`: Comprehensive algorithm for merging fragments based on distance and identity.

```r
library(atena)
# Fetch and parse dm6 annotations
te_ann <- annotaTEs(genome="dm6", parsefun=rmskatenaparser, BPPARAM=SerialParam())
```

### Filtering by Class
Specific functions extract TEs by class and relative length (completeness compared to consensus):
- `getLINEs(te_ann, relLength=0.9)`
- `getLTRs(te_ann, relLength=0.8, fullLength=TRUE)`
- `getDNAtransposons(te_ann)`
- `getSINEs(te_ann)`

## Expression Quantification Workflow

Quantification follows a two-step pattern: building a parameter object and calling `qtex()`.

### 1. Build Parameter Object
Choose the method based on your research needs:

**ERVmap (Filtering-based)**
Best for high-confidence alignments. It filters reads based on alignment scores and edit distance.
```r
empar <- ERVmapParam(bamfiles, teFeatures=te_ann, singleEnd=TRUE, ignoreStrand=TRUE)
```

**Telescope (EM-based)**
Uses a Bayesian EM algorithm to reassign multi-mapping reads to the most likely locus.
```r
tspar <- TelescopeParam(bamfiles, teFeatures=te_ann, singleEnd=TRUE)
```

**TEtranscripts (EM-based)**
Reassigns multi-mapping reads proportionally to relative abundance. Often used for subfamily-level quantification.
```r
ttpar <- TEtranscriptsParam(bamfiles, teFeatures=te_ann, geneFeatures=gannot, aggregateby="repName")
```

### 2. Run Quantification
The `qtex()` function executes the quantification and returns a `SummarizedExperiment`.

```r
se <- qtex(tspar)
# Access counts
counts <- assay(se)
# Access feature metadata (Status, RelLength, Class)
meta <- rowData(se)
```

## Key Parameters and Tips

- **Multi-mapping Info**: For gene/TE integration, BAM files must contain secondary alignments or the `NH` tag.
- **Paired-end Data**: Set `singleEnd=FALSE`. Use `fragments=TRUE` to treat mates independently (ERVmap style) or `fragments=FALSE` to count pairs once.
- **Strandedness**: Use `ignoreStrand=FALSE` for stranded protocols.
- **Aggregation**: Use the `aggregateby` argument in Param constructors to group counts by `repName` (subfamily), `repClass`, or custom columns.
- **Parallelization**: Most functions support `BPPARAM` from the `BiocParallel` package to speed up processing of large BAM files.

## Reference documentation

- [An introduction to the atena package](./references/atena.md)