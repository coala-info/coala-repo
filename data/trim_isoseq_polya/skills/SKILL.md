---
name: trim_isoseq_polya
description: The `trim_isoseq_polya` tool identifies and removes polyA tail sequences from IsoSeq transcript FASTA files. Use when user asks to 'remove polyA tails', 'trim polyA sequences', or 'prepare IsoSeq transcripts for alignment'.
homepage: https://github.com/PacificBiosciences/trim_isoseq_polyA
metadata:
  docker_image: "quay.io/biocontainers/trim_isoseq_polya:0.0.3--h7c8eefc_0"
---

# trim_isoseq_polya

## Overview
The `trim_isoseq_polya` tool is a specialized utility designed for the Pacific Biosciences IsoSeq workflow. It identifies and removes polyA tail sequences from transcript FASTA files. This step is essential for improving alignment accuracy and ensuring that the polyA tail does not interfere with the identification of the true 3' end of the transcript.

## Usage Guidelines

### Basic Command Pattern
The tool typically operates on input FASTA files generated during the IsoSeq pipeline.
```bash
trim_isoseq_polyA -i input.fasta -o trimmed_output.fasta
```

### Key Parameters
*   `-i, --input`: Path to the input FASTA file containing IsoSeq transcripts.
*   `-o, --output`: Path for the resulting FASTA file with polyA tails removed.
*   `-m, --min-length`: (Optional) Minimum length of the polyA tail to be trimmed (check version-specific defaults, usually ~20bp).

### Best Practices
*   **Pipeline Placement**: Run this tool after clustering (e.g., after `isoseq cluster` or `isoseq3`) but before mapping to a reference genome.
*   **Input Format**: Ensure the input is in FASTA format. If your data is in BAM format (common in newer PacBio workflows), convert to FASTA first or use the `isoseq3` suite's integrated trimming features if available.
*   **Validation**: Compare the sequence lengths before and after trimming to ensure the tool is correctly identifying tails without over-trimming the transcript body.

## Reference documentation
- [trim_isoseq_polya Overview](./references/anaconda_org_channels_bioconda_packages_trim_isoseq_polya_overview.md)