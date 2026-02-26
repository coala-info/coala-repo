---
name: sak
description: The sak tool manipulates and extracts specific data from genomic sequence files. Use when user asks to extract sequences by index, trim sequences to specific coordinate ranges, or convert between sequence formats.
homepage: https://github.com/seqan/seqan/tree/master/apps/sak
---


# sak

## Overview
The `sak` tool is a versatile utility for sequence file manipulation. It allows for precise extraction of data from large genomic files without needing complex scripts. Use this skill to perform tasks such as isolating specific chromosomes from a multi-FASTA file, trimming sequences to specific coordinate ranges, or converting between sequence formats.

## Common CLI Patterns

### Sequence Extraction
To extract specific sequences from a multi-sequence file by their index (0-based):
```bash
sak -s 0 input.fasta -o first_sequence.fasta
sak -s 0 -s 2 input.fasta -o sequences_1_and_3.fasta
```

### Sub-sequence Trimming
To extract a specific range (e.g., from base 10 to 50) of a sequence:
```bash
sak -s 0 -i 10 -e 50 input.fasta -o trimmed.fasta
```
*Note: `-i` (begin) is inclusive, `-e` (end) is exclusive.*

### Filtering and Formatting
`sak` can be used to filter sequences based on length or to simply reformat files:
```bash
sak input.fastq -o output.fasta
```

## Expert Tips
- **Multiple Ranges**: You can specify multiple `-s`, `-i`, and `-e` flags. If you provide multiple sequences and one range, the range is applied to all selected sequences.
- **In-place processing**: While `sak` typically outputs to a file or stdout, always verify the output with a small subset before processing large datasets, as it is optimized for speed and does not perform extensive validation of coordinate bounds.
- **Standard Streams**: Use `-o -` to redirect output to stdout for piping into other bioinformatics tools.

## Reference documentation
- [sak - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sak_overview.md)
- [seqan/apps/sak at main · seqan/seqan · GitHub](./references/github_com_seqan_seqan_tree_main_apps_sak.md)