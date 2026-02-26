---
name: bioconductor-ensdb.mmusculus.v79
description: This package provides Ensembl-based genome annotations for Mus musculus using the version 79 database. Use when user asks to retrieve mouse gene annotations, fetch genomic coordinates for transcripts or exons, or map between Ensembl IDs and gene symbols.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EnsDb.Mmusculus.v79.html
---


# bioconductor-ensdb.mmusculus.v79

name: bioconductor-ensdb.mmusculus.v79
description: Provides Ensembl-based genome annotations for Mus musculus (mouse) using the Ensembl version 79 database. Use this skill when you need to retrieve gene, transcript, exon, or genomic coordinate information for mouse (mm10/GRCm38) within an R/Bioconductor environment.

# bioconductor-ensdb.mmusculus.v79

## Overview
The `EnsDb.Mmusculus.v79` package is a data-specific annotation package providing an interface to Ensembl version 79 for *Mus musculus*. It uses the `ensembldb` framework to allow users to query genomic features, map between different identifiers (e.g., Gene IDs to symbols), and fetch coordinates for genomic regions.

## Basic Usage

### Loading the Package
To use the database, load the library. The database object itself is named `EnsDb.Mmusculus.v79`.

```r
library(EnsDb.Mmusculus.v79)
# View database metadata
EnsDb.Mmusculus.v79
```

### Common Queries
Since this package is an `EnsDb` object, you use functions from the `ensembldb` package to interact with it.

**1. List all genes:**
```r
gns <- genes(EnsDb.Mmusculus.v79)
head(gns)
```

**2. Get transcripts for a specific gene:**
```r
txs <- transcripts(EnsDb.Mmusculus.v79, filter = GeneNameFilter("Id2"))
```

**3. Convert Ensembl IDs to Gene Symbols:**
```r
select(EnsDb.Mmusculus.v79, 
       keys = c("ENSMUSG00000025902"), 
       columns = c("SYMBOL", "GENEBIOTYPE"), 
       keytype = "GENEID")
```

## Filtering Data
The package supports complex queries using filters. Common filters include `GeneNameFilter`, `SymbolFilter`, `SeqNameFilter`, and `TxBiotypeFilter`.

```r
# Get all protein coding genes on Chromosome 11
filters <- AnnotationFilterList(
    SeqNameFilter("11"),
    GeneBiotypeFilter("protein_coding")
)
pc_genes_chr11 <- genes(EnsDb.Mmusculus.v79, filter = filters)
```

## Integration with Other Bioconductor Objects
You can easily extract information as `GRanges` objects for use in downstream bioinformatics workflows (like RNA-seq or ChIP-seq analysis).

```r
# Get promoter regions (2kb upstream of TSS)
proms <- promoters(EnsDb.Mmusculus.v79, upstream = 2000, downstream = 200)
```

## Tips
- **Version Consistency:** This package is based on Ensembl 79 (GRCm38/mm10). Ensure your alignment/mapping coordinates match this assembly.
- **Functionality:** Most "workhorse" functions (like `genes()`, `transcripts()`, `exonsBy()`) are actually defined in the `ensembldb` package; `EnsDb.Mmusculus.v79` provides the data container.
- **Discovery:** Use `listColumns(EnsDb.Mmusculus.v79)` to see all available data fields you can retrieve.

## Reference documentation
- [EnsDb.Mmusculus.v79 Reference Manual](./references/reference_manual.md)