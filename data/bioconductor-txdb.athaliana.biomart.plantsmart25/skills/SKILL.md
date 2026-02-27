---
name: bioconductor-txdb.athaliana.biomart.plantsmart25
description: This package provides a TxDb annotation object for Arabidopsis thaliana based on the Ensembl Plants 25 BioMart data source. Use when user asks to retrieve genomic feature coordinates, extract transcripts or exons, or group genomic features by gene for Arabidopsis thaliana.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Athaliana.BioMart.plantsmart25.html
---


# bioconductor-txdb.athaliana.biomart.plantsmart25

name: bioconductor-txdb.athaliana.biomart.plantsmart25
description: Provides access to the TxDb annotation object for Arabidopsis thaliana based on BioMart plantsmart25 (Ensembl Plants 25). Use this skill when performing genomic analyses in R that require transcript, exon, or CDS coordinates for Arabidopsis thaliana, specifically using the Ensembl Plants 25/EBI UK data source.

# bioconductor-txdb.athaliana.biomart.plantsmart25

## Overview
This skill facilitates the use of the `TxDb.Athaliana.BioMart.plantsmart25` Bioconductor package. This package is an annotation hub that provides a `TxDb` (Transcript Database) object for *Arabidopsis thaliana*. It serves as a standardized R interface to genomic features (genes, transcripts, exons, and CDS) sourced from BioMart (Ensembl Plants 25) as of March 2015.

## Typical Workflow

### 1. Loading the Package
To access the database object, load the library. This automatically instantiates the `TxDb` object in the global environment.

```r
library(TxDb.Athaliana.BioMart.plantsmart25)
```

### 2. Inspecting the Database
The primary object has the same name as the package. You can inspect its metadata and available seqlevels.

```r
# View object summary
TxDb.Athaliana.BioMart.plantsmart25

# Check genome and taxonomy
genome(TxDb.Athaliana.BioMart.plantsmart25)
```

### 3. Extracting Genomic Features
Use standard `GenomicFeatures` functions to extract data from the TxDb object.

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(TxDb.Athaliana.BioMart.plantsmart25)

# Get all exons
exons <- exons(TxDb.Athaliana.BioMart.plantsmart25)

# Get all genes
genes <- genes(TxDb.Athaliana.BioMart.plantsmart25)
```

### 4. Grouping Features
Commonly, features are grouped by their parent relationship (e.g., exons by transcript or transcripts by gene).

```r
# Get exons grouped by transcript
exons_by_tx <- exonsBy(TxDb.Athaliana.BioMart.plantsmart25, by = "tx")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(TxDb.Athaliana.BioMart.plantsmart25, by = "gene")

# Get CDS grouped by transcript
cds_by_tx <- cdsBy(TxDb.Athaliana.BioMart.plantsmart25, by = "tx")
```

## Tips and Best Practices
- **Object Name**: The database object is named `TxDb.Athaliana.BioMart.plantsmart25`.
- **Coordinate System**: Ensure your experimental data (e.g., BAM files or GRanges) uses the same chromosome naming convention (seqlevels) as this TxDb object. Use `seqlevels(TxDb.Athaliana.BioMart.plantsmart25)` to verify.
- **Integration**: This package is designed to work seamlessly with the `GenomicFeatures`, `GenomicRanges`, and `AnnotationDbi` frameworks.
- **Data Version**: Note that this package is based on Ensembl Plants 25 (2015). If you require the most recent Arabidopsis annotation (e.g., Araport11), check for newer TxDb or EnsDb packages.

## Reference documentation
- [TxDb.Athaliana.BioMart.plantsmart25 Reference Manual](./references/reference_manual.md)