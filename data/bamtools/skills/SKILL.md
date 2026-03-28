---
name: bamtools
description: "bamtools is a command-line toolkit for the manipulation, filtering, and management of BAM alignment files. Use when user asks to filter alignments by quality or region, convert BAM files to other formats, split files by reference or tag, merge multiple datasets, or generate alignment statistics."
homepage: https://github.com/pezmaster31/bamtools
---


# bamtools

## Overview
bamtools is a comprehensive command-line toolkit designed for the efficient manipulation and querying of BAM (Binary Alignment/Map) files. It operates through a suite of specialized sub-tools, each targeting a specific aspect of alignment data management. Whether you are performing quality control, preparing data for visualization, or subsetting large datasets for specific genomic regions, bamtools provides a high-performance interface to handle the complexities of the BAM format.

## Core Usage Patterns

### Global Arguments
Most bamtools commands follow a standard input/output syntax:
- **Input**: Use `-in <file.bam>`. For multiple files, repeat the flag: `-in file1.bam -in file2.bam`.
- **Output**: Use `-out <file.bam>`.
- **Streaming**: If `-in` is omitted, the tool attempts to read from `stdin`. If `-out` is omitted, it writes to `stdout`.

### Essential Sub-tools

#### 1. Filtering Data (`filter`)
The `filter` tool is one of the most powerful components, allowing for complex queries.
- **By Mapping Quality**: `bamtools filter -in input.bam -mapQuality ">30"`
- **By Region**: `bamtools filter -in input.bam -region chr1:100..500`
- **By Flags**: `bamtools filter -in input.bam -isPaired true -isProperPair true`
- **By Name**: `bamtools filter -in input.bam -name "read_id"`

#### 2. Converting Formats (`convert`)
Transform BAM data into other common bioinformatics formats.
- **To SAM**: `bamtools convert -format sam -in input.bam`
- **To FASTQ**: `bamtools convert -format fastq -in input.bam -out output.fq`
- **To JSON**: `bamtools convert -format json -in input.bam`

#### 3. Splitting Files (`split`)
Divide a large BAM file into multiple smaller files based on specific properties.
- **By Reference**: `bamtools split -in input.bam -reference` (Creates files named `input.REF_*.bam`)
- **By Mapping Status**: `bamtools split -in input.bam -mapped`
- **By Tag**: `bamtools split -in input.bam -tag RG` (Splits by Read Group)

#### 4. Statistics and Summaries (`stats` & `count`)
- **General Stats**: `bamtools stats -in input.bam` provides totals for reads, paired reads, strand alignment, and more.
- **Quick Count**: `bamtools count -in input.bam` returns the total number of alignments.

#### 5. File Management (`merge`, `sort`, `index`)
- **Merge**: `bamtools merge -in 1.bam -in 2.bam -out merged.bam`
- **Sort**: `bamtools sort -in input.bam -out sorted.bam` (Defaults to coordinate sort).
- **Index**: `bamtools index -in sorted.bam` (Generates a `.bai` file).

## Expert Tips
- **Piping**: Combine bamtools with other tools like samtools using pipes for efficient workflows: `samtools view -u ... | bamtools filter -mapQuality ">30"`.
- **Header Manipulation**: Use `bamtools header` to view or replace the BAM header without re-aligning. To replace: `bamtools header -in input.bam -replace header.txt -out new_header.bam`.
- **Random Sampling**: Use `bamtools random -n 1000 -in input.bam` to extract a subset of reads for testing or downsampling.
- **Reverting**: The `revert` tool is useful for removing duplicate marks and restoring the BAM file to its original state (e.g., clearing mapping information to re-map).



## Subcommands

| Command | Description |
|---------|-------------|
| bamtools convert | converts BAM to a number of other formats. |
| bamtools count | prints number of alignments in BAM file(s). |
| bamtools coverage | prints coverage data for a single BAM file. |
| bamtools filter | filters BAM file(s). |
| bamtools header | prints header from BAM file(s). |
| bamtools index | creates index for BAM file. |
| bamtools merge | merges multiple BAM files into one. |
| bamtools random | grab a random subset of alignments. |
| bamtools resolve | resolves paired-end reads (marking the IsProperPair flag as needed). |
| bamtools revert | removes duplicate marks and restores original (non-recalibrated) base qualities. |
| bamtools sort | sorts a BAM file. |
| bamtools split | splits a BAM file on user-specified property, creating a new BAM output file for each value found. |
| bamtools stats | prints general alignment statistics. |

## Reference documentation
- [BamTools Toolkit Tutorial](./references/github_com_pezmaster31_bamtools_wiki_Tutorial_Toolkit_BamTools-1.0.pdf.md)
- [Using the toolkit](./references/github_com_pezmaster31_bamtools_wiki_Using-the-toolkit.md)