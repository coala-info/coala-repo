---
name: pbmm2
description: "pbmm2 is a high-performance wrapper for minimap2 designed to align Pacific Biosciences reads to a reference genome. Use when user asks to align PacBio subreads or HiFi data, index a reference genome, or generate sorted and indexed BAM files for downstream analysis."
homepage: https://github.com/PacificBiosciences/pbmm2
---

# pbmm2

## Overview

pbmm2 is a high-performance C++ wrapper for the minimap2 library, specifically engineered for the Pacific Biosciences ecosystem. It simplifies the alignment process by providing pre-defined "presets" that encapsulate recommended mapping parameters for different PacBio library types. Unlike generic aligners, pbmm2 natively handles PacBio-specific metadata, supports SMRT Analysis datasets (XML), and can generate sorted, indexed BAM files on-the-fly that are ready for downstream polishing tools like GenomicConsensus.

## Core Workflows

### 1. Indexing a Reference
While pbmm2 can align directly to a FASTA file, creating a `.mmi` index is recommended for large genomes or repetitive use.
```bash
pbmm2 index reference.fasta reference.mmi --preset <PRESET>
```
*Note: Indexing parameters like k-mer size (-k) cannot be overridden during the alignment step if using a pre-built index.*

### 2. Standard Alignment
Align reads and produce a BAM file. The tool automatically handles PacBio BAM tags.
```bash
pbmm2 align reference.mmi reads.subreads.bam output.bam --preset SUBREAD
```

### 3. Optimized HiFi/CCS Alignment with Sorting
For HiFi data, use the `CCS` or `HIFI` preset and enable on-the-fly sorting to generate a BAI index automatically.
```bash
pbmm2 align ref.fasta movie.ccs.bam out.aligned.bam --preset HIFI --sort -j 12 -J 4
```

## Command Line Patterns & Best Practices

### Preset Selection
Choosing the correct `--preset` is critical for alignment quality:
- `SUBREAD`: For standard continuous long reads (CLR).
- `CCS` or `HIFI`: For highly accurate circular consensus reads (Default).
- `ISOSEQ`: For full-length transcript data (cDNA).
- `UNROLLED`: For specialized workflows requiring unrolled subreads.

### Performance Tuning
- **Threading (-j):** Defines alignment threads. If not specified, pbmm2 uses all available cores minus those reserved for I/O and sorting.
- **Sort Threads (-J):** When using `--sort`, dedicate specific threads to sorting. A common ratio is 1 sort thread per 3-4 alignment threads (max 8 sort threads).
- **Memory (-m):** Use `-m 4G` to define memory per sort thread. Increasing this reduces disk I/O pressure during large-scale sorts.

### Input Flexibility
- **FOFN (File Of File Names):** Process multiple movies by passing a `.fofn` file.
- **FASTA/FASTQ:** When using non-BAM input, you must provide read group information:
  ```bash
  pbmm2 align ref.fa reads.fastq out.bam --rg '@RG\tID:movie1\tSM:sampleA'
  ```
- **Streaming:** Omit the output filename to stream BAM data to stdout for piping into samtools.

### Sorting and Indexing
- Use `--sort` to generate a coordinate-sorted BAM.
- By default, a `.bai` index is created. For very large genomes (e.g., some plants), use `--bam-index CSI`.
- To skip index generation entirely, use `--bam-index NONE`.

## Expert Tips
- **Homopolymer Compression:** The `-H` (homopolymer-compressed k-mer) setting is active by default for `SUBREAD` and `UNROLLED` presets. Disable it with `-u` if necessary for specific biological contexts.
- **Polishing Compatibility:** If you intend to use the output for polishing with GenomicConsensus, you must use BAM input and ensure the `--sort` flag is used.
- **Temporary Files:** Sorting creates temporary files in the current directory. Use the `TMPDIR` environment variable to redirect these to high-speed scratch space.



## Subcommands

| Command | Description |
|---------|-------------|
| pbmm2 align | Align PacBio reads to reference sequences |
| pbmm2 index | Index reference and store as .mmi file |

## Reference documentation
- [github_com_PacificBiosciences_pbmm2_blob_develop_README.md](./references/github_com_PacificBiosciences_pbmm2_blob_develop_README.md)
- [anaconda_org_channels_bioconda_packages_pbmm2_overview.md](./references/anaconda_org_channels_bioconda_packages_pbmm2_overview.md)