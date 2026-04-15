---
name: modeltest-ng
description: ModelTest-NG identifies the most appropriate model of sequence evolution for DNA or protein multiple sequence alignments. Use when user asks to select a substitution model, evaluate phylogenetic models using AIC or BIC, or determine the best-fit evolutionary parameters for a dataset.
homepage: https://github.com/ddarriba/modeltest
metadata:
  docker_image: "quay.io/biocontainers/modeltest-ng:0.1.7--h5c6ebe3_0"
---

# modeltest-ng

## Overview

ModelTest-NG is a high-performance tool designed to identify the most appropriate model of sequence evolution for a given multiple sequence alignment (MSA). By evaluating various substitution matrices, rate heterogeneity parameters (like Gamma distribution or Invariant sites), and base frequencies, it provides the statistical foundation (via AIC, AICc, or BIC) required for accurate phylogenetic inference. This skill helps you navigate the command-line interface to process DNA and protein data efficiently, including utilizing parallel processing for large datasets.

## Usage Guidelines

### Basic Command Structure
The standard execution requires an input alignment and a specification of the data type.
- **DNA Analysis**: `modeltest-ng -i <input_alignment> -d nt`
- **Protein Analysis**: `modeltest-ng -i <input_alignment> -d aa`

### Common CLI Patterns
- **Thread Management**: Use `-p <number_of_threads>` to enable multithreading. This is critical for large alignments or when testing extensive model sets.
- **Model Selection**: By default, the tool evaluates a wide range of models. You can restrict or expand the candidate set using specific flags if you have prior knowledge of the dataset.
- **Output Redirection**: Use `-o <prefix>` to define the base name for result files (.out, .log, and .stat).

### Expert Tips
- **Topology Search**: If the default fixed topology is insufficient, use the `-t` argument to specify how the candidate topologies should be handled (e.g., fixed, BIONJ, or ML).
- **Frequency Estimation**: Pay attention to the `-f` argument to control how character frequencies are treated (empirical vs. maximum likelihood).
- **Memory and Performance**: For extremely large datasets, ensure you are using the MPI-enabled version if available on the system, or the SIMD-optimized builds (AVX/SSE) for faster likelihood calculations.
- **Verification**: Always check the version using `modeltest-ng --version` to ensure compatibility with specific model sets or bug fixes mentioned in recent releases.

## Reference documentation
- [ModelTest-NG GitHub Repository](./references/github_com_ddarriba_modeltest.md)
- [ModelTest-NG Wiki Overview](./references/github_com_ddarriba_modeltest_wiki.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_modeltest-ng_overview.md)