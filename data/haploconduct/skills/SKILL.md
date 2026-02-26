---
name: haploconduct
description: HaploConduct is a bioinformatics toolkit for de novo assembly that reconstructs individual haplotype sequences from viral quasispecies or polyploid genomes. Use when user asks to perform strain-aware viral genome assembly, reconstruct haplotypes from high-coverage viral samples, or assemble polyploid genomes while preserving haplotype identity.
homepage: https://github.com/HaploConduct/HaploConduct
---


# haploconduct

## Overview

HaploConduct is a specialized bioinformatics toolkit for de novo assembly that focuses on preserving haplotype identity. Unlike standard assemblers that produce a single consensus sequence, HaploConduct aims to reconstruct the individual sequences of different strains or chromosomes present in a sample. It provides two primary workflows: SAVAGE, which is optimized for extremely high-coverage viral samples where multiple strains coexist, and POLYTE, which is tailored for polyploid genomes where coverage per haplotype is relatively low but the total ploidy is known.

## Usage and CLI Patterns

The toolkit is accessed through a central wrapper script. Note that the current implementation requires a Python 2.7 environment.

### SAVAGE (Strain Aware VirAl GEnome assembly)
Use this for viral quasispecies reconstruction without a reference genome.

*   **Primary Command**: `haploconduct savage`
*   **Input Requirements**: Illumina paired-end reads.
*   **Coverage Target**: Requires high total coverage, typically at least 10,000x.
*   **Mechanism**: Uses an overlap graph-based approach to enumerate statistically well-calibrated groups of reads to reconstruct individual haplotypes.

### POLYTE (POLYploid genome fitTEr)
Use this for diploid or polyploid organisms when the ploidy is known.

*   **Primary Command**: `haploconduct polyte`
*   **Input Requirements**: Illumina paired-end reads.
*   **Coverage Target**: Requires approximately 10x coverage per haplotype; optimal performance is achieved at 15-20x per haplotype.
*   **Mechanism**: Employs an iterative scheme to join reads and contigs while preserving haplotype identity based on a haplotype-aware overlap graph.

## Best Practices and Expert Tips

*   **Environment Management**: Since HaploConduct relies on Python 2.7 and specific C++ dependencies (Boost, OpenMP), it is highly recommended to run it within a dedicated Conda environment.
*   **Reference-Guided Mode**: While designed for de novo assembly, the toolkit can operate in reference-guided mode. In this case, ensure `bwa` and `samtools` are available in your PATH, as they are used for the alignment stages.
*   **Data Quality**: Both methods are specifically tuned for Illumina paired-end data. Ensure adapters are trimmed and low-quality reads are filtered before starting the assembly to improve the accuracy of the overlap graph.
*   **Ploidy Specification**: When using POLYTE, the ploidy must be known and specified. Providing an incorrect ploidy will lead to fragmented or chimeric assemblies.
*   **Memory and CPU**: The overlap graph construction and clique enumeration (via the internal `quick-cliques` package) can be computationally intensive. Ensure your system has sufficient RAM for high-coverage viral datasets.

## Reference documentation

- [HaploConduct GitHub Repository](./references/github_com_HaploConduct_HaploConduct.md)
- [HaploConduct Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_haploconduct_overview.md)