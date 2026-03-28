---
name: flexsweep
description: Flexsweep is a machine learning tool used to identify genomic regions that have undergone natural selection by detecting selective sweeps. Use when user asks to simulate training data, train a CNN model for population genetics, or classify genomic loci as neutral or under selection.
homepage: https://github.com/jmurga/flexsweep
---

# flexsweep

## Overview
Flexsweep is a machine learning-based population genetics tool designed to identify genomic regions that have undergone natural selection. It specifically focuses on "selective sweeps," where a beneficial mutation increases in frequency, reducing genetic variation in nearby regions. 

The tool operates through a multi-stage workflow:
1. **Simulation**: Generating synthetic data that mimics the target population's history.
2. **Training**: Building a CNN model capable of distinguishing between neutral evolution and various types of sweeps (hard, soft, complete, or incomplete).
3. **Classification**: Applying the model to empirical data to predict selection at specific genomic loci.

## CLI Usage and Best Practices

### Core Command Structure
The primary entry point for the tool is the `flexsweep` command. It uses a sub-command architecture for different stages of the analysis.

```bash
# General syntax
flexsweep [OPTIONS] COMMAND [ARGS]...
```

### Key Sub-commands
*   **Simulation**: Used to generate training data. It often interfaces with simulators like `discoal` or `msprime` to create the necessary feature matrices.
*   **Training**: Processes simulated data to train the CNN.
*   **Prediction/Classification**: Runs the trained model on VCF or other genomic formats to identify sweeps.

### Expert Tips for Genomic Analysis
*   **Demographic Modeling**: Ensure your simulations reflect the demographic history (bottlenecks, expansions) of your target population. A model trained on a constant population size will produce high false-positive rates when applied to a population that has undergone a bottleneck.
*   **Feature Normalization**: Flexsweep relies on summary statistics and windowed genomic data. Ensure your input data is normalized consistently with the training set to maintain classification accuracy.
*   **GPU Acceleration**: Since the tool uses TensorFlow, ensure CUDA dependencies are correctly configured to significantly speed up the training and prediction phases.
*   **Memory Management**: For large-scale genomic sweeps, use the tool's ability to process data in windows to avoid exceeding RAM limits, especially when working with high-density SNP data.

### Common Workflow Pattern
1.  Define the demographic model using `demes` or simulation parameters.
2.  Generate neutral and sweep simulations (varying age and strength).
3.  Train the CNN using the `flexsweep` training module.
4.  Scan the empirical genome using a sliding window approach to generate predictions.



## Subcommands

| Command | Description |
|---------|-------------|
| flexsweep cnn | Run the Flexsweep CNN for training or prediction. |
| flexsweep fvs-discoal | Estimate summary statistics from discoal simulations and build feature vectors. |
| flexsweep fvs-vcf | Estimate summary statistics from VCF files and build feature vectors. |
| flexsweep simulator | Run the discoal Simulator with user-specified parameters. |

## Reference documentation
- [Flexsweep GitHub Repository](./references/github_com_jmurga_flexsweep_blob_main_README.md)
- [Project Configuration and Dependencies](./references/github_com_jmurga_flexsweep_blob_main_pyproject.toml.md)