---
name: maracluster
description: MaRaCluster clusters fragment spectra from shotgun proteomics experiments to identify similar spectra and generate high-quality consensus spectra. Use when user asks to cluster mass spectrometry data, group similar fragment spectra, or generate consensus spectra from multiple proteomics runs.
homepage: https://github.com/statisticalbiotechnology/maracluster
metadata:
  docker_image: "biocontainers/maracluster:1.02.1_cv1"
---

# maracluster

## Overview

MaRaCluster is a specialized tool for the large-scale clustering of fragment spectra from shotgun proteomics experiments. It identifies similar spectra across different runs and groups them into clusters, which can then be used to generate high-quality consensus spectra. This process reduces the computational burden of downstream peptide identification and improves the signal-to-noise ratio by averaging signals from multiple observations of the same peptide ion.

## CLI Usage and Best Practices

### 1. Preparing Input Files
MaRaCluster requires a simple text file containing the paths to your spectrum files (one path per line).

**Linux/macOS:**
```bash
ls -1 path/to/spectra/*.ms2 > file_list.txt
```

**Windows:**
```cmd
dir path\to\spectra /b /s > file_list.txt
```

### 2. Spectrum Clustering
The `batch` command performs the initial clustering. It processes the files listed in your input text file and calculates similarity scores.

```bash
maracluster batch -b file_list.txt
```

*   **Output:** By default, results are saved in a `maracluster_output` directory.
*   **Result Files:** You will see multiple files named `MaRaCluster.clusters_p<x>.tsv`, where `<x>` represents different p-value thresholds (e.g., p10, p15, p20).
*   **File Format:** These are tab-separated files containing:
    1.  Path to the spectrum file
    2.  Scan number (or scan index)
    3.  Cluster index
*   **Note:** Empty lines in the output file act as delimiters between different clusters.

### 3. Generating Consensus Spectra
Once clustering is complete, use the `consensus` command to create representative spectra for each cluster. You must choose one of the p-value threshold files generated in the previous step.

```bash
maracluster consensus -l maracluster_output/MaraCluster.clusters_p10.tsv
```

### 4. Expert Tips
*   **P-value Selection:** Lower p-value thresholds (e.g., p10) are less stringent and result in larger, potentially more heterogeneous clusters. Higher thresholds (e.g., p30) are more stringent, ensuring clusters contain highly similar spectra.
*   **Input Compatibility:** MaRaCluster can process any MS2 spectrum format supported by ProteoWizard (e.g., mzML, mzXML, MGF, MS2).
*   **Help Command:** For a full list of advanced parameters, including precursor tolerance and intensity thresholds, run:
    ```bash
    maracluster -h
    ```

## Reference documentation
- [MaRaCluster README](./references/github_com_statisticalbiotechnology_maracluster.md)