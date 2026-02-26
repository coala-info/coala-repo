---
name: minute
description: This tool automates the primary analysis of MINUTE-ChIP datasets. Use when user asks to process MINUTE-ChIP data, from raw reads to analyzed results, including quality control, alignment, and peak calling.
homepage: https://github.com/NBISweden/minute/
---


# minute

minute/SKILL.md
```yaml
name: minute
description: Automates the primary analysis steps for MINUTE-ChIP datasets using a Snakemake workflow. Use when Claude needs to process MINUTE-ChIP data, from raw reads to analyzed results, including quality control, alignment, and peak calling.
```
## Overview
The `minute` skill is a Snakemake-based workflow designed for the primary analysis of MINUTE-ChIP datasets. It streamlines the process from raw sequencing reads through to generating analyzed results, encompassing essential steps like quality control, read alignment, and peak calling. This skill is ideal when you need to process and analyze MINUTE-ChIP data efficiently.

## Usage Instructions

The `minute` workflow is executed via the command line. It relies on a configuration file to define input parameters and sample information.

### Installation

To install `minute`, use Conda:

```bash
conda install bioconda::minute
```

### Basic Workflow Execution

1.  **Prepare Input Data**: Ensure your MINUTE-ChIP sequencing reads are organized.
2.  **Create Configuration File**: A configuration file (typically `config.yaml`) is required to specify input files, sample names, and analysis parameters. Refer to the `minute` documentation for the exact structure and required parameters.
3.  **Run the Workflow**: Execute the `minute` workflow using Snakemake. The general command structure is:

    ```bash
    minute --configfile path/to/your/config.yaml
    ```

    *   Replace `path/to/your/config.yaml` with the actual path to your configuration file.
    *   The `minute` command itself is a wrapper that likely invokes Snakemake with the appropriate rules and configurations.

### Key Considerations and Expert Tips

*   **Configuration is Crucial**: The `config.yaml` file is central to the `minute` workflow. Pay close attention to sample naming, input file paths, and any specific parameters for alignment, peak calling, or downstream analysis.
*   **Resource Management**: For larger datasets, consider using Snakemake's resource management options (e.g., `--cores`, `--resources`) to optimize execution on your computing environment.
*   **Documentation**: Always refer to the official `minute` documentation for the most up-to-date information on configuration options, parameters, and advanced usage. The documentation is available at [minute.readthedocs.io](https://minute.readthedocs.io/en/latest).
*   **Troubleshooting**: If you encounter errors, check your `config.yaml` for typos or incorrect paths. Review the Snakemake output logs for specific error messages.

## Reference documentation
- [MINUTE-ChIP data analysis workflow](https://minute.readthedocs.io/en/latest)