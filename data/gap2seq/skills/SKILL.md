---
name: gap2seq
description: Gap2Seq closes gaps in genomic scaffolds by finding paths through a de Bruijn graph that match estimated gap lengths using short-read data. Use when user asks to fill gaps in an assembly, close scaffold gaps using short reads, or refine genomic sequences by modeling exact path lengths.
homepage: https://www.cs.helsinki.fi/u/lmsalmel/Gap2Seq/
---


# gap2seq

## Overview
Gap2Seq is a specialized bioinformatic tool designed to close gaps in genomic scaffolds by modeling the gap-filling task as an exact path length problem within a de Bruijn graph (DBG). It utilizes short-read data to find paths that match the estimated gap size between contigs. This skill provides the necessary command-line patterns and parameter guidance to execute the tool effectively, ensuring high-quality assembly completion with a distinction between "safe" (high confidence) and "unsafe" bases.

## Usage Patterns

### Basic Execution
The primary interface is the `Gap2Seq.sh` wrapper script. You must provide the scaffold file, the output destination, and a comma-separated list of read files.

```bash
Gap2Seq.sh -scaffolds assembly.fasta -filled assembly_filled.fasta -reads reads_R1.fastq,reads_R2.fastq
```

### Core Parameters
- `-scaffolds`: Input FASTA file containing scaffolds with gaps (N's).
- `-filled`: Path for the resulting FASTA file.
- `-reads`: Comma-separated list of FASTQ files (supports multiple libraries).
- `-k`: K-mer length for the de Bruijn graph (default: 31). Adjust based on read length and complexity.
- `-solid`: Minimum k-mer occurrence to be included in the graph (default: 2). Increase for high-coverage data to filter sequencing errors.

### Advanced Refinement
- **Memory Management**: Use `-max-mem [GB]` to limit the DP table computation (default: 20GB). This is shared across threads.
- **Gap Estimation**: If your assembly has inaccurate gap size estimates, increase `-dist-error` (default: 500) to allow the algorithm to search a wider range.
- **Fringe Handling**: Use `-fuz` (default: 10) to define how many nucleotides at the edge of the gap should be ignored/overwritten to find a better entry point into the graph.
- **Strictness**: 
    - Use `-unique` to only fill gaps where a single best path exists.
    - Use `-best-only` to restrict solutions to the mathematically optimal length (standard behavior in older versions).

## Expert Tips
- **Case Sensitivity**: By default, Gap2Seq outputs "safe" bases (common to all valid paths) in **UPPERCASE** and "unsafe" bases in **lowercase**. To force all output to uppercase, use the `-all-upper` flag.
- **Parallelization**: The tool parallelizes at the gap level. Use `-nb-cores` to specify the thread count; setting it to `0` uses all available cores.
- **Input Preparation**: Ensure your read files are accessible and correctly formatted. While the tool handles multiple files, they must be separated by commas without spaces in the command string.
- **Memory Aborts**: If the log indicates search was aborted due to memory limits, consider increasing `-max-mem` or increasing the `-solid` threshold to simplify the de Bruijn graph.

## Reference documentation
- [Gap2Seq README](./references/www_cs_helsinki_fi_u_lmsalmel_Gap2Seq_README.txt.md)
- [Gap2Seq Homepage](./references/www_cs_helsinki_fi_u_lmsalmel_Gap2Seq.md)