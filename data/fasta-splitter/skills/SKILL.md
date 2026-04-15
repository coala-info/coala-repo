---
name: fasta-splitter
description: fasta-splitter segments large FASTA files into smaller, approximately equal-sized parts while ensuring individual sequence records remain intact. Use when user asks to split genomic datasets into a specific number of files, partition sequences by count or total length, or manage large files for parallel processing.
homepage: http://kirill-kryukov.com/study/tools/fasta-splitter/
metadata:
  docker_image: "quay.io/biocontainers/fasta-splitter:0.2.6--0"
---

# fasta-splitter

## Overview

The `fasta-splitter` utility provides a robust way to segment large genomic datasets into smaller, approximately equal-sized files. It is format-aware, meaning it ensures that individual sequence records remain intact and are never divided in the middle. This tool is essential for optimizing bioinformatics pipelines that benefit from parallelization or for handling files that are too large for single-threaded analysis tools to process efficiently.

## Command Line Usage

The basic syntax for the tool is:
`fasta-splitter.pl [options] <file>...`

### Common Splitting Strategies

**Split into a specific number of files**
Use this when you want to distribute a workload across a fixed number of CPU cores.
`fasta-splitter.pl --n-parts 8 input.fasta`

**Split by sequence count**
Use this to ensure each output file contains a specific number of sequences (e.g., 1000 sequences per file).
`fasta-splitter.pl --measure count --part-size 1000 input.fasta`

**Split by sequence length (Basepairs)**
Use this when the sequences vary significantly in length to ensure each file has a similar total number of nucleotides.
`fasta-splitter.pl --measure seq --part-size 5000000 input.fasta`

**Split by total data size (Bytes)**
The default mode. Useful for managing disk space or meeting file size limitations.
`fasta-splitter.pl --measure all --part-size 100MB input.fasta`

### Output and Formatting

**Organize output files**
Always specify an output directory to prevent cluttering your working directory, especially when generating many parts.
`fasta-splitter.pl --n-parts 10 --out-dir ./split_results/ input.fasta`

**Customize file naming**
Adjust the separator and padding to match your pipeline's naming conventions.
`fasta-splitter.pl --n-parts 5 --part-num-prefix "_chunk_" --nopad input.fasta`

**Adjust sequence formatting**
Modern bioinformatics tools often prefer single-line sequences. Set line length to 0 to remove wrapping.
`fasta-splitter.pl --n-parts 4 --line-length 0 input.fasta`

## Expert Tips and Best Practices

- **Memory Efficiency**: The script reads the input file twice. The first pass calculates boundaries and the second pass writes the data. This allows it to handle massive datasets without loading the entire file into RAM.
- **Sequence Integrity**: If you have a single, extremely large sequence (like a whole chromosome), this tool will not split it. It only partitions files containing multiple sequences.
- **Sampling**: To extract a small subset from the beginning of a large file, combine `--n-parts` and `--part-size`. For example, `--n-parts 1 --part-size 100` will output only the first 100 units and stop.
- **Preserving Order**: The tool never reorders sequences. Concatenating the output files in numerical order will reconstruct the original file (though line breaks may change based on your `--line-length` setting).
- **Line Endings**: If moving files between Windows and Linux environments, use the `--eol` flag (dos|mac|unix) to ensure compatibility with downstream tools.

## Reference documentation

- [FASTA Splitter Homepage](./references/kirill-kryukov_com_study_tools_fasta-splitter.md)
- [FASTA Splitter Version History](./references/kirill-kryukov_com_study_tools_fasta-splitter_history.html.md)