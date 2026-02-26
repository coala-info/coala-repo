---
name: correlationplus
description: "correlationplus is a Python suite for calculating and analyzing residue correlation matrices and communication networks from protein structures or molecular dynamics trajectories. Use when user asks to calculate dynamical cross-correlations or linear mutual information, visualize correlation heatmaps, perform centrality analysis to identify critical residues, or find communication pathways between residues."
homepage: https://github.com/tekpinar/correlationplus
---


# correlationplus

## Overview
correlationplus is a Python-based suite designed for the biophysical analysis of protein systems. It enables researchers to move from raw structural data (PDB) or simulation trajectories (MD) to sophisticated correlation matrices and network-based residue analysis. The tool supports various metrics including dynamical cross-correlations (DCC), linear mutual information (LMI), and sequence-based covariation. By treating the protein as a graph, it identifies critical residues through centrality measures like betweenness, closeness, and eigenvector centrality, which are essential for understanding allosteric regulation.

## CLI Usage Patterns

The tool is accessed via a single entry point with four primary subcommands: `calculate`, `visualize`, `analyze`, and `paths`.

### 1. Calculation of Correlations
Use the `calculate` module to generate correlation data from structural models or trajectories.
*   **From PDB (Elastic Network Model):**
    `correlationplus calculate -p protein.pdb -m anm`
*   **From MD Trajectory:**
    `correlationplus calculate -p protein.pdb -f trajectory.xtc -m md`
*   **Dihedral Correlations:**
    `correlationplus calculate -p protein.pdb -f trajectory.xtc -m md --dihedral` (Supports phicc, psicc, and omegacc).

### 2. Visualization
Generate heatmaps and centrality plots to interpret the calculated data.
*   **Correlation Heatmaps:**
    `correlationplus visualize -i correlation.mat -o heatmap.png`
*   **Interactive Plots:**
    Recent versions support interactive Plotly heatmaps and centrality plots. Use the `-inter` flag if available in the specific version's help menu.

### 3. Centrality Analysis
Identify "hub" residues or those critical for communication.
*   **Standard Analysis:**
    `correlationplus analyze -i correlation.mat -p protein.pdb`
*   **Specific Metrics:**
    Calculate current flow betweenness, closeness, or eigenvector centralities to pinpoint allosteric sites.

### 4. Communication Pathways
*   **Pathfinding:**
    `correlationplus paths -i correlation.mat -p protein.pdb --source 10 --target 150`
    This identifies the most probable communication routes between residue 10 and residue 150.

## Expert Tips and Best Practices

*   **Environment Management:** Due to specific dependencies like `MDAnalysis` and `llvmlite`, always install `correlationplus` in a dedicated virtual environment. Ensure `pip` is updated to at least version 21.0.1 before installation.
*   **Handling Large Trajectories:** When working with large MD files, ensure the topology (PDB/PSF) matches the trajectory exactly. Use the `--selection` flag (if supported by the specific calculation) to focus on C-alpha atoms to reduce computational overhead.
*   **Metric Selection:** 
    *   Use **DCC** (Dynamical Cross-Correlation) for linear displacements.
    *   Use **LMI** (Linear Mutual Information) to capture non-linear correlations and correlations that DCC might miss due to orthogonal movements.
*   **PyMOL Integration:** The `analyze` module often produces `.pml` scripts. Run these in PyMOL to automatically map centrality values onto the 3D structure (e.g., coloring residues by their "importance" in the network).
*   **Interactive Debugging:** If using Jupyter or Colab, the package provides an API that allows for interactive adjustment of arguments and real-time visualization of RMSF and entropy.

## Reference documentation
- [correlationplus GitHub Repository](./references/github_com_tekpinar_correlationplus.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_correlationplus_overview.md)