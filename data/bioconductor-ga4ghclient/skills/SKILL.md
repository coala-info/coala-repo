---
name: bioconductor-ga4ghclient
description: This tool provides an R interface to access and analyze genomic data from GA4GH-compliant servers. Use when user asks to search for datasets, query variants by genomic coordinates, or retrieve genotype data from public genomic APIs.
homepage: https://bioconductor.org/packages/release/bioc/html/GA4GHclient.html
---


# bioconductor-ga4ghclient

name: bioconductor-ga4ghclient
description: Access and analyze genomic data from Global Alliance for Genomics and Health (GA4GH) compliant servers. Use this skill to search for datasets, reference genomes, variants, and reads from public APIs (like 1000 Genomes or Ensembl) and convert them into tidy R data frames or Bioconductor S4 objects (VCF, GRanges).

## Overview

The `GA4GHclient` package provides an R interface to the GA4GH Genomics API. It allows researchers to query large-scale genomic databases without downloading entire experiments. The package automatically converts API responses into standard Bioconductor objects like `VCF` (from `VariantAnnotation`) or `DataFrame` (from `S4Vectors`), facilitating downstream analysis with existing Bioconductor tools.

## Core Workflow

### 1. Setup and Connection
Define the host URL of the GA4GH server you wish to query.

```r
library(GA4GHclient)
host <- "http://1kgenomes.ga4gh.org/"
```

### 2. Discovery (Datasets and Variant Sets)
Before querying specific variants, you must identify the `datasetId` and `variantSetId`.

```r
# Find available datasets
datasets <- searchDatasets(host, nrows = 1)
datasetId <- datasets$id

# Find variant sets (equivalent to VCF files) within a dataset
variantSets <- searchVariantSets(host, datasetId, nrows = 1)
variantSetId <- variantSets$id
```

### 3. Searching Variants
You can search for variants by genomic coordinates. By default, these return `VCF` objects.

```r
# Search by coordinates (1-based indexing)
variants <- searchVariants(host, variantSetId, 
                           referenceName = "1", 
                           start = 15000, 
                           end = 16000, 
                           nrows = 10)

# To get a simple data frame instead of a VCF object:
variants_df <- searchVariants(host, variantSetId, 
                              referenceName = "1", 
                              start = 15000, 
                              end = 16000, 
                              asVCF = FALSE)
```

### 4. Integration with Annotation Objects
Use `GRanges` to query variants for specific genes using Bioconductor annotation packages.

```r
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(GenomeInfoDb)

# Get coordinates for a gene (e.g., SCN1A)
gene_id <- select(org.Hs.eg.db, keys = "SCN1A", keytype = "SYMBOL", columns = "ENTREZID")$ENTREZID
gr <- genes(TxDb.Hsapiens.UCSC.hg19.knownGene, filter = list(gene_id = gene_id))

# Match seqlevels style to the server (usually NCBI for 1kGenomes)
seqlevelsStyle(gr) <- "NCBI"

# Search using the GRanges object
variants_gene <- searchVariantsByGRanges(host, variantSetId, gr)
```

### 5. Retrieving Genotypes (CallSets)
To get sample-specific genotype data (the `GT` field), you must specify `callSetIds`.

```r
# Get IDs for the first 5 samples
callSetIds <- searchCallSets(host, variantSetId, nrows = 5)$id

# Query variants including genotype calls for those samples
vcf <- searchVariants(host, variantSetId, 
                      referenceName = "1", 
                      start = 15000, 
                      end = 16000, 
                      callSetIds = callSetIds)

# Access genotypes
geno(vcf)$GT
```

## Key Functions Reference

| Category | Functions |
| --- | --- |
| **Metadata** | `searchDatasets`, `searchReferenceSets`, `searchReferences` |
| **Variants** | `searchVariantSets`, `searchVariants`, `searchVariantsByGRanges`, `getVariant` |
| **Samples** | `searchCallSets`, `getCallSet`, `searchBiosamples`, `searchIndividuals` |
| **Reads** | `searchReadGroupSets`, `searchReads` |
| **Sequence** | `listReferenceBases` |
| **Expression** | `searchRnaQuantifications`, `searchExpressionLevels` |

## Tips and Best Practices

- **Coordinate Systems**: R uses 1-based indexing. Ensure your `start` and `end` parameters align with the server's reference genome version (e.g., hg19/NCBI37 vs hg38).
- **Response Size**: If queries are slow or timing out, adjust the `responseSize` parameter to control how many records are fetched per API call.
- **VCF Conversion**: Use `asVCF = TRUE` (default) when you plan to use `VariantAnnotation` methods like `locateVariants` or `predictCoding`. Use `asVCF = FALSE` for quick data exploration in tidy formats.
- **Reference Genomes**: Always check the reference genome name using `searchReferenceSets(host)` to ensure compatibility with your `TxDb` or `OrgDb` objects.

## Reference documentation
- [GA4GHclient Vignette (Rmd)](./references/GA4GHclient.Rmd)
- [GA4GHclient Vignette (Markdown)](./references/GA4GHclient.md)