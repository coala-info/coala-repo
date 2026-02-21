---
name: bioconductor-gwascat
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gwascat.html
---

# bioconductor-gwascat

name: bioconductor-gwascat
description: Use when Claude needs to query, analyze, or visualize the NHGRI-EBI GWAS catalog in R. This skill provides methods for fetching the latest GWAS data, filtering by traits or genomic regions, mapping to ontologies (Disease Ontology, EFO), and calculating risk allele counts.

## Overview
The `gwascat` package provides tools for managing and querying the NHGRI-EBI GWAS catalog. It represents GWAS associations as `GRanges` objects, allowing for seamless integration with other Bioconductor genomic analysis workflows.

## Core Workflows

### 1. Data Acquisition
The package provides access to both legacy snapshots and the live EBI catalog.

```r
library(gwascat)

# Get the most recent version from EBI (cached via BiocFileCache)
gwcat <- get_cached_gwascat()

# Convert to a tidy GRanges object
gg <- as_GRanges(gwcat)

# Load a legacy snapshot (e.g., April 2020)
data(ebicat_2020_04_30)
gwtrunc <- ebicat_2020_04_30
```

### 2. Querying and Filtering
Filter the catalog by traits, SNPs, or genomic locations.

```r
# Find most frequent traits
topTraits(gwtrunc)

# Subset by specific trait
ldl_hits <- subsetByTraits(gwtrunc, tr = "LDL cholesterol")

# Subset by SNP RSIDs
rsids <- c("rs12670798", "rs3846662")
subset_snps <- gwtrunc[intersect(getRsids(gwtrunc), rsids)]

# Subset by genomic region (e.g., Chromosome 17)
chr17_hits <- subsetByChromosome(gwtrunc, ch = "17")
```

### 3. Visualization
Generate Manhattan plots or integrate with Gviz for genomic context.

```r
# Basic Manhattan plot for specific traits
traitsManh(gwtrunc, traits = c("Height", "Body mass index"))

# Convert GWAS catalog data for Gviz tracking
# g2 is a GRanges defining the region of interest
# basic <- gwcex2gviz(basegr = gwtrunc, contextGR = g2)
```

### 4. Risk Allele Counting
Calculate the number of risk alleles in a genotype matrix.

```r
# gg17N is a matrix of genotypes (rows=samples, cols=SNPs)
# gwwl is the GWAS catalog object
counts <- riskyAlleleCount(gg17N, matIsAB = FALSE, chr = "ch17", gwwl = gwtrunc)
```

### 5. Ontology Mapping
The catalog includes mappings to the Experimental Factor Ontology (EFO). You can also map to Disease Ontology (DO) or Human Phenotype Ontology (HPO).

```r
# Access EFO graph data
data(efo.obo.g)

# Filter catalog by EFO mapped traits
autoimmune_hits <- gwtrunc[grep("autoimmune", gwtrunc$MAPPED_TRAIT)]
```

## Tips and Best Practices
- **Coordinate Systems**: By default, recent EBI downloads use GRCh38. Always verify the genome build using `genome(gg)` before overlapping with other datasets.
- **Standard Chromosomes**: Use `GenomeInfoDb::keepStandardChromosomes` to remove non-standard contigs often found in raw GWAS downloads.
- **Tidy Methods**: As of 2022, `gwascat` supports `dplyr` verbs (like `arrange`, `filter`) directly on the object returned by `get_cached_gwascat()`.
- **CADD Scores**: Use `bindcadd_snv()` to retrieve pathogenicity scores for specific variants, though this requires an active network connection.

## Reference documentation
- [gwascat: structuring and querying the NHGRI GWAS catalog](./references/gwascat.md)
- [GWAS catalog: Phenotypes systematized by the experimental factor ontology](./references/gwascatOnt.md)