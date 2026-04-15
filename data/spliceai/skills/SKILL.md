---
name: spliceai
description: SpliceAI is a deep learning tool that predicts the probability of genetic variants altering splicing by evaluating sequence context for the creation or disruption of splice sites. Use when user asks to predict splice-altering effects of variants, interpret delta scores in a VCF, or configure parameters for deep intronic cryptic splice site detection.
homepage: https://github.com/Illumina/SpliceAI
metadata:
  docker_image: "quay.io/biocontainers/spliceai:1.3.1--pyh864c0ab_1"
---

# spliceai

## Overview

SpliceAI is a deep learning-based tool developed by Illumina that predicts the probability of a variant altering splicing. It evaluates the sequence context around a variant to determine if it creates or disrupts splice donor or acceptor sites. Use this skill to correctly configure CLI parameters, interpret the resulting delta scores, and apply appropriate filtering thresholds for variant interpretation.

## Installation

Install SpliceAI and its dependencies (specifically TensorFlow) using pip or conda:

```bash
# Via pip
pip install tensorflow spliceai

# Via conda
conda install -c bioconda spliceai
```

## Basic Usage

The primary interface is the `spliceai` command. It requires an input VCF, a reference genome, and gene annotations.

### Standard Command
```bash
spliceai -I input.vcf -O output.vcf -R genome.fa -A grch38
```

### Using Pipes
For integration into bioinformatics pipelines, you can pipe the input and output:
```bash
cat input.vcf | spliceai -R genome.fa -A grch37 > output.vcf
```

## Parameter Configuration

- **-I / -O**: Input and output VCF paths.
- **-R**: Path to the reference genome fasta file (must match the assembly used in the VCF).
- **-A**: Gene annotation. Use the built-in shortcuts `grch37` or `grch38` for GENCODE V24 canonical annotations, or provide a path to a custom text file.
- **-D (Distance)**: Maximum distance between the variant and the gained/lost splice site. Defaults to 50bp. Increase this (e.g., `-D 500`) to detect deep intronic cryptic splice sites, though this increases runtime.
- **-M (Masking)**: 
    - `0` (Default): Raw scores. Includes all predicted changes.
    - `1`: Masked scores. Sets delta scores to 0 for changes that strengthen existing annotated sites or weaken unannotated sites. Recommended for clinical variant interpretation.

## Interpreting Results

SpliceAI adds a `SpliceAI` entry to the VCF INFO field with the format:
`ALLELE|SYMBOL|DS_AG|DS_AL|DS_DG|DS_DL|DP_AG|DP_AL|DP_DG|DP_DL`

### Delta Scores (DS)
The Delta Score represents the probability (0 to 1) of the variant being splice-altering. Use the maximum of the four DS values:
- **0.2**: High recall (captures most splice-altering variants).
- **0.5**: Recommended (balanced sensitivity and specificity).
- **0.8**: High precision (high confidence in the predicted effect).

### Delta Positions (DP)
Indicates where the splicing change occurs relative to the variant:
- **Positive values**: Downstream of the variant.
- **Negative values**: Upstream of the variant.

## Expert Tips and Limitations

- **Variant Types**: SpliceAI only annotates SNVs and simple INDELs (where either REF or ALT is a single base).
- **Gene Boundaries**: Variants are only scored if they fall within the boundaries defined in the annotation file (`-A`).
- **Proximity to Ends**: Variants within 5kb of chromosome ends are not scored.
- **Reference Consistency**: Ensure the reference fasta matches the VCF exactly; SpliceAI will skip variants where the REF allele does not match the genome.
- **Custom Sequences**: To score sequences not in a VCF, use the Python API to load the models and run `predict()` on one-hot encoded sequences.

## Reference documentation
- [SpliceAI GitHub Repository](./references/github_com_Illumina_SpliceAI.md)
- [Bioconda SpliceAI Overview](./references/anaconda_org_channels_bioconda_packages_spliceai_overview.md)