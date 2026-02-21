---
name: bioconductor-bsgenome.btaurus.ucsc.bostau9
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Btaurus.UCSC.bosTau9.html
---

# bioconductor-bsgenome.btaurus.ucsc.bostau9

name: bioconductor-bsgenome.btaurus.ucsc.bostau9
description: Provides the full genome sequences for Bos taurus (Cow) as provided by UCSC (build bosTau9, April 2018) and stored in Biostrings objects. Use this skill when you need to access, analyze, or extract genomic sequences from the cow genome in R, perform genome-wide motif searching, or extract upstream/downstream sequences relative to gene models.

# bioconductor-bsgenome.btaurus.ucsc.bostau9

## Overview

The `BSgenome.Btaurus.UCSC.bosTau9` package is a genomic data package containing the complete genome sequence for *Bos taurus* (Cow). It is based on the UCSC bosTau9 assembly. The sequences are stored as `DNAString` or `DNAStringSet` objects, allowing for efficient sequence manipulation and analysis within the Bioconductor ecosystem.

## Core Usage

### Loading the Genome
To use the package, you must first load it into your R session.

```r
library(BSgenome.Btaurus.UCSC.bosTau9)
genome <- BSgenome.Btaurus.UCSC.bosTau9
```

### Inspecting Sequence Information
You can check available chromosomes and their lengths.

```r
# View genome object details
genome

# Get sequence names (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (e.g., Chromosome 1)
genome$chr1
# or
genome[["chr1"]]
```

### Sequence Extraction
Extract specific sub-sequences using `getSeq`.

```r
# Extract a specific region from Chromosome 2
# Coordinates: 1000 to 2000
my_seq <- getSeq(genome, "chr2", start=1000, end=2000)
```

## Common Workflows

### Extracting Upstream Sequences
A common task is extracting promoter or upstream regions using a `TxDb` object (gene model).

```r
library(GenomicFeatures)

# Create a TxDb object for bosTau9 (requires internet connection or local cache)
refGene_txdb <- makeTxDbFromUCSC("bosTau9", "refGene")

# Extract 1000bp upstream of all transcripts
up1000seqs <- extractUpstreamSeqs(genome, refGene_txdb, width=1000)
```

### Genome-Wide Motif Searching
You can search for specific DNA motifs across the entire cow genome.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAT")

# Match the motif on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# To search across all chromosomes, use vmatchPattern
all_matches <- vmatchPattern(motif, genome)
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "on-disk" caching via the `.2bit` format, but loading many large chromosomes into memory simultaneously can be intensive. Access specific chromosomes as needed.
- **Compatibility**: Ensure that any annotation objects (like `TxDb` or `GRanges`) use the same naming convention (e.g., "chr1", "chr2") and assembly version (bosTau9) to avoid coordinate mismatches.
- **Coordinate System**: UCSC uses a 1-based coordinate system in R/Bioconductor (standard for `IRanges` and `GRanges`).

## Reference documentation

- [BSgenome.Btaurus.UCSC.bosTau9 Reference Manual](./references/reference_manual.md)