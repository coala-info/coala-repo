---
name: harpy
description: Harpy is a bioinformatics pipeline designed to process linked-read and whole-genome sequencing data into phased haplotypes and assemblies. Use when user asks to perform quality control, demultiplex reads, align sequences to a reference, call SNPs, phase haplotypes, or simulate linked-read data.
homepage: https://github.com/pdimens/harpy/
metadata:
  docker_image: "quay.io/biocontainers/harpy:3.2--pyhdfd78af_0"
---

# harpy

## Overview
Harpy is a comprehensive bioinformatics pipeline designed specifically for linked-read sequencing data, though it also supports standard whole-genome sequencing (WGS). It automates the transition from raw sequencing reads to high-level genomic products like phased haplotypes and assemblies. By leveraging a modular architecture, harpy allows users to execute specific stages of the genomic analysis workflow—such as quality control, alignment, and variant calling—using a consistent command-line interface.

## Core CLI Usage
The primary entry point for the tool is the `harpy` command. It follows a modular structure:

```bash
harpy <module> [options] <args>
```

### Common Modules
- **QC**: Perform quality control on raw or processed reads.
- **Demultiplex**: Separate reads based on barcodes (supports TELLseq, stLFR).
- **Align**: Map reads to a reference genome.
- **SNP**: Call single nucleotide polymorphisms.
- **Phase**: Generate phased haplotypes from linked-read data.
- **Simulate**: Create synthetic linked-read data for benchmarking.

## Utility Scripts
Harpy includes several standalone utilities for manipulating BAM and FASTQ files specific to linked-read metadata (BX tags):

- `bx_stats`: Generate statistics on barcode distribution and molecule lengths.
- `extract_bxtags`: Pull barcode information from reads for downstream analysis.
- `check_bam` / `check_fastq`: Validate the integrity and format of sequencing files.
- `assign_mi`: Assign molecular identifiers to alignments.
- `standardize_barcodes_sam`: Ensure barcode tags follow standard conventions across different platforms.

## Expert Tips and Best Practices
- **Environment Management**: Use `pixi` or `conda` to manage dependencies. Harpy relies on a specific stack including `snakemake`, `pysam`, and `bcftools`.
- **Containerization**: For high-performance computing (HPC) environments, use the Apptainer/Singularity image to ensure reproducibility and avoid dependency conflicts.
- **Simulation for Benchmarking**: If working with a new species or library type, use the `Simulate` module (via HACk or Mimick) to generate a "truth set" to calibrate your variant calling and phasing parameters.
- **Resource Allocation**: Since harpy uses Snakemake internally, you can pass cluster-specific configuration if running on a SLURM or SGE environment to manage memory-intensive steps like alignment and phasing.



## Subcommands

| Command | Description |
|---------|-------------|
| harpy align | Align sequences to a reference genome. Provide an additional subcommand bwa or strobe to get more information on using those aligners. Both have comparable performance, but strobe is typically faster. The aligners are not linked-read aware, but the workflows ensure linked-read information is carried over to the alignment records. |
| harpy assembly | Assemble linked reads into a genome. The linked-read barcodes must be in BX:Z or BC:Z FASTQ header tags. It is strongly recommended to first deconvolve the input FASTQ files with harpy deconvolve. |
| harpy convert | [deprecated] Convert between linked-read formats. This module of Harpy has been deprecated and its function has been moved to the Djinn package. |
| harpy deconvolve | Resolve barcode sharing in unrelated molecules. Provide the input fastq files and/or directories at the end of the command. |
| harpy demultiplex | Demultiplex haplotagged FASTQ files. Check that you are using the correct haplotagging method/technology, since the different barcoding approaches have very different demultiplexing strategies. |
| harpy deps | Locally install workflow dependencies. These commands are intended only for situations on HPCs where conda cannot be installed or the worker nodes do not have internet access to download conda/apptainer workflow dependencies. |
| harpy diagnose | Attempt to resolve workflow errors |
| harpy impute | Impute variant genotypes from alignments. Provide the parameter file followed by the input VCF and the input alignment files/directories (.bam) at the end of the command. |
| harpy metassembly | Assemble linked reads into a metagenome. The linked-read barcodes must be in BX:Z or BC:Z FASTQ header tags. It is strongly recommended to first deconvolve the input FASTQ files with harpy deconvolve. |
| harpy phase | Phase SNPs into haplotypes. Provide the vcf file followed by the input alignment (.bam) files and/or directories. |
| harpy qc | FASTQ adapter removal, quality filtering, etc. Linked-read presence and type is auto-detected. |
| harpy resume | Continue an incomplete Harpy workflow by bypassing preprocessing steps and executing the Snakemake command present in the target directory. |
| harpy simulate | Simulate genomic variants. To simulate genomic variants, provide an additional subcommand {snpindel,inversion,cnv,translocation} to get more information about that workflow. The variant simulator (simuG) can only simulate one type of variant at a time, so you may need to run it a few times if you want multiple variant types. |
| harpy snp | Call SNPs and small indels from alignments. Provide an additional subcommand mpileup or freebayes to get more information on using those variant callers. They are both robust variant callers, but freebayes is recommended when ploidy is greater than 2. |
| harpy sv | Call inversions, deletions, and duplications from alignments using LEVIATHAN or NAIBR. |
| harpy template | Create files and HPC configs for workflows. All commands write to stdout. Use hpc-* and impute without arguments. |
| harpy validate | File format checks for linked-read data. This is useful to make sure your input files are formatted correctly for the processing pipeline before you are surprised by errors hours into an analysis. |
| harpy view | View a workflow's components. These convenient commands let you view/edit the latest workflow log file, snakefile, snakemake parameter file, workflow config file in a directory that was used for the output of a Harpy run. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_pdimens_harpy.md)
- [Harpy README](./references/github_com_pdimens_harpy_blob_main_README.md)
- [Project Configuration and Scripts](./references/github_com_pdimens_harpy_blob_main_pyproject.toml.md)