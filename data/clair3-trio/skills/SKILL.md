---
name: clair3-trio
description: Clair3-Trio is a variant caller that performs joint genomic analysis on family trios using Nanopore long-read sequencing data. Use when user asks to call variants from a trio, perform pedigree-based genomic analysis, or identify SNPs and Indels using Mendelian inheritance priors.
homepage: https://github.com/HKU-BAL/Clair3-Trio
---


# clair3-trio

## Overview

Clair3-Trio is a specialized variant caller designed for family-based genomic analysis using Nanopore long-reads. While standard callers treat family members as independent samples, Clair3-Trio employs a Trio-to-Trio deep neural network and a specialized loss function (MCVLoss) that incorporates Mendelian inheritance priors. This joint calling approach significantly improves F1-scores for SNPs and Indels and drastically reduces the number of predicted variants that violate inheritance laws, making it the preferred tool for pedigree-based research and clinical genetics using ONT data.

## Command Line Usage

The primary entry point is the `run_clair3_trio.sh` script. It requires paths to the reference genome, BAM files for all three members, and specific pre-trained models.

### Basic Execution Pattern

```bash
run_clair3_trio.sh \
  --ref_fn=/path/to/ref.fa \
  --bam_fn_c=/path/to/child.bam \
  --bam_fn_p1=/path/to/parent1.bam \
  --bam_fn_p2=/path/to/parent2.bam \
  --sample_name_c=CHILD_ID \
  --sample_name_p1=PARENT1_ID \
  --sample_name_p2=PARENT2_ID \
  --threads=16 \
  --model_path_clair3=/path/to/models/clair3_models/MODEL_NAME \
  --model_path_clair3_trio=/path/to/models/clair3_trio_models/TRIO_MODEL_NAME \
  --output=/path/to/output_dir
```

### Key Parameters

- `--bam_fn_c/p1/p2`: Input BAM files for Child, Parent 1, and Parent 2.
- `--model_path_clair3`: Path to the standard Clair3 model used for pileup calling.
- `--model_path_clair3_trio`: Path to the specific Trio model used for joint calling.
- `--gvcf`: Enable this flag to generate output in gVCF format.
- `--enable_phasing`: Enables phasing for the called variants.

## Expert Tips and Best Practices

### Model Selection and Matching
It is critical to match the Clair3 pileup model with the Clair3-Trio model based on the flowcell and chemistry used:
- **R10.4.1 (Kit 14/Q20+):** Use `r1041_e82_400bps_sup_v400` (Clair3) with `c3t_hg002_dna_r1041_e82_400bps_sup` (Trio).
- **R9.4.1 (Guppy 5 SUP):** Use `r941_prom_sup_g5014` (Clair3) with `c3t_hg002_r941_prom_sup_g5014` (Trio).
- **R9.4.1 (Guppy 4 HAC):** Use `r941_prom_hac_g360+g422` (Clair3) with `c3t_hg002_g422` (Trio).

### Path Handling
When running via Docker or Singularity, always use **absolute paths** for input and output directories. Ensure the container has appropriate volume mounts (`-v`) for the reference, BAMs, models, and output location.

### Performance Expectations
Clair3-Trio is optimized for speed. A whole-genome trio call typically takes approximately 2.4 times the runtime of a single-sample Clair3 run, rather than the 3 times expected from independent processing.

### Phasing and Haplotagging
For advanced downstream analysis, use the following flags to produce phased VCFs and haplotagged BAMs:
- `--enable_phasing`
- `--enable_output_phasing`
- `--enable_output_haplotagging`

## Reference documentation
- [Clair3-Trio GitHub Repository](./references/github_com_HKU-BAL_Clair3-Trio.md)
- [Bioconda Clair3-Trio Package](./references/anaconda_org_channels_bioconda_packages_clair3-trio_overview.md)