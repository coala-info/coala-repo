---
name: hat-phasing
description: HAT reconstructs haplotypes by integrating short-read and long-read sequencing data using a reference genome backbone. Use when user asks to phase SNPs, identify ploidy blocks, or perform haplotype assembly using NGS and TGS data.
homepage: https://github.com/AbeelLab/hat/
metadata:
  docker_image: "quay.io/biocontainers/hat-phasing:0.1.8--pyh5e36f6f_0"
---

# hat-phasing

## Overview
HAT (Haplotype Assembly Tool) is a specialized bioinformatic tool designed to reconstruct haplotypes by leveraging the complementary strengths of Next-Generation Sequencing (NGS) and Third-Generation Sequencing (TGS). By using a reference genome as a backbone, HAT identifies "ploidy blocks"—genomic regions with sufficient heterozygosity—and clusters reads to resolve individual haplotypes. This skill provides guidance on configuring the HAT command line, managing its multi-tool dependencies, and processing the resulting phase matrices and block files.

## Installation and Environment
HAT can be installed via Conda or Pip. Ensure your environment includes the necessary scientific Python stack.

```bash
# Recommended installation via Bioconda
conda install -c bioconda hat-phasing

# Alternative via Pip
pip install HAT-phasing
```

**Dependencies**: HAT requires `pysam`, `Biopython`, `numpy`, `matplotlib`, and `seaborn`. If using the assembly feature (`-ha`), the following must be in your system PATH: `minimap2`, `bwa`, `miniasm`, `seqkit`, and `Pilon`.

## Core Command Pattern
The basic execution of HAT requires six positional arguments following any optional flags.

```bash
HAT [options] <chromosome_name> <vcf_file> <short_read_bam> <long_read_bam> <ploidy> <output_prefix> <output_dir>
```

### Positional Arguments
1.  **chromosome_name**: The specific chromosome/contig to phase (must match the VCF and BAM headers).
2.  **vcf_file**: A VCF containing the SNPs to be used for phasing.
3.  **short_read_bam**: Sorted BAM file of NGS data aligned to the reference.
4.  **long_read_bam**: Sorted BAM file of TGS data aligned to the reference.
5.  **ploidy**: The expected ploidy level (e.g., 2 for diploid, 3 for triploid).
6.  **output_prefix**: Prefix for the generated output files.
7.  **output_dir**: Directory where results will be stored.

## Expert Tips and Best Practices

### Input Optimization
*   **VCF Filtering**: HAT's performance is highly dependent on the quality of SNPs. It is recommended to use tools like `vcffilter` to select high-confidence SNPs before running HAT.
*   **BAM Indexing**: Ensure both short and long-read BAM files are sorted and indexed (`samtools index`).

### Using the Haplotype Assembly (-ha) Feature
The `-ha` option enables the assembly of the actual haplotype sequences rather than just providing the phase matrix.
*   **Required Flags**: When using `-ha`, you must also provide the long-read fasta (`-lf`) and short-read fastq files (`-sf1`, `-sf2`).
*   **Tool Pathing**: Since HAT looks for assembly tools (like `minimap2` and `Pilon`) in the system PATH, verify they are accessible by running `which <tool_name>` before starting a long-running HAT job.

### Interpreting Outputs
HAT produces four primary outputs in the specified directory:
*   **_ploidy_blocks**: A figure and text file defining regions where haplotypes show sufficient differentiation.
*   **_phase_matrix**: Contains the resolved alleles for each SNP locus across the haplotypes.
*   **_phased_blocks**: Details the read clustering, showing which specific reads were assigned to which haplotype and block.

### Targeted Phasing
If you only need to phase a specific region of a chromosome, use the `-pl` (phasing location) flag to limit the scope and reduce computation time.

## Reference documentation
- [HAT Main Documentation](./references/github_com_AbeelLab_hat.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hat-phasing_overview.md)
- [Example Dataset and Command Usage](./references/github_com_AbeelLab_hat_tree_main_Example_haplosim-triploid-CP048984.1-highhetero.md)