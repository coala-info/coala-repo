---
name: aquilasv
description: AquilaSV is a specialized bioinformatics tool designed for region-based diploid assembly.
homepage: https://github.com/maiziezhoulab/AquilaSV
---

# aquilasv

## Overview

AquilaSV is a specialized bioinformatics tool designed for region-based diploid assembly. It excels at identifying structural variants by reconstructing haplotypes from linked-read sequencing data (specifically 10X and stLFR). The tool operates in a sequential three-step pipeline that moves from read phasing and molecule reconstruction to local assembly using SPAdes, and finally to variant calling against a reference genome. It is particularly useful for researchers needing high-resolution diploid assemblies of specific genomic regions to resolve complex structural variations.

## Installation and Setup

The most reliable way to install AquilaSV is via Bioconda:

```bash
conda install bioconda::aquilasv
```

Ensure that `samtools` and `minimap2` are available in your PATH, as they are critical dependencies for the assembly and alignment steps.

## Core Workflow

The AquilaSV pipeline must be executed in order. Each step relies on the output directory created by the previous step.

### Step 1: Phasing and Molecule Reconstruction
This step processes the linked-reads and prepares them for assembly.

```bash
python3 AquilaSV_step1.py --bam_file input.bam --vcf_file variants.vcf --chr_num 1 --out_dir results_dir
```

*   **--bam_file**: Input BAM generated from BWA-MEM, LongRanger, or EMA.
*   **--vcf_file**: Small variants (SNPs/Indels) from a caller like FreeBayes, used for phasing.
*   **--mole_boundary**: (Optional) Default is 50000 (50kb). Adjust this to differentiate reads with the same barcode from different long molecules.

### Step 2: Local Assembly
This step performs the diploid assembly of the phased reads.

```bash
python3 AquilaSV_step2.py --out_dir results_dir --chr_num 1 --reference hg19.fa
```

*   **--num_threads**: Controls how many files are assembled simultaneously.
*   **--num_threads_spades**: Controls the threads used by the underlying SPAdes assembler (the `-t` parameter).

### Step 3: Structural Variant Calling
The final step compares the assembled contigs to the reference to call SVs.

```bash
python3 AquilaSV_step3.py --assembly_dir results_dir --ref_file hg19.fa --chr_num 1 --out_dir final_vcf_dir
```

*   **--var_size**: (Optional) Default is 1. This is the cutoff size for indels and SVs.
*   **--clean**: (Optional) Default is 1. Set to 0 if you wish to keep intermediate assembly files for manual inspection.

## Best Practices and Tips

*   **Resource Management**: For a 60X coverage dataset, expect a memory footprint of approximately 20GB.
*   **Chromosome Formatting**: Ensure the `--chr_num` matches the naming convention in your BAM and Reference files (e.g., use `3` or `chr3` consistently).
*   **Output Inspection**: The final output is `AquilaSV_Contig_final.vcf`. You can also find haplotype-specific fasta files (`hp1.fasta` and `hp2.fasta`) in the `Assembly_Contigs_files` subdirectory for further analysis or visualization in IGV.
*   **Threading**: Step 2 is the most computationally intensive. Balance `--num_threads` and `--num_threads_spades` based on your total available CPU cores to avoid over-subscription.

## Reference documentation
- [AquilaSV Overview](./references/anaconda_org_channels_bioconda_packages_aquilasv_overview.md)
- [AquilaSV GitHub Documentation](./references/github_com_maiziezhoulab_AquilaSV.md)