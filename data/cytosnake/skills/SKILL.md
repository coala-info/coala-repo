---
name: cytosnake
description: CytoSnake is a command-line tool that manages and executes reproducible image-based profiling pipelines for single-cell morphology data. Use when user asks to initialize a profiling project, run CellProfiler or DeepProfiler workflows, or benchmark memory usage during data processing.
homepage: https://github.com/WayScience/CytoSnake
metadata:
  docker_image: "quay.io/biocontainers/cytosnake:0.0.2--pyhdfd78af_0"
---

# cytosnake

## Overview
CytoSnake is a command-line interface designed to manage and execute reproducible image-based profiling pipelines. It acts as an orchestrator for Snakemake workflows, allowing researchers to transform raw single-cell morphology features into analyzed datasets through standardized steps like annotation and aggregation. By using a structured project environment and symlinking data, it ensures that high-dimensional microscopy data remains organized, scalable, and easy to process across different computational environments.

## Project Initialization
Before running any analysis, you must initialize a project directory. CytoSnake creates a `.cytosnake` directory to track project states and a `data/` directory containing symlinks to your input files to preserve storage.

- **Standard Initialization**: Use `cytosnake init` with data and metadata paths.
  `cytosnake init -d <FILES_OR_DIR> -m <METADATA_DIR>`
- **Handling Multiple Platemaps**: If your experiment involves multiple platemaps, you must provide a barcode file using the `-b` flag.
  `cytosnake init -d <DATA> -m <METADATA> -b <BARCODE_FILE>`
- **Data Compatibility**: CytoSnake is optimized for features extracted via CellProfiler or DeepProfiler.

## Executing Workflows
Workflows are the primary method for data processing. Once a project is initialized, use the `run` command to trigger the Snakemake-backed pipelines.

- **Run a Workflow**: `cytosnake run <WORKFLOW_NAME>`
- **Primary Workflows**:
  - `cp_process`: Standard pipeline for CellProfiler data (includes annotation and aggregation).
  - `dp_process`: Standard pipeline for DeepProfiler data.
- **Execution Flags**:
  - Use `n_cores` to define the maximum number of CPU cores for parallel processing.
  - Use `force_run` to ignore existing outputs and restart the workflow from the beginning.
  - Use `allow_unlock` to clear directory locks if a previous run was unexpectedly interrupted.

## Performance Benchmarking
CytoSnake uses `Memray` to monitor memory usage and identify bottlenecks or leaks within the profiling scripts.

1. **Enable Profiling**: Modify the `config/configurational.yaml` file within your project and set the profiling parameter to `True`.
2. **Execution**: Run your desired workflow (e.g., `cytosnake run cp_process`). Benchmarking data is collected automatically during the run.
3. **Accessing Results**: Benchmark files are saved in the `benchmarks/` folder of your project directory.
4. **Analysis**: Use the `memray stats` command to convert the binary benchmark files into readable JSON format for detailed inspection.

## Expert Tips and Best Practices
- **Symlink Awareness**: Since CytoSnake uses symlinks in the `data/` folder, ensure the source data files are not moved or deleted after initialization, or the workflow will fail.
- **Workflow Customization**: While default parameters are provided, users can fine-tune analytical steps (like aggregation operations or metadata joining) by editing the specific workflow configuration files generated in the project directory.
- **Conda Integration**: Always run CytoSnake within a dedicated Conda environment to ensure Snakemake and its dependencies (like Memray) are correctly mapped to the CLI.
- **Verification**: Use `cytosnake help` to verify the installation and view the full list of available subcommands and arguments.



## Subcommands

| Command | Description |
|---------|-------------|
| cytosnake_align | Aligns sequencing reads to a reference genome. |
| cytosnake_makedb | Builds a database for cytosnake. |

## Reference documentation
- [CytoSnake Tutorial](./references/cytosnake_readthedocs_io_en_latest_tutorial.html.md)
- [Benchmarking Workflows](./references/cytosnake_readthedocs_io_en_latest_benchmarking.html.md)
- [CytoSnake Workflows](./references/cytosnake_readthedocs_io_en_latest_workflows.html.md)