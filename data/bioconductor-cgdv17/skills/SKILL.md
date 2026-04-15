---
name: bioconductor-cgdv17
description: This tool provides access and analysis tools for the Complete Genomics Diversity panel variant calls on chromosome 17. Use when user asks to access VCF data for diverse human populations, filter variants by quality, count variants in specific genomic regions, or integrate variant data with gene annotations.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/cgdv17.html
---

# bioconductor-cgdv17

name: bioconductor-cgdv17
description: Analysis and exploration of the Complete Genomics Diversity panel for chromosome 17. Use this skill to access variant calls (VCF data), population metadata, and structural variation for 46 individuals across 11 human populations. It is particularly useful for filtering variants by quality, counting variants in specific genomic regions (e.g., near genes like ORMDL3), and integrating variant data with expression sets.

# bioconductor-cgdv17

## Overview
The `cgdv17` package provides a subset of the Complete Genomics Diversity panel, specifically focusing on variant calls for chromosome 17. It includes data for 46 individuals from diverse populations (ASW, CEU, CHB, GIH, JPT, LWK, MKK, MXL, TSI, YRI). The package uses a `raggedVariantSet` container to manage high-depth sequencing data and provides tools to filter variants by quality and genomic location.

## Core Workflows

### Loading Data and Population Metadata
To begin, load the package and the population vector to identify sample origins.
```r
library(cgdv17)
data(popvec)
table(popvec) # View distribution across populations (e.g., ASW, CEU, YRI)
```

### Accessing Variant Data
The package uses `getRVS` to obtain a reference to the serialized variant data.
```r
# Get the raggedVariantSet instance
rv = getRVS("cgdv17")

# Extract data for a specific individual (e.g., NA06985)
R85 = getrd(rv, "NA06985")

# Filter by quality (QUAL)
# High quality variants are typically those in the top quartile (e.g., >= 166)
R85hiq = R85[elementMetadata(R85)$QUAL >= 166]
```

### Regional Variant Analysis
You can count or extract variants within specific genomic coordinates, such as the vicinity of a gene.

```r
# Define a region (e.g., 50kb upstream of a TSS on chr17)
library(GenomicRanges)
region = GRanges("chr17", IRanges(start=38087429, width=50000))

# Count variants across multiple samples with a quality threshold
# Use lapply or mclapply for parallel processing
counts = countVariants(rv, region, minQual=160, lapply)

# Retrieve full GRanges for variants in the region
variants_list = variantGRanges(rv, region, minQual=160, lapply)
```

### Structural Context and Annotation
Integrate with `VariantAnnotation` and `TxDb` packages to determine if variants are intronic, exonic, or in UTRs.

```r
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
tx19 = TxDb.Hsapiens.UCSC.hg19.knownGene

# Locate variants in structural contexts
mycache = new.env(hash=TRUE)
locs = locateVariants(R85hiq, tx19, AllVariants(), cache=mycache)
table(locs$LOCATION)
```

## Data Structures
- **popvec**: A named character vector mapping sample IDs to population codes.
- **h1**: A sample VCF header object providing metadata on the sequencing and conversion process.
- **raggedVariantSet**: The primary container for the 46 individuals' chromosome 17 data.

## Tips
- **Phasing**: Phasing information is stored in the `geno` column of the elementMetadata (e.g., `1|0` for phased, `1/0` for unphased).
- **Sample Filtering**: If integrating with expression data (like the `CY17` smlSet), ensure you subset the `raggedVariantSet` to matching sample names: `rv_subset = rv[, sample_names]`.
- **Quality Control**: Always check the distribution of `QUAL` scores. Some samples may have significantly lower variant counts due to quality issues and should be excluded from downstream analysis.

## Reference documentation
- [Exploring the Complete Genomics Diversity panel](./references/cgdv.md)