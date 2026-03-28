---
name: telr
description: TELR identifies transposable element insertions in long-read sequencing data that are absent from a reference genome. Use when user asks to detect non-reference transposable elements, perform local reassembly of insertion loci, or estimate allele frequencies from PacBio and Oxford Nanopore reads.
homepage: https://github.com/bergmanlab/telr
---

# telr

## Overview
TELR (pronounced "Teller") is a specialized computational pipeline designed to identify transposable element insertions that are present in long-read sequencing data but absent from the reference genome. It is particularly effective for PacBio and Oxford Nanopore technologies. The tool automates a complex four-stage workflow: initial structural variation (SV) detection, local reassembly of candidate loci, precise coordinate mapping of TE-flank boundaries, and estimation of allele frequency within the sample.

## Installation and Environment Setup
The most reliable way to run TELR is within a dedicated Conda environment to manage its numerous bioinformatic dependencies (Sniffles, RepeatMasker, minimap2, etc.).

```bash
# Create and activate the environment
mamba create -n TELR --channel bioconda telr
conda activate TELR
```

## Core CLI Usage
TELR requires three primary inputs: your long reads, a reference genome, and a TE consensus library.

### Basic Command Pattern
```bash
telr -i reads.fq -r reference.fa -l te_library.fa -o output_dir -t 8
```

### Input Formats
- **Reads (`-i`)**: Supports FASTA, FASTQ, or BAM files. If providing BAM, ensure it was generated using compatible aligners like Minimap2 (with Cigar/MD strings) or NGMLR.
- **Reference (`-r`)**: FASTA format. Must match the assembly used for initial read mapping.
- **Library (`-l`)**: FASTA format containing TE consensus sequences.

## Expert Configuration and Best Practices

### Technology Presets
Always specify the sequencing technology to optimize internal parameters:
- For PacBio: `-x pacbio` (default)
- For Oxford Nanopore: `-x ont`

### Tool Selection (Aligners, Assemblers, and Polishers)
TELR allows swapping components based on your data quality and computational resources:
- **Aligner**: `--aligner nglmr` (default, better for SVs) or `--aligner minimap2` (faster).
- **Assembler**: `--assembler wtdbg2` (default, fast) or `--assembler flye` (often more robust for complex TEs).
- **Polisher**: `--polisher wtdbg2` or `--polisher flye`. Match the polisher to the assembler for best results.

### Performance Tuning
- **Threading**: Use `-t` to specify CPU cores. Local assembly is parallelized per candidate locus.
- **Polishing Iterations**: Increase `-p` (e.g., `-p 2` or `-p 3`) if working with high-error raw reads to improve insertion sequence accuracy.
- **Intermediate Files**: Use `-k` or `--keep_files` during troubleshooting to inspect local assemblies and RepeatMasker logs.

### Refining Insertion Detection
- **Gap/Overlap**: If you find TEs are being missed or coordinates are slightly off, adjust `-g` (max gap) and `-v` (max overlap) for flanking sequence alignments.
- **Annotation**: Use `--minimap2_family` if you want to bypass RepeatMasker for TE family annotation, which can be significantly faster for large datasets.



## Subcommands

| Command | Description |
|---------|-------------|
| minimap2 | Minimap2 is a versatile tool for sequence alignment. It can be used for various tasks including indexing reference genomes, mapping long reads (PacBio, Nanopore), short reads, and performing overlap detection for assembly. |
| ngmlr | ngmlr 0.2.7 (build: Feb 21 2022 18:53:53, start: 2026-02-25.22:02:43) |
| sniffles | Structural Variant Caller |
| telr | Program for detecting non-reference TEs in long read data |

## Reference documentation
- [TELR Usage Guide](./references/github_com_bergmanlab_TELR_blob_master_docs_02_Usage.md)
- [Installation Instructions](./references/github_com_bergmanlab_TELR_blob_master_docs_01_Installation.md)
- [Output File Descriptions](./references/github_com_bergmanlab_TELR_blob_master_docs_03_Output_Files.md)
- [TELR README](./references/github_com_bergmanlab_TELR_blob_master_README.md)