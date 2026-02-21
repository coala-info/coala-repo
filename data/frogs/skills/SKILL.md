---
name: frogs
description: FROGS (Find, Rapidly, OTUs with Galaxy Solution) is a comprehensive bioinformatic suite designed for the analysis of amplicon sequencing data.
homepage: https://github.com/geraldinepascal/FROGS
---

# frogs

## Overview

FROGS (Find, Rapidly, OTUs with Galaxy Solution) is a comprehensive bioinformatic suite designed for the analysis of amplicon sequencing data. While it is widely known for its Galaxy integration, it provides a robust Command Line Interface (CLI) for automated pipelines. It excels at transforming raw reads into filtered, taxonomically annotated abundance tables (BIOM format) and provides statistical insights into microbial communities. The workflow is particularly strong in handling diverse sequencing technologies and managing complex issues like multi-affiliations and functional predictions.

## Installation and Environment Management

FROGS requires specific environments due to conflicting dependencies (notably R versions for PICRUSt2).

*   **Core Tools**: Install via Bioconda.
    ```bash
    conda env create --name frogs@5.1.0 --file frogs-conda-requirements.yaml
    conda activate frogs@5.1.0
    ```
*   **Functional Analysis**: Use a dedicated environment for `FROGSFUNC` tools.
    ```bash
    conda env create --name frogsfunc@5.1.0 --file frogsfunc-conda-requirements.yaml
    conda activate frogsfunc@5.1.0
    ```

## Common CLI Patterns

### 1. Preprocessing and Merging
The first step typically involves merging paired-end reads.
*   **Standard Merge**: Uses VSEARCH by default.
*   **PEAR Integration**: If PEAR is installed in your PATH or `libexec`, use `--merge-software pear` for potentially higher merging efficiency in complex regions like ITS.
*   **Overlap Requirement**: Ensure a minimum overlap of 10nt between R1 and R2; otherwise, reads may be rejected or treated as non-overlapping.

### 2. Denoising and Clustering
FROGS supports multiple clustering and denoising strategies:
*   **Swarm**: Use for clustering without a global similarity threshold.
*   **DADA2**: Use for high-resolution ASV (Amplicon Sequence Variant) generation.
*   **Fastidious Mode**: When using Swarm, the "fastidious" option is recommended to recover low-abundance sequences.

### 3. Taxonomic Affiliation
Assigning identity to sequences:
*   **BLAST+**: The default engine for taxonomic assignment.
*   **Multi-affiliation**: FROGS handles sequences that match multiple references, providing a clear view of taxonomic uncertainty.

### 4. Conversion and Export
To move from the internal BIOM format to readable tables:
*   Use `biom2tsv.py` to generate TSV files for Excel or R.

## Expert Tips and Best Practices

*   **Memory Management**: When running the test suite or large-scale affiliations, explicitly define memory and CPU limits:
    `sh test_frogs.sh <NB_CPU> <JAVA_MEM_GB> <OUT_FOLDER>`
*   **ITS Processing**: For ITS data, always run the `itsx.py` tool to extract the conserved regions and remove flanking LSU/SSU sequences, which improves clustering and affiliation accuracy.
*   **Chimera Removal**: FROGS manages separated PCRs during the chimera removal step. Ensure your metadata correctly identifies samples to allow for cross-sample chimera detection.
*   **Parallelization**: Most FROGS tools support the `--nb-cpu` parameter. Scale this according to your hardware, but monitor memory usage as some steps (like RDP Classifier) can be memory-intensive.
*   **Verification**: Always run the included `test_frogs.sh` after installation to ensure all dependencies (Python, Perl, R, and binaries like VSEARCH/Swarm) are correctly linked.

## Reference documentation
- [FROGS GitHub Repository](./references/github_com_geraldinepascal_FROGS.md)
- [Bioconda FROGS Package Overview](./references/anaconda_org_channels_bioconda_packages_frogs_overview.md)