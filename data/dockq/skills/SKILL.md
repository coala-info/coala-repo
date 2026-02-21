---
name: dockq
description: DockQ is a computational tool designed to provide a single continuous quality measure for docking models.
homepage: https://github.com/bjornwallner/DockQ
---

# dockq

## Overview
DockQ is a computational tool designed to provide a single continuous quality measure for docking models. It automates the process of comparing a predicted structure (model) to a reference structure (native), handling the complexities of chain mapping, symmetry, and different molecular types. It is particularly useful for structural biologists and computational chemists who need to validate docking simulations or rank-order predicted poses based on their similarity to known experimental data.

## Basic Usage
The primary command follows a simple model-to-native comparison:

```bash
DockQ <model_file> <native_file>
```

### Scoring Legend
*   **< 0.23**: Incorrect
*   **0.23 – 0.48**: Acceptable quality
*   **0.49 – 0.79**: Medium quality
*   **≥ 0.80**: High quality

## Common CLI Patterns

### Output Formatting
*   **Compact Output**: Use `--short` to get a condensed version of the results, ideal for parsing or quick terminal reviews.
*   **Machine Readable**: Use `--json <filename.json>` to dump the complete results data into a JSON file for downstream analysis.

### Handling Different Molecular Types
*   **Small Molecules**: Add the `--small_molecule` flag to score ligands. Note that ligands must have separate chain identifiers in the PDB/mmCIF files.
*   **Nucleic Acids**: DNA and RNA interfaces are handled automatically alongside proteins.
*   **Peptides**: Use `--capri_peptide` for specific scoring parameters related to peptide docking.

### Chain Mapping and Optimization
DockQ v2 automatically attempts to find the optimal mapping between interfaces in the native and model structures. You can control this behavior using the `--mapping` flag:

*   **Force Specific Mapping**: `--mapping AB:BA` (Maps model chain A to native B, and model B to native A).
*   **Partial Mapping (Wildcards)**: `--mapping A*:W*` (Fixes model A to native W, while letting DockQ optimize the remaining chains).
*   **Target Specific Interface**: `--mapping :WX` (Finds the best match in the model for the specific native interface WX).

## Expert Tips
*   **Performance**: For large complexes with many homologous chains, manually defining the mapping with `--mapping` significantly speeds up computation by reducing the search space.
*   **Alignment**: If the structures are already pre-aligned and you wish to skip the internal alignment step, use the `--no_align` flag.
*   **Multiprocessing**: For large-scale evaluations, use `--n_cpu <number>` to parallelize the calculations.
*   **mmCIF Support**: DockQ supports both `.pdb` and `.cif` formats. For mmCIF files, the tool uses the `label_asym_id` field for chain identification.

## Reference documentation
- [DockQ GitHub Repository](./references/github_com_wallnerlab_DockQ.md)
- [Grouping chains for evaluation](./references/github_com_wallnerlab_DockQ_issues_33.md)