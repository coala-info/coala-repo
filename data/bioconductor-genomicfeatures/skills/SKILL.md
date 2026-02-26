---
name: bioconductor-genomicfeatures
description: This tool manages and retrieves transcript-centric genomic annotations using TxDb objects. Use when user asks to load or create transcript databases, retrieve genomic coordinates for features like exons or promoters, group features by gene or transcript, map between genomic identifiers, or extract transcript sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicFeatures.html
---


# bioconductor-genomicfeatures

name: bioconductor-genomicfeatures
description: Comprehensive management and retrieval of transcript-centric genomic annotations using TxDb objects. Use when Claude needs to: (1) Load or create transcript databases (TxDb), (2) Retrieve genomic coordinates for exons, transcripts, CDS, or promoters as GRanges, (3) Group features by gene or transcript (GRangesList), (4) Map between different genomic identifiers (select/columns/keys), or (5) Extract transcript/CDS sequences from a BSgenome.

## Overview
The `GenomicFeatures` package provides a specialized SQLite-backed container called `TxDb` for storing and querying transcript metadata. It allows users to retrieve genomic coordinates for various features (UTRs, CDS, exons, transcripts) and maintains the biological relationships between them. It is a core component of the Bioconductor ecosystem for transcriptomics and genomic interval analysis.

## Core Workflows

### 1. Obtaining a TxDb Object
There are three primary ways to access transcript metadata:
*   **From a Bioconductor Annotation Package:**
    ```R
    library(TxDb.Hsapiens.UCSC.hg19.knownGene)
    txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
    ```
*   **From a local SQLite file:**
    ```R
    txdb <- loadDb("path/to/my_database.sqlite")
    ```
*   **Creating a new TxDb:** Use the `txdbmaker` package (the successor to internal `GenomicFeatures` making functions) to build objects from UCSC, Ensembl, or GFF/GTF files.

### 2. Filtering by Chromosome
To improve performance or focus on specific regions, use `seqlevels` to restrict the active chromosomes in the `TxDb` object:
```R
# View active levels
seqlevels(txdb)

# Restrict to chromosome 15
seqlevels(txdb) <- "chr15"

# Reset to original state
seqlevels(txdb) <- seqlevels0(txdb)
```

### 3. Data Retrieval with select()
`TxDb` objects support the standard `AnnotationDbi` interface for tabular data:
```R
# Check available columns and keytypes
columns(txdb)
keytypes(txdb)

# Map Gene IDs to Transcript Names
keys <- c("100033417", "100033420")
select(txdb, keys = keys, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

### 4. Retrieving Genomic Ranges (GRanges)
Use specific accessors to get coordinates. These functions return `GRanges` objects:
*   `transcripts(txdb, filter=NULL)`
*   `exons(txdb)`
*   `cds(txdb)`
*   `promoters(txdb, upstream=2000, downstream=400)`
*   `terminators(txdb, upstream=2000, downstream=400)`

### 5. Working with Grouped Features (GRangesList)
To maintain biological context (e.g., which exons belong to which transcript), use the `By` family of functions:
```R
# Group transcripts by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Group exons by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")

# Predefined convenience groupings
introns <- intronsByTranscript(txdb)
five_utrs <- fiveUTRsByTranscript(txdb)
three_utrs <- threeUTRsByTranscript(txdb)
```

### 6. Sequence Extraction
Pair a `TxDb` with a `BSgenome` object to extract actual DNA sequences:
```R
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19

# Extract all transcript sequences
tx_seqs <- extractTranscriptSeqs(genome, txdb, use.names=TRUE)

# Extract only CDS sequences (for meaningful translation)
cds_ranges <- cdsBy(txdb, by="tx", use.names=TRUE)
cds_seqs <- extractTranscriptSeqs(genome, cds_ranges)

# Translate to protein
proteins <- translate(cds_seqs)
```

## Tips and Best Practices
*   **Metadata:** Call the `txdb` object directly (e.g., typing `txdb` in the console) to see the data source, genome assembly (e.g., hg19), and organism.
*   **Coordinate Systems:** Always ensure the `BSgenome` version matches the `TxDb` version (e.g., both hg19 or both hg38) to avoid incorrect sequence extraction.
*   **Synthetic IDs:** If a data source lacks unique IDs for features, `GenomicFeatures` creates synthetic IDs. You can still map these back to original IDs using `select()`.
*   **Downstream Analysis:** The `GRanges` and `GRangesList` objects returned are designed for use with `findOverlaps` and `summarizeOverlaps` in the `GenomicRanges` and `GenomicAlignments` packages.

## Reference documentation
- [Obtaining and Utilizing TxDb Objects](./references/GenomicFeatures.md)