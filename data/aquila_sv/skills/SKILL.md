---
name: aquila_sv
description: AquilaSV detects structural variants by performing local, phased diploid assemblies from linked-read sequencing data. Use when user asks to detect structural variants, perform local phased assembly, or identify haplotype-specific genomic variations.
homepage: https://github.com/maiziezhoulab/AquilaSV
---


# aquila_sv

## Overview
AquilaSV is a specialized bioinformatics pipeline designed to detect structural variants by performing local, phased diploid assemblies. Instead of relying solely on read alignments, it reconstructs haplotype-specific contigs to identify complex genomic variations with high precision. The tool is optimized for linked-read technologies and operates in a three-step sequential workflow to move from raw alignments to a final VCF.

## Installation and Environment
The most reliable way to use AquilaSV is via Bioconda:
```bash
conda install bioconda::aquila_sv
```
Ensure that `SAMtools`, `minimap2`, and `SPAdes` are installed and accessible in your system PATH, as the pipeline relies on these for alignment and assembly tasks.

## Execution Workflow

### Step 1: Phasing and Molecule Reconstruction
This step processes the input BAM and VCF to generate phased molecule files and haplotype-specific fastq files.
```bash
AquilaSV_step1 --bam_file input.bam --vcf_file initial_variants.vcf --chr_num 1 --out_dir results_sv
```
*   **--bam_file**: Must be generated from BWA-MEM, LongRanger, or EMA.
*   **--vcf_file**: Initial variants (e.g., from FreeBayes) used for phasing.
*   **--mole_boundary**: Default is 50000 (50kb). Adjust this if your linked-read molecule lengths differ significantly.

### Step 2: Local Assembly
This step uses SPAdes to perform local assemblies of the phased regions.
```bash
AquilaSV_step2 --out_dir results_sv --chr_num 1 --reference genome.fa --num_threads 10 --num_threads_spades 5
```
*   **--num_threads**: Controls how many files are assembled simultaneously.
*   **--num_threads_spades**: Controls the threads assigned to each individual SPAdes instance.

### Step 3: Variant Calling
The final step aligns the assembled contigs back to the reference to call the final set of variants.
```bash
AquilaSV_step3 --assembly_dir results_sv --ref_file genome.fa --chr_num 1 --out_dir final_vcf_output
```
*   **--var_size**: Default is 1. This is the cutoff size for indels and SVs.
*   **Output**: The primary result is `AquilaSV_Contig_final.vcf`, containing SNPs, small Indels, and SVs.

## Expert Tips and Best Practices
*   **Resource Management**: For a single SV region at 60X coverage, expect to use approximately 20GB of RAM. Scale your `--num_threads` accordingly to avoid OOM (Out of Memory) errors on high-density regions.
*   **Disk Space**: Use the `--clean 1` flag (enabled by default) in Step 1 and Step 3 to automatically delete intermediate assembly files and temporary fastq/bam files, which can otherwise consume significant storage.
*   **Input Requirements**: Ensure your input BAM is indexed. If you are targeting specific chromosomes, ensure the `--chr_num` matches the naming convention in your BAM/VCF (e.g., "1" vs "chr1").
*   **Haplotype Analysis**: The pipeline generates separate fasta files for each haplotype (`Aquila_Contig_chr*_hp1.fasta` and `hp2.fasta`). These can be used for manual inspection of specific variants in assembly viewers or via dot-plots.

## Reference documentation
- [AquilaSV Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_aquila_sv_overview.md)
- [AquilaSV GitHub Documentation](./references/github_com_maiziezhoulab_AquilaSV.md)