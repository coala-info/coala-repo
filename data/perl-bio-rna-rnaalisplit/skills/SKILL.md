---
name: perl-bio-rna-rnaalisplit
description: This tool splits structural RNA alignments into smaller subsets while preserving secondary structure metadata. Use when user asks to split RNA alignments, extract individual sequences from a Stockholm file, or deconvolve multi-sequence alignments while maintaining consensus structure information.
homepage: http://metacpan.org/pod/Bio::RNA::RNAaliSplit
metadata:
  docker_image: "quay.io/biocontainers/perl-bio-rna-rnaalisplit:0.11--pl5321hdfd78af_0"
---

# perl-bio-rna-rnaalisplit

## Overview
This tool provides a specialized interface for manipulating structural RNA alignments. It is particularly useful for bioinformatics workflows where large, multi-sequence alignments need to be broken down into constituent parts while preserving secondary structure information (SS_cons). It automates the "deconvolution" process, ensuring that when an alignment is split, the corresponding structural metadata remains consistent with the subset of sequences.

## Usage Patterns

### Basic Alignment Splitting
The primary command `rnaalisplit` is used to process Stockholm files.

```bash
rnaalisplit input_alignment.stk
```

### Common Options and Flags
- `--outdir <dir>`: Specify a directory to store the resulting split files.
- `--split-by-seq`: Extract each sequence into its own individual alignment file.
- `--keep-structure`: Ensures that the consensus secondary structure line is preserved and correctly truncated/mapped in the output files.
- `--format <format>`: While it defaults to Stockholm, you can specify output formats if the specific version supports conversion (e.g., fasta, phylip).

### Expert Tips
- **Stockholm Format Requirement**: Ensure your input files contain the `#=GC SS_cons` line if you are performing structure-aware splitting. The tool relies on these headers to maintain structural integrity.
- **Handling Large Alignments**: When working with Rfam-scale alignments, use the `--outdir` flag to avoid cluttering your working directory, as the tool can generate hundreds of files depending on the number of sequences.
- **Validation**: After splitting, verify the integrity of the output files using `esl-alistat` (from the HMMER/Easel suite) to ensure the alignments are still valid and the lengths match the expected structural coordinates.

## Reference documentation
- [Bio::RNA::RNAaliSplit Documentation](./references/metacpan_org_pod_Bio__RNA__RNAaliSplit.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-rna-rnaalisplit_overview.md)