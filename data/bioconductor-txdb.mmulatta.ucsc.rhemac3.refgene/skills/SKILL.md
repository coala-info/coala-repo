---
name: bioconductor-txdb.mmulatta.ucsc.rhemac3.refgene
description: This package provides a transcript database for the Macaca mulatta rheMac3 genome assembly using UCSC refGene annotations. Use when user asks to extract genomic features like genes, transcripts, or exons, group features by gene or transcript, or query genomic coordinates for the rheMac3 rhesus macaque assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Mmulatta.UCSC.rheMac3.refGene.html
---

# bioconductor-txdb.mmulatta.ucsc.rhemac3.refgene

## Overview
This skill provides guidance on using the `TxDb.Mmulatta.UCSC.rheMac3.refGene` Bioconductor package. This package is a "Transcript Database" (TxDb) object that serves as an R interface to prefabricated genomic annotations for *Macaca mulatta*. It is specifically built from the UCSC `rheMac3` genome assembly using the `refGene` track data.

## Typical Workflow

### 1. Loading the Package
To access the annotation object, load the library. The object itself shares the name of the package.

```r
library(TxDb.Mmulatta.UCSC.rheMac3.refGene)
# Assign to a shorter variable for convenience
txdb <- TxDb.Mmulatta.UCSC.rheMac3.refGene
txdb
```

### 2. Extracting Genomic Features
Use the standard `GenomicFeatures` accessor functions to extract specific features as `GRanges` or `GRangesList` objects.

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
exons <- exons(txdb)

# Get all genes (represented by their genomic extent)
genes <- genes(txdb)

# Get promoters
promoters <- promoters(txdb, upstream=2000, downstream=400)
```

### 3. Grouping Features
Often, you need to see how exons or transcripts are related to genes. Use the `By` family of functions.

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by="gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by="gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by="tx")
```

### 4. Filtering and Selection
You can use the `columns`, `keytypes`, and `select` methods to query the database for specific identifiers.

```r
# View available columns
columns(txdb)

# View available keytypes (e.g., GENEID, TXNAME)
keytypes(txdb)

# Example: Retrieve transcript names for a specific Gene ID
select(txdb, keys="100123456", columns=c("TXNAME", "TXSTRAND"), keytype="GENEID")
```

## Tips for Usage
- **Coordinate System**: Ensure your experimental data (e.g., BAM files or peak calls) is aligned to the `rheMac3` assembly. Using these annotations with other builds (like `rheMac8` or `Mmul_10`) will result in incorrect mapping.
- **Integration**: This package is designed to work seamlessly with `GenomicRanges`, `AnnotationDbi`, and `Gviz` for visualization.
- **Metadata**: Call `metadata(txdb)` to see the exact source URLs and creation date of the database.

## Reference documentation
- [TxDb.Mmulatta.UCSC.rheMac3.refGene](./references/reference_manual.md)