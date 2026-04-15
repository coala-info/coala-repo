---
name: antarna
description: antaRNA performs inverse folding of mono- and bistable RNA macromolecules using ant-colony optimization to find sequences that meet specific structural requirements. Use when user asks to design RNA sequences for target secondary structures, model bistable molecules like riboswitches, or perform multi-objective inverse folding of pseudoknot RNA.
homepage: https://github.com/RobertKleinkauf/antarna
metadata:
  docker_image: "quay.io/biocontainers/antarna:2.0.1.2--py27_0"
---

# antarna

## Overview

antaRNA (ant assembled RNA) is a computational tool designed for the inverse folding of mono- and bistable RNA macromolecules. By employing ant-colony optimization, it searches for RNA sequences that satisfy specific structural requirements. It integrates with the ViennaRNA package to evaluate base pair probability matrices, allowing users to model complex behaviors such as ligand-induced conformational changes and multi-objective structural targets.

## CLI Usage Patterns

The tool is executed via Python and follows a hierarchical command structure based on the optimization objective.

### Basic Command Structure
```bash
python antarna.py [COMMON_OPTIONS] [MODUS] [MODUS_OPTIONS]
```

### Optimization Modes
1.  **MFE (Minimum Free Energy):** Used for standard dot-bracket structure optimization. This is the preferred mode when you have a single target secondary structure.
2.  **DP (Dot Plot):** Used for dot plot structure optimization. This mode is essential for designing bistable molecules where the goal is to match a specific base pair probability distribution rather than a single static structure.

## Workflow Best Practices

### Designing Bistable RNA
To design molecules that can switch between two states (e.g., riboswitches), use the `DP` mode. This allows the tool to utilize the base pair probability matrix to ensure the sequence can realistically occupy multiple conformational states.

### Applying Constraints
antaRNA supports structural constraints to simulate induced conformations. Use these when:
*   Modeling ligand binding sites that "lock" certain bases.
*   Enforcing specific base pairings that must exist in the final design.
*   Defining "Terrain Graphs" to guide the ant colony optimization through complex structural landscapes.

### Handling Pseudoknots
The tool is capable of multi-objective inverse folding of pseudoknot RNA. When working with pseudoknots, ensure the input structures are formatted correctly for the optimization engine to recognize non-nested interactions.

## Expert Tips
*   **Sequence Constraints:** You can apply constraints to the primary sequence (e.g., forcing a specific start codon or conserved motif) alongside structural constraints.
*   **Terrain Graph Pruning:** For large or complex structures, the Terrain Graph functionality helps in pruning the search space, making the optimization more efficient.
*   **Visualization:** Use the included `plot_B_UB.py` script to visualize the relationship between different structural objectives or energy states during the design process.

## Reference documentation
- [Main Repository and Usage Overview](./references/github_com_RobertKleinkauf_antarna.md)