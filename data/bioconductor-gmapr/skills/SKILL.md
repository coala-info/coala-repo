---
name: bioconductor-gmapr
description: This tool provides an R interface for genomic mapping, alignment, and variant tallying using the GMAP/GSNAP suite. Use when user asks to create genome indices, align sequencing reads with GSNAP, or generate nucleotide-level variant tallies from BAM files.
homepage: https://bioconductor.org/packages/release/bioc/html/gmapR.html
---


# bioconductor-gmapr

name: bioconductor-gmapr
description: Genomic mapping, alignment, and variant tallying using the GMAP/GSNAP suite. Use this skill when you need to create genome indices, align short or long sequencing reads (RNA-seq or DNA-seq), or generate nucleotide-level summaries (tallies) from BAM files within an R environment.

# bioconductor-gmapr

## Overview

The `gmapR` package provides an R interface to the GMAP suite of tools. Its primary utilities include **GSNAP** (Genomic Short-read Nucleotide Alignment Program) for alignment and **bam_tally** for summarizing alignments into variant counts and coverage. It is particularly effective for RNA-seq alignment due to its sophisticated handling of splice sites and SNP-tolerant mapping.

## Core Workflows

### 1. Creating a GmapGenome Index

Before alignment, you must create a genome index. This can be built from a `BSgenome` object or a FASTA file.

```r
library(gmapR)
library(BSgenome.Hsapiens.UCSC.hg19)

# Define where the index will be stored
genome_dir <- GmapGenomeDirectory("path/to/indices", create = TRUE)

# Create the GmapGenome object
gmap_genome <- GmapGenome(genome = Hsapiens,
                          directory = genome_dir,
                          name = "hg19",
                          create = TRUE,
                          k = 12L)
```

### 2. Adding Splice Sites

For RNA-seq, adding known splice sites improves alignment accuracy across junctions.

```r
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
exons <- exonsBy(txdb)

# Assign splice sites to the genome object
spliceSites(gmap_genome, "knownGene") <- exons
```

### 3. Aligning Reads with GSNAP

Alignment is controlled by a `GsnapParam` object, which defines penalties, splicing behavior, and output constraints.

```r
# Configure parameters
params <- GsnapParam(genome = gmap_genome,
                     unique_only = TRUE,
                     novelsplicing = TRUE,
                     splicing = "knownGene",
                     npaths = 1L)

# Run alignment
# input_a and input_b are used for paired-end reads
output <- gsnap(input_a = "reads_1.fastq",
                input_b = "reads_2.fastq",
                params = params)

# Access BAM files
bam_files <- path(output)
```

### 4. Summarizing Variants with bam_tally

The `bam_tally` function provides nucleotide-level counts (reference vs. alternative) for a genomic region.

```r
# Define tally parameters
tally_param <- BamTallyParam(gmap_genome,
                             minimum_mapq = 20L,
                             concordant_only = TRUE,
                             indels = TRUE)

# Execute tallying
tallies <- bam_tally("aligned_reads.bam", tally_param)

# Convert to a VRanges object for variant analysis
variants <- variantSummary(tallies)
```

### 5. Creating Genome Packages

To share or version a specific genome index, you can wrap it into a standard R data package.

```r
makeGmapGenomePackage(gmapGenome = gmap_genome,
                      version = "1.0.0",
                      maintainer = "Name <email@example.com>",
                      author = "Author Name",
                      destDir = ".",
                      license = "Artistic-2.0",
                      pkgName = "GmapGenome.Hsapiens.UCSC.hg19")
```

## Tips and Best Practices

- **Memory Management**: Creating indices for large genomes (like Human) is resource-intensive. Ensure sufficient RAM is available during the `GmapGenome(..., create = TRUE)` step.
- **K-mer Size**: The `k` parameter (default 12) affects sensitivity and memory. Smaller values increase sensitivity for very short reads but use more memory.
- **GsnapOutput**: The object returned by `gsnap()` contains paths to multiple BAM files (e.g., unique, multireads, translocations) depending on the `split_output` parameter.
- **TP53Genome**: For testing and examples, `gmapR` provides a `TP53Genome()` function that returns a small, ready-to-use genome object.

## Reference documentation
- [gmapR](./references/gmapR.md)