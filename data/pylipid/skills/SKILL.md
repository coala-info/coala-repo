---
name: pylipid
description: PyLipID is a Python toolkit for analyzing lipid-protein interactions and kinetics from molecular dynamics simulations. Use when user asks to characterize lipid-protein interactions, identify binding sites, calculate residence times, implement dual-cutoff schemes, or generate representative binding poses.
homepage: https://github.com/wlsong/PyLipID
---


# pylipid

## Overview
PyLipID is a specialized Python toolkit designed to characterize how lipids interact with membrane proteins. It is particularly effective for processing trajectories from coarse-grained (CG) or all-atom simulations to identify specific binding sites and quantify the kinetics of interaction. Use this skill to guide the setup of interaction analyses, implement the dual-cutoff scheme to filter "rattling" noise, and generate representative binding poses for structural analysis.

## Installation and Setup
Install PyLipID using one of the following methods:
- **Conda (Bioconda):** `conda install bioconda::pylipid`
- **Pip:** `pip install pylipid`
- **Source:** `git clone https://github.com/wlsong/PyLipID` followed by `python setup.py install`

## Core Workflow and Best Practices

### 1. Interaction Analysis Setup
The primary entry point for analysis is typically the `LipidInteraction` class. You must provide the trajectory files and the topology.
- **Dual-Cutoff Scheme:** Always define two cutoffs (lower and upper) to handle the "rattling in cage" effect. The interaction starts when a lipid enters the lower cutoff and ends only when it exits the upper cutoff.
- **Lipid Selection:** Specify the residue name of the lipid of interest (e.g., "POPC", "CHOL").

### 2. Key Metrics and Functions
- **Binding Site Detection:** PyLipID uses community structures in interaction networks to group residues into binding sites.
- **Kinetics:** Use the library to calculate:
    - **Residence Time:** How long a lipid stays at a site.
    - **koff:** The dissociation rate constant.
- **Contact Collection:** Use `li.collect_residue_contacts()` to aggregate interaction data across trajectories.

### 3. Bound Pose Analysis
- **Representative Poses:** Generate the most frequent or energetically favorable orientations of lipids within identified binding sites.
- **Clustering:** Use the automated clustering schemes to categorize bound poses and identify distinct binding modes.

### 4. Expert Tips
- **Memory Management:** When working with large MD trajectories, ensure your environment has sufficient RAM, as loading multiple trajectories for contact collection can be memory-intensive.
- **Visualization:** PyLipID can generate manuscript-ready figures. Use the built-in plotting functions to visualize residence times per residue or binding site.
- **Jupyter Integration:** While scripts are supported, using Jupyter notebooks is recommended for iterative analysis and immediate visualization of interaction networks.

## Reference documentation
- [PyLipID Overview](./references/anaconda_org_channels_bioconda_packages_pylipid_overview.md)
- [PyLipID GitHub Repository](./references/github_com_wlsong_PyLipID.md)
- [PyLipID Issues and Troubleshooting](./references/github_com_wlsong_PyLipID_issues.md)