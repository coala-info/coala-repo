---
name: bioconductor-txdb.sscrofa.ucsc.susscr3.refgene
description: "This package provides a TxDb object containing UCSC susScr3 refGene annotations for the pig genome. Use when user asks to access pig genomic coordinates, extract gene models, retrieve transcript structures, or perform genomic overlaps for the susScr3 assembly."
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Sscrofa.UCSC.susScr3.refGene.html
---


# bioconductor-txdb.sscrofa.ucsc.susscr3.refgene

name: bioconductor-txdb.sscrofa.ucsc.susscr3.refgene
description: Provides access to the UCSC susScr3 (Pig/Sus scrofa) refGene annotation database as a TxDb object. Use this skill when working with pig genomic coordinates, gene models, transcript structures, or performing genomic overlaps and annotation for the susScr3 assembly in R.

# bioconductor-txdb.sscrofa.ucsc.susscr3.refgene

## Overview
This package provides an R interface to a prefabricated database containing genomic annotations for *Sus scrofa* (Pig). It specifically uses the UCSC susScr3 genome build and the refGene track. The primary object exposed is `TxDb.Sscrofa.UCSC.susScr3.refGene`, which is a `TxDb` object (Transcript Database).

## Loading the Annotation Data
To use the database, load the library and reference the object by its name:

```r
library(TxDb.Sscrofa.UCSC.susScr3.refGene)

# Assign to a shorter variable for convenience
txdb <- TxDb.Sscrofa.UCSC.susScr3.refGene
txdb
```

## Common Workflows

### Extracting Genomic Features
Use functions from the `GenomicFeatures` and `GenomicRanges` packages to extract specific features:

```r
library(GenomicFeatures)

# Get all transcripts
tx <- transcripts(txdb)

# Get all exons
ex <- exons(txdb)

# Get all genes
gn <- genes(txdb)

# Get Coding Sequences (CDS)
cds_regions <- cds(txdb)
```

### Grouping Features
You can retrieve features grouped by their parent relationship (e.g., exons belonging to a specific gene):

```r
# Get exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Get transcripts grouped by gene
tx_by_gene <- transcriptsBy(txdb, by = "gene")

# Get exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx")
```

### Querying the Database
To see what types of data can be retrieved or used as filters:

```r
# List available columns
columns(txdb)

# List available key types (e.g., GENEID, TXNAME)
keytypes(txdb)

# Example: Select specific info for a set of gene IDs
keys <- head(keys(txdb, "GENEID"))
select(txdb, keys = keys, columns = c("TXNAME", "TXSTRAND"), keytype = "GENEID")
```

## Tips
* **Genome Build**: Ensure your experimental data (e.g., BAM files, BED files) is aligned to the **susScr3** assembly. Using this package with other builds (like susScr11) will result in incorrect coordinate mapping.
* **Coordinate System**: TxDb objects use 1-based coordinates (standard for Bioconductor/R).
* **Integration**: This object integrates seamlessly with `findOverlaps` and other `GenomicRanges` tools for annotating peaks or variants.

## Reference documentation
- [TxDb.Sscrofa.UCSC.susScr3.refGene](./references/reference_manual.md)