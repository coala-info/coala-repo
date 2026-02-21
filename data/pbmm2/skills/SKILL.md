---
name: pbmm2
description: `pbmm2` is the official Pacific Biosciences wrapper for `minimap2`, serving as the modern replacement for BLASR.
homepage: https://github.com/PacificBiosciences/pbmm2
---

# pbmm2

## Overview

`pbmm2` is the official Pacific Biosciences wrapper for `minimap2`, serving as the modern replacement for BLASR. It is designed to handle native PacBio data formats (BAM and XML datasets) as both input and output. The tool simplifies the alignment process by providing curated parameter presets that optimize `minimap2` for specific PacBio library types, ensuring high-quality mapping for long-read data. It also supports integrated on-the-fly sorting and indexing, making the output immediately ready for polishing and variant calling.

## Core Workflows

### 1. Reference Indexing
While optional, indexing is recommended if a reference will be used multiple times with the same preset. Note that parameters like k-mer size (`-k`) cannot be overridden during alignment if using a pre-built index.

```bash
pbmm2 index reference.fasta reference.mmi --preset [PRESET]
```

### 2. Basic Alignment
Align reads using a reference (FASTA or MMI) and input (BAM, XML, FASTA, or FASTQ).

```bash
pbmm2 align reference.fasta input.subreads.bam output.aligned.bam --preset SUBREAD
```

### 3. Optimized Sorting and Threading
For most production workflows, use `--sort` to generate a coordinate-sorted BAM.

*   **Thread Allocation**: Use `-j` for alignment threads and `-J` for sort threads.
*   **Memory**: Use `-m` to define memory per sort thread (e.g., `4G`).
*   **Recommendation**: Use 4 to 8 sort threads to avoid disk I/O bottlenecks.

```bash
pbmm2 align ref.fasta movie.subreads.bam out.bam --preset SUBREAD --sort -j 12 -J 4 -m 4G
```

## Presets and Data Types

Always select the preset that matches your input data:

| Preset | Application |
| :--- | :--- |
| `SUBREAD` | Standard subreads (default for many PacBio workflows) |
| `CCS` or `HIFI` | Highly accurate circular consensus sequences |
| `ISOSEQ` | Full-length transcript data |
| `UNROLLED` | Mapping of unrolled polymerase reads |

## Expert Tips and CLI Patterns

### Handling FASTA/FASTQ Input
When using non-BAM input (FASTA/FASTQ), you must manually provide Read Group information using the `--rg` flag to ensure downstream compatibility.

```bash
pbmm2 align ref.fasta reads.fastq out.bam --preset HIFI --rg '@RG\tID:myid\tSM:mysample'
```

### Streaming Output
To avoid large intermediate files or to pipe into other tools like `samtools`, omit the output filename to stream BAM to stdout.

```bash
pbmm2 align ref.mmi movie.subreads.bam --preset SUBREAD | samtools sort > sorted.bam
```

### Dataset XML Support
If the input is a PacBio Dataset XML (e.g., `.subreadset.xml`), `pbmm2` can output an `.alignmentset.xml`. This automatically triggers the generation of a `.pbi` (PacBio Index) file.

```bash
pbmm2 align ref.fasta input.subreadset.xml output.alignmentset.xml --preset SUBREAD --sort
```

### Overriding Parameters
If the presets are insufficient, you can manually tune the alignment:
*   `-k`: k-mer size (max 28).
*   `-u`: Disable homopolymer-compressed k-mer (active by default for `SUBREAD` and `UNROLLED`).
*   `-A`, `-B`: Match score and mismatch penalty.
*   `-o`, `-e`: Gap open and extension penalties.

## Reference documentation
- [PacificBiosciences/pbmm2 Main Documentation](./references/github_com_PacificBiosciences_pbmm2.md)