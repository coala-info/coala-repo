---
name: bioconductor-ensdb.hsapiens.v75
description: This package provides Ensembl release 75 genome annotations for Homo sapiens based on the GRCh37/hg19 assembly. Use when user asks to retrieve gene, transcript, or exon metadata, filter genomic features by coordinates, or map between Ensembl identifiers and gene symbols.
homepage: https://bioconductor.org/packages/release/data/annotation/html/EnsDb.Hsapiens.v75.html
---

# bioconductor-ensdb.hsapiens.v75

name: bioconductor-ensdb.hsapiens.v75
description: Provides Ensembl-based genome annotations for Homo sapiens (human) based on Ensembl release 75 (GRCh37/hg19). Use this skill when you need to retrieve gene, transcript, exon, or protein metadata, genomic coordinates, or mapping between different identifiers for the human genome using the ensembldb framework.

# bioconductor-ensdb.hsapiens.v75

## Overview

The `EnsDb.Hsapiens.v75` package is a Bioconductor annotation data package containing a local SQLite database of Ensembl release 75 annotations for *Homo sapiens*. It is designed to be used with the `ensembldb` package to perform complex genomic queries, filter annotations, and map between various genomic features.

## Core Usage

### Loading the Database
To use the annotations, load the package. The database object itself is named `EnsDb.Hsapiens.v75`.

```r
library(EnsDb.Hsapiens.v75)
# View database metadata
EnsDb.Hsapiens.v75
```

### Common Workflows

The package relies on the `ensembldb` API. Common tasks include:

1.  **Retrieving Genes or Transcripts**:
    ```r
    # Get all genes as a GRanges object
    gns <- genes(EnsDb.Hsapiens.v75)

    # Get transcripts for a specific gene
    txs <- transcripts(EnsDb.Hsapiens.v75, filter = GeneNameFilter("BRCA1"))
    ```

2.  **Filtering Data**:
    Use filters to narrow down results by chromosome, symbol, or biotype.
    ```r
    # Filter for protein coding genes on chromosome Y
    filters <- ~ seq_name == "Y" & gene_biotype == "protein_coding"
    y_genes <- genes(EnsDb.Hsapiens.v75, filter = filters)
    ```

3.  **Mapping Identifiers**:
    Convert between Ensembl IDs, Gene Symbols, and Entrez IDs.
    ```r
    select(EnsDb.Hsapiens.v75, 
           keys = "BRCA1", 
           keytype = "GENENAME", 
           columns = c("GENEID", "SEQNAME", "GENEBIOTYPE"))
    ```

4.  **Extracting Genomic Features**:
    Retrieve exons or CDS grouped by gene or transcript.
    ```r
    # Get exons grouped by gene
    exns <- exonsBy(EnsDb.Hsapiens.v75, by = "gene")
    ```

## Tips and Best Practices

- **Version Awareness**: This package uses Ensembl release 75, which corresponds to the **GRCh37 (hg19)** genome assembly. Do not use this for GRCh38 coordinates.
- **Filter Syntax**: You can use either the object-oriented filter classes (e.g., `GeneNameFilter("ALB")`) or the formula-based syntax (e.g., `~ genename == "ALB"`).
- **Coordinate System**: Always verify that your input data (e.g., BAM files or SNP lists) matches the GRCh37 coordinate system used by this database.
- **Integration**: This object is compatible with other Bioconductor tools like `Gviz` for visualization or `AnnotationDbi` for general querying.

## Reference documentation

- [EnsDb.Hsapiens.v75 Reference Manual](./references/reference_manual.md)