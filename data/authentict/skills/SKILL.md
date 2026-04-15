---
name: authentict
description: AuthentiCT estimates modern DNA contamination in ancient DNA single-stranded libraries by modeling C-to-T deamination patterns. Use when user asks to estimate the proportion of modern DNA in an aDNA sample, analyze C-to-T substitution frequencies, or simulate ancient DNA sequences with specific damage parameters.
homepage: https://github.com/StephanePeyregne/AuthentiCT
metadata:
  docker_image: "quay.io/biocontainers/authentict:1.0.1--py311h9f5acd7_0"
---

# authentict

## Overview

AuthentiCT is a specialized command-line tool designed for paleogenomics to estimate present-day DNA contamination in ancient DNA single-stranded libraries. It operates by modeling ancient DNA damage (specifically C-to-T deamination) and assumes that modern contaminants lack these damage patterns. 

Use this skill when you need to:
1. Estimate the proportion of modern DNA in an aDNA sample.
2. Analyze C-to-T substitution frequencies across sequences.
3. Simulate aDNA sequences with specific damage parameters for model testing.

**Important Constraints:**
- **Library Type:** Only supports single-stranded libraries. Do not use for double-stranded library patterns.
- **Treatments:** Cannot be used on samples treated with Uracil-DNA Glycosylase (UDG) or other enzymes that remove deamination.
- **Filtering:** Do not use on datasets already filtered to include only deaminated sequences, as the model requires the full distribution to estimate contamination.

## Installation and Setup

AuthentiCT can be installed via Bioconda or pip:

```bash
# Via Conda
conda install bioconda::authentict

# Via Pip (from source)
pip3 install [path_to_repository]
```

## Input Requirements

- **Format:** SAM format is required.
- **MD Tag:** Every sequence must have an `MD` field to identify substitutions relative to the reference.
- **Preparation:** If the SAM/BAM file lacks MD tags, generate them using `samtools calmd`.

## Command Usage

### Estimating Contamination (deam2cont)

The primary command for contamination estimation.

```bash
# Basic usage with a SAM file
AuthentiCT deam2cont -o results.txt -s 100000 input.sam

# Processing a BAM file via pipe
samtools view -h input.bam | AuthentiCT deam2cont -o results.txt -s 100000 -
```

**Key Options:**
- `-m [int]`: Mapping quality cutoff (e.g., 30).
- `-l [int]`: Sequence length cutoff (e.g., 35).
- `-b [int]`: Base quality cutoff (e.g., 30).
- `-s [int]`: Maximum number of sequences used to fit the model (default: 100,000).
- `--decoding`: Prints posterior probabilities for each state (5' overhang, double-stranded, internal single-stranded, 3' overhang) line-by-line.

### Analyzing Deamination (deamination)

Use this to inspect the raw C-to-T substitution frequencies.

```bash
AuthentiCT deamination -o deam_freqs.txt -m 30 -l 35 input.sam
```

### Simulating aDNA (simulation)

Generates simulated sequences under the ancient DNA damage model.

```bash
AuthentiCT simulation -N 1000 -GC 0.4 -L 50 -l 30 -o simulated.sam
```

## Expert Tips and Best Practices

1. **MD Field Generation:** Always ensure your SAM/BAM has been processed with `samtools calmd`. Without the MD tag, AuthentiCT cannot identify the substitutions necessary for the damage model.
2. **Memory and Performance:** For very large datasets, use the `-s` flag to limit the number of sequences used for model fitting. 100,000 sequences is usually sufficient for a stable estimate.
3. **Configuration Files:** For advanced users, you can provide a tab-separated configuration file to specify fixed parameters (e.g., error rate `e`, contamination `contam`, or deamination rates `rss`).
4. **Interpreting Output:** The `deam2cont` output provides a likelihood ratio (score). A higher score indicates a higher probability that the sequence is endogenous rather than a contaminant.
5. **Quality Control:** Use the `-m` (mapping quality) and `-b` (base quality) filters to ensure that the deamination signal is not being confounded by sequencing errors or misalignments.

## Reference documentation
- [AuthentiCT GitHub Repository](./references/github_com_StephanePeyregne_AuthentiCT.md)
- [Bioconda AuthentiCT Overview](./references/anaconda_org_channels_bioconda_packages_authentict_overview.md)