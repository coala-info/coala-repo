---
name: ddquint
description: "ddquint analyzes multiplex digital droplet PCR data to detect chromosomal copy number variations and aneuploidy. Use when user asks to analyze quintuplex ddPCR data, perform HDBSCAN-based clustering on droplet amplitudes, or generate chromosomal copy number reports."
homepage: https://github.com/globuzzz2000/ddQuint
---


# ddquint

## Overview

ddquint is a specialized bioinformatics pipeline designed for the analysis of multiplex digital droplet PCR data, specifically optimized for quintuplex assays. It transforms raw amplitude data into chromosomal copy number calls by employing HDBSCAN-based clustering to classify droplets and applying a rigorous Poisson correction to account for undetectable mixed-target droplets. The tool is essential for detecting aneuploidy (chromosomal gains or losses) and provides both visual plots and structured Excel reports for clinical or research validation.

## Core CLI Usage

The tool can be operated in three primary modes: interactive GUI, automated command-line analysis, and configuration management.

### Basic Analysis
To run a standard analysis on a folder containing QX Manager CSV export files:
```bash
ddquint --dir /path/to/amplitude_csv_folder/
```

### Configuration Management
ddquint uses a JSON-based configuration system to tune clustering and detection thresholds.
*   **Generate a template**: Create a starting `config.json` to customize parameters.
    ```bash
    ddquint --config template
    ```
*   **Run with custom config**: Apply specific clustering or centroid settings.
    ```bash
    ddquint --dir /path/to/data --config my_custom_config.json
    ```
*   **View current settings**: Display the active configuration in the terminal.
    ```bash
    ddquint --config
    ```

### Parameter Tuning
For fine-tuning HDBSCAN or expected centroids, use the built-in graphical editor:
```bash
ddquint --parameters
```

## Expert Tips and Best Practices

### Handling the Mixed-Target Problem
In quintuplex assays, droplets containing multiple different target types are undetectable by the hardware. ddquint solves this using the ratio of single-target droplets to empty droplets:
*   **Logic**: $\lambda_i = \ln(1 + \frac{P(\text{only } i)}{P(\text{empty})})$
*   **Tip**: Ensure your "Negative" cluster (empty droplets) is well-defined in the `EXPECTED_CENTROIDS` configuration, as the entire Poisson correction relies on the accuracy of the empty droplet count.

### Optimizing Clustering (HDBSCAN)
If the automated clustering fails to identify all 6 populations (Negative + 5 Chromosomes), adjust these parameters in your config:
*   `HDBSCAN_MIN_SAMPLES`: Increase this if you have high background noise.
*   `HDBSCAN_EPSILON`: Adjust this to control how closely droplets must be packed to form a cluster.
*   `EXPECTED_CENTROIDS`: If your assay uses different fluorophores or concentrations, update the coordinate map in the config to match your specific amplitude peaks.

### Interpreting Results
The pipeline classifies samples into three states:
1.  **Euploid**: Within the `EUPLOID_TOLERANCE` of the expected value.
2.  **Aneuploidy**: Clear gain or loss detected.
3.  **Buffer Zone**: Values that fall between euploid and aneuploid ranges. These are flagged as uncertain and often indicate technical artifacts or low-quality samples.

### Output Files
After execution, check the output directory for:
*   **Excel Report**: Contains sample descriptions, calculated copy numbers, and final classifications.
*   **Well Plots**: Individual 2D scatter plots showing the clustering results for each well.
*   **Plate Overview**: A composite image for rapid visual QC of the entire run.

## Reference documentation
- [ddquint - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ddquint_overview.md)
- [GitHub - globuzzz2000/ddQuint: ddPCR analysis for quintuplex assay](./references/github_com_globuzzz2000_ddQuint.md)