---
name: centreseq
description: The centreseq tool is a bioinformatics pipeline designed to rapidly establish a core genome from a collection of bacterial strains. Use when user asks to establish a core genome, annotate bacterial assemblies, or perform sequence clustering.
homepage: https://github.com/bfssi-forest-dussault/centreseq
---

# centreseq

## Overview

The `centreseq` tool is a bioinformatics pipeline designed to rapidly establish a core genome from a collection of bacterial strains. It streamlines the process of gene prediction, clustering, and core genome identification by integrating several high-performance tools like Prokka for annotation and MMseqs2 for sequence clustering. This skill provides the necessary procedural knowledge to execute the `centreseq` workflow, manage its dependencies, and interpret its outputs for downstream genomic analysis.

## Installation and Environment Setup

Due to specific dependency requirements (particularly Prokka and MMseqs2), use the following optimized Conda environment setup to ensure compatibility:

```bash
# Create and configure the environment
conda create -n centreseq python=3.7
conda activate centreseq

# Add necessary channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# Install centreseq and fix Prokka/Perl dependency issues
conda install centreseq -c bioconda
conda uninstall prokka
conda install -c conda-forge -c bioconda -c defaults prokka
conda install perl=5.22.0
```

## Core CLI Usage

The primary entry point for the tool is the `centreseq` command.

### Basic Command Structure
```bash
centreseq [OPTIONS] COMMAND [ARGS]...
```

### Common Commands and Options
- `--version`: Check the current installed version.
- `--help`: Display available commands and detailed option descriptions.

### Workflow Best Practices
1. **Input Preparation**: Ensure your bacterial strain sequences are in standard FASTA format.
2. **Annotation**: The tool typically utilizes Prokka for functional annotation. Ensure Prokka is correctly configured in your path.
3. **Clustering**: `centreseq` uses MMseqs2 for clustering. Note that version `9-d36de` is specifically recommended to avoid known bugs in later versions that may cause functional tests to hang.
4. **Output Management**: The tool generates core genome alignments and summary statistics. Use the `--output` flags (where applicable) to organize results into specific directories for easier downstream processing with tools like RAxML or FastTree.

## Troubleshooting and Known Issues

- **Hanging Tests**: If the functional tests hang indefinitely, verify that `mmseqs2` is pinned to version `9-d36de`.
- **Perl Errors**: Prokka often fails due to Perl version mismatches. Downgrading to `perl=5.22.0` within the `centreseq` environment usually resolves these conflicts.
- **Resource Allocation**: For large numbers of strains, ensure sufficient threads are allocated to MMseqs2 via the CLI options to reduce processing time.



## Subcommands

| Command | Description |
|---------|-------------|
| centreseq | CentreSeq is a tool for analyzing sequencing data. |
| centreseq core | Given an input directory containing any number of assemblies (.fasta), centreseq core will 1) annotate the genomes with Prokka, 2) perform self- clustering on each genome with MMSeqs2 linclust, 3) concatenate the self- clustered genomes into a single pan-genome, 4) cluster the pan-genome with MMSeqs2 linclust, establishing a core genome, 5) generate helpful reports to interrogate your dataset Note that if specified output directory already exists, centreseq will search for an existing Prokka directory and skip this step if possible. |
| centreseq extract | Given the path to the centreseq core directory and the ID of a cluster representative, will create a multi-FASTA containing the sequences for all members of that cluster. Generates both an .ffn and .faa file. |
| centreseq_subset | Given an input text file of Sample IDs and a summary report, will return a filtered version of the summary report for clusters that belong exclusively in the input sample ID list |
| centreseq_tree | Processes centreseq core output files to produce files that can be fed into phylogenetic tree building software. |

## Reference documentation

- [Main Repository Overview](./references/github_com_BFSSI-Bioinformatics-Lab_centreseq.md)
- [Installation and README](./references/github_com_BFSSI-Bioinformatics-Lab_centreseq_blob_master_README.md)
- [Conda Metadata and Dependencies](./references/github_com_BFSSI-Bioinformatics-Lab_centreseq_blob_master_meta.yaml.md)