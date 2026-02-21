---
name: aquila
description: Aquila is a specialized bioinformatic pipeline designed for diploid genome reconstruction.
homepage: https://github.com/maiziex/Aquila
---

# aquila

## Overview
Aquila is a specialized bioinformatic pipeline designed for diploid genome reconstruction. It leverages the long-range information provided by linked-reads to partition sequencing data into two haplotypes. By performing local assembly on these partitioned reads, Aquila generates high-quality contigs that facilitate the detection of complex structural variations and provide a phased view of the personal genome. It is particularly useful for researchers working with 10x Genomics data who require more than just standard variant calling.

## Installation and Setup
The most efficient way to install Aquila is via Bioconda:
```bash
conda install bioconda::aquila
```
You must also download the required uniqueness map and reference files (specifically for hg38) from the project's Zenodo repository as specified in the documentation.

## Core Workflow

### Step 0: Sorting BAM (Optional/Recommended)
If you plan to run assembly on specific chromosomes or if your computing environment is prone to interruptions, run the sorting step first to save time in Step 1.
```bash
Aquila_step0_sortbam --bam_file possorted_bam.bam --out_dir Assembly_results --num_threads_for_samtools_sort 30
```

### Step 1: Read Partitioning and Phasing
This step partitions the linked-reads based on a provided VCF file.
```bash
Aquila_step1 --bam_file possorted_bam.bam --vcf_file sample_variants.vcf --sample_name MySample --out_dir Assembly_results --uniq_map_dir ./Uniqness_map_hg38
```
**Key Parameters:**
- `--bam_file`: Must be a barcode-aware BAM (e.g., from Longranger).
- `--vcf_file`: Small variants VCF (e.g., from FreeBayes or 1000 Genomes).
- `--uniq_map_dir`: Path to the uniqueness map directory.
- `--chr_start` / `--chr_end`: Use these to process specific chromosomes (use `23` for chrX).

### Step 2: Diploid Assembly
This step performs the actual de novo assembly using the phased fragments from Step 1.
```bash
Aquila_step2 --out_dir Assembly_results --reference ./ref.fa --num_threads 30
```
**Key Parameters:**
- `--reference`: Path to the GRCh38 reference fasta.
- `--num_threads`: Number of files to assemble simultaneously.
- `--num_threads_spades`: Number of threads assigned to the underlying SPAdes assembler.

## Best Practices and Tips
- **Memory Management**: Step 1 is memory-intensive. For a 60X human genome, expect to need ~450GB of RAM if running WGS on a single node.
- **Parallelization**: To reduce wall-clock time, run chromosomes in parallel across multiple nodes using the `--chr_start` and `--chr_end` flags.
- **Sex Chromosomes**: Always use `23` to represent `chrX`. Note that the current version of Aquila does not support `chrY`.
- **Input VCF**: While you can use a sample-specific VCF, using a 1000 Genomes VCF as input can help Aquila better partition linked-reads by providing a set of common variants.
- **Output**: The final contigs are located in `Assembly_results/Assembly_Contigs_files/` as `Aquila_contig.fasta`.

## Reference documentation
- [Aquila GitHub Repository](./references/github_com_maiziex_Aquila.md)
- [Bioconda Aquila Overview](./references/anaconda_org_channels_bioconda_packages_aquila_overview.md)