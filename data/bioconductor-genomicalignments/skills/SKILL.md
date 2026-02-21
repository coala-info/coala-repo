---
name: bioconductor-genomicalignments
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicAlignments.html
---

# bioconductor-genomicalignments

## Overview
The `GenomicAlignments` package is the standard Bioconductor infrastructure for handling high-throughput sequencing alignments. It provides efficient containers for single-end and paired-end reads, allowing for complex operations like overlap detection, coverage calculation, and nucleotide-level analysis. It is particularly powerful for RNA-seq because it natively supports gapped alignments (junction reads).

## Core Workflows

### 1. Loading Alignment Data
Use `readGAlignments` for single-end data and `readGAlignmentPairs` for paired-end data.

```r
library(GenomicAlignments)

# Load single-end BAM
bam_file <- "path/to/file.bam"
aln <- readGAlignments(bam_file)

# Load paired-end BAM (preserves pairing information)
galp <- readGAlignmentPairs(bam_file, use.names=TRUE)

# Use ScanBamParam for filtering (e.g., duplicates, map quality)
param <- ScanBamParam(flag=scanBamFlag(isDuplicate=FALSE), what="seq")
aln_filtered <- readGAlignments(bam_file, param=param)
```

### 2. Accessing Alignment Metadata
Standard accessors extract information directly from the objects:
- `seqnames(aln)`: Chromosomes.
- `strand(aln)`: Alignment strand.
- `cigar(aln)`: CIGAR strings.
- `qwidth(aln)`: Query (read) width.
- `start(aln)` / `end(aln)`: Genomic coordinates.
- `njunc(aln)`: Number of junctions (N operations in CIGAR).
- `grglist(aln)`: Convert alignments to a `GRangesList` (useful for gapped reads).

### 3. Counting Reads (summarizeOverlaps)
This is the primary method for generating count matrices for differential expression (DESeq2/edgeR).

```r
# features is usually a GRangesList (exons by gene)
# fls is a vector of BAM file paths
counts <- summarizeOverlaps(features, fls, mode="Union", ignore.strand=TRUE)

# Access the count matrix
count_matrix <- assay(counts)
```
**Modes:**
- `Union`: (Default) Read overlaps any part of a feature.
- `IntersectionStrict`: Read must be entirely within the feature.
- `IntersectionNotEmpty`: Resolves overlaps where a read hits multiple features.

### 4. RNA-seq Splice Compatibility
To determine if a read is compatible with a specific transcript's splicing pattern:

```r
# Find overlaps between reads and transcripts
ov <- findOverlaps(aln, exbytx)

# Encode the overlaps
enc <- encodeOverlaps(aln, exbytx, hits=ov, flip.query.if.wrong.strand=TRUE)

# Filter for splice-compatible hits
is_compatible <- isCompatibleWithSplicing(enc)
compatible_ov <- ov[is_compatible]
```

### 5. Nucleotide-Level Analysis
Extract sequences to compare reads against the reference genome.

```r
# Get original query sequences (restoring orientation)
oqseq <- mcols(aln)$seq
is_minus <- as.logical(strand(aln) == "-")
oqseq[is_minus] <- reverseComplement(oqseq[is_minus])

# Extract reference sequences for the aligned regions
library(BSgenome.Hsapiens.UCSC.hg19)
ref_seqs <- extractTranscriptSeqs(Hsapiens, grglist(aln))
```

## Tips and Best Practices
- **Memory Management**: For large BAM files, use `BamFileList(..., yieldSize=1000000)` to process data in chunks.
- **Paired-End Strand Mode**: When using `readGAlignmentPairs`, pay attention to `strandMode`. `strandMode=1` (default) means the strand of the pair is the strand of the first mate.
- **CIGAR Operations**: Use `tabulate_cigar_ops()` (from the `cigarillo` dependency) or `cigarOpTable()` to summarize insertions, deletions, and skips across a whole BAM file.
- **Junctions**: `njunc(aln) > 0` identifies reads that cross at least one exon-exon junction.

## Reference documentation
- [An Introduction to the GenomicAlignments Package](./references/GenomicAlignmentsIntroduction.md)
- [Overlap encodings](./references/OverlapEncodings.md)
- [Working with aligned nucleotides](./references/WorkingWithAlignedNucleotides.md)
- [Counting reads with summarizeOverlaps](./references/summarizeOverlaps.md)