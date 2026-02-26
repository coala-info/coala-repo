---
name: pathogist
description: PathOGiST is a genomic analysis pipeline that clusters bacterial isolates by integrating SNP, MLST, and CNV genotyping signals. Use when user asks to create distance matrices, perform correlation clustering, or execute a consensus clustering pipeline for pathogen typing.
homepage: https://github.com/WGS-TB/PathOGiST
---


# pathogist

## Overview
PathOGiST (Pathogen Optimal Grouping in Space and Time) is a genomic analysis pipeline designed for public health microbiology. It enables the clustering of bacterial isolates by integrating multiple genotyping signals—specifically SNPs from Snippy, MLSTs from MentaLiST, and CNVs from Prince. Use this skill to navigate the multi-step process of distance matrix creation, correlation clustering, and final consensus clustering to achieve high-resolution pathogen typing that outperforms single-criterion methods.

## Installation and Environment
PathOGiST is optimized for Linux environments and is currently **not compatible with OSX**.

- **Conda Setup**:
  ```bash
  conda create --name pathogist python=3.5
  source activate pathogist
  conda install -c bioconda pathogist
  ```
- **Proprietary Dependency**: You must install **CPLEX** separately as it is proprietary software required for the clustering optimization and is not included in the conda package.

## Core Workflows

### 1. Distance Matrix Creation
Generate distance matrices from specific genotyping tool outputs.
- **Command**: `PATHOGIST distance [path/to/calls_file.txt] [TYPE] [output_path]`
- **Supported Types**: `SNP` (compatible with Snippy), `MLST` (compatible with MentaLiST), `CNV` (compatible with Prince).
- **Input Format**: The `calls_file.txt` must be a plain text file containing a list of **absolute paths** to your individual sample call files (one per line).

### 2. Correlation Clustering
Cluster samples based on a single distance matrix.
- **Command**: `PATHOGIST correlation [distance_matrix.tsv] [threshold] [output_path]`
- **Tip**: The threshold value is a cutoff used to construct the similarity matrix from the distances.

### 3. Consensus Clustering
Combine multiple genotyping signals into a single unified clustering assignment.
- **Command**: `PATHOGIST consensus [distances_list] [clusterings_list] [fine_clusterings_list] [output_path]`
- **Input Requirements**:
  - Input files (distances, clusterings) must use the format `[name]=[absolute_path]`.
  - Example line in a distances list file: `SNP=/absolute/path/to/snp_dist.tsv`
  - The "fine clusterings" file should list the names of the clusterings (e.g., `SNP`) that represent the highest resolution data.

### 4. Full Pipeline Execution
To run the entire workflow from start to finish:
1. **Initialize**: Generate a template configuration file using `PATHOGIST run [path/to/config.yaml] --new_config`.
2. **Configure**: Manually edit the generated file to include absolute paths to your genotyping call files and adjust parameters.
3. **Execute**: Run the pipeline with `PATHOGIST run [path/to/config.yaml]`.

## Best Practices
- **Absolute Paths**: PathOGiST requires absolute paths in almost all input text files and configuration entries. Relative paths often cause the pipeline to fail.
- **Sample Naming**: Ensure sample identifiers are identical across different genotyping methods (e.g., the ID in the SNP call file must match the ID in the MLST call file) to ensure the consensus clustering step can correctly map the isolates.
- **Modular Debugging**: If the full pipeline fails, use the `distance` and `correlation` subcommands individually to verify that each genotyping signal is producing valid intermediate TSV files.

## Reference documentation
- [PathOGiST GitHub Repository](./references/github_com_WGS-TB_PathOGiST.md)
- [Bioconda PathOGiST Overview](./references/anaconda_org_channels_bioconda_packages_pathogist_overview.md)