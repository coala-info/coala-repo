---
name: bioconductor-genbankr
description: This tool parses GenBank files into semantically useful Bioconductor objects like GenBankRecord, GRanges, and TxDb. Use when user asks to read .gbk or .gb files, extract genomic features such as genes and exons, retrieve sequences, or convert GenBank records into TxDb objects for downstream analysis.
homepage: https://bioconductor.org/packages/3.6/bioc/html/genbankr.html
---

# bioconductor-genbankr

name: bioconductor-genbankr
description: Parsing GenBank files into semantically useful Bioconductor objects. Use this skill when you need to read .gbk or .gb files, extract genomic features (genes, exons, CDS), retrieve sequences, or convert GenBank records into TxDb or GRanges objects for downstream analysis.

## Overview

The `genbankr` package provides a robust parser for GenBank files, transforming them into `GenBankRecord` objects. These objects integrate seamlessly with the Bioconductor ecosystem, supporting standard accessors for genomic ranges and sequences. It handles the complexities of GenBank formatting, such as joining multi-segment features and approximating transcripts when explicit annotations are missing.

## Core Workflows

### Loading GenBank Data

There are two primary ways to load data: from a local file or via a GenBank accession number (requires `rentrez`).

```r
library(genbankr)

# 1. From a local file
gb <- readGenBank("path/to/file.gbk")

# 2. From an accession number
id <- GBAccession("U49845.1")
gb <- readGenBank(id)

# 3. Using rtracklayer style import
util_file <- GenBankFile("path/to/file.gbk")
gb <- import(util_file)
```

### Extracting Standard Features

`GenBankRecord` objects support standard Bioconductor accessors that return `GRanges` objects.

```r
# Extract genomic features
g  <- genes(gb)
tx <- transcripts(gb)
ex <- exons(gb)
cd <- cds(gb)

# Extract sequences (returns DNAStringSet)
sq <- getSeq(gb)

# Grouped features
ex_by_tx <- exonsBy(gb, by = "tx")
cds_by_tx <- cdsBy(gb, by = "tx")
```

### Specialized genbankr Accessors

Use these functions to retrieve GenBank-specific metadata and non-standard features.

```r
# Metadata
acc  <- accession(gb)
v    <- vers(gb)
def  <- definition(gb)
loc  <- locus(gb)
src  <- sources(gb)

# Specialized regions
variants_gr <- variants(gb)      # Returns VRanges
inter       <- intergenic(gb)    # Regions between genes
other       <- otherFeatures(gb) # Features like promoters, misc_feature, etc.
```

### Integration with GenomicFeatures

You can convert a `GenBankRecord` directly into a `TxDb` object for use with packages like `GenomicFeatures` or `VariantAnnotation`.

```r
txdb <- makeTxDbFromGenBank(gb)
```

## Usage Tips

- **Partial Features**: By default, `readGenBank` warns about features with non-exact boundaries (e.g., `<1..100`). Set `partial = TRUE` to include them or `partial = FALSE` to suppress warnings and exclude them.
- **Memory Management**: If you do not need the raw sequence, set `ret.seq = FALSE` in `readGenBank` to save memory, though note that variant parsing requires the sequence.
- **Origin Sequence**: The package determines chromosome names (seqnames) based on the 'chromosome', 'strain', or 'organism' attributes found in the source features.
- **Approximate Annotations**: If a file contains CDS but no exon annotations, `genbankr` automatically generates "approximate exons" from the CDS boundaries.

## Reference documentation

- [genbankr Reference Manual](./references/reference_manual.md)