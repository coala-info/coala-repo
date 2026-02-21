---
name: immuneml
description: The immuneML platform is a specialized framework designed for the machine learning-based classification and analysis of adaptive immune receptors.
homepage: https://github.com/uio-bmi/immuneML
---

# immuneml

## Overview
The immuneML platform is a specialized framework designed for the machine learning-based classification and analysis of adaptive immune receptors. It bridges the gap between immunology and data science by providing a structured environment to process experimental data, engineer features, and apply machine learning algorithms (via scikit-learn or PyTorch). Use this skill to navigate the command-line interface, validate installations, and manage the results of repertoire-based ML workflows.

## Installation and Validation
Before running analyses, ensure the environment is correctly configured. Python 3.9+ is required (3.11+ recommended for simulations).

- **Quick Install**: `pip install immune-ml` or `conda install -c bioconda immuneml`.
- **Verify Installation**: Run `immune-ml -h` to confirm the CLI is accessible.
- **Smoke Test**: Execute `immune-ml-quickstart ./quickstart_results/` to generate a synthetic dataset and run a baseline analysis. This confirms that the underlying ML libraries and reporting engines are functional.

## Command Line Usage
The primary interface for immuneML is a single command that requires a specification file and an output directory.

- **Standard Execution**:
  `immune-ml <path_to_specification.yaml> <result_folder_path>`
- **Result Navigation**:
  Every successful run generates an `index.html` file in the result folder. Always start result interpretation here, as it provides a high-level summary of trained models, predictions, and visualizations.

## Expert Tips and Best Practices
- **Virtual Environments**: Always install immuneML in a dedicated virtual environment to avoid dependency conflicts with other ML frameworks.
- **Specification Auditing**: After a run, check `full_specification.yaml` in the output folder. This file contains the original input with all default parameters explicitly filled in, which is essential for reproducibility and debugging.
- **Log Monitoring**: If a run fails, the `log.txt` file in the result subfolder is the primary source for troubleshooting. It captures the specific step (e.g., encoding, training, or reporting) where the error occurred.
- **Data Formatting**: Ensure input data follows the AIRR Community standards for the best compatibility with built-in importers.
- **Resource Management**: Machine learning on large repertoires can be memory-intensive. When running on clusters, monitor the `log.txt` to ensure the process is not being killed by OOM (Out of Memory) errors during the encoding phase.

## Reference documentation
- [immuneML GitHub Repository](./references/github_com_uio-bmi_immuneML.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_immuneml_overview.md)