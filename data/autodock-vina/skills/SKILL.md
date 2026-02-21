---
name: autodock-vina
description: AutoDock Vina is a specialized tool for computational docking that predicts the preferred orientation of a ligand when bound to a receptor.
homepage: https://github.com/ccsb-scripps/AutoDock-Vina
---

# autodock-vina

## Overview

AutoDock Vina is a specialized tool for computational docking that predicts the preferred orientation of a ligand when bound to a receptor. It utilizes a sophisticated scoring function and a rapid gradient-optimization conformational search. This skill enables the execution of docking tasks, including single-ligand docking, batch virtual screening, and the use of advanced features like macrocycle support and hydrated docking protocols.

## Command Line Usage

### Basic Docking Execution
The most common use case involves docking a single ligand to a receptor within a defined search space (grid box).

```bash
vina --receptor receptor.pdbqt --ligand ligand.pdbqt \
     --center_x 11.0 --center_y 12.0 --center_z 13.0 \
     --size_x 20.0 --size_y 20.0 --size_z 20.0 \
     --out output.pdbqt
```

### Using Configuration Files
For complex setups, it is best practice to store parameters in a `.txt` file to improve reproducibility.

```bash
# config.txt
receptor = protein.pdbqt
center_x = 10.5
center_y = -5.2
center_z = 12.1
size_x = 22.5
size_y = 22.5
size_z = 22.5
exhaustiveness = 16

# Execution
vina --config config.txt --ligand ligand.pdbqt --out result.pdbqt
```

### Virtual Screening (Batch Mode)
Vina 1.2.x supports batch processing for screening multiple ligands against a single receptor.

```bash
vina --receptor receptor.pdbqt --batch ligand_folder/*.pdbqt --dir output_directory
```

### Scoring Functions
You can toggle between the classic Vina scoring function and the AutoDock4 scoring function (which requires AutoDock map files).

- **Vina (Default):** `--scoring vina`
- **AutoDock4:** `--scoring ad4` (Requires `--map receptor.map_prefix.map`)

## Expert Tips and Best Practices

- **Exhaustiveness:** The default value is 8. For high-quality publications or complex ligands with many rotatable bonds, increase this to 16, 32, or 64. Note that runtime increases linearly with exhaustiveness.
- **PDBQT Preparation:** Vina requires inputs in `.pdbqt` format. Ensure all hydrogens are added, non-polar hydrogens are merged, and partial charges are assigned before conversion.
- **Search Space (Grid Box):** The box should be large enough to allow the ligand to rotate freely but small enough to focus on the binding site. A box too large will significantly increase the search time and may lead to false positives in non-binding regions.
- **CPU Threads:** Vina automatically detects the number of available cores. Use `--cpu N` to manually restrict the tool to a specific number of threads if running on a shared cluster.
- **Output Analysis:** The output `.pdbqt` file contains multiple "models" (poses). The first model is always the pose with the highest predicted binding affinity (most negative kcal/mol).

## Reference documentation
- [AutoDock Vina: Docking and virtual screening program](./references/github_com_ccsb-scripps_AutoDock-Vina.md)