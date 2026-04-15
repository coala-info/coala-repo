---
name: cutefc
description: The cutefc tool force-calls and regenotypes structural variants from sequencing data using a set of predefined coordinates. Use when user asks to force-call structural variants, regenotype samples based on a population VCF, or determine the presence and zygosity of known variants in BAM or CRAM files.
homepage: https://github.com/tjiangHIT/cuteFC
metadata:
  docker_image: "quay.io/biocontainers/cutefc:1.0.2--pyhdfd78af_0"
---

# cutefc

## Overview
The cutefc tool provides an efficient method for force-calling structural variants. Unlike discovery-based callers that look for novel events, cutefc focuses on regenotyping—taking a set of predefined SV coordinates and re-examining raw sequencing data (BAM/CRAM) to determine the presence and zygosity of those variants in specific samples. This is essential for building high-quality SV pangenomes and performing joint analysis where missing data must be distinguished from true reference alleles.

## Command Line Usage
The primary workflow involves taking a VCF of candidate SVs and a set of alignments to produce a regenotyped VCF.

### Basic Force-Calling
To regenotype a sample based on a population VCF:
```bash
cutefc <input.bam> <reference.fa> <candidates.vcf> <output.vcf> <work_dir>
```

### Key Parameters and Optimization
*   **Thread Management**: Use `-t` to specify the number of threads. Force-calling is computationally intensive during the alignment parsing phase; allocating 8-16 threads is recommended for human-scale genomes.
*   **Coverage Thresholds**: Use `--min_support` to define the minimum number of reads required to support a variant call. For low-depth data, lowering this value can increase sensitivity, though it may introduce noise.
*   **Search Window**: The `--max_cluster_bias` parameter controls how far from the candidate coordinate the tool will look for supporting evidence. Increase this for noisier long-read data (e.g., older Oxford Nanopore runs).

## Best Practices
*   **Input Preparation**: Ensure the candidate VCF is properly sorted and indexed. The tool performs best when the input VCF contains precise breakpoints.
*   **Reference Consistency**: The reference FASTA used for force-calling must be identical to the one used for the original BAM/CRAM alignment to avoid coordinate shifts.
*   **Resource Allocation**: Provide a dedicated `<work_dir>` on a high-speed disk (SSD) as cutefc generates intermediate temporary files during the signature extraction phase.
*   **Batch Processing**: When processing large cohorts, run cutefc on individual samples in parallel and then merge the resulting VCFs using `bcftools merge` or `GLNexus` for a final joint-called project.

## Reference documentation
- [cutefc Overview](./references/anaconda_org_channels_bioconda_packages_cutefc_overview.md)