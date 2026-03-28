---
name: savana
description: "SAVANA is a somatic structural variant caller and copy number aberration analyzer optimized for long-read sequencing data. Use when user asks to detect structural variations, identify copy number aberrations, estimate tumor purity, or perform tumor-only somatic variant calling."
homepage: https://github.com/cortes-ciriano-lab/savana
---


# savana

## Overview

SAVANA is a specialized somatic variant caller optimized for long-read sequencing data, such as Oxford Nanopore (ONT) and PacBio HiFi. It processes aligned tumor and normal BAM files to detect structural variations through read evidence clustering and consensus breakpoint calling. Beyond SVs, SAVANA identifies copy number aberrations (CNAs) using circular binary segmentation and provides advanced genomic insights, including tumor purity estimation, ploidy determination, and allele-specific absolute copy number fitting.

## Command Line Usage and Best Practices

### Core Execution Patterns

The primary entry point for somatic SV calling requires tumor and normal BAMs, a reference FASTA, and an output directory.

**Standard Somatic SV Calling:**
```bash
savana --tumour <tumour.bam> --normal <normal.bam> --outdir <output_dir> --ref <reference.fasta>
```

**Integrated SV and CNA Calling:**
To enable copy number analysis, you must provide germline SNP information. Using a matched germline SNP VCF is strongly recommended for accuracy.
```bash
savana --tumour <tumour.bam> --normal <normal.bam> --outdir <output_dir> --ref <reference.fasta> --snp_vcf <germline_snps.vcf>
```

**Tumor-Only Mode:**
Use the `to` subcommand when a matched normal sample is unavailable.
```bash
savana to --tumour <tumour.bam> --outdir <output_dir> --ref <reference.fasta> --g1000_vcf 1000g_hg38
```

### Expert Tips and Optimization

*   **Phasing for Performance:** For optimal SV calling and CNA fitting, phase your input BAM files prior to running SAVANA. Phased data significantly improves the tool's ability to distinguish somatic events.
*   **Targeted Analysis:** Use the `--contigs` argument to restrict the analysis to specific chromosomes (e.g., `--contigs contigs.hg38.txt`). This reduces processing time and avoids artifacts in unplaced or decoy contigs.
*   **CNA Blacklisting:** When calling CNAs, provide a blacklist BED file using `--blacklist` to exclude problematic genomic regions (e.g., centromeres or high-signal regions) that can skew segmentation results.
*   **Resource Management:** For large datasets, utilize the `--threads` parameter to parallelize the workload. A typical subset run (50k reads) takes approximately 1 minute with 8 CPUs.
*   **SNP Source Selection:** If a matched germline VCF is unavailable, use the built-in 1000 Genomes references via `--g1000_vcf 1000g_hg38` (for hg38) or `--g1000_vcf 1000g_hg19` (for hg19).

### Subcommand Reference

*   `run`: Identify and cluster breakpoints (raw variants).
*   `classify`: Apply a model to classify variants in an existing VCF.
*   `cna`: Execute the copy number aberration pipeline independently.
*   `to`: Specialized mode for tumor-only somatic SV identification.
*   `evaluate`: Compare SAVANA VCFs against truth sets to label somatic/germline status.



## Subcommands

| Command | Description |
|---------|-------------|
| run | Savana is a tool for structural variant detection in cancer genomes. |
| savana classify | Classify variants in a VCF file. |
| savana cna | Copy Number Aberration analysis tool |
| savana evaluate | Evaluate VCF files by comparing them against reference VCFs and adding labels to the INFO field. |
| savana train | Train the model to predict germline and somatic variants (GERMLINE label must be present) |
| to | Convert BAM files to SAVANA output format |

## Reference documentation
- [SAVANA Main Repository and Documentation](./references/github_com_cortes-ciriano-lab_savana_blob_main_README.md)
- [SAVANA Project Overview](./references/github_com_cortes-ciriano-lab_savana.md)