---
name: biosyntax-vim
description: bioSyntax-vim provides domain-specific syntax highlighting for biological data formats within the Vim text editor. Use when user asks to highlight genomic files, visually audit bioinformatics formats like SAM or VCF, or identify sequence patterns in FASTQ files.
homepage: https://github.com/bioSyntax/bioSyntax-vim
---


# biosyntax-vim

## Overview
bioSyntax-vim is a specialized plugin that integrates the bioSyntax coloring logic into the Vim text editor. It transforms the standard monochrome or poorly highlighted terminal view of biological data into a structured, color-coded environment. By providing domain-specific syntax highlighting for common bioinformatics formats, it allows for faster visual auditing of genomic files, easier identification of sequence patterns (like 'N' bases in FASTQ), and clearer distinction between metadata headers and data records.

## Usage and Best Practices

### Manual Filetype Triggering
While bioSyntax-vim uses `ftdetect` to automatically recognize files by their extensions, you may need to manually trigger highlighting for files with non-standard extensions or when piped from other tools.

Use the following commands within Vim:
- **SAM files**: `:set filetype=sam`
- **VCF files**: `:set filetype=vcf`
- **FASTQ files**: `:set filetype=fq`
- **GTF/GFF files**: `:set filetype=gtf`
- **BED files**: `:set filetype=bed`
- **PDB/PyMol**: `:set filetype=pymol`
- **Multiple Alignment**: `:set filetype=aln`

### Handling Large Genomic Files
Vim can struggle with syntax highlighting on extremely large files (e.g., multi-gigabyte FASTQ or SAM files).
- **Disable highlighting for performance**: If the editor becomes unresponsive, use `:syntax off`.
- **Limit highlighting**: Use `:syntax sync minlines=100` to prevent Vim from parsing the entire file for context.
- **Read-only mode**: Open large files with `vim -R` to prevent accidental modifications while browsing.

### Format-Specific Features
- **GTF/BED Shading**: The plugin supports 2-shade chromosome coloring to help visually distinguish between different genomic regions.
- **FASTQ Validation**: The `fq` syntax highlighting is designed to recognize 'N' characters in sequence lines, making it easier to spot low-quality reads.
- **SAM/BAM Viewing**: When using Vim as a pager for `samtools view`, ensure the filetype is set to `sam` to correctly parse the tab-delimited fields and flag stats.

### Integration with Pagers
To use bioSyntax-vim highlighting when viewing files via `less`, you can utilize the `vimpager` script or set an alias that calls Vim in a read-only, minimal configuration:
```bash
alias biosam='vim -R -c "set ft=sam" -'
```



## Subcommands

| Command | Description |
|---------|-------------|
| vim | Vi IMproved, a text editor |
| vim | VIM - Vi IMproved, a text editor |

## Reference documentation
- [bioSyntax-vim README](./references/github_com_bioSyntax_bioSyntax-vim_blob_master_README.md)
- [Commit History (Supported Formats)](./references/github_com_bioSyntax_bioSyntax-vim_commits_master.md)