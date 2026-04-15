---
name: bioconductor-txdbmaker
description: The txdbmaker package generates TxDb objects that store genomic coordinates for transcripts, exons, CDS, and genes in a local SQLite-backed database. Use when user asks to create TxDb objects from UCSC, Ensembl, or BioMart sources, parse local GFF or GTF files into annotation databases, or save and load TxDb objects for persistent use.
homepage: https://bioconductor.org/packages/release/bioc/html/txdbmaker.html
---

# bioconductor-txdbmaker

## Overview

The `txdbmaker` package is the standard Bioconductor tool for generating `TxDb` objects. These objects serve as local SQLite-backed databases containing the genomic coordinates of transcripts, exons, CDS, and genes. This package decouples the *creation* of these databases from the *analysis* functions found in `GenomicFeatures`.

## Core Workflows

### 1. Creating TxDb from Remote Sources

**From UCSC Genome Browser:**
Use `makeTxDbFromUCSC` to pull data directly from UCSC tables.
```r
library(txdbmaker)

# Check supported tables for a genome
supportedUCSCtables(genome="hg38")

# Create TxDb (e.g., for Human hg38 using GENCODE/RefSeq)
txdb_hg38 <- makeTxDbFromUCSC(genome="hg38", tablename="knownGene")
```

**From Ensembl/BioMart:**
Use `makeTxDbFromEnsembl` for direct Ensembl access or `makeTxDbFromBiomart` for flexible BioMart queries.
```r
# Ensembl direct
txdb_ens <- makeTxDbFromEnsembl(organism="Homo sapiens", release=110)

# BioMart
txdb_bm <- makeTxDbFromBiomart(dataset="hsapiens_gene_ensembl")
```

### 2. Creating TxDb from Local Files (GFF/GTF)

This is the most common workflow for custom genomes or specific annotation versions.
```r
txdb_gff <- makeTxDbFromGFF(file="path/to/annotation.gtf",
                            format="gtf",
                            organism="Mus musculus")
```

### 3. Persistence: Saving and Loading

Because `TxDb` objects are SQLite databases, they should be saved to disk to avoid re-downloading or re-parsing large files. **Note:** Do not use `save()` or `saveRDS()`; use the specialized DB functions.

```r
# Save to disk
saveDb(txdb_hg38, file="hg38_refgene.sqlite")

# Load in a new session
txdb <- loadDb("hg38_refgene.sqlite")
```

### 4. Creating Annotation Packages

If you intend to share the annotation or use it across many projects, wrap it in a standard R package.
```r
makeTxDbPackageFromUCSC(genome="mm9", 
                        tablename="knownGene",
                        version="1.0.0",
                        maintainer="Name <email@example.com>",
                        author="Author Name",
                        destDir=".")
```

## Key Functions Reference

| Function | Purpose |
| :--- | :--- |
| `makeTxDbFromUCSC` | Download and build from UCSC Genome Browser. |
| `makeTxDbFromEnsembl` | Build from Ensembl HTTP/FTP sources. |
| `makeTxDbFromBiomart` | Build using BioMart web services. |
| `makeTxDbFromGFF` | Parse local GFF3 or GTF files. |
| `makeTxDb` | Low-level constructor for manual data frames (transcripts, splicings, genes). |
| `supportedUCSCtables` | List available tracks for a specific UCSC genome. |
| `saveDb` / `loadDb` | SQLite-specific serialization for TxDb objects. |

## Tips for Success

- **Chrominfo:** When using `makeTxDbFromGFF`, it is often helpful to provide a `chrominfo` argument (a data frame with `chrom` and `length`) to ensure all chromosomes are correctly represented, even those without features.
- **Circular Sequences:** Use the `circ_seqs` argument (e.g., `circ_seqs="chrM"`) to correctly handle mitochondrial or plasmid DNA.
- **Memory/Time:** Building a `TxDb` from BioMart or UCSC can be slow and memory-intensive. Always `saveDb` the result to facilitate reproducible research and faster loading in future sessions.

## Reference documentation
- [Making TxDb Objects](./references/txdbmaker.md)