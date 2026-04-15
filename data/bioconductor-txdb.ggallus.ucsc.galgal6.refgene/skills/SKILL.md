---
name: bioconductor-txdb.ggallus.ucsc.galgal6.refgene
description: This package provides a Bioconductor TxDb object containing genomic coordinates for the Gallus gallus (chicken) galGal6 genome build based on the UCSC refGene track. Use when user asks to retrieve genomic coordinates for chicken transcripts, exons, CDS, or genes, group features by gene or transcript, or annotate experimental data using the galGal6 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Ggallus.UCSC.galGal6.refGene.html
---

# bioconductor-txdb.ggallus.ucsc.galgal6.refgene

name: bioconductor-txdb.ggallus.ucsc.galgal6.refgene
description: Annotation package for Gallus gallus (chicken) providing a TxDb object based on the UCSC galGal6 genome build and the refGene track. Use this skill when you need to retrieve genomic coordinates for transcripts, exons, CDS, or genes for chicken research using Bioconductor.

# bioconductor-txdb.ggallus.ucsc.galgal6.refgene

## Overview

The `TxDb.Ggallus.UCSC.galGal6.refGene` package is a specialized Bioconductor annotation resource. It contains a pre-built `TxDb` (Transcript Database) object that serves as an R interface to the UCSC `refGene` table for the `galGal6` (chicken) genome assembly. This package is essential for genomic workflows involving chicken data, such as RNA-Seq annotation, peak localization in ChIP-Seq, or any task requiring precise genomic coordinates for gene models.

## Usage and Workflows

### Loading the Database

To use the package, load the library and access the primary object, which shares the package name.

```r
library(TxDb.Ggallus.UCSC.galGal6.refGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Ggallus.UCSC.galGal6.refGene
txdb
```

### Extracting Genomic Features

Use standard `GenomicFeatures` functions to extract data from the TxDb object.

*   **Extract all transcripts:** `transcripts(txdb)`
*   **Extract all exons:** `exons(txdb)`
*   **Extract all CDS (Coding Sequences):** `cds(txdb)`
*   **Extract all genes:** `genes(txdb)`

### Grouping Features

Often, you need features grouped by their parent relationship (e.g., all exons belonging to a specific gene).

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get transcripts grouped by gene
transcripts_by_gene <- transcriptsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx", use.names = TRUE)
```

### Filtering and Selecting

You can use the `select`, `keys`, and `columns` methods to query specific information.

```r
# List available columns
columns(txdb)

# List available keytypes (e.g., GENEID, TXNAME)
keytypes(txdb)

# Retrieve specific transcript names for a set of Gene IDs
select(txdb, 
       keys = c("12345", "67890"), 
       columns = c("TXNAME", "TXSTRAND"), 
       keytype = "GENEID")
```

### Integration with Other Packages

*   **Coordinate Overlaps:** Use with `GenomicRanges::findOverlaps` to annotate experimental data (like BAM or BED files) with gene models.
*   **Visualization:** Use with `Gviz` or `ggbio` to create genomic track plots for the chicken genome.
*   **Sequence Extraction:** Use with `BSgenome.Ggallus.UCSC.galGal6` and `extractTranscriptSeqs` to get nucleotide sequences for transcripts.

## Tips

*   **Genome Build:** Ensure your experimental data is aligned to `galGal6`. If using `galGal5` or `galGal4`, this package will have coordinate mismatches.
*   **Naming Convention:** The `TXNAME` in this package typically refers to RefSeq accessions (e.g., NM_ or XM_ identifiers).
*   **Metadata:** Call `metadata(txdb)` to see the exact source URL and creation date of the database.

## Reference documentation

- [TxDb.Ggallus.UCSC.galGal6.refGene Reference Manual](./references/reference_manual.md)