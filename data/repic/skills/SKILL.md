---
name: repic
description: REPIC (REliable PIcking by Consensus) is an ensemble learning methodology designed to harmonize results from various cryo-EM particle picking tools.
homepage: https://github.com/ccameron/REPIC
---

# repic

## Overview
REPIC (REliable PIcking by Consensus) is an ensemble learning methodology designed to harmonize results from various cryo-EM particle picking tools. Instead of relying on a single algorithm, REPIC identifies particles common to multiple sets—known as consensus particles—using graph theory and integer linear programming. This approach effectively reduces false positives and increases the confidence of the final particle stack, which is critical for high-resolution 3D reconstructions.

## CLI Usage and Best Practices

### Core Command Structure
The primary entry point for the tool is the `repic` command. After installation via Conda or Docker, verify the installation and view available subcommands:
```bash
repic -h
```

### Iterative Ensemble Picking
The most common workflow involves iterative picking to refine the consensus set. This requires a configuration file (in JSON format) and specifies the computational resources.
```bash
repic iter_pick <config_json> <num_workers> <num_iterations>
```
*   **config_json**: Path to the JSON file containing paths to micrographs and picker outputs.
*   **num_workers**: Number of CPU cores to allocate for parallel processing.
*   **num_iterations**: Number of iterations for the ensemble learning process (e.g., 100).

### Input Requirements
REPIC is strict about its input format. Ensure all particle sets meet the following criteria:
*   **File Format**: Must be in `.box` format.
*   **Data Columns**: Each file must contain particle coordinates (x, y) and the detection box size (in pixels).
*   **Scores**: An optional confidence score [0-1] can be included to weight the consensus.

### Data Preparation
If your pickers output formats other than `.box` (such as `.star` or `.cs`), use the included utility script to prepare your data:
```bash
python coord_converter.py --input <input_file> --output <output_name>.box
```

### Optimization Tips
*   **ILP Solver**: While REPIC can use the SciPy ILP optimizer, it is significantly more performant with the **Gurobi** optimizer. If working with large datasets, ensure Gurobi and a valid academic license are configured in your environment.
*   **Box Size Consistency**: Ensure that the box size defined in the `.box` files is consistent across different picking sets for a single micrograph to avoid artifacts during the consensus calculation.
*   **Docker Usage**: For a "batteries-included" experience that includes the pickers themselves (SPHIRE-crYOLO, DeepPicker, and Topaz), use the Docker container rather than a bare-metal Conda install.

## Reference documentation
- [REPIC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_repic_overview.md)
- [REPIC GitHub Repository](./references/github_com_ccameron_REPIC.md)