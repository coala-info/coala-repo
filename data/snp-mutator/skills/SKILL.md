---
name: snp-mutator
description: The snp-mutator tool generates mutated FASTA replicates from a reference genome by introducing substitutions, insertions, and deletions. Use when user asks to create mutated genomic sequences, generate ground-truth VCF files for pipeline validation, or simulate population diversity through polymorphic mutations.
homepage: https://github.com/CFSAN-Biostatistics/snp-mutator
metadata:
  docker_image: "quay.io/biocontainers/snp-mutator:1.2.0--pyh24bf2e0_0"
---

# snp-mutator

## Overview
The `snp-mutator` tool is a specialized utility for bioinformatics that transforms a reference FASTA file into one or more mutated replicates. It supports a variety of mutation types—including single-base substitutions, insertions, and deletions—distributed uniformly across the genome or restricted to specific "pools" of eligible positions. Beyond generating sequences, it produces essential metadata such as VCF files and mutation summaries, making it a powerful tool for validating genomic pipelines.

## CLI Usage and Best Practices

### Core Command
The primary entry point for the tool is `snpmutator`. While specific flag names are often context-dependent based on the version, the tool generally follows standard bioinformatics CLI patterns for input and output.

### Key Capabilities
- **Replicate Generation**: Create multiple mutated versions of a single reference genome in one execution.
- **Mutation Types**: Supports substitutions, insertions, and deletions.
- **Controlled Randomness**: Mutations are uniformly distributed by default, but can be constrained to specific genomic regions (pools).
- **Group Partitioning**: Replicates can be organized into groups, where each group shares a specific pool of eligible mutation sites.
- **Output Formats**:
    - **FASTA**: The mutated sequences.
    - **VCF**: Standard Variant Call Format files representing the introduced changes.
    - **Summary/Metrics**: Files detailing the original base vs. the mutation and various genomic metrics.

### Expert Tips
- **Output Organization**: Use the output directory option to prevent cluttering your workspace, especially when generating a large number of replicates.
- **Custom Deflines**: Use the sequence ID customization feature to ensure that downstream tools can distinguish between different replicates or groups.
- **Monomorphic vs. Polymorphic**: Decide whether mutations should be consistent across all replicates (monomorphic) or vary between them (polymorphic) to better simulate real-world population diversity.
- **VCF Validation**: Always generate the VCF output when using these sequences to test SNP pipelines, as it provides the "ground truth" for sensitivity and specificity calculations.

## Reference documentation
- [github_com_CFSAN-Biostatistics_snp-mutator.md](./references/github_com_CFSAN-Biostatistics_snp-mutator.md)
- [anaconda_org_channels_bioconda_packages_snp-mutator_overview.md](./references/anaconda_org_channels_bioconda_packages_snp-mutator_overview.md)