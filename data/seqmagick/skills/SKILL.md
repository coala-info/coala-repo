---
name: seqmagick
description: seqmagick is a powerful command-line interface that acts as a frontend for Biopython's SeqIO module.
homepage: http://github.com/fhcrc/seqmagick
---

# seqmagick

## Overview
seqmagick is a powerful command-line interface that acts as a frontend for Biopython's SeqIO module. It simplifies complex sequence manipulation tasks into concise commands. Use this skill to perform format conversions, remove gaps, generate reverse complements, filter sequences by quality or ID, and deduplicate datasets. It is designed for bioinformaticians who need the reliability of Biopython with the convenience of an ImageMagick-like syntax.

## Common CLI Patterns

### 1. File Information and Statistics
Use the `info` command to get a quick summary of sequence files, including the number of sequences, format, and length statistics.
```bash
# Describe all FASTA and Stockholm files in the directory
seqmagick info *.fasta *.sto
```

### 2. Format Conversion
The `convert` command handles transitions between different bioinformatics file formats.
```bash
# Convert FASTA to PHYLIP
seqmagick convert input.fasta output.phy

# Convert FASTQ to FASTA
seqmagick convert input.fastq output.fasta
```

### 3. In-place Modification (Mogrify)
The `mogrify` command applies transformations directly to the input file. Use this with caution as it overwrites the original data.
```bash
# Remove all gaps from a FASTA file in-place
seqmagick mogrify --ungap sequences.fasta

# Convert all sequences to uppercase in-place
seqmagick mogrify --upper-case sequences.fasta
```

### 4. Sequence Manipulation
You can apply multiple transformations during a conversion or modification.
```bash
# Reverse complement sequences and sort by length
seqmagick convert --revcomp --sort length input.fasta output.fasta

# Remove gaps and change case to lowercase
seqmagick convert --ungap --lower-case input.fasta output.fasta
```

### 5. Subsetting and Filtering
Filter sequences based on specific criteria like ID or quality scores.
```bash
# Deduplicate sequences (remove identical sequences)
seqmagick convert --deduplicate-sequences input.fasta output.fasta

# Filter sequences by a list of IDs in a file
seqmagick convert --include-from-file ids.txt input.fasta output.fasta
```

## Expert Tips
- **Biopython Parity**: Since seqmagick is a wrapper for Biopython, it supports any format that `Bio.SeqIO` supports. If a format is missing, ensure your environment has the latest Biopython installed.
- **Pipe Support**: seqmagick supports standard streams. Use `-` as a filename to read from stdin or write to stdout.
- **Quality Trimming**: For NGS data, use the quality filtering options to clean up FASTQ files before downstream analysis.
- **Alignment Cleaning**: The `--ungap` flag is essential when moving from a multiple sequence alignment (MSA) back to unaligned sequences for tools that do not support gap characters.

## Reference documentation
- [github_com_fhcrc_seqmagick.md](./references/github_com_fhcrc_seqmagick.md)
- [anaconda_org_channels_bioconda_packages_seqmagick_overview.md](./references/anaconda_org_channels_bioconda_packages_seqmagick_overview.md)