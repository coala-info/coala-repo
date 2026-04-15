---
name: bioconductor-alabaster.string
description: This tool saves and loads Biostrings XStringSet objects to and from file artifacts using the alabaster framework. Use when user asks to save DNA, RNA, or amino acid sequences to disk, load biological sequence artifacts into R, or persist QualityScaledXStringSet objects with their metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.string.html
---

# bioconductor-alabaster.string

name: bioconductor-alabaster.string
description: Save and load Biostrings XStringSet objects (DNA, RNA, AA, and QualityScaled variants) to and from file artifacts using the alabaster framework. Use this skill when you need to persist biological sequence data to disk in a standardized, portable format or reload previously saved sequence artifacts into an R session.

# bioconductor-alabaster.string

## Overview

The `alabaster.string` package provides a standardized way to serialize `XStringSet` objects from the `Biostrings` package. It follows the **alabaster** framework's philosophy of using `saveObject` and `readObject` generics, ensuring that biological sequences, their names, and associated metadata (mcols) are preserved across sessions and platforms. It supports standard `DNAStringSet`, `RNAStringSet`, and `AAStringSet` objects, as well as their `QualityScaled` counterparts.

## Core Workflow

### Saving Sequences

To save a sequence object, use the `saveObject()` function. This creates a directory containing the sequence data (often in FASTA format), metadata, and an `OBJECT` file identifying the type.

```r
library(Biostrings)
library(alabaster.string)

# Create an example DNAStringSet with metadata
dna <- DNAStringSet(c(seq1="ACGT", seq2="TGCA"))
mcols(dna)$score <- c(0.5, 0.9)

# Define output directory
out_dir <- tempfile("dna_artifact")

# Save the object
saveObject(dna, out_dir)
```

### Loading Sequences

To reload a saved artifact, use the `readObject()` function pointing to the directory created during the save process.

```r
# Load the object back into R
roundtrip <- readObject(out_dir)

# The result is a DNAStringSet (or appropriate XStringSet subclass)
class(roundtrip)
```

### Handling Quality Scores

The package automatically handles `QualityScaledXStringSet` objects, preserving both the sequences and their associated Phred quality scores.

```r
# Example with QualityScaledDNAStringSet
x <- DNAStringSet(c("TTGA", "CTCN"))
q <- PhredQuality(c("*+,-", "6789"))
y <- QualityScaledDNAStringSet(x, q)

# Save and Read
tmp <- tempfile("quality_dna")
saveObject(y, tmp)
roundtrip_q <- readObject(tmp)
```

## Implementation Details

- **Storage Format**: Sequences are typically stored in Gzipped FASTA files (`sequences.fasta.gz`) within the artifact directory.
- **Metadata**: Sequence-level annotations (mcols) are stored in the `sequence_annotations/` subdirectory, usually in HDF5 format.
- **Names**: Sequence names are stored in `names.txt.gz`.
- **Portability**: The resulting directory is a self-contained artifact that can be moved between systems and reloaded as long as `alabaster.string` and its dependencies are installed.

## Reference documentation

- [Saving XStringSets to artifacts and back again](./references/userguide.md)