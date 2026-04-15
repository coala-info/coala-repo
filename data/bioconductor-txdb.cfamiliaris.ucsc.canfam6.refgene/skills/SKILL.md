---
name: bioconductor-txdb.cfamiliaris.ucsc.canfam6.refgene
description: This package provides a TxDb annotation object for the dog genome based on the UCSC canFam6 assembly and refGene track. Use when user asks to retrieve genomic coordinates for dog genes, transcripts, or exons, extract features grouped by gene or transcript, or annotate genomic ranges for the canFam6 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/TxDb.Cfamiliaris.UCSC.canFam6.refGene.html
---

# bioconductor-txdb.cfamiliaris.ucsc.canfam6.refgene

name: bioconductor-txdb.cfamiliaris.ucsc.canfam6.refgene
description: Provides the TxDb annotation object for Canis familiaris (Dog) based on the UCSC canFam6 genome build and the refGene track. Use this skill when an AI agent needs to retrieve genomic coordinates for dog genes, transcripts, exons, or CDS regions, or when performing genomic overlaps and transcript-centric analyses for the canFam6 assembly.

## Overview

The `TxDb.Cfamiliaris.UCSC.canFam6.refGene` package is a Bioconductor annotation resource containing a `TxDb` object. This object serves as an R interface to a prefabricated SQLite database of gene models for the dog (*Canis familiaris*). It is specifically based on the UCSC `canFam6` genome assembly and the `refGene` annotation track.

## Basic Usage

### Loading the Package
To use the annotation object, first load the library:

```r
library(TxDb.Cfamiliaris.UCSC.canFam6.refGene)
```

### Accessing the TxDb Object
The package automatically creates an object with the same name as the package. You can inspect its metadata and genome information by calling the object directly:

```r
txdb <- TxDb.Cfamiliaris.UCSC.canFam6.refGene
txdb
```

### Extracting Genomic Features
Use standard `GenomicFeatures` functions to extract data from the TxDb object:

*   **Transcripts**: `transcripts(txdb)`
*   **Exons**: `exons(txdb)`
*   **CDS**: `cds(txdb)`
*   **Genes**: `genes(txdb)`

### Grouping Features
To get features grouped by a parent element (e.g., all exons belonging to a specific gene):

```r
# Exons grouped by gene
exons_by_gene <- exonsBy(txdb, by = "gene")

# Transcripts grouped by gene
transcripts_by_gene <- transcriptsBy(txdb, by = "gene")

# Exons grouped by transcript
exons_by_tx <- exonsBy(txdb, by = "tx", use.names = TRUE)
```

## Common Workflows

### Finding Coordinates for Specific Genes
If you have a list of Gene IDs (RefSeq or Entrez depending on the track), you can subset the `genes` output:

```r
all_genes <- genes(txdb)
my_genes <- all_genes[all_genes$gene_id %in% c("ID1", "ID2")]
```

### Annotating Genomic Ranges
When performing ChIP-seq or RNA-seq analysis, you often need to find the nearest gene to a set of peaks:

```r
library(variantFiltering) # or GenomicFeatures
# Assuming 'peaks' is a GRanges object
# Find promoter regions (e.g., 2kb upstream of TSS)
promoters_gr <- promoters(txdb, upstream = 2000, downstream = 200)
```

## Tips
*   **Coordinate System**: This package uses the `canFam6` assembly. Ensure your experimental data (e.g., BAM or BED files) is aligned to `canFam6` before performing overlaps.
*   **Naming**: Use `seqlevelsStyle(txdb)` to check if the chromosomes use "chr1" (UCSC style) or "1" (NCBI style). You can change it using `seqlevelsStyle(txdb) <- "Ensembl"`.
*   **Discovery**: Use `columns(txdb)` to see what types of data can be retrieved and `keytypes(txdb)` to see what IDs can be used for filtering.

## Reference documentation
- [TxDb.Cfamiliaris.UCSC.canFam6.refGene Reference Manual](./references/reference_manual.md)