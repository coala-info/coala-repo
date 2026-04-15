---
name: spectra-cluster-cli
description: spectra-cluster-cli clusters similar mass spectra from proteomics experiments to identify consistent patterns using the PRIDE Cluster algorithm. Use when user asks to cluster mass spectrometry data, group similar spectra, perform incremental clustering, or filter peaks for improved accuracy.
homepage: https://github.com/spectra-cluster/spectra-cluster-cli
metadata:
  docker_image: "quay.io/biocontainers/spectra-cluster-cli:1.1.2--0"
---

# spectra-cluster-cli

## Overview

The spectra-cluster-cli is a Java-based standalone implementation of the PRIDE Cluster algorithm. It enables the grouping of similar mass spectra to identify consistent patterns across proteomics experiments. The tool is designed to handle both repository-scale data and smaller local datasets, producing results in a specialized `.clustering` format. It supports peak filtering to improve accuracy and allows for incremental clustering by incorporating previously generated results.

## Installation and Setup

The tool requires a Java Runtime Environment (JRE). It can be installed via Bioconda or by downloading the JAR file directly.

```bash
# Installation via Conda
conda install bioconda::spectra-cluster-cli

# Execution via JAR
java -jar spectra-cluster-cli-[version].jar [options] <input_files>
```

## Common CLI Patterns

### Basic Clustering
To cluster multiple MGF files using default settings and write the output to a specific file:

```bash
java -jar spectra-cluster-cli.jar -output_path results.clustering file1.mgf file2.mgf
```

### Recommended Filtering
To improve clustering accuracy, it is highly recommended to filter out low m/z noise or immonium ions:

```bash
# Filter immonium ions
java -jar spectra-cluster-cli.jar -filter immonium_ions -output_path results.clustering input.mgf

# Filter all peaks below 150 m/z
java -jar spectra-cluster-cli.jar -filter mz_150 -output_path results.clustering input.mgf
```

### Incremental Clustering
You can add new spectra to existing clustering results by providing the previous `.clustering` file as an input (requires version 1.0.4+):

```bash
java -jar spectra-cluster-cli.jar -output_path updated_results.clustering previous_results.clustering new_data.mgf
```

## Expert Tips and Best Practices

### Dataset Size Optimization
The algorithm's sensitivity is affected by the number of comparisons. Adjust the `-x_min_comparisons` parameter based on your data volume:
- **Small Datasets (< 100 MS runs)**: Set `-x_min_comparisons 10000` to improve accuracy.
- **Large/Repository Scale**: Use the default `5000`.

### Handling Small Datasets
For very small datasets where the algorithm might not learn enough from the data, use the adaptive comparison correction:
- `-x_min_adapt_comparison`: Sets a minimum number of comparisons to be used as a correction factor.

### Advanced Metadata and Scoring
- **Additional Scores**: Use the `-add_scores` flag to include JSON-encoded properties in the `.clustering` output.
- **Identification Filtering**: You can choose to cluster only identified or only unidentified spectra using specific command-line flags (refer to `-help` for the exact version-specific flags).

### Performance
The tool automatically utilizes all available CPU cores. Ensure the system has sufficient RAM allocated to the JVM for large MGF files.

## Reference documentation
- [spectra-cluster-cli - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_spectra-cluster-cli_overview.md)
- [GitHub - spectra-cluster/spectra-cluster-cli: Prototype of a CLI to run the clustering process](./references/github_com_spectra-cluster_spectra-cluster-cli.md)