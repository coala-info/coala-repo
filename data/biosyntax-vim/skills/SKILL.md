---
name: biosyntax-vim
description: biosyntax-vim provides syntax highlighting and intuitive color schemes for common bioinformatics file formats within the Vim editor. Use when user asks to view genomic data with color-coded patterns, highlight biological file formats like SAM or VCF in Vim, or visually inspect sequence alignments and quality scores.
homepage: https://github.com/bioSyntax/bioSyntax-vim
---


# biosyntax-vim

## Overview
bioSyntax-vim is a specialized plugin that brings intuitive color schemes to standard bioinformatics file formats. It helps researchers identify patterns, errors, and structural elements in large genomic and proteomic datasets directly within the Vim editor. By mapping specific biological meanings (like base quality, feature types, or sequence identity) to distinct colors, it transforms dense text files into human-readable data.

## Usage and Best Practices

### Filetype Detection
The plugin automatically recognizes common biological extensions. Open any supported file to trigger the highlighting:
- **Sequencing**: `.fq`, `.fastq`, `.sam`, `.bam`
- **Genomics**: `.gtf`, `.gff`, `.bed`, `.vcf`
- **Structural/Other**: `.pdb`, `.aln`, `.nexus`, `.flagstat`

### Manual Filetype Overrides
If a file lacks a standard extension or the syntax does not trigger automatically, manually set the filetype within Vim:
- For SAM files: `:set filetype=sam`
- For FASTQ files: `:set filetype=fq`
- For GTF/BED files: `:set filetype=gtf` or `:set filetype=bed`
- For Clustal/ALN files: `:set filetype=aln`

### Working with Large Files
Bioinformatics files are often massive. To maintain performance while using syntax highlighting:
- **Disable Undo**: Use `vim -n [file]` to skip the swap file for faster loading.
- **Read-Only Mode**: Use `view [file]` or `vim -R [file]` to prevent accidental modifications to raw data.
- **Large File Plugin**: Consider using a "LargeFile" plugin alongside bioSyntax to automatically disable certain features (like folding) that can lag on multi-gigabyte SAM files.

### Integration with `less`
You can use bioSyntax highlighting as a pager for the command line. Add the following to your shell configuration (e.g., `.bashrc` or `.zshrc`) to use Vim as a colorized pager:
```bash
alias biosyntax='vim -R -c "set syntax=on" -'
```
Then pipe data directly:
```bash
samtools view -h sample.bam | head -n 100 | biosyntax
```

### Expert Tips
- **Conserved Positions**: When viewing `.aln` (Clustal) files, bioSyntax highlights conserved residues, making it easier to identify functional domains in alignments.
- **Base Quality**: In FASTQ files, the syntax highlighting often distinguishes between the sequence line and the quality score line, helping you visually scan for low-quality 'N' bases.
- **Chromosomal Shading**: For GTF and BED files, the plugin uses "2shade" coloring to help distinguish between different chromosomes or feature types.

## Reference documentation
- [bioSyntax-vim Repository](./references/github_com_bioSyntax_bioSyntax-vim.md)
- [Supported Formats and Commits](./references/github_com_bioSyntax_bioSyntax-vim_commits_master.md)