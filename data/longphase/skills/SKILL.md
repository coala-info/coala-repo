---
name: longphase
description: LongPhase is an ultra-fast genomic phasing engine that integrates SNPs, structural variants, and methylation data into unified haplotypes using long-read sequencing. Use when user asks to phase variants, co-phase structural variants with SNPs, haplotag reads, or phase DNA modifications.
homepage: https://github.com/twolinin/longphase
---


# longphase

## Overview

LongPhase is an ultra-fast genomic phasing engine optimized for long-read technologies. It moves beyond simple SNP phasing by allowing the simultaneous integration of multiple variant types—including structural variants and methylation data—into a unified haplotype framework. It is particularly effective for Nanopore ultra-long reads, where it can produce nearly chromosome-level blocks in minutes. Use this skill to construct command-line workflows for variant phasing, read haplotagging, and modification calling.

## Core Workflows and CLI Patterns

### 1. Basic SNP Phasing
The primary command for phasing SNPs. You must specify the sequencing platform to apply the correct error model.

```bash
# For Nanopore data
longphase phase \
  -s input_snps.vcf \
  -b alignment.bam \
  -r reference.fasta \
  -t 16 \
  -o output_prefix \
  --ont

# For PacBio HiFi data
longphase phase \
  -s input_snps.vcf \
  -b alignment.bam \
  -r reference.fasta \
  -t 16 \
  -o output_prefix \
  --pb
```

### 2. Co-phasing SVs and Indels
To improve haplotype block length and resolve structural variants, provide the SV VCF alongside the SNP VCF.

```bash
longphase phase \
  -s snps.vcf \
  --sv-file structural_variants.vcf \
  -b alignment.bam \
  -r reference.fasta \
  --ont \
  -o phased_variants
```

### 3. Haplotagging Reads
Once variants are phased, use the `haplotag` command to assign individual reads in a BAM/CRAM file to specific haplotypes (HP1 or HP2).

```bash
longphase haplotag \
  -s phased_snps.vcf \
  --sv-file phased_svs.vcf \
  -b alignment.bam \
  -r reference.fasta \
  -t 8 \
  -o tagged_reads
```
*   **Tip**: Use `--cram` to output in CRAM format instead of the default BAM.
*   **Tip**: Use `--qualityThreshold` (default 1) to skip tagging low-quality alignments.

### 4. Phasing DNA Modifications (5mC)
This is a two-step process. First, call modifications, then phase them.

```bash
# Step 1: Call modifications
longphase modcall \
  -b alignment.bam \
  -r reference.fasta \
  -t 16 \
  -o mod_calls

# Step 2: Phase modifications with SNPs
longphase phase \
  -s snps.vcf \
  --mod-file mod_calls.vcf \
  -b alignment.bam \
  -r reference.fasta \
  --ont \
  -o phased_modifications
```

## Expert Tips and Best Practices

*   **Input Preparation**: Ensure your BAM/CRAM files are sorted and indexed (`samtools index`). The reference FASTA must also be indexed (`samtools faidx`).
*   **Memory Management**: LongPhase is highly efficient, but for very high coverage or complex regions, ensure sufficient threads (`-t`) are allocated to maintain its "ultra-fast" performance.
*   **Region Filtering**: If you only need to phase a specific chromosome or locus, use the `--region` parameter (e.g., `--region chr1:1000000-2000000`) to save time and resources.
*   **Somatic Phasing**: For specialized somatic cases, note that there are sister projects: `longphase-s` (paired tumor/normal) and `longphase-to` (tumor-only).
*   **Supplementary Alignments**: By default, `haplotag` may not tag supplementary alignments. Use `--tagSupplementary` if your analysis requires every alignment segment to be assigned a haplotype.



## Subcommands

| Command | Description |
|---------|-------------|
| haplotag | Tag alignments with haplotype information based on SNP and SV data. |
| modcall | modcall |
| phase | Phases genomic reads using SNP and optionally SV information. |

## Reference documentation
- [LongPhase Main Documentation](./references/github_com_twolinin_longphase.md)
- [Haplotag Command Parameters](./references/github_com_twolinin_longphase_blob_main_Haplotag.cpp.md)
- [Example Docker Workflow](./references/github_com_twolinin_longphase_blob_main_Dockerfile.md)