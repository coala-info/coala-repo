---
name: tadbit
description: Tadbit is a computational framework for the analysis, normalization, and 3D modeling of Hi-C genomic data. Use when user asks to map Hi-C reads, normalize interaction matrices, detect topologically associating domains, or generate three-dimensional chromatin structures.
homepage: http://sgt.cnag.cat/3dg/tadbit/
---


# tadbit

## Overview
Tadbit is a comprehensive computational framework designed for the analysis and 3D modeling of genome structures. It handles the full pipeline of Hi-C data processing, from raw sequence mapping and quality control to the generation of three-dimensional chromatin models. Use this skill to guide the execution of genomic binning, normalization of interaction matrices, and the identification of structural features like TADs.

## Core Workflows and CLI Patterns

### 1. Data Pre-processing and Mapping
Tadbit uses a specialized mapping strategy to handle chimeric reads typical of Hi-C experiments.
- **Gem Mapping**: Use `tadbit map` to align reads. It is recommended to use the iterative mapping approach to maximize the number of valid interactions.
- **Quality Control**: Run `tadbit parse` to filter reads. Focus on removing self-circles, dangling ends, and PCR duplicates.

### 2. Normalization and Binning
Before structural modeling, interaction matrices must be corrected for experimental biases.
- **Binning**: Use `tadbit bin` to aggregate reads into genomic windows (e.g., 10kb, 50kb, 1Mb).
- **Normalization**: Apply the Vanilla Coverage or ICE (Iterative Correction and Eigenvector decomposition) methods via `tadbit normalize`. Ensure the matrix is "balanced" before proceeding to TAD detection.

### 3. TAD Detection
Tadbit identifies Topologically Associating Domains using a breakpoint detection algorithm.
- **Command**: `tadbit segment`
- **Best Practice**: Use the `--closeness` parameter to fine-tune the sensitivity of boundary detection. Higher values result in larger, more inclusive domains.

### 4. 3D Structural Modeling
This is the core "modeling" component where interaction frequencies are converted into spatial constraints.
- **Constraint Generation**: Use `tadbit model` to generate a set of 3D structures that satisfy the Hi-C constraints.
- **Optimization**: It is standard practice to generate an ensemble of models (e.g., 100 to 1000) to account for the stochastic nature of chromatin folding.
- **Validation**: Use the `--evaluate` flag to check the correlation between the input Hi-C data and the distances in the generated 3D models.

## Expert Tips
- **Resolution Selection**: For TAD detection, 50kb resolution is often optimal for mammalian genomes. For fine-scale looping, 5kb or 10kb is required but demands significantly higher sequencing depth.
- **Filtering**: Always check the `tadbit describe` output after parsing to ensure that the percentage of "valid" reads is sufficient (typically >40% of mapped reads).
- **Parallelization**: Modeling is computationally intensive. Utilize the `--cpus` flag to distribute the workload across multiple cores.



## Subcommands

| Command | Description |
|---------|-------------|
| tadbit | TADbit: a toolkit for the analysis of chromosome conformation capture sequencing data. |
| tadbit | A toolkit for analyzing and visualizing Hi-C data. |
| tadbit | A toolkit for analyzing and visualizing TADs. |
| tadbit | TADbit: a toolkit for the analysis of 3D genome organization. |
| tadbit bin | bin Hi-C data into matrices |
| tadbit describe | Describe jobs and results in a given working directory |
| tadbit filter | Filter parsed Hi-C reads and get valid pair of reads to work with |
| tadbit map | Map Hi-C reads and organize results in an output working directory |
| tadbit merge | load two working directories with different Hi-C data samples and merges them into a new working directory generating some statistics |
| tadbit normalize | normalize Hi-C data and generates array of biases |
| tadbit parse | Parse mapped Hi-C reads and get the intersection |
| tadbit segment | Finds TAD or compartment segmentation in Hi-C data. |
| tadbit_clean | Delete jobs and results of a given list of jobids in a given directories |

## Reference documentation
- [Tadbit Overview on Bioconda](./references/anaconda_org_channels_bioconda_packages_tadbit_overview.md)
- [3D Genomics with Tadbit](./references/sgt_cnag_cat_3dg_tadbit.md)