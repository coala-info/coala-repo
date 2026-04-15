---
name: nordic
description: NORDic is a Python framework that uses network-oriented modeling to automate gene interaction analysis and drug repurposing. Use when user asks to build Boolean networks from transcriptomic data, identify master regulators of disease, score drug efficacy through signature reversal, or adaptively recommend treatments.
homepage: https://github.com/clreda/NORDic
metadata:
  docker_image: "quay.io/biocontainers/nordic:2.7.1--py311h8ddd9a4_0"
---

# nordic

## Overview

NORDic (Network-Oriented Repurposing of Drugs) is a specialized Python framework designed to automate the modeling of gene interactions and their influence on biological activity. Unlike traditional drug discovery tools, NORDic uses a network-oriented approach to predict drug effects and identify off-targets that might lead to toxic side effects. It is particularly powerful for studying complex diseases where prior knowledge of the gene regulation hierarchy is limited or unavailable.

The package is structured into four functional submodules:
1.  **NI (Network Inference)**: Builds Boolean networks from various biological sources.
2.  **PMR (Identification of Master Regulators)**: Detects key genes driving diseased transcriptomic profiles.
3.  **DS (Drug Scoring)**: Evaluates treatment efficacy based on signature reversal scores.
4.  **DR (Drug Repurposing)**: Uses bandit algorithms to adaptively recommend treatments with bounded false discovery rates.

## Installation and Environment Setup

NORDic has specific system dependencies, including `graphviz`, `clingo`, and `maboss`.

### Recommended Conda Setup
```bash
# Create a dedicated environment
conda create -n nordic_env python=3.8
conda activate nordic_env

# Install core dependencies
conda install -c potassco clingo
conda install -c colomoto maboss
conda install -c bioconda nordic
```

### Docker Alternative
For the most stable environment, use the CoLoMoTo-Docker image which comes pre-configured with NORDic and its dependencies:
```bash
pip install -U colomoto-docker
colomoto-docker
```

## Core Workflows

### 1. Network Inference (NI)
Use this submodule to identify disease-associated gene regulatory networks. It is unique because it can infer networks even without previously curated experiments.
```python
import NORDic
# Access NI functions to build Boolean networks from transcriptomic data
# help(NORDic.NI)
```

### 2. Master Regulator Detection (PMR)
Use this to find "master regulators" by analyzing the network topology and dynamics relative to diseased profiles.
```python
# Score regulators based on their ability to shift the network from diseased to control states
```

### 3. Drug Scoring (DS)
Apply this to compute a "signature reversal score." A higher score indicates a more promising treatment that moves the patient's gene expression profile toward a healthy control state.
```python
# Simulate drug perturbations on the Boolean network
```

### 4. Adaptive Drug Repurposing (DR)
Use this for sample-efficient drug testing. It employs a bandit algorithm to test treatments adaptively, minimizing the number of simulations needed to find effective candidates.

## Expert Tips

- **Dynamic Analysis**: NORDic relies on Boolean network dynamics. Ensure your input data is normalized appropriately for transcriptomic profiling to get accurate inference results.
- **Off-Target Prediction**: Always use the network-oriented approach to check for off-target effects, which are identified by observing perturbations in non-specific areas of the inferred gene regulatory network.
- **Documentation Access**: Since the package is highly modular, use Python's built-in help system to explore specific function signatures: `help(NORDic.submodule.function_name)`.
- **Resource Management**: Simulations, especially within the DR (Drug Repurposing) module, can be computationally intensive. When running large-scale bandit algorithms, ensure `maboss` is correctly configured to utilize available CPU cores.

## Reference documentation
- [NORDic GitHub Repository](./references/github_com_clreda_NORDic.md)
- [Bioconda NORDic Overview](./references/anaconda_org_channels_bioconda_packages_nordic_overview.md)