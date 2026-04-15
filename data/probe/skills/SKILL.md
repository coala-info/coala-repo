---
name: probe
description: The probe tool performs all-atom contact analysis to identify steric clashes, hydrogen bonds, and van der Waals interactions within or between molecular structures. Use when user asks to detect clashes, validate packing quality, analyze inter-chain contacts, or generate dot-list visualizations for kinemage files.
homepage: http://kinemage.biochem.duke.edu/software/probe/
metadata:
  docker_image: "quay.io/biocontainers/probe:2.18--h9948957_0"
---

# probe

## Overview
The `probe` tool is a specialized utility for all-atom contact analysis. It uses a small rolling probe (typically 0.25Å) to identify where atoms are in close contact, providing a more detailed view of packing than traditional surface algorithms. It is primarily used to detect "clashes" (overlaps), validate H-bond networks, and assess the quality of protein structures.

## Usage Guidelines

### Pre-requisites
- **Add Hydrogens**: `probe` requires explicit hydrogen atoms to produce meaningful results. Always process PDB files with `reduce` before running `probe`.
- **Input Format**: Standard PDB format.

### Common Command Patterns
The general syntax follows: `probe [options] "source selection" ["target selection"] input.pdb`

- **Identify Clashes and Contacts**:
  Generate a list of interactions (clashes, H-bonds, van der Waals) between all atoms.
  ```bash
  probe -both "all" input_with_h.pdb
  ```

- **Self-Interactions**:
  Analyze packing within a specific chain or residue range.
  ```bash
  probe -self "chainA" input_with_h.pdb
  ```

- **Inter-chain Analysis**:
  Check contacts between a protein and a ligand or two different chains.
  ```bash
  probe "chainA" "chainB" input_with_h.pdb
  ```

- **Condensed Table Output**:
  Instead of a dot-list for visualization, output a summary table of scores.
  ```bash
  probe -summary "all" input_with_h.pdb
  ```

### Selection Syntax
`probe` uses a specific string-based selection language:
- `all`: All atoms.
- `chainA`: All atoms in chain A.
- `res1-50`: Residues 1 through 50.
- `water`: Water molecules.
- `not water`: Everything except waters.

### Expert Tips
- **Dot Density**: Use `-density=16` (default) for standard analysis or `-density=100` for high-quality publication graphics.
- **Probe Radius**: The default is 0.25Å. Adjusting this (e.g., `-radius=0.5`) can change the sensitivity to packing gaps.
- **Visualization**: The default output is a "dot-list" intended for `.kin` (kinemage) files. To view these, pipe the output into a file and open with KiNG or Mage.
- **Clash Detection**: Focus on "spikes" in the visualization; large red spikes indicate significant steric clashes that likely require sidechain flipping or model adjustment.

## Reference documentation
- [Probe Software Overview](./references/kinemage_biochem_duke_edu_software_probe.md)