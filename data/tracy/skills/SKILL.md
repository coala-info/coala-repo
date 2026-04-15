---
name: tracy
description: Tracy is a high-performance tool for analyzing, aligning, and basecalling Sanger sequencing data. Use when user asks to basecall chromatogram files, align traces to a reference, decompose heterozygous mutations, or assemble multiple traces into a consensus sequence.
homepage: https://github.com/gear-genomics/tracy
metadata:
  docker_image: "quay.io/biocontainers/tracy:0.8.1--h4d20210_0"
---

# tracy

## Overview
Tracy is a specialized tool for the high-performance analysis of Sanger sequencing data. It moves beyond simple basecalling by providing robust algorithms for profile-to-sequence and profile-to-profile alignment. It is particularly useful for deconvolving heterozygous mutations (double peaks) into separate alleles and performing reference-guided or de novo assembly of Sanger traces.

## Core Workflows

### Basecalling
Convert raw chromatogram files into standard sequence formats.
- **FASTA/FASTQ**: `tracy basecall -f fasta -o out.fasta input.ab1`
- **Detailed Trace Info**: Use `json` or `tsv` formats to see primary and secondary basecalls, which is essential for identifying heterozygous sites.
  - `tracy basecall -f json -o out.json input.ab1`

### Trace Alignment
Align a trace to a reference sequence or another chromatogram.
- **To FASTA reference**: `tracy align -r reference.fa -o prefix input.ab1`
- **To Wildtype trace**: `tracy align -r wildtype.ab1 -o prefix input.ab1`
- **To Genome**: Requires an index.
  1. Index: `tracy index -o hg38.fa.fm9 hg38.fa.gz`
  2. Align: `tracy align -r hg38.fa.gz input.ab1`

### Variant Calling and Deconvolution
Handle complex traces with heterozygous mutations or indels.
- **Decomposition**: Split a heterozygous trace into two separate alleles.
  - `tracy decompose -r reference.fa -o prefix input.ab1`
- **Variant Calling**: Call and annotate SNVs and InDels.
  - `tracy decompose -v -a homo_sapiens -r hg38.fa.gz -o prefix input.ab1`
  - *Note*: Output is in BCF format; use `bcftools view` to convert to VCF.

### Assembly and Consensus
Combine multiple traces into a single sequence.
- **Forward/Reverse Consensus**: `tracy consensus forward.ab1 reverse.ab1`
- **Reference-Guided Assembly**: `tracy assemble -r reference.fa file1.ab1 file2.ab1 ...`
- **De Novo Assembly**: `tracy assemble file1.ab1 file2.ab1 ...` (requires sufficient overlap).

## Expert Tips
- **Indexing**: Large genome indices only need to be built once. Always check if a `.fm9` index exists before running `align` on a genome.
- **Heterozygous Indels**: If a trace becomes "messy" after a certain point, use `decompose`. This is a common sign of a heterozygous insertion or deletion.
- **Output Prefixes**: Many subcommands use `-o` as a filename prefix rather than a single file, as they generate multiple related output files (e.g., `.align1`, `.align2`, `.bcf`).



## Subcommands

| Command | Description |
|---------|-------------|
| tracy align | Align Sanger trace files to a reference genome or wildtype trace |
| tracy assemble | Assemble trace files into a consensus sequence, optionally guided by a reference. |
| tracy basecall | Basecalling of Sanger trace files |
| tracy consensus | Generate a consensus sequence from two trace files |
| tracy decompose | Decompose Sanger chromatogram trace files to identify variants or reference alignments. |
| tracy index | Index a genome for tracy |

## Reference documentation
- [Tracy CLI Usage](./references/www_gear-genomics_com_docs_tracy_cli.md)
- [Tracy GitHub Repository](./references/github_com_gear-genomics_tracy.md)