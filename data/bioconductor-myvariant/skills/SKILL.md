---
name: bioconductor-myvariant
description: This R package provides an interface to the MyVariant.info services for querying and retrieving comprehensive genetic variant annotations. Use when user asks to annotate variants using HGVS IDs or rsIDs, perform batch variant lookups, or search for variants based on specific genomic features like CADD scores or ClinVar status.
homepage: https://bioconductor.org/packages/release/bioc/html/myvariant.html
---


# bioconductor-myvariant

name: bioconductor-myvariant
description: Access MyVariant.info services to query and retrieve genetic variant annotations. Use this skill when you need to annotate genetic variants using HGVS IDs or rsIDs, perform batch variant lookups, or search for variants based on specific genomic features (e.g., CADD scores, ClinVar status, or gene names) within an R environment.

## Overview

The `myvariant` package is an R client for the MyVariant.info REST web service. It allows users to retrieve high-throughput variant annotations from a wide array of aggregated resources (like CADD, dbNSFP, ClinVar, and dbSNP). The workflow typically involves converting variant data (often from VCF files) into HGVS identifiers and then querying the MyVariant.info API for detailed functional annotations.

## Core Workflows

### 1. Converting VCF to HGVS IDs
To query MyVariant.info, variants must be in HGVS format (e.g., `chr1:g.35367G>A`). You can use the `VariantAnnotation` package to read VCFs and `myvariant` to format them.

```r
library(myvariant)
library(VariantAnnotation)

# Read VCF
vcf_file <- system.file("extdata", "dbsnp_mini.vcf", package="myvariant")
vcf <- readVcf(vcf_file, genome="hg19")

# Convert to HGVS IDs (supports 'snp', 'ins', 'del', 'delins')
hgvs_ids <- formatHgvs(vcf, variant_type="snp")
```

### 2. Retrieving Annotations (Annotation Service)
Use `getVariant` for single lookups and `getVariants` for batch processing.

```r
# Single variant lookup
variant <- getVariant("chr1:g.35367G>A")
# Access specific fields (e.g., CADD phred score)
variant[[1]]$cadd$phred

# Batch lookup with specific fields
hgvs_list <- c("chr1:g.35367G>A", "chr16:g.28883241A>G")
res <- getVariants(hgvs_list, fields="cadd.consequence")
```

### 3. Searching for Variants (Query Service)
Use `queryVariant` to search for variants matching specific criteria using a Lucene-style query string.

```r
# Search by gene name and return specific fields
queryVariant(q="dbnsfp.genename:MLL2", fields=c("cadd.phred", "cadd.consequence"))

# Search by rsID
queryVariant(q="rs58991260", fields="dbsnp.flags")
```

### 4. Batch Querying by rsID
If you have a list of rsIDs, use `queryVariants` with the `scopes` parameter set to `dbsnp.rsid`.

```r
rsids <- c("rs62651026", "rs376007522")
res <- queryVariants(q=rsids, scopes="dbsnp.rsid", fields="all")

# Filter results (e.g., variants documented in the Wellderly study)
wellderly_variants <- subset(res, !is.na(wellderly.vartype))
```

## Tips and Best Practices
- **Field Selection**: Use the `fields` argument to limit the data returned. This significantly improves performance and reduces memory usage. Use `fields="all"` only when necessary.
- **Reference Genome**: Currently, HGVS IDs are primarily based on GRCh38/hg19. Ensure your VCF coordinates match the expected reference.
- **Handling Missing Data**: When performing batch queries, use `returnall=TRUE` in `getVariants` or `queryVariants` to receive a list containing successful hits, as well as missing or duplicate terms.
- **Large Queries**: For very large lists of variants, the POST-based functions (`getVariants`, `queryVariants`) are more efficient than individual GET requests.

## Reference documentation
- [MyVariant.info R Client](./references/myvariant.md)