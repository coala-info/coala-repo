---
name: bioconductor-txdb.ptroglodytes.ucsc.pantro6.refgene
description: This package provides a Bioconductor TxDb object containing UCSC refGene annotations for the Chimpanzee panTro6 genome assembly. Use when user asks to retrieve genomic coordinates for genes, transcripts, exons, or CDS regions, group features by gene or transcript, or query the panTro6 annotation database in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Ptroglodytes.UCSC.panTro6.refGene.html
---

# bioconductor-txdb.ptroglodytes.ucsc.pantro6.refgene

name: bioconductor-txdb.ptroglodytes.ucsc.pantro6.refgene
description: Access and query the UCSC panTro6 refGene annotation database for Chimpanzee (Pan troglodytes). Use this skill when you need to retrieve genomic coordinates for genes, transcripts, exons, or CDS regions for the panTro6 assembly in R.

# bioconductor-txdb.ptroglodytes.ucsc.pantro6.refgene

## Overview
This skill provides guidance on using the `TxDb.Ptroglodytes.UCSC.panTro6.refGene` R package. This is a Bioconductor AnnotationData package that provides a `TxDb` (Transcript Database) object. It contains the gene models for the Chimpanzee (*Pan troglodytes*) genome assembly panTro6, based on the UCSC refGene track.

## Getting Started
To use the database, load the library in R. The package automatically creates an object named `TxDb.Ptroglodytes.UCSC.panTro6.refGene`.

```r
library(TxDb.Ptroglodytes.UCSC.panTro6.refGene)
# Reference the object
txdb <- TxDb.Ptroglodytes.UCSC.panTro6.refGene
```

## Common Workflows

### 1. Extracting Genomic Features
Use functions from the `GenomicFeatures` package to extract features as `GRanges` objects.

```r
library(GenomicFeatures)

# Get all genes
gn <- genes(txdb)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
ex <- exons(txdb)

# Get coding sequences
cds_regions <- cds(txdb)
```

### 2. Grouping Features
Retrieve features grouped by their parent relationships (e.g., all exons belonging to a specific gene).

```r
# Exons grouped by gene
ex_by_gene <- exonsBy(txdb, by = "gene")

# Transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Exons grouped by transcript
ex_by_tx <- exonsBy(txdb, by = "tx")
```

### 3. Querying the Database
Use the `select` interface to retrieve specific data based on keys.

```r
# View available columns
columns(txdb)

# View available keytypes (e.g., GENEID, TXNAME)
keytypes(txdb)

# Example: Get transcript names for a specific Gene ID
select(txdb, 
       keys = "100610355", 
       columns = c("TXNAME", "TXSTRAND"), 
       keytype = "GENEID")
```

## Tips
- **Assembly Matching**: Ensure your experimental data (e.g., BAM or BED files) is aligned to the **panTro6** assembly. Using these annotations with other assemblies (like panTro5) will result in incorrect mapping.
- **GenomicFeatures Dependency**: While this package contains the data, you must load the `GenomicFeatures` library to use most extraction functions like `genes()`, `exonsBy()`, etc.
- **Metadata**: You can check the source and creation date of the database using `metadata(txdb)`.

## Reference documentation
- [TxDb.Ptroglodytes.UCSC.panTro6.refGene](./references/reference_manual.md)