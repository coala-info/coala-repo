---
name: fastools
description: fastools provides a suite of efficient utilities for manipulating, converting, and analyzing FASTA and FASTQ sequence data. Use when user asks to calculate sequence statistics, convert between sequence formats, filter sequences by length, extract sequences by ID, or interleave and de-interleave paired-end files.
homepage: https://git.lumc.nl/j.f.j.laros/fastools
metadata:
  docker_image: "quay.io/biocontainers/fastools:1.1.5--pyh7cba7a3_0"
---

# fastools

## Overview
The fastools toolkit provides a suite of efficient utilities for handling common sequence data formats. It is designed to bridge gaps in bioinformatics pipelines by offering fast, lightweight operations for sequence manipulation. Use this skill to perform tasks such as calculating sequence statistics, splitting or merging files, and converting between FASTA and FASTQ formats without the overhead of larger genomic frameworks.

## Common CLI Patterns

### Sequence Statistics
To get a quick summary of sequence lengths, GC content, and N-counts:
```bash
fastools stats input.fastq
```

### Format Conversion
Convert FASTQ files to FASTA format while maintaining sequence integrity:
```bash
fastools fastq-to-fasta input.fastq > output.fasta
```

### Sequence Extraction and Filtering
Extract specific sequences based on identifiers or filter by length:
```bash
# Extract sequences by ID list
fastools extract ids.txt input.fasta > filtered.fasta

# Filter sequences shorter than a specific threshold
fastools filter -m 50 input.fastq > long_reads.fastq
```

### File Manipulation
Handle paired-end data or split large files for parallel processing:
```bash
# Interleave paired-end files
fastools interleave forward.fastq reverse.fastq > interleaved.fastq

# De-interleave a file into two separate files
fastools deinterleave interleaved.fastq -1 forward.fastq -2 reverse.fastq
```

## Expert Tips
- **Piping**: fastools is designed to work with standard streams. Chain commands together (e.g., `fastools filter ... | fastools stats`) to avoid creating large intermediate files.
- **Compressed Files**: Most fastools commands natively support gzipped input, which is standard for raw sequencing data.
- **Validation**: Use the `stats` command as a first step in any pipeline to ensure the input file is not corrupted and meets expected quality metrics.



## Subcommands

| Command | Description |
|---------|-------------|
| fastools aln | Calculate the Levenshtein distance between two FASTA files. |
| fastools collapse | Remove all mononucleotide stretches from a FASTA file. |
| fastools csv2fa2 | Convert a CSV file to two FASTA files. |
| fastools dna2rna | Convert the FASTA/FASTQ content from DNA to RNA. |
| fastools edit | Replace regions in a reference sequence. The header of the edits file must have the following strucure: >name chrom:start_end |
| fastools fa2fq | Convert a FASTA file to a FASTQ file. |
| fastools fa2gb | Convert a FASTA file to a GenBank file. |
| fastools famotif2bed | Find a given sequence in a FASTA file and write the results to a Bed file. |
| fastools fq2fa | Convert a FASTQ file to a FASTA file. |
| fastools gb2fa | Convert a GenBank file to a FASTA file. |
| fastools gen | Generate a DNA sequence in FASTA format. |
| fastools maln | Calculate the Hamming distance between all sequences in a FASTA file. |
| fastools mangle | Calculate the complement (not reverse-complement) of a FASTA sequence. |
| fastools restrict | Fragment a genome with restriction enzymes. |
| fastools reverse | Make the reverse complement a FASTA/FASTQ file. |
| fastools rna2dna | Convert the FASTA/FASTQ content from RNA to DNA. |
| fastools rselect | Select a substring from every read. Positions are one-based and inclusive. |
| fastools s2i | Convert sanger FASTQ to illumina FASTQ. |
| fastools sanitise | Convert a FASTA/FASTQ file to a standard FASTA/FASTQ file. |
| fastools select | Select a substring from every read. Positions are one-based and inclusive. |
| fastools splitseq | Split a FASTA/FASTQ file based on containing part of the sequence |
| fastools_add | Add a sequence to the 5' end of each read in a FASTQ file. |
| fastools_cat | Return the sequence content of a FASTA file. |
| fastools_descr | Return the description of all records in a FASTA file. |
| fastools_get | Retrieve a reference sequence and find the location of a specific gene. |
| fastools_lenfilt | Split a FASTA/FASTQ file on length. |
| fastools_length | Report the lengths of all FASTA records in a file. |
| fastools_list_enzymes | List of restriction enzymes. |
| fastools_merge | Merge two FASTA files. |
| fastools_raw2fa | Make a FASTA file from a raw sequence. |
| fastools_tagcount | Count tags in a FASTA file. |

## Reference documentation
- [fastools Overview](./references/anaconda_org_channels_bioconda_packages_fastools_overview.md)