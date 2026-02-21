---
name: fastq-join
description: fastq-join is a sequence assembly tool used to merge paired-end reads.
homepage: https://github.com/movingpictures83/FastQJoin
---

# fastq-join

## Overview
fastq-join is a sequence assembly tool used to merge paired-end reads. It identifies the overlapping region between two reads and creates a single, longer sequence. This process is essential for improving sequence length and accuracy in downstream bioinformatics pipelines. This skill covers both the standard command-line interface and the specific configuration required for the PluMA plugin implementation.

## Command Line Usage
The standard utility (from ea-utils) follows a specific output naming convention using a percentage sign as a placeholder.

### Basic Syntax
```bash
fastq-join [options] <read1.fq> <read2.fq> -o <output_prefix.%.fq>
```

### Common Options
- `-m <int>`: Minimum overlap length (default is 6). Increase this to reduce false-positive joins in low-complexity regions.
- `-p <int>`: Maximum difference percentage allowed in the overlap (default is 8). Lower values increase stringency.
- `-v <char>`: Verifies that the sequence IDs in both files match. Highly recommended for data integrity.

### Output Files
The tool generates three distinct files based on the `-o` parameter:
1. `prefix.join.fq`: The successfully merged reads.
2. `prefix.un1.fq`: Forward reads that failed to join.
3. `prefix.un2.fq`: Reverse reads that failed to join.

## PluMA Plugin Configuration
When using the FastQJoin PluMA plugin, the tool expects a configuration file rather than direct CLI arguments for the filenames.

### Input Format (TXT)
Create a text file containing keyword-value pairs:
```text
file1: path/to/forward_reads.fastq
file2: path/to/reverse_reads.fastq
```

### Execution and Output
The plugin outputs three files starting with a user-specified prefix. The primary joined output is formatted as a FASTA file:
- `<prefix>joined`: The merged sequences in FASTA format.

## Best Practices
- **Quality Trimming**: Always perform quality trimming (e.g., using fastq-mcf or Trimmomatic) before joining. Low-quality bases at the ends of reads significantly interfere with overlap detection.
- **Overlap Validation**: If your library preparation has a known insert size, ensure the overlap length makes biological sense. If the overlap is consistently too short, check for adapter contamination.
- **Memory Management**: fastq-join is generally memory-efficient as it processes reads in a stream, but ensure your system PATH is correctly configured to locate the binary when using wrapper plugins.

## Reference documentation
- [FastQJoin Repository Overview](./references/github_com_movingpictures83_FastQJoin.md)