---
name: correlationplus
description: correlationplus calculates, visualizes, and analyzes residue correlation maps from protein structures or molecular dynamics trajectories to investigate allosteric regulation and coordinated motion. Use when user asks to calculate correlation matrices from PDB files or trajectories, visualize heatmaps, compare difference maps between protein states, or identify allosteric communication pathways.
homepage: https://github.com/tekpinar/correlationplus
---


# correlationplus

## Overview
correlationplus is a Python-based suite designed to transform complex protein structural data into interpretable correlation maps. It allows researchers to investigate how residues within a protein move in a coordinated fashion, which is essential for understanding biological function and allosteric regulation. The tool supports multiple input types, ranging from simple PDB structures (using Elastic Network Models) to full atomistic MD trajectories, and provides specialized modules for the calculation, graphical representation, and statistical analysis of these interactions.

## Core Workflows and CLI Patterns

The tool is organized into four primary functional modules accessible via the command line.

### 1. Calculation (correlation_calculate)
Use this module to generate correlation matrices from structural data.
*   **From PDB (ENM):** Calculate correlations based on the topology of a single structure using Anisotropic Network Models (ANM).
*   **From Trajectory:** Process MD simulation files (e.g., .dcd, .xtc) to compute DCCM or LMI.
*   **Key Parameters:**
    *   `-p`: Input PDB file.
    *   `-f`: Trajectory file (optional, for MD-based calculation).
    *   `-m`: Correlation method (`dccm` for linear, `lmi` for non-linear).
    *   `-o`: Output filename for the generated matrix (typically `.dat` or `.npy`).

### 2. Visualization (correlation_visualize)
Use this module to create publication-quality heatmaps and 2D plots of the correlation matrices.
*   **Heatmaps:** Visualize the $N \times N$ residue correlation matrix.
*   **Key Parameters:**
    *   `-i`: Input correlation matrix file.
    *   `-p`: Reference PDB file (to map residue numbers correctly).
    *   `--limit`: Set the color scale limits (e.g., -1.0 to 1.0 for DCCM).
    *   `--output_type`: Specify format (e.g., `png`, `pdf`, `svg`).

### 3. Analysis (correlation_analyze)
Use this module to extract biological insights from the calculated data.
*   **Residue Centrality:** Identify "hub" residues that are highly correlated with many others.
*   **Difference Maps:** Compare correlation maps between two states (e.g., apo vs. holo) to see how ligand binding changes dynamics.
*   **Key Parameters:**
    *   `-i1`, `-i2`: Input matrices for comparison.
    *   `--analysis_type`: Choose between `diff`, `average`, or `centrality`.

### 4. Path Analysis (correlation_paths)
Identify communication pathways between distant residues (allostery).
*   **Shortest Paths:** Find the most efficient "communication" routes between a source and target residue based on correlation weights.

## Expert Tips and Best Practices
*   **LMI vs. DCCM:** Use Linear Mutual Information (LMI) if you suspect non-linear correlations or if the protein undergoes large conformational changes where simple vector-based correlations (DCCM) might be insufficient.
*   **Atom Selection:** By default, the tool often focuses on C-alpha atoms. Ensure your PDB file is cleaned of alternative conformations or non-standard residues unless specifically required.
*   **Trajectory Alignment:** Before calculating correlations from an MD trajectory, ensure the trajectory is properly fitted/aligned to a reference structure to remove global rotation and translation.
*   **Virtual Environments:** Always install in a virtual environment to avoid dependency conflicts with `MDAnalysis` and `numpy`.



## Subcommands

| Command | Description |
|---------|-------------|
| correlationplus | A Python package to calculate, visualize and analyze protein correlation maps. |
| correlationplus analyze | A Python package to calculate, visualize and analyze protein correlation maps. |
| correlationplus calculate | A Python package to calculate, visualize and analyze protein correlation maps. |
| correlationplus paths | A Python package to calculate, visualize and analyze protein correlation maps. |
| visualize | A Python package to calculate, visualize and analyze protein correlation maps. |

## Reference documentation
- [correlationplus README](./references/github_com_tekpinar_correlationplus_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_correlationplus_overview.md)