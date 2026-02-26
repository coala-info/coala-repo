---
name: varlociraptor
description: Varlociraptor is a high-precision variant caller that statistically models and filters genetic variants. Use when user asks to estimate sequencing error profiles, call genetic variants, filter variant calls by FDR, re-evaluate candidate variants, estimate allele fractions, or analyze multi-sample scenarios.
homepage: https://varlociraptor.github.io
---


# varlociraptor

## Overview
Varlociraptor is a high-precision variant caller that replaces traditional heuristic filters with a unified statistical model. It calculates the probability of specific biological scenarios (e.g., "is this variant somatic?") and provides a Maximum A Posteriori (MAP) estimate of the allele fraction. Use this tool to move away from manual "hard-filtering" (like depth or quality cuts) and instead filter calls based on a target FDR, ensuring reproducible and statistically sound results across different sequencing technologies and experimental designs.

## Core Workflow and CLI Patterns

### 1. Preprocessing and Alignment Properties
Before calling, Varlociraptor needs to estimate the error profile of your sequencing data.
```bash
varlociraptor estimate alignment-properties reference.fasta --bam sample.bam > model.json
```
*Tip: Run this for each sample to account for sample-specific biases (e.g., different library prep or sequencing runs).*

### 2. Calling Variants
Varlociraptor uses a "scenario" configuration to define the expected genetics. The calling process typically involves two steps: preprocessing the observations and then calculating the posterior probabilities.

**Preprocess observations:**
```bash
varlociraptor preprocess variants reference.fasta --bam sample.bam --candidates candidates.vcf > sample.bcf
```

**Call based on a scenario:**
```bash
varlociraptor call variants generic --scenario scenario.yaml --observations sample=sample.bcf > calls.bcf
```
*Note: The scenario file defines the samples, their relationships, and the events you want to distinguish (e.g., germline vs. somatic).*

### 3. FDR-Based Filtration
Instead of filtering by QUAL or DP, use the `filter-calls` command to control the false discovery rate for a specific event defined in your scenario.
```bash
varlociraptor filter-calls control-fdr calls.bcf --events SOMATIC_TUMOR --fdr 0.05 > filtered.vcf
```

## Expert Tips
- **Candidate Generation:** Varlociraptor is a "proposer-verifier" caller. It requires a VCF of candidate variants (from tools like Delly, FreeBayes, or a simple pileup). It then re-evaluates these candidates using its statistical model.
- **Unified Model:** Use the same tool for both small variants (SNVs/Indels) and structural variants (SVs). The statistical model handles both by evaluating the evidence in the BAM/CRAM files.
- **MAP Estimates:** Look for the `AF` field in the output, which represents the Maximum A Posteriori estimate of the alteration fraction. This is more robust than a simple ratio of reads, as it accounts for mapping uncertainty and biases.
- **Multi-Sample Scenarios:** When working with pedigrees or tumor-normal pairs, define the "contamination" or "heterogeneity" parameters in your scenario to allow the model to account for impure samples.

## Reference documentation
- [Varlociraptor Homepage](./references/varlociraptor_github_io_landing.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_varlociraptor_overview.md)