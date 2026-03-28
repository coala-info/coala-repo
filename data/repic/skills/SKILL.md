---
name: repic
description: REPIC identifies consensus particles from multiple cryo-EM particle picking algorithms using an ensemble learning framework. Use when user asks to find consensus particles, filter false positives from particle sets, or perform iterative particle picking for 3D reconstruction.
homepage: https://github.com/ccameron/REPIC
---

# repic

## Overview
REPIC provides a robust framework for ensemble learning in cryo-EM. Instead of relying on a single particle picking algorithm, it identifies "consensus particles" that are common across multiple sets of picked coordinates. By treating particle sets as nodes in a graph and solving for the maximum weight clique using ILP (via Gurobi or SciPy), REPIC filters out false positives and improves the reliability of particle sets used for 3D reconstruction. It is particularly effective when combining results from manual picking, template matching, and deep learning methods.

## Core CLI Usage

The primary entry point is the `repic` command. Ensure your environment is activated (`conda activate repic`) before execution.

### General Syntax
```bash
repic <command> [options]
```

### Common Commands
- `repic -h`: Display the global help menu and available subcommands.
- `repic iter_pick`: Execute the iterative particle picking workflow.
- `repic ensemble`: (Inferred) Combine multiple existing .box files into a consensus set.

### Iterative Picking Pattern
Iterative picking is used to refine particle sets through multiple rounds of consensus.
```bash
repic iter_pick <config_json> <num_threads> <num_particles>
```
*   **config_json**: Path to a JSON file defining the pickers and parameters (e.g., `iter_config.json`).
*   **num_threads**: Number of CPU cores to allocate.
*   **num_particles**: Target number of particles to pick per micrograph.

### Docker Execution
If using the Docker container (which includes pre-installed pickers like crYOLO and Topaz), use the following pattern to mount your data:
```bash
docker run --gpus all -v /path/to/your/data:/data repic_img repic iter_pick /data/config.json 4 100
```

## Best Practices and Tips

### Input Requirements
*   **File Format**: REPIC expects particle sets in `.box` format.
*   **Columns**: Each `.box` file must contain X and Y coordinates and detection box size (in pixels). An optional score column [0-1] can be included.
*   **Consistency**: Ensure that the box sizes are consistent across different pickers for the same dataset to improve consensus accuracy.

### Optimizer Selection
*   **Gurobi**: Highly recommended for performance and required to reproduce manuscript results. Requires a free academic license.
*   **SciPy**: Automatically used as a fallback if Gurobi is not installed. Suitable for smaller datasets or when Gurobi is unavailable.

### Integration with Pickers
*   REPIC acts as a wrapper/consensus layer. If you are not using the Docker version, you must ensure that external pickers (crYOLO, Topaz, DeepPicker) are installed in your path or specified correctly in your configuration files.
*   Use the `repic_colab.ipynb` for cloud-based testing or when local GPU resources are limited.



## Subcommands

| Command | Description |
|---------|-------------|
| repic get_cliques | Finds cliques of particles based on proximity in 3D space. |
| repic iter_config | Generates configuration files for iterative particle picking. |
| repic_iter_pick | Iteratively pick particles based on a configuration file. |
| repic_run_ilp | Run the ILP solver to find the optimal particle configuration. |

## Reference documentation
- [REPIC GitHub Repository](./references/github_com_ccameron_REPIC_blob_main_README.md)
- [REPIC Docker Configuration](./references/github_com_ccameron_REPIC_blob_main_Dockerfile.md)
- [Iterative Picking Command Reference](./references/github_com_ccameron_REPIC_blob_main_repic_commands_iter_pick.py.md)