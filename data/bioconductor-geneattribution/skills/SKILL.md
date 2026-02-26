---
name: bioconductor-geneattribution
description: This tool identifies candidate genes associated with noncoding genetic variation by calculating posterior probabilities based on genomic distance and functional data. Use when user asks to prioritize genes at GWAS loci, calculate gene attribution probabilities, or incorporate eQTL and Hi-C data into gene mapping.
homepage: https://bioconductor.org/packages/release/bioc/html/geneAttribution.html
---


# bioconductor-geneattribution

name: bioconductor-geneattribution
description: Identification of candidate genes associated with noncoding genetic variation (e.g., GWAS loci). Use this skill to calculate posterior probabilities for genes likely to be causative at a specific genomic position based on distance (exponential decay) and optional empirical data (eQTLs, Hi-C).

## Overview

The `geneAttribution` package helps researchers prioritize candidate genes at genomic loci, typically following a Genome-Wide Association Study (GWAS). It models the likelihood of a gene being causative as a function of its distance from the variant (using an exponential distribution) and can incorporate functional genomic data (e.g., eQTLs or chromatin conformation) to weight these probabilities.

## Core Workflow

### 1. Define Gene Models
Before attributing genes, you must load gene coordinates. The `geneModels()` function defaults to GRCh38 (`TxDb.Hsapiens.UCSC.hg38.knownGene`).

```r
library(geneAttribution)

# Default: GRCh38
geneLocs <- geneModels()

# For hg19/GRCh37
# library(TxDb.Hsapiens.UCSC.hg19.knownGene)
# geneLocs <- geneModels(TxDb.Hsapiens.UCSC.hg19.knownGene)

# Optional: Filter by length or specific gene sets
# geneLocs <- geneModels(maxGeneLength = 500000, genesToInclude = c("GENE1", "GENE2"))
```

### 2. Basic Gene Attribution
Calculate probabilities based solely on distance to the locus.

```r
# geneAttribution(chromosome, position, geneModels)
pp <- geneAttribution("chr2", 127156000, geneLocs)
print(pp)
```

### 3. Incorporating Empirical Data
Enhance the model using BED files containing eQTLs, Hi-C interactions, or other functional links.

```r
# Load BED files (Chr, Start, End, Symbol, [Score])
# Weights multiply the likelihood if the locus falls within the BED region
empirical <- loadBed(c("path/to/hiC.bed", "path/to/eqtl.bed"), weights = c(2, 5))

# Run attribution with empirical weights
pp_weighted <- geneAttribution("chr2", 127156000, geneLocs, empirical)
```

## Function Reference

### geneAttribution() Parameters
- `lambda`: Decay parameter for distance (default: 7.61e-06). Smaller values favor closer genes more strongly.
- `maxDist`: Maximum distance from locus to consider a gene (default: 1,000,000 bp).
- `minPP`: Probability threshold. Genes below this are grouped as "Other" (default: 0.05). Set to 0 to see all genes.

### Retrieving Coordinates
To get the genomic ranges for the prioritized genes:
```r
# Match results back to the gene models
geneLocs[match(names(pp), geneLocs$symbol)]
```

## Tips and Best Practices
- **Genome Builds**: Ensure your input coordinates, `TxDb` object, and BED files all use the same assembly (e.g., all hg38 or all hg19).
- **Gene Symbols**: The package relies on gene symbols. Ensure the `symbol` column in your `geneModels` matches the symbols used in your empirical BED files.
- **Weighting**: A weight of 1 has no effect; weights > 1 increase the likelihood of a gene if the locus overlaps the provided region.

## Reference documentation
- [geneAttribution](./references/geneAttribution.md)