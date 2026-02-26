---
name: sourcepredict
description: Sourcepredict is a machine learning tool that identifies the origins of metagenomic samples by comparing their taxonomic profiles against a reference dataset. Use when user asks to predict source proportions, perform microbial source tracking, or detect contamination in metagenomic datasets.
homepage: https://github.com/maxibor/sourcepredict
---


# sourcepredict

## Overview

Sourcepredict is a machine learning tool designed to solve the "source tracking" problem in metagenomics. It identifies the likely origins of a metagenomic sample by comparing its taxonomic profile against a reference dataset of known sources. The tool operates by reducing the dimensionality of the datasets (using MDS or TSNE) and then applying K-Nearest Neighbors (KNN) classification to estimate source proportions. Use this skill when you have taxonomic count tables and need to quantify environmental contributions or detect contamination in metagenomic datasets.

## Installation

Install via Conda (recommended) or Pip:

```bash
conda install -c conda-forge -c maxibor sourcepredict
# OR
pip install sourcepredict
```

## Required Input Files

To run a prediction, you must provide three specific CSV files:

1.  **Sink File**: Taxonomic counts for the unknown samples you want to test.
2.  **Source File**: Taxonomic counts for the reference samples with known origins.
3.  **Label File**: A mapping file that assigns each sample in the Source File to a specific environment or category.

## Command Line Usage

### Basic Execution
The standard command structure requires the source and label flags followed by the sink file:

```bash
sourcepredict -s sources.csv -l labels.csv sink_sample.csv
```

### Advanced Options
- **Parallel Processing**: Use `-t` to specify the number of CPU cores.
- **Normalization**: Use `-n` to change the normalization method (e.g., GMPR).
- **Embedding Method**: Use `-me` to specify the dimensionality reduction method.

### Example Workflow
```bash
# 1. Download example data
wget https://raw.githubusercontent.com/maxibor/sourcepredict/master/data/modern_gut_microbiomes_labels.csv -O labels.csv
wget https://raw.githubusercontent.com/maxibor/sourcepredict/master/data/modern_gut_microbiomes_sources.csv -O sources.csv

# 2. Run prediction on a sink sample
sourcepredict -s sources.csv -l labels.csv my_sink_sample.csv -t 4
```

## Best Practices and Expert Tips

- **Taxonomic Consistency**: Ensure that the taxonomic ranks (e.g., species, genus) and naming conventions are identical between your sink and source files. If the features do not match, the machine learning model will produce inaccurate results.
- **The "Unknown" Check**: Sourcepredict performs a two-step process. Step 1 estimates the "unknown" proportion. If this value is high, it indicates that your reference source dataset does not adequately represent the environments present in your sink sample.
- **Normalization**: The default GMPR (Geometric Mean of Pairwise Ratios) normalization is generally preferred for metagenomic count data as it handles zero-inflation better than standard total sum scaling.
- **Output Interpretation**: The tool generates a `.sourcepredict.csv` file. This contains the percentage contribution of each source to your sink. Always verify the "Testing Accuracy" reported in the CLI output to gauge the reliability of the KNN classifier for your specific dataset.

## Reference documentation
- [Sourcepredict GitHub Repository](./references/github_com_maxibor_sourcepredict.md)
- [Sourcepredict Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sourcepredict_overview.md)