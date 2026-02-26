---
name: fastaq
description: fastaq is a toolkit for the rapid manipulation, conversion, and filtering of biological sequence files. Use when user asks to interleave or deinterleave read pairs, reverse complement sequences, translate nucleotides to proteins, filter sequences by length, or convert between file formats like FASTA and FASTQ.
homepage: https://github.com/sanger-pathogens/Fastaq
---


# fastaq

## Overview
`fastaq` is a specialized toolkit designed for the rapid manipulation of biological sequence files. It provides a suite of command-line utilities to perform common bioinformatics tasks such as format conversion, sequence filtering, and read pair management. The tool is particularly useful for its ability to automatically detect file formats, handle gzipped data seamlessly, and support Unix-style piping for building efficient processing chains.

## Core Usage Patterns

### Basic Command Structure
All operations follow the pattern:
`fastaq <command> [options] <input_file> <output_file>`

To see all available commands:
`fastaq`

To see help for a specific command:
`fastaq <command> --help`

### Handling Compressed Files
`fastaq` automatically handles gzipped files based on the `.gz` extension.
- **Input**: If the filename ends in `.gz`, it is automatically unzipped.
- **Output**: If the output filename ends in `.gz`, the result is automatically zipped.

### Piping and Chaining
Use a hyphen (`-`) to represent `stdin` or `stdout`. This allows for efficient command chaining without writing intermediate files.
Example: Reverse complement a file and then translate it:
`fastaq reverse_complement in.fastq.gz - | fastaq translate - out.fasta`

## High-Utility Commands

### Read Pair Management
- **Interleave**: Combine two files (forward and reverse) into one interleaved file.
  `fastaq interleave fwd.fastq rev.fastq interleaved.fastq`
- **Deinterleave**: Split an interleaved file back into two separate files.
  `fastaq deinterleave interleaved.fastq fwd.fastq rev.fastq`

### Sequence Manipulation
- **Reverse Complement**: `fastaq reverse_complement in.fasta out.fasta`
- **Translate**: Translate nucleotide sequences to protein.
  `fastaq translate in.fasta out.fasta`
- **Trim Ns**: Remove ambiguous bases from the ends of sequences.
  `fastaq trim_Ns_at_end in.fasta out.fasta`
- **Filter**: Extract a subset of sequences based on length or ID.
  `fastaq filter --min_length 500 in.fasta out.fasta`

### Format Conversion
`fastaq` can convert between several formats (FASTA, FASTQ, GFF3, EMBL, GBK, Phylip).
- **To FASTA**: `fastaq to_fasta in.gbk out.fasta`
- **To FASTQ**: `fastaq fasta_to_fastq in.fasta in.qual out.fastq`

## Expert Tips
- **Automatic Detection**: You do not need to specify the input format; `fastaq` detects it automatically.
- **Annotation Loss**: Be aware that `fastaq` focuses on sequences and quality scores. It ignores annotations (like those in GFF3 or GenBank files) during manipulation.
- **Deduplication**: Use `to_unique_by_id` to remove duplicate sequences. If duplicates are found, the tool intelligently keeps the longest sequence.
- **Sorting**: Use `sort_by_size` or `sort_by_name` to organize large sequence files for downstream analysis.

## Reference documentation
- [Fastaq Main Documentation](./references/github_com_sanger-pathogens_Fastaq.md)