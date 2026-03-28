---
name: pyfastaq
description: pyfastaq is a toolkit for the rapid manipulation and transformation of FASTA and FASTQ files. Use when user asks to filter sequences, convert file formats, interleave read pairs, or perform sequence transformations like reverse complementing and translating.
homepage: https://github.com/sanger-pathogens/Fastaq
---

# pyfastaq

## Overview

pyfastaq is a specialized toolkit designed for the rapid manipulation of FASTA and FASTQ files. It provides a suite of command-line utilities to handle common bioinformatics tasks—such as quality control, sequence formatting, and read pair management—without requiring custom scripts. The tool is particularly powerful for its ability to automatically detect input formats, handle gzipped files natively, and support Unix piping for complex multi-step transformations.

## Core Usage Patterns

The primary entry point is the `fastaq` command followed by a specific sub-command.

### Basic Syntax
```bash
fastaq <command> [options] <input_file> <output_file>
```

### Working with Compressed Files
pyfastaq automatically handles compression based on file extensions.
- **Input**: Files ending in `.gz` are automatically unzipped.
- **Output**: Naming an output file with `.gz` will automatically trigger gzip compression.

### Using Pipes for Efficiency
To avoid creating large intermediate files, use the minus sign (`-`) to represent `stdin` or `stdout`.
```bash
fastaq reverse_complement input.fastq.gz - | fastaq translate - output.fasta
```

## High-Utility Commands

### Sequence Filtering and Sorting
- **filter**: Extract a subset of sequences based on length, name, or specific IDs.
- **sort_by_size**: Order sequences from longest to shortest (or vice versa).
- **sort_by_name**: Sort sequences lexicographically.
- **to_unique_by_id**: Remove duplicate sequences based on their names, keeping the longest version.

### Read Pair Management
- **interleave**: Combine two files (forward and reverse reads) into one interleaved file.
- **deinterleave**: Split an interleaved paired-end file into two separate files.
- **strip_illumina_suffix**: Clean up read names by removing `/1` or `/2` suffixes.

### Sequence Transformation
- **reverse_complement**: Generate the reverse complement of all sequences in a file.
- **translate**: Convert nucleotide sequences into protein sequences.
- **trim_ends**: Remove a fixed number of bases from the start or end of every sequence.
- **trim_Ns_at_end**: Specifically remove ambiguous 'N' bases from the start and end of sequences.
- **acgtn_only**: Replace any non-ACGTN characters with 'N'.

### Format Conversion
- **to_fasta**: Convert various formats (FASTQ, GFF3, EMBL, GBK, Phylip) into standardized FASTA.
- **fasta_to_fastq**: Convert FASTA and a corresponding `.qual` file into FASTQ format.
- **scaffolds_to_contigs**: Break scaffold sequences into individual contigs at gap positions.

## Expert Tips

1. **Automatic Detection**: You do not need to specify if an input is FASTA or FASTQ; the tool detects the format automatically.
2. **Annotation Handling**: Note that pyfastaq focuses strictly on sequences and quality scores. If you provide an annotated format like GBK or EMBL, the annotations will be ignored in the output.
3. **Memory Efficiency**: When dealing with massive datasets, prefer piping (`-`) to minimize disk I/O.
4. **Quick Counting**: Use `fastaq count_sequences <file>` for a rapid summary of the number of records in any supported format.



## Subcommands

| Command | Description |
|---------|-------------|
| fastaq | A command-line tool for manipulating FASTA and FASTQ files. |
| fastaq interleave | Interleave two FASTA files. |
| pyfastaq fastaq count_sequences | Count the number of sequences in a FASTA or FASTQ file. |
| pyfastaq fastaq deinterleave | Deinterleaves a FASTAQ file into two separate FASTAQ files. |
| pyfastaq fastaq reverse_complement | Reverse complement a FASTA file |
| pyfastaq fastaq scaffolds_to_contigs | Convert scaffolds to contigs |
| pyfastaq fastaq sort_by_name | Sort FASTA/FASTQ records by name. |
| pyfastaq fastaq sort_by_size | Sort FASTA/FASTQ files by sequence length. |
| pyfastaq fastaq strip_illumina_suffix | Remove Illumina suffix from FASTA/FASTQ IDs |
| pyfastaq fastaq to_fake_qual | Convert FASTA to FASTQ with fake quality scores. |
| pyfastaq fastaq to_random_subset | Select a random subset of sequences from a FASTA file. |
| pyfastaq fastaq to_unique_by_id | Remove duplicate sequences from a FASTA or FASTQ file, keeping only the first occurrence of each sequence ID. |
| pyfastaq fastaq trim_Ns_at_end | Remove Ns from the ends of sequences. |
| pyfastaq_fastaq | Convert FASTA to FASTQ format. |
| pyfastaq_fastaq acgtn_only | Filter FASTA/FASTQ sequences to only include ACGTN characters. |
| pyfastaq_fastaq filter | Filter FASTA/FASTQ files based on various criteria. |
| pyfastaq_fastaq to_fasta | Convert FASTA to FASTA format. |
| pyfastaq_fastaq_translate | Translate DNA sequences to protein sequences. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_sanger-pathogens_Fastaq.md)