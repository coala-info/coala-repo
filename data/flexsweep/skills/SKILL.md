---
name: flexsweep
description: Flexsweep is a tool for detecting selective sweeps in genomic data. Use when user asks to detect selective sweeps in genomic data or analyze genomic data to identify regions under selection.
homepage: https://github.com/jmurga/flexsweep
---


# flexsweep

yaml
name: flexsweep
description: A tool for detecting selective sweeps in genomic data. Use when analyzing genomic data to identify regions that have undergone recent positive selection.
---
## Overview
Flexsweep is a bioinformatics tool designed to detect selective sweeps in genomic data. It utilizes a convolutional neural network (CNN) to classify genomic loci as either neutral or under selection. The process involves simulating data under various demographic models and selection scenarios, then training the CNN to identify these patterns. This skill is useful for researchers analyzing population genetics data to understand evolutionary processes.

## Usage Instructions

Flexsweep is typically used via its command-line interface. The core functionality involves simulating data and then classifying regions based on these simulations.

### Core Workflow

1.  **Simulation**: Generate genomic data under specific demographic models and selection parameters.
2.  **Classification**: Use a trained model to classify simulated or real genomic regions as neutral or under selection.

### Key Parameters and Options

While specific command-line arguments are not detailed in the provided documentation, common patterns for such tools involve:

*   **Input Data**: Specifying input files for genomic data (e.g., VCF, FASTA) or simulation parameters.
*   **Model Specification**: Indicating the demographic model and selection parameters for simulations.
*   **Output**: Defining output file formats and locations for classified regions or simulation results.
*   **Model Training/Loading**: Options to train a new CNN model or load a pre-trained one.

### Best Practices and Expert Tips

*   **Understand Your Data**: Before running flexsweep, ensure you have a clear understanding of your genomic data and the evolutionary hypotheses you want to test. This will guide your choice of demographic models and selection parameters.
*   **Parameter Tuning**: Experiment with different demographic models and selection parameters (sweep strength, age, starting allele frequency, completeness) to accurately reflect your biological system.
*   **Computational Resources**: Simulation and model training can be computationally intensive. Ensure you have adequate computational resources and consider using parallel processing if available.
*   **Consult Documentation**: For detailed command-line arguments, specific file formats, and advanced options, always refer to the official flexsweep documentation.

## Reference documentation
- [GitHub Repository](https://github.com/jmurga/flexsweep)
- [Anaconda.org Overview](https://anaconda.org/bioconda/flexsweep)