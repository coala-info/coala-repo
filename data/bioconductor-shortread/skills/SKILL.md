---
name: bioconductor-shortread
description: This tool provides a comprehensive toolkit for processing, quality assessment, filtering, and trimming of high-throughput sequencing data in FASTQ format. Use when user asks to read or write FASTQ files, generate quality assessment reports, filter or trim reads based on quality or sequence content, or manipulate DNA sequences using Biostrings-compatible objects.
homepage: https://bioconductor.org/packages/release/bioc/html/ShortRead.html
---


# bioconductor-shortread

name: bioconductor-shortread
description: Comprehensive toolkit for high-throughput sequencing data (FASTQ) processing, quality assessment, filtering, and trimming. Use when Claude needs to: (1) Read and write FASTQ files, (2) Generate quality assessment (QA) reports, (3) Filter or trim reads based on quality or sequence content, (4) Manipulate DNA sequences using Biostrings-compatible objects.

## Overview
The `ShortRead` package is a core Bioconductor tool for managing FASTQ files. It provides infrastructure for reading, writing, and performing quality control on high-throughput sequencing data. It represents data using S4 classes like `ShortReadQ`, which integrates sequences (as `DNAStringSet`), quality scores, and read identifiers. The package is designed to handle large datasets efficiently through streaming and sampling mechanisms.

## Core Functions and Workflows

### 1. Data Input and Inspection
- **Small files:** Use `readFastq("path/to/file.fastq.gz")` to load the entire file into memory as a `ShortReadQ` object.
- **Large files (Streaming):** Use `FastqStreamer` to iterate through files in chunks (default is 1 million records) to maintain a low memory footprint.
- **Sampling:** Use `FastqSampler` to draw a random subset of reads for quick exploratory analysis.
- **Quick Summary:** `countFastq("file.fastq.gz")` provides the number of records, nucleotides, and scores without loading the full sequence data.

### 2. Quality Assessment (QA)
Generate technical reports to evaluate the quality of sequencing runs:
```r
# Collect statistics
fls <- dir("data/", pattern="*.fastq.gz", full.names=TRUE)
qaSummary <- qa(fls, type="fastq")

# Generate and view HTML report
browseURL(report(qaSummary))

# Access specific data frames
head(qaSummary[["readCounts"]])
head(qaSummary[["baseCalls"]])
```

### 3. Filtering and Trimming
Filtering is most efficient when performed within a `FastqStreamer` loop:
- **Pre-defined filters:** Use `srFilter` functions like `nFilter()` (to remove reads with 'N' bases) or `dustFilter()`.
- **Quality Trimming:** Use `trimTails()` or `trimTailw()` to remove low-quality ends based on Phred scores.
- **Manual Subsetting:** `ShortReadQ` objects support standard R indexing. For example, `fq[width(fq) > 50]` keeps reads longer than 50bp.
- **Writing:** Use `writeFastq(fq, "output.fastq.gz", mode="a")` to append processed chunks to a new file.

### 4. Sequence Analysis and Exploration
- **Read Occurrence:** `tables(fq)` identifies the most frequent sequences (useful for finding adapter contamination).
- **Nucleotide Content:** `alphabetFrequency(sread(fq))` calculates base composition per read.
- **Edit Distance:** `srdistance(sread(fq), "SEQUENCE")` finds near-matches to a specific adapter or primer.
- **Duplicates:** `srduplicated(fq)` identifies identical reads, which may indicate PCR artifacts.

## Tips for Success
- **Biostrings Integration:** The sequences inside a `ShortReadQ` object are `DNAStringSet` objects. You can extract them using `sread(fq)` and use any function from the `Biostrings` package.
- **Quality Scores:** Access quality scores with `quality(fq)`. Use `encoding(quality(fq))` to see the mapping between ASCII characters and Phred scores.
- **Paired-end Data:** When filtering paired-end data, you must process both R1 and R2 files simultaneously to ensure the reads remain synchronized.
- **Memory:** For files larger than a few gigabytes, always use `FastqStreamer` instead of `readFastq`.

## Reference documentation
- [Overview](./references/Overview.md)