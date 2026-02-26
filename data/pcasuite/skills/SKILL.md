---
name: pcasuite
description: pcasuite manages molecular dynamics data by compressing trajectories into PCA-based formats and performing structural analysis on the compressed files. Use when user asks to compress trajectories with pcazip, reconstruct files with pcaunzip, or analyze dynamics and extract structural metadata using pczdump.
homepage: https://mmb.irbbarcelona.org/gitlab/andrio/pcasuite
---


# pcasuite

## Overview

The `pcasuite` is a specialized toolkit for the efficient management of molecular dynamics (MD) data. It allows you to transform bulky trajectory files into compact PCA-compressed formats (.pcz) while retaining a specified percentage of the system's variance. This skill provides the procedural knowledge to compress trajectories with `pcazip`, reconstruct them with `pcaunzip`, and perform high-level analysis (like fluctuation calculations or hinge point prediction) directly on compressed data using `pczdump`.

## Core Workflows

### Trajectory Compression (`pcazip`)
Use `pcazip` to reduce trajectory size. You must provide a trajectory and a reference structure (PDB) to define atom names.

*   **Basic Compression:**
    `pcazip -i input.traj -o output.pcz -p reference.pdb`
*   **Quality Control:**
    Use `-q` to specify the percentage of total variance to maintain (e.g., `-q 90`) or `-e` to specify a fixed number of eigenvectors.
*   **Atom Selection:**
    Use `-M "mask"` (Amber-style syntax) to compress only specific residues or atom types (e.g., `:1-100@CA`).
*   **Gaussian RMSd:**
    Add the `-g` flag to use a Gaussian-weighted RMSd algorithm for recentering, which can be more robust for flexible systems.

### Trajectory Reconstruction (`pcaunzip`)
Use `pcaunzip` to revert a .pcz file back to a readable trajectory format.

*   **Standard Recovery:**
    `pcaunzip -i input.pcz -o output.traj`
*   **PDB Output:**
    If the original compression included a PDB, you can extract frames directly to PDB format using the `--pdb` flag.

### Analysis without Decompression (`pczdump`)
`pczdump` is the most versatile tool in the suite, allowing for rapid querying of the compressed data.

*   **Metadata Retrieval:**
    `pczdump -i input.pcz --info` (Returns atom counts, frames, and explained variance).
*   **Dynamics Analysis:**
    *   **Fluctuations:** `pczdump -i input.pcz --fluc` (Add `--bfactor` to output as B-factors).
    *   **Hinge Prediction:** `pczdump -i input.pcz --hinge` to identify potential pivot points in the protein.
    *   **Collectivity:** `pczdump -i input.pcz --collectivity` to measure how many atoms participate in a specific eigenvector's movement.
*   **Structural Extraction:**
    *   **Average Structure:** `pczdump -i input.pcz --avg`
    *   **Projections:** `pczdump -i input.pcz --proj` to get projections for specific eigenvectors.

## Expert Tips

*   **Masking is Critical:** Always use a mask (`-M`) during compression to focus on the solute (e.g., protein backbones) and exclude solvent/ions. This significantly improves compression ratios and the quality of the PCA.
*   **Verbose Mode:** Use `-v` during long compression tasks to monitor progress, as PCA calculation on large trajectories can be computationally intensive.
*   **Eigenvector Animation:** Use `pczdump -i input.pcz --anim --evec 1` to generate a trajectory showing the motion described by the first principal component.

## Reference documentation
- [pcasuite GitHub Repository](./references/github_com_mmb-irb_pcasuite.md)