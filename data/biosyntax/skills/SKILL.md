---
name: biosyntax
description: bioSyntax provides syntax highlighting for computational biology file formats to improve the manual inspection of genomic data. Use when user asks to view highlighted biological files in the terminal, inspect SAM or VCF records with color-coding, or pipe bioinformatics tool outputs into a formatted viewer.
homepage: https://github.com/bioSyntax/bioSyntax
metadata:
  docker_image: "biocontainers/biosyntax:v1.0.0b-1-deb_cv1"
---

# biosyntax

## Overview
bioSyntax is a suite of syntax highlighting definitions designed specifically for computational biology. It transforms dense, monochromatic biological data into intuitively structured text, making it easier to manually inspect alignments, sequences, and variant calls. This skill focuses on the native command-line wrappers and editor configurations that allow researchers to work more efficiently with large-scale genomic data.

## CLI Usage Patterns
The primary method for using bioSyntax in the terminal is through its format-specific `less` wrappers. These tools allow for high-performance, highlighted viewing of large files.

### Using [format]-less Wrappers
Instead of using standard `less`, use the bioSyntax equivalent for the specific file type:
- `sam-less [file.sam]` - Highlights SAM alignments.
- `vcf-less [file.vcf]` - Highlights VCF variant records.
- `fasta-less [file.fasta]` - Highlights FASTA sequences.
- `fastq-less [file.fastq]` - Highlights FASTQ sequences and quality scores.

### Piping from Bioinformatics Tools
You can pipe output from standard tools directly into bioSyntax wrappers to inspect data streams in real-time. Use the `-` character to denote reading from standard input:
- `samtools view -h sample.bam | sam-less -`
- `bcftools view sample.bcf | vcf-less -`
- `grep "pattern" sequences.fasta | fasta-less -`

## Supported File Formats
bioSyntax provides specialized logic for the following formats:
- **Alignments**: .sam, .flagstat, .clustal
- **Sequences**: .fasta, .fastq, .faidx
- **Variants**: .vcf
- **Annotations**: .gtf, .bed
- **Structures**: .pdb

## Editor Integration and Best Practices
- **Automatic Detection**: Once installed, bioSyntax typically recognizes files by their extension. If highlighting does not appear in Vim, ensure the filetype is set correctly (e.g., `:set filetype=sam`).
- **Header Inclusion**: For SAM files, always include the header (the `@` lines) when piping. bioSyntax uses header information to correctly parse and color-code the alignment section.
- **Performance**: Because the CLI wrappers are based on `less`, they are safe to use on multi-gigabyte files. They do not load the entire file into memory, making them ideal for quick inspections of BAM/SAM or VCF files.
- **Installation**: Use the `bioSyntax_INSTALL.sh` script found in the repository root to automatically configure Vim, Less, Sublime3, and Gedit environments.

## Expert Tips
- **Terminal Compatibility**: If colors appear garbled, ensure your terminal supports 256 colors (check `echo $TERM`).
- **Streaming Data**: Use `sam-less` when debugging pipelines to verify that read groups, flags, and CIGAR strings are being generated as expected without needing to write a full BAM file to disk.

## Reference documentation
- [bioSyntax Main Repository](./references/github_com_bioSyntax_bioSyntax.md)