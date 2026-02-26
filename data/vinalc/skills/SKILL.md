---
name: vinalc
description: VinaLC performs parallelized molecular docking for high-throughput virtual screening. Use when user asks to prepare input files for docking, configure docking parameters, or execute high-throughput molecular docking.
homepage: https://github.com/XiaohuaZhangLLNL/VinaLC
---


# vinalc

## Overview

VinaLC is a parallelized version of AutoDock Vina designed for high-performance computing environments. It utilizes MPI (Message Passing Interface) and multi-threading to distribute docking tasks across multiple nodes and CPU cores. This skill provides guidance on preparing the required list-based input files, configuring docking parameters, and executing the program in a parallel environment.

## Input Preparation

VinaLC requires three primary text-based input files to manage batch processing.

### 1. Receptor List (`--recList`)
A text file containing the paths to receptor files in `.pdbqt` format.
```text
protein1.pdbqt
protein2.pdbqt
```

### 2. Ligand List (`--ligList`)
A text file containing the paths to ligand files in `.pdbqt` format.
```text
ligands/compound_001.pdbqt
ligands/compound_002.pdbqt
```

### 3. Geometry List (`--geoList`)
A text file defining the search space for each receptor listed in the `--recList`. Each line must correspond to the same line in the receptor list.
Format: `center_x center_y center_z size_x size_y size_z`
```text
15.2 20.5 10.1 20.0 20.0 20.0
12.0 18.4 11.5 22.5 22.5 22.5
```

## Command Line Usage

### Basic Execution
VinaLC is typically executed via `srun` (Slurm) or `mpirun`. You must specify the three list files.

```bash
srun -N4 -n4 -c12 vinalc --recList recList.txt --ligList ligList.txt --geoList geoList.txt
```
*   `-N4`: Number of nodes.
*   `-n4`: Number of MPI tasks.
*   `-c12`: Number of CPUs/threads per task.

### Advanced Options
*   `--exhaustiveness <int>`: Controls the depth of the global search (default: 8). Increase for higher accuracy at the cost of time.
*   `--granularity <float>`: Sets the grid spacing (default: 0.375).
*   `--num_modes <int>`: Maximum number of binding modes to generate (default: 9).
*   `--scoreCF <float>`: Score cutoff (default: -8.0). Only ligands with a binding energy better than this value will be saved.
*   `--randomize`: Use different random seeds for each complex to ensure stochastic variation.

## Expert Tips

*   **PDBQT Preparation**: All input files must be in PDBQT format. Use `prepare_receptor4.py` and `prepare_ligand4.py` from MGLTools or Open Babel (`babel -isdf lig.sdf -opdbqt lig.pdbqt`) for conversion.
*   **Grid Spacing Consistency**: Ensure the `granularity` parameter in VinaLC matches the spacing used when determining grid dimensions in AutoDockTools.
*   **Load Balancing**: VinaLC is optimized for large-scale virtual screening. For small datasets, the overhead of MPI may outweigh the performance gains.
*   **Memory Management**: When running on many cores, ensure the total memory of the node can accommodate the receptor files being loaded into memory by each task.

## Reference documentation
- [VinaLC GitHub Repository](./references/github_com_XiaohuaZhangLLNL_VinaLC.md)
- [VinaLC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vinalc_overview.md)