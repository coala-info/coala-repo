---
name: leehom
description: leehom reconstructs DNA fragments by stripping sequencing adapters and merging overlapping paired-end reads using a Bayesian algorithm. Use when user asks to strip sequencing adapters, merge overlapping paired-end reads, reconstruct DNA fragments from ancient DNA, or automatically infer adapter sequences.
homepage: https://grenaud.github.io/leeHom/
---


# leehom

## Overview
leehom is a specialized bioinformatics tool designed for the reconstruction of DNA fragments from Illumina sequencing data. It employs a Bayesian maximum a posteriori (MAP) algorithm to simultaneously strip sequencing adapters and merge overlapping portions of paired-end reads. While applicable to any Illumina dataset, it is uniquely suited for ancient DNA (aDNA) research because it effectively handles the short fragment lengths and specific error profiles associated with degraded genetic material. The tool relies heavily on base quality scores to calculate the probability of specific insert sizes and sequences.

## Installation and Setup
The most efficient way to install leehom is via Bioconda:
```bash
conda install -c bioconda leehom
```

## Core Usage Patterns

### Multi-threading for Performance
For large datasets, use the multi-threaded version of the tool to overcome I/O bottlenecks.
- **Command**: `leeHomMulti`
- **Flag**: `-t <threads>`
- **Note**: Performance gains typically level off after a few cores due to I/O limitations.

### Automatic Adapter Inference
If the adapter sequences are unknown for paired-end data, leehom can infer them using a maximum-likelihood method.
- **Flag**: `--auto`

### Trimming Leading Bases
To remove a specific number of bases from the start of the sequencing (e.g., to remove damaged terminal bases or specific motifs):
- **Flag**: `-k N,N` (where N is the number of bases to trim)
- **Example**: `-k 2,2` to trim 2 bases from the start of both reads.

### Handling UMIs
leehom can process Unique Molecular Identifiers (UMIs) located at the ends of the insert. If a UMI is observed twice (in both reads of a pair), the tool uses maximum-likelihood inference to determine the correct UMI sequence.

## Expert Tips and Best Practices
- **Quality Score Integrity**: leehom's Bayesian model assumes that quality scores are representative of actual error probabilities. Ensure your data has not undergone transformations that "flatten" or inaccurately rescale quality scores before processing.
- **Insert Size Priors**: For optimal performance, you can provide a prior distribution that models the probability of observing specific insert sizes. This is particularly useful in aDNA contexts where the fragment size distribution is often known or predictable.
- **BAM and FastQ Support**: The tool is compatible with both BAM and FastQ file formats.

## Reference documentation
- [leeHom Project Page](./references/grenaud_github_io_leeHom.md)
- [Bioconda leehom Overview](./references/anaconda_org_channels_bioconda_packages_leehom_overview.md)