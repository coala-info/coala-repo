---
name: bioconductor-txdb.mmulatta.ucsc.rhemac8.refgene
description: This package provides a Bioconductor TxDb annotation object for the Macaca mulatta (Rhesus monkey) genome based on the UCSC rheMac8 build and refGene track. Use when user asks to retrieve genomic coordinates for transcripts, exons, CDS, or genes, or group genomic features by gene for Rhesus macaque research.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Mmulatta.UCSC.rheMac8.refGene.html
---

# bioconductor-txdb.mmulatta.ucsc.rhemac8.refgene

name: bioconductor-txdb.mmulatta.ucsc.rhemac8.refgene
description: Provides the TxDb annotation object for Macaca mulatta (Rhesus monkey) based on the UCSC rheMac8 genome build and the refGene track. Use this skill when an AI agent needs to retrieve genomic coordinates for transcripts, exons, CDS, or genes for Rhesus macaque research using Bioconductor.

# bioconductor-txdb.mmulatta.ucsc.rhemac8.refgene

## Overview
This skill facilitates the use of the `TxDb.Mmulatta.UCSC.rheMac8.refGene` R package. This is a standard Bioconductor annotation package that exposes a `TxDb` (Transcript Database) object. It provides a structured interface to the RefSeq gene annotations for the `rheMac8` assembly of the Rhesus monkey genome.

## Basic Usage

### Loading the Package
To access the annotation object, load the library in R:
```r
library(TxDb.Mmulatta.UCSC.rheMac8.refGene)
```

### Accessing the TxDb Object
The package automatically creates an object with the same name as the package. You can inspect its metadata and genome build:
```r
txdb <- TxDb.Mmulatta.UCSC.rheMac8.refGene
txdb
```

### Common Data Extraction Workflows
Use standard `GenomicFeatures` functions to extract genomic ranges:

1.  **Extract all transcripts:**
    ```r
    tx <- transcripts(txdb)
    ```

2.  **Extract genes:**
    ```r
    gn <- genes(txdb)
    ```

3.  **Group features by gene:**
    ```r
    # Get all exons grouped by gene ID
    exons_by_gene <- exonsBy(txdb, by = "gene")

    # Get all transcripts grouped by gene ID
    tx_by_gene <- transcriptsBy(txdb, by = "gene")
    ```

4.  **Extract CDS (Coding Sequences):**
    ```r
    cds_ranges <- cds(txdb)
    ```

### Filtering and Selecting
You can use the `select`, `keys`, and `columns` methods (from the `AnnotationDbi` framework) to query specific data:
```r
# List available columns
columns(txdb)

# List available keytypes (e.g., GENEID, TXNAME)
keytypes(txdb)

# Query specific information for a set of gene IDs
keys_vec <- head(keys(txdb, keytype="GENEID"))
select(txdb, keys=keys_vec, columns=c("TXNAME", "TXSTRAND"), keytype="GENEID")
```

## Tips for Success
- **Coordinate System:** Ensure your experimental data (e.g., BAM or BED files) uses the `rheMac8` coordinate system to match this package.
- **Integration:** This package is designed to work seamlessly with `GenomicRanges` and `Gviz` for visualization and overlap analysis.
- **Naming Convention:** The object name is long; assigning it to a shorter variable like `txdb` is recommended for readability.

## Reference documentation
- [TxDb.Mmulatta.UCSC.rheMac8.refGene Reference Manual](./references/reference_manual.md)