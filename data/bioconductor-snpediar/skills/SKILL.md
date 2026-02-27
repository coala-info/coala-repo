---
name: bioconductor-snpediar
description: This package provides an interface to download and parse SNP, genotype, and medical condition data from the SNPedia wiki. Use when user asks to fetch SNP metadata, extract clinical significance for specific genotypes, or browse genetic information related to medical conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/SNPediaR.html
---


# bioconductor-snpediar

name: bioconductor-snpediar
description: Interface with SNPedia to download and parse SNP, genotype, and medical condition data. Use when the user needs to retrieve curated genetic information, associated diseases, or genotype-specific magnitudes and repute from the SNPedia wiki via the MediaWiki API.

## Overview

SNPediaR provides tools to programmatically search, download, and parse content from SNPedia, a curated database of single-nucleotide polymorphisms (SNPs). It allows users to retrieve structured metadata from wiki pages, including genomic coordinates, associated genes, and the clinical significance (repute/magnitude) of specific genotypes.

## Package Installation and Loading

To use the package, ensure it is installed via BiocManager and load it:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SNPediaR")
library(SNPediaR)
```

## Core Workflows

### Downloading SNP and Genotype Pages

Use `getPages()` to fetch the raw wiki text for specific SNPs or genotypes.

*   **Fetch a SNP page**: `pg <- getPages(titles = "Rs53576")`
*   **Fetch multiple genotype pages**: `pgs <- getPages(titles = c("Rs53576(A;A)", "Rs53576(A;G)"))`

### Extracting Structured Information

SNPedia pages contain "tabular" metadata. Use specific extraction functions to parse this into R objects.

*   **Parse SNP metadata**: `extractSnpTags(pg$Rs53576)`
    *   Returns: Chromosome, position, GMAF, associated gene, and summary.
*   **Parse Genotype metadata**: `sapply(pgs, extractGenotypeTags)`
    *   Returns: Alleles, magnitude (clinical importance), repute (Good/Bad), and summary.

### Streamlined Download and Parse

You can pass a parsing function directly into `getPages` to process data during the download:

```r
# Extract specific tags for multiple genotypes in one call
getPages(titles = c("Rs53576(A;A)", "Rs53576(A;G)"),
         wikiParseFunction = extractGenotypeTags,
         tags = c("allele1", "allele2", "magnitude"))
```

### Exploring Categories

SNPedia organizes pages into categories. Use `getCategoryElements()` to discover SNPs related to specific topics or conditions.

*   **List medical conditions**: `conds <- getCategoryElements(category = "Is_a_medical_condition")`
*   **Filter for specific terms**: `grep("cancer", conds, value = TRUE)`

Common categories include:
*   `Is_a_snp`
*   `Is_a_genotype`
*   `Is_a_medical_condition`
*   `Is_a_medicine`
*   `Is_a_topic`

### Custom Parsing

If the built-in tag extractors do not meet your needs, define a custom function to process the raw wiki text:

```r
# Example: Extracting PubMed IDs
findPMID <- function(x) {
    lines <- unlist(strsplit(x, split = "\n"))
    grep("PMID=", lines, value = TRUE)
}

getPages(titles = "Rs53576", wikiParseFunction = findPMID)
```

## Tips and Best Practices

*   **Title Formatting**: SNP titles usually start with a capital 'R' (e.g., "Rs53576"). Genotype titles follow the format "RsID(Allele1;Allele2)".
*   **API Limits**: When downloading large numbers of pages, `getPages` handles the MediaWiki API batching, but be mindful of network latency.
*   **Data Cleaning**: The output of `extractSnpTags` and `extractGenotypeTags` often contains character strings. Convert columns like `magnitude` or `position` to numeric if performing calculations.

## Reference documentation

- [SNPediaR](./references/SNPediaR.Rmd)
- [SNPediaR](./references/SNPediaR.md)