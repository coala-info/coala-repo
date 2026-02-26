---
name: smina
description: "smina is a computational chemistry tool used to predict ligand-receptor binding poses and evaluate binding affinities through docking and energy minimization. Use when user asks to dock ligands to a receptor, perform energy minimization on molecular poses, evaluate binding affinity with scoring functions, or define binding sites using autoboxing."
homepage: https://sourceforge.net/projects/smina/
---


# smina

## Overview
smina is a specialized tool for computational chemistry used to predict how small molecules (ligands) bind to receptors (proteins). While based on AutoDock Vina, smina is optimized for scoring function development and high-performance energy minimization. Use this skill to automate docking workflows, refine ligand poses through minimization, or evaluate binding affinity using custom or default scoring terms.

## Command Line Usage

### Basic Docking
To perform a standard docking run with a defined search box:
```bash
smina -r receptor.pdbqt -l ligand.sdf --center_x 10 --center_y 10 --center_z 10 --size_x 20 --size_y 20 --size_z 20 -o docked_output.sdf
```

### Automated Search Box (Autoboxing)
Instead of manual coordinates, use a reference ligand to define the binding site:
```bash
smina -r receptor.pdbqt -l ligand.sdf --autobox_ligand crystal_ligand.pdb -o output.sdf
```
*   Use `--autobox_add <angstroms>` (default is 4) to increase the buffer space around the reference ligand.

### Energy Minimization and Scoring
smina excels at local refinement and scoring existing poses:
*   **Score only**: Evaluate the affinity of a provided pose without moving it.
    ```bash
    smina -r receptor.pdbqt -l ligand.sdf --score_only
    ```
*   **Minimization**: Perform a local gradient-descent minimization to find the nearest local minimum.
    ```bash
    smina -r receptor.pdbqt -l ligand.sdf --minimize -o minimized.sdf
    ```
*   **Local Search**: Perform a local search starting from the input pose.
    ```bash
    smina -r receptor.pdbqt -l ligand.sdf --local_only --autobox_ligand ligand.sdf
    ```

### Custom Scoring Functions
You can define a custom scoring function by providing a text file with weights and terms:
```bash
smina -r receptor.pdbqt -l ligand.sdf --custom_scoring weights.txt --score_only
```
*   Use `--print_terms` to see all available scoring terms (e.g., `gauss`, `repulsion`, `hydrophobic`, `non_dir_h_bond`).
*   Use `--print_atom_types` to see available atom types for type-specific potentials.

## Expert Tips and Best Practices
*   **File Formats**: Unlike standard Vina, smina supports many formats (SDF, MOL2, PDB) via OpenBabel. However, ligands must have partial charges added beforehand.
*   **Exhaustiveness**: The `--exhaustiveness` parameter (default 8) controls the search depth. Increase this (e.g., to 16 or 32) for more thorough sampling at the cost of time.
*   **Flexible Residues**: Define flexible side chains using `--flexres` (e.g., `A:10,A:12`) or define a radius around a ligand using `--flexdist_ligand` and `--flexdist`.
*   **Convergence**: The `--minimize` command goes to convergence. If you need faster, less precise refinement, use `--minimize_iters` to set a specific iteration count.
*   **Covalent Docking Hack**: You can simulate covalent docking by defining a custom scoring function with a very strong `atom_type_gaussian` potential between specific atom types (e.g., faking a bond between a specific ligand atom and a receptor residue).

## Reference documentation
- [smina Files Overview](./references/sourceforge_net_projects_smina_files.md)
- [smina Project Summary](./references/sourceforge_net_projects_smina.md)