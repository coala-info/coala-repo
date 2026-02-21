---
name: bioconductor-bsgenome.ppaniscus.ucsc.panpan2
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ppaniscus.UCSC.panPan2.html
---

# bioconductor-bsgenome.ppaniscus.ucsc.panpan2

name: bioconductor-bsgenome.ppaniscus.ucsc.panpan2
description: Access and analyze the full genome sequences for Pan paniscus (Bonobo) using the UCSC panPan2 assembly. Use this skill when performing genomic analysis in R that requires the Bonobo reference genome, including sequence extraction, chromosome length retrieval, and genome-wide motif searching.

# bioconductor-bsgenome.ppaniscus.ucsc.panpan2

## Overview

The `BSgenome.Ppaniscus.UCSC.panPan2` package is a Bioconductor data package containing the full genome sequences for *Pan paniscus* (Bonobo) as provided by UCSC (assembly version panPan2, released December 2015). The sequences are stored as `Biostrings` objects, allowing for efficient manipulation and analysis within the R environment.

## Loading and Basic Usage

To use the genome, you must first load the package:

```r
library(BSgenome.Ppaniscus.UCSC.panPan2)
genome <- BSgenome.Ppaniscus.UCSC.panPan2
```

### Exploring the Genome

- **List sequences**: View available chromosomes and scaffolds.
  ```r
  seqnames(genome)
  ```
- **Check sequence lengths**: Get the lengths of all sequences in the assembly.
  ```r
  seqlengths(genome)
  head(seqlengths(genome))
  ```
- **Access specific chromosomes**: Retrieve the DNA sequence for a specific chromosome.
  ```r
  chr1_seq <- genome$chr1
  # Or using index notation
  chr2_seq <- genome[["chr2"]]
  ```

## Common Workflows

### Sequence Extraction

Extract specific sub-sequences using `getSeq`. This is more efficient than loading entire chromosomes for small regions.

```r
# Extract a specific region from chromosome 1
my_region <- getSeq(genome, names="chr1", start=1000, end=2000)
```

### Genome-wide Motif Searching

Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find motifs across the entire genome.

```r
library(Biostrings)
motif <- "TATAWAW"
# Search on a single chromosome
matches <- matchPattern(motif, genome$chr1)

# Search across the whole genome
all_matches <- vmatchPattern(motif, genome)
```

### Working with Genomic Ranges

The package integrates seamlessly with `GenomicRanges` for coordinate-based analysis.

```r
library(GenomicRanges)
gr <- GRanges(seqnames="chr1", ranges=IRanges(start=c(100, 500), end=c(200, 600)))
seqs <- getSeq(genome, gr)
```

## Tips and Best Practices

- **Memory Management**: BSgenome objects use "on-disk" caching. Accessing `genome$chr1` loads the sequence into memory. If working with many chromosomes, consider using `getSeq` with specific ranges to minimize memory footprint.
- **Coordinate System**: UCSC genomes use 1-based indexing in R/Bioconductor, consistent with standard R conventions.
- **Metadata**: Use `metadata(genome)` to see details about the source provider and assembly date.

## Reference documentation

- [BSgenome.Ppaniscus.UCSC.panPan2 Reference Manual](./references/reference_manual.md)