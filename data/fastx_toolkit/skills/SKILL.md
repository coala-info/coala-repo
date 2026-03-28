---
name: fastx_toolkit
description: The FASTX-Toolkit provides a collection of command-line utilities for the preprocessing, filtering, and manipulation of FASTA and FASTQ sequencing data. Use when user asks to filter reads by quality, trim sequences, clip adapters, convert FASTQ to FASTA, or demultiplex barcodes.
homepage: https://github.com/agordon/fastx_toolkit
---

# fastx_toolkit

## Overview

The FASTX-Toolkit provides essential utilities for the initial cleanup and manipulation of raw sequencing data. It is particularly useful for improving mapping results by removing low-quality reads, stripping technical sequences like adapters and barcodes, and converting between FASTQ and FASTA formats. While it is legacy software, it remains a standard for quick, low-level manipulation of sequence files.

## Core Command Line Patterns

### Quality Control and Filtering
- **Filter by quality**: Use `fastq_quality_filter` to remove reads that do not meet a minimum quality threshold.
  - `-q [min_score]`: Minimum quality score to keep.
  - `-p [min_percent]`: Minimum percent of bases that must have the `-q` quality.
  - Example: `fastq_quality_filter -q 20 -p 80 -i input.fastq -o filtered.fastq`
- **Generate Statistics**: Use `fastx_quality_stats` to produce a text-based report of quality scores per position, which is required for generating boxplots.
  - Example: `fastx_quality_stats -i input.fastq -o stats.txt`

### Sequence Modification
- **Trimming**: Use `fastx_trimmer` to cut specific columns from the start or end of reads (e.g., removing fixed-length barcodes or low-quality ends).
  - `-f [first_base]`: First base to keep (default is 1).
  - `-l [last_base]`: Last base to keep.
  - Example: `fastx_trimmer -f 5 -i input.fastq -o trimmed.fastq`
- **Clipping Adapters**: Use `fastx_clipper` to remove known adapter sequences.
  - `-a [adapter_sequence]`: The sequence to search for and remove.
  - `-l [min_length]`: Discard sequences shorter than this after clipping.
  - Example: `fastx_clipper -a ATCGGCT -i input.fastq -o clipped.fastq`
- **Reverse Complement**: Use `fastx_reverse_complement` to flip sequences and their corresponding quality scores.
  - Example: `fastx_reverse_complement -i input.fasta -o rc.fasta`

### Format Conversion and Organization
- **FASTQ to FASTA**: Use `fastq_to_fasta` to convert formats, optionally discarding sequences with unknown (N) nucleotides.
  - `-n`: Keep sequences with unknown nucleotides (default is to discard).
  - Example: `fastq_to_fasta -i input.fastq -o output.fasta`
- **Barcode Splitting**: Use `fastx_barcode_splitter.pl` to demultiplex a file based on a list of barcodes.
  - `--bcfile [file]`: A tab-delimited file containing barcode names and sequences.
  - `--prefix [path]`: Output file prefix.
  - `--suffix [ext]`: Output file extension (e.g., .fastq).

## Expert Tips
- **Input/Output**: Most tools use `-i` for input and `-o` for output. If omitted, they typically read from STDIN and write to STDOUT, allowing for piping: `fastx_trimmer -f 5 | fastq_quality_filter -q 20`.
- **Quality Scores**: Be aware of your data's encoding (Sanger vs. Illumina 1.3+). Use `fastq_quality_converter` if you need to transform ASCII quality scores to different offsets.
- **Collapsing Sequences**: Use `fastx_collapser` to merge identical sequences in a FASTA/Q file and report their multiplicity, which is highly effective for small RNA datasets.



## Subcommands

| Command | Description |
|---------|-------------|
| fastq_quality_converter | Converts FASTQ quality scores from ASCII to numeric (or vice versa). Part of the FASTX Toolkit. |
| fastq_to_fasta | Convert FASTQ files to FASTA files. |
| fastx_collapser | Collapses identical sequences in a FASTA/Q file into a single sequence. |
| fastx_trimmer | The FASTX-Toolkit Fastx Trimmer is used to shorten sequences in a FASTA or FASTQ file (trimming bases from the beginning or end of the sequences). |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_agordon_fastx_toolkit.md)