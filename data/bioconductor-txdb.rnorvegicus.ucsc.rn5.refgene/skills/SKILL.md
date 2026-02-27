---
name: bioconductor-txdb.rnorvegicus.ucsc.rn5.refgene
description: This package provides genomic annotation data for the Rattus norvegicus rn5 genome build using the UCSC refGene track. Use when user asks to retrieve rat gene models, extract transcript or exon coordinates, or access CDS and promoter locations for genomic analysis in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Rnorvegicus.UCSC.rn5.refGene.html
---


# bioconductor-txdb.rnorvegicus.ucsc.rn5.refgene

name: bioconductor-txdb.rnorvegicus.ucsc.rn5.refgene
description: Provides genomic annotation data for Rattus norvegicus (Rat) based on the UCSC rn5 genome build and the refGene track. Use this skill when an AI agent needs to retrieve gene models, transcripts, exons, or CDS locations for rat genomic analysis in R.

# bioconductor-txdb.rnorvegicus.ucsc.rn5.refgene

## Overview
This skill provides guidance on using the `TxDb.Rnorvegicus.UCSC.rn5.refGene` Bioconductor annotation package. This package contains a `TxDb` (Transcript Database) object which serves as an R interface to a prefabricated database of rat genomic features. It is specifically built from the UCSC `rn5` genome assembly using the `refGene` track data.

## Basic Usage

### Loading the Package
To access the annotation object, load the library:
```r
library(TxDb.Rnorvegicus.UCSC.rn5.refGene)
```

### Accessing the TxDb Object
The primary object is named identically to the package:
```r
txdb <- TxDb.Rnorvegicus.UCSC.rn5.refGene
txdb
```

### Common Data Extraction Workflows
The object is compatible with the `GenomicFeatures` framework. Common operations include:

1.  **Extracting all transcripts:**
    ```r
    library(GenomicFeatures)
    all_transcripts <- transcripts(txdb)
    ```

2.  **Extracting features grouped by gene:**
    ```r
    # Get exons grouped by gene ID
    exons_by_gene <- exonsBy(txdb, by = "gene")
    
    # Get transcripts grouped by gene ID
    tx_by_gene <- transcriptsBy(txdb, by = "gene")
    ```

3.  **Extracting CDS or Promoters:**
    ```r
    all_cds <- cds(txdb)
    all_promoters <- promoters(txdb, upstream = 2000, downstream = 400)
    ```

4.  **Filtering by Chromosome:**
    ```r
    # Restrict to a specific chromosome to save memory/time
    seqlevels(txdb) <- "chr1"
    chr1_genes <- genes(txdb)
    # Reset levels
    restoreSeqlevels(txdb)
    ```

## Tips and Best Practices
- **Object Inspection:** Use `columns(txdb)` to see available metadata fields and `keytypes(txdb)` to see what identifiers (like GENEID or TXNAME) can be used for lookups.
- **Integration:** This package is often used in conjunction with `org.Rn.eg.db` to map RefSeq/UCSC IDs to Gene Symbols or Entrez IDs.
- **Coordinate System:** Ensure your experimental data (e.g., BAM files or GRanges) is also based on the `rn5` assembly to avoid coordinate mismatches.

## Reference documentation
- [TxDb.Rnorvegicus.UCSC.rn5.refGene Reference Manual](./references/reference_manual.md)