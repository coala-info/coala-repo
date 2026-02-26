---
name: phu
description: phu is a modular bioinformatics toolkit designed to streamline viral genomics workflows by providing tools for sequence clustering, protein family screening, and taxonomic data parsing. Use when user asks to identify protein families within DNA contigs, dereplicate viral sequences into species-level vOTUs, or simplify complex taxonomy prediction outputs.
homepage: https://github.com/camilogarciabotero/phu
---


# phu

## Overview
`phu` (Phage Utilities) is a modular bioinformatics toolkit designed to streamline viral genomics workflows. It provides a unified command-line interface for complex tasks such as sequence clustering, protein family screening, and taxonomic data parsing. By wrapping high-performance tools like vclust, pyHMMER, and Pyrodigal, it allows researchers to move from raw viral contigs to classified and grouped viral operational taxonomic units (vOTUs) efficiently.

## Installation
Install `phu` via the Bioconda channel:
```bash
mamba create -n phu bioconda::phu
conda activate phu
```

## Core Commands and Usage

### 1. Screening Contigs (`screen`)
Use this command to identify specific protein families within DNA contigs. It automatically handles gene prediction and HMM searches.

*   **Basic screening**:
    ```bash
    phu screen --input contigs.fasta --hmm markers.hmm --output results/
    ```
*   **Advanced options**:
    *   `--hmm_mode`: Specify the type of HMM file (e.g., `hmmer3`).
    *   `--save-proteins`: Extract and save the predicted protein sequences that matched the HMMs.
    *   `--custom-hmm`: Build a custom HMM from the screening results for downstream analysis.

### 2. Sequence Clustering (`cluster`)
Use this to dereplicate viral sequences or group them into species-level vOTUs. This command leverages `vclust` for high-performance alignment and clustering.

*   **Standard clustering**:
    ```bash
    phu cluster --input viral_sequences.fasta --output_dir clusters/
    ```
*   **Workflow**: This is typically used after initial viral identification to reduce redundancy in a dataset before performing comparative genomics.

### 3. Taxonomy Simplification (`simplify-taxa`)
Use this to parse and condense complex taxonomy prediction outputs (specifically from vContact) into readable, compact lineage codes.

*   **Usage**:
    ```bash
    phu simplify-taxa --input vcontact_output.csv --output simplified_taxonomy.tsv
    ```

## Expert Tips and Best Practices
*   **Protein Prediction**: `phu` uses `Pyrodigal-gv` or `ViralGeneFinder` for gene prediction during the `screen` process. If working with highly divergent viral genomes, ensure your input contigs are of sufficient length (typically >1kb) for reliable gene calls.
*   **Performance**: The `screen` command utilizes `pyHMMER` for significant speed improvements over standard HMMER by avoiding disk I/O for intermediate files.
*   **Data Cleaning**: Before running `cluster`, it is often beneficial to use `seqkit` (a dependency of `phu`) to filter out very short sequences or low-complexity reads to improve clustering quality.
*   **Taxonomy Mapping**: When using `simplify-taxa`, ensure your input headers match the expected vContact format to allow the regex-based simplification logic to function correctly.

## Reference documentation
- [phu Overview](./references/anaconda_org_channels_bioconda_packages_phu_overview.md)
- [phu GitHub Repository](./references/github_com_camilogarciabotero_phu.md)