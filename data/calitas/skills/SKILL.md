---
name: calitas
description: CALITAS identifies potential CRISPR off-target sites by performing specialized gapped alignments between guide sequences and a reference genome. Use when user asks to search for off-target sites, align sequences to a reference, perform pairwise sequence alignments, or prepare VCF files for variant-aware searches.
homepage: https://github.com/editasmedicine/calitas
---


# calitas

## Overview
CALITAS is a specialized bioinformatic tool designed to identify potential CRISPR off-target sites by performing customized gapped alignments. Unlike standard aligners, it is "CRISPR-aware," meaning it understands the relationship between protospacers and PAM sequences. It excels at providing a non-redundant list of candidate sites, allowing for mismatches and DNA/RNA bulges (gaps) while maintaining a consistent "canonical" alignment for every locus found.

## Core Commands
CALITAS operates via four primary sub-commands:
- `SearchReference`: The main tool for genome-wide discovery of off-target sites using a FASTA reference.
- `AlignToReference`: Used to generate standardized, high-quality alignments for a list of known genomic coordinates.
- `PairwiseAlignSequences`: Performs direct alignment between two sets of sequences.
- `PrepareVcf`: Optimizes VCF files for use in variant-aware off-target searches.

## Usage Guidelines

### Reference Preparation
All commands utilizing a FASTA file require a sequence index (`.fai`) and a sequence dictionary (`.dict`).
```bash
samtools faidx reference.fa
samtools dict -a GRCh38 -s human -o reference.dict reference.fa
```

### Off-Target Search (SearchReference)
To search a genome for a specific guide, provide the guide sequence in UPPER CASE and the PAM in lower case.
```bash
calitas SearchReference \
  -i GAGTCCGAGCAGAAGAAGAAnrg \
  -I guide_name \
  -r hg38.fa \
  -o results.txt \
  --max-guide-diffs 5 \
  --max-pam-mismatches 1
```

### Standardizing Known Sites (AlignToReference)
If you have a list of coordinates (e.g., from an experimental assay) and want the CALITAS-standardized alignment:
1. Create a tab-delimited input with headers: `id`, `query`, `chrom`, `position`.
2. Run the alignment:
```bash
calitas AlignToReference -i input_sites.txt -r hg38.fa -o output_alignments.txt --window-size 60
```

### Variant-Aware Searching
To include genetic variation in your search, first process your VCF:
```bash
calitas PrepareVcf -i input.vcf -o prepared.vcf.gz
```
Then pass the prepared VCF to `SearchReference` using the `-v` flag to find off-targets that only exist in specific genetic backgrounds.

## Expert Tips
- **PAM Flexibility**: You can provide multiple PAMs or perform PAM-less searches by adjusting the input string and the `--max-pam-mismatches` parameter.
- **Scoring**: Use the customizable scoring system to penalize gaps more heavily than mismatches if your specific Cas enzyme is less tolerant of bulges.
- **Memory Management**: When running the JAR directly, ensure sufficient heap space for large genomes (e.g., `-Xmx8g` for human genome searches).
- **Output Interpretation**: The `strand` column indicates the strand the guide resembles. A `+` strand report means the guide binds to the `-` (bottom) genomic strand.



## Subcommands

| Command | Description |
|---------|-------------|
| AlignToReference | Performs glocal alignment of query sequence to a window on the reference. Input should be a tab-delimited file with the following columns (with headers): |
| PairwiseAlignSequences | Performs pairwise alignment of sequences. Input is a file with two sequences per line, separated by whitespace. Sequences may be composed of DNA and RNA bases and ambiguity codes. No headers are required or expected. |
| PrepareVcf | Prepares a VCF for optimal use by SearchReference. Does the following: |
| SearchReference | Searches a reference sequence for alignments of a guide+PAM. |

## Reference documentation
- [CALITAS README](./references/github_com_editasmedicine_calitas_blob_master_README.md)