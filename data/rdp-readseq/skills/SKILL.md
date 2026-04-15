---
name: rdp-readseq
description: rdp-readseq converts and manipulates ribosomal RNA sequence data between various bioinformatics formats. Use when user asks to convert sequence formats, resample sequence files, reverse complement DNA, remove redundant sequences, split files, or select sequences by ID.
homepage: https://anaconda.org/channels/bioconda/packages/rdp-readseq/overview
metadata:
  docker_image: "biocontainers/rdp-readseq:v2.0.2-6-deb_cv1"
---

# rdp-readseq

## Overview
The `rdp-readseq` tool is a specialized utility for bioinformaticians working with microbial sequence data. It bridges the gap between the Ribosomal Database Project's specific data structures and common sequence analysis formats. Use this skill to automate the conversion of large rRNA datasets, ensuring that metadata and sequence integrity are preserved during format transitions.

## Command Line Usage
The tool typically operates as a Java-based utility. The primary syntax follows this pattern:

`java -jar readseq.jar [options] [input-file]`

### Common Conversion Patterns
*   **FASTA Conversion**: To convert an RDP-formatted file to FASTA (the most common requirement for BLAST or alignment tools):
    `rdp-readseq -f8 input_file > output.fasta`
*   **Format Identification**: To check the format of an unknown sequence file:
    `rdp-readseq -i input_file`
*   **Multiple Sequences**: The tool can process files containing multiple entries, outputting them as a concatenated stream in the target format.

### Format Flags
Use these flags with the `-f` option to specify output formats:
*   `-f1`: IG/Stanford
*   `-f2`: GenBank
*   `-f3`: EMBL
*   `-f8`: FASTA
*   `-f12`: Phylip

## Expert Tips
*   **Piping**: `rdp-readseq` supports standard streams. You can pipe the output directly into alignment tools like `mafft` or `clustalo` to save disk space and time.
*   **Memory Management**: For very large RDP database files, increase the Java heap size using `-Xmx` (e.g., `java -Xmx2g -jar readseq.jar ...`).
*   **Header Preservation**: When converting to FASTA, RDP-specific identifiers are often truncated or modified. Always verify that your downstream tools can parse the resulting headers, especially if they contain taxonomic information.



## Subcommands

| Command | Description |
|---------|-------------|
| ReadSeqMain | Main entry point for ReadSeq operations. Use with a subcommand. |
| ResampleSeqFile | ResampleSeqFile |
| RevComplement | Reverse complement a DNA sequence |
| RmRedundantSeqs | Remove redundant sequences from a FASTA file. |
| SeqFileSplitter | Splits a sequence file into smaller files. |
| SequenceSelector | Selects sequences from input files based on a list of IDs. |
| rdp-readseq_to-fastq | Converts sequence files to FASTQ format. |
| to-fasta | Converts RDP readseq format to FASTA format. |
| to-stk | Converts a readseq file to a Stockholm format file. |

## Reference documentation
- [Bioconda rdp-readseq Overview](./references/anaconda_org_channels_bioconda_packages_rdp-readseq_overview.md)