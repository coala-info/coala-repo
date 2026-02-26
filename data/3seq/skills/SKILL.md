---
name: 3seq
description: 3seq identifies recombination events within aligned nucleotide sequences by testing triplets for mosaic patterns. Use when user asks to detect recombination, identify parental sequences, generate p-value tables for statistical significance, or filter sequence alignments.
homepage: https://mol.ax/software/3seq/
---


# 3seq

## Overview
3seq is a specialized bioinformatics tool used to identify recombination events within a set of aligned nucleotide sequences. It works by exhaustively (or via sampling) testing triplets of sequences to determine if one sequence (the "child") is a mosaic of the other two ("parents"). This is particularly useful for viral evolution studies, mitochondrial DNA analysis, and identifying horizontal gene transfer. The tool relies on a pre-computed p-value table for statistical significance, which must be generated or associated before a full analysis can be performed.

## Setup and P-Value Table Management
Before running recombination analyses, you must establish a p-value table.

- **Generate a table**: Use `-g <filename> <size>`. The size should match or exceed the number of polymorphic sites in your alignment.
  `3seq -g myTable700 700`
- **Associate/Check a table**: Use `-c <filename>` to link a table to the executable.
  `3seq -c myTable700`
- **Verify association**: Run `3seq` without arguments to see which table is currently active.

## Common CLI Patterns

### Full Recombination Analysis
The standard "full run" mode tests all possible triplets.
- **Basic run**: `3seq -f input.aln`
- **Recommended production run**: Use `-d` to remove duplicate sequences (improves speed/accuracy) and `-id` to prefix output files.
  `3seq -f input.aln -d -id project_alpha`

### Data Filtering and Subsetting
- **Remove duplicates**: `3seq -w input.aln unique.aln -a -d`
- **Extract specific range**: Use `-f` (first) and `-l` (last) for nucleotide positions.
  `3seq -w input.aln subset.aln -a -f400 -l600`
- **Filter by sequence name**: Use a text file containing names.
  `3seq -f input.aln -subset names.txt`

### Advanced Analysis Options
- **Minimum segment length**: Use `-L <int>` to ignore recombination events that result in very short segments (useful for phylogenetic validation).
  `3seq -f input.aln -L 500`
- **Significance threshold**: Adjust the Dunn-Šidák corrected p-value threshold (default is 0.05).
  `3seq -f input.aln -t 0.01`
- **Random sampling**: For large datasets where $N > 500$, use `-rand` and `-n` to perform subsampling.
  `3seq -f input.aln -rand 50 -n 100`

## Input and Output Reference

### Supported Formats
- **PHYLIP**: Type 1 (interleaved/sequential) and Type 2 (newline after name). Names must not contain spaces.
- **FASTA**: Standard format. Spaces are allowed in names.
- **Validation**: Check format compatibility with `3seq -i <file>`.

### Primary Output Files
- **.3s.rec**: The main results file. Columns include Parent P, Parent Q, Child C, uncorrected p-value, corrected p-value, and breakpoint locations.
- **.3s.log**: A copy of the terminal output and run statistics.
- **.3s.pvalhist**: A histogram of p-values to check for distribution uniformity.

## Expert Tips
- **Memory Awareness**: 3seq is memory-intensive. For alignments with >1400 polymorphic sites, a table requiring ~3.5GB of RAM is ideal, though smaller tables can be used with Hogan-Siegmund approximations (enabled by default).
- **Parallelization**: If running on a cluster, use `-b` (begin) and `-e` (end) to split the sequence range across different jobs. Ensure `-#` is used if you want the multiple-comparison correction to apply only to the subset being tested.
- **Visualizing Triplets**: Use `-triplet <file> <P> <Q> <C>` to generate an EPS file showing informative sites for a specific result of interest.

## Reference documentation
- [3SEQ Manual](./references/mol_ax_content_media_2018_02_3seq_manual.20180209.pdf.md)
- [3SEQ Software Overview](./references/mol_ax_software_3seq.md)