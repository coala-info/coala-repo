---
name: pcasuite
description: pcasuite is a toolkit for compressing and analyzing molecular dynamics trajectories using Principal Component Analysis. Use when user asks to compress trajectories into PCZ files, decompress data into standard formats, or analyze essential dynamics and structural fluctuations.
homepage: https://mmb.irbbarcelona.org/gitlab/andrio/pcasuite
---

# pcasuite

## Overview
pcasuite is a specialized toolkit designed for the efficient storage and analysis of molecular dynamics trajectories. By applying Principal Component Analysis, it reduces the storage footprint of trajectory data while preserving essential conformational variance. It is particularly useful when handling large-scale simulation data where disk space is a constraint or when rapid analysis of essential dynamics (eigenvectors and projections) is required.

## Core Workflows

### Compressing Trajectories (pcazip)
Use `pcazip` to convert standard MD trajectories into compressed PCZ files.

*   **Basic Compression**:
    `pcazip -i trajectory.x -o output.pcz -p reference.pdb`
*   **Quality-Based Compression**: Define the percentage of total variance to retain (e.g., 90%).
    `pcazip -i trajectory.x -o output.pcz -p reference.pdb -q 90`
*   **Fixed Eigenvector Count**: Store a specific number of principal components.
    `pcazip -i trajectory.x -o output.pcz -p reference.pdb -e 20`
*   **Atom Selection**: Use an Amber-style mask to compress only specific regions (e.g., C-alpha atoms).
    `pcazip -i trajectory.x -o output.pcz -p reference.pdb -M ":@CA"`

### Decompressing Trajectories (pcaunzip)
Use `pcaunzip` to restore a trajectory for use in other MD analysis tools.

*   **Restore to Amber Format**:
    `pcaunzip -i input.pcz -o restored.x`
*   **Restore to PDB Format**: (Requires that a PDB was provided during compression)
    `pcaunzip -i input.pcz -o restored.pdb --pdb`

### Analyzing Compressed Data (pczdump)
Use `pczdump` to query the contents of a PCZ file without decompressing the entire trajectory.

*   **Metadata and Statistics**: View variance, atom counts, and compression quality.
    `pczdump -i input.pcz --info`
*   **Atomic Fluctuations**: Calculate RMSF or B-factors.
    `pczdump -i input.pcz --fluc --bfactor`
*   **Essential Dynamics**: Extract eigenvalues or animate movement along a specific eigenvector.
    `pczdump -i input.pcz --evals`
    `pczdump -i input.pcz --anim --evec 1`
*   **Structural Analysis**: Extract the average structure or compute RMSD.
    `pczdump -i input.pcz --avg -o average.pdb --pdb`

## Expert Tips
*   **Recentering**: By default, `pcazip` uses standard RMSd for recentering. For systems with high local flexibility, use the `-g` flag for Gaussian-weighted recentering to improve the definition of the essential subspace.
*   **Masking**: Always use the `-M` (mask) or `-m` (PDB mask) option if you only care about the protein backbone or specific residues. This significantly increases compression ratios and reduces noise in the PCA.
*   **Verbosity**: Use the `-v` flag during compression of large trajectories to monitor progress, as PCA calculation on high-atom-count systems can be computationally intensive.



## Subcommands

| Command | Description |
|---------|-------------|
| pcaunzip | Decompress PCA data from a file |
| pcazip | Compresses amber format trajectory files using Principal Component Analysis (PCA). |
| pczdump | Extract information and perform calculations on PCZ files |

## Reference documentation
- [pcasuite README](./references/github_com_mmb-irb_pcasuite_blob_master_README.md)