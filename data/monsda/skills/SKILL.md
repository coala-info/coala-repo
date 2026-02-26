---
name: monsda
description: MONSDA is a wrapper that orchestrates complex bioinformatics workflows by automating the generation and execution of Snakemake and Nextflow files from a single JSON configuration. Use when user asks to manage HTS data analysis, generate workflow configuration files, or run bioinformatics pipelines using Snakemake or Nextflow engines.
homepage: https://github.com/jfallmann/MONSDA
---


# monsda

## Overview

MONSDA (Modular Organizer of Nextflow and Snakemake driven HTS Data Analysis) is a specialized wrapper designed to streamline complex bioinformatics workflows. It centralizes the management of HTS analysis by using a single JSON configuration file to orchestrate multiple sub-workflows. By automating the generation of Snakemake and Nextflow files, it allows researchers to focus on experimental parameters rather than workflow syntax. It emphasizes FAIR data principles by integrating tightly with Conda and Mamba for environment reproducibility.

## Installation and Setup

Install MONSDA via the Bioconda channel to ensure all dependencies are correctly resolved:

```bash
conda install -c bioconda -c conda-forge monsda
```

For faster environment resolution, use Mamba as the solver:

```bash
mamba install -c bioconda -c conda-forge monsda
```

## Configuration Workflow

The `config.json` file is the core of any MONSDA analysis. It defines paths, processing steps, and tool-specific settings.

1.  **Interactive Configuration**: Run the built-in configurator to generate a valid JSON template.
    ```bash
    monsda_configure
    ```
2.  **Directory Structure**: Ensure your local data follows the "condition-tree" defined in your config file, as MONSDA dictates directory organization based on these conditions.
3.  **Sub-configs**: Note that MONSDA will split your main config into sub-configs located in `SubSnakes/` (for Snakemake) or `SubFlows/` (for Nextflow) during execution.

## Execution Patterns

### Running with Snakemake (Default)
Use this pattern for standard local execution. Specify the number of threads and the path to your Conda environments.

```bash
monsda -j ${THREADS} --configfile ${CONFIG}.json --directory ${PWD} --conda-frontend mamba --conda-prefix ${PATH_TO_CONDA_ENVS}
```

### Running with Nextflow
To switch the execution engine to Nextflow, use the `--nextflow` flag.

```bash
monsda --nextflow -j ${THREADS} --configfile ${CONFIG}.json --directory ${PWD}
```

### HPC and Workload Managers (SLURM)
MONSDA supports cluster execution by passing profiles to the underlying engines.

*   **For Snakemake**: Use a pre-configured SLURM profile.
    ```bash
    monsda -j ${THREADS} --configfile ${CONFIG}.json --directory ${PWD} --profile ${SLURMPROFILE} --conda-frontend mamba
    ```
*   **For Nextflow**: Set the executor environment variable before running.
    ```bash
    export NXF_EXECUTOR=slurm
    monsda --nextflow -j ${THREADS} --configfile ${CONFIG}.json --directory ${PWD}
    ```

## Expert Tips and Best Practices

*   **Environment Management**: Always use `--conda-frontend mamba` when running Snakemake workflows to significantly speed up the creation of tool-specific environments.
*   **Manual Inspection**: If a workflow fails, inspect the generated files in `SubSnakes` or `SubFlows` to debug the specific command-line arguments being passed to the bioinformatics tools.
*   **Custom Tools**: To add new tools to the pipeline, modify the `workflows/` directory and update `template.json` to include the new parameters.
*   **Resource Allocation**: When running on a cluster, ensure the `--conda-prefix` points to a shared filesystem accessible by all compute nodes.

## Reference documentation
- [MONSDA Main Repository](./references/github_com_jfallmann_MONSDA.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_monsda_overview.md)