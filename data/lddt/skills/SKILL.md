---
name: lddt
description: The lddt tool measures the local structural similarity between protein models and reference structures by analyzing the preservation of inter-atomic distances. Use when user asks to evaluate protein model accuracy, compare structures with domain shifts, or assess the local quality of specific regions like active sites.
homepage: https://swissmodel.expasy.org/lddt
metadata:
  docker_image: "quay.io/biocontainers/lddt:2.2--h9ee0642_0"
---

# lddt

## Overview
The `lddt` tool provides a robust alternative to RMSD for protein structure comparison. While RMSD requires a global superposition and is highly sensitive to hinge movements or domain shifts, lDDT focuses on the preservation of inter-atomic distances within a local radius. This makes it ideal for assessing the accuracy of specific regions (like active sites) and evaluating models where the relative orientation of domains might differ from the reference despite high local accuracy.

## Command Line Usage
The standard CLI execution follows this pattern:
`lddt [options] <model_pdb> <reference_pdb>`

### Common Patterns
- **Standard Evaluation**: Run with default thresholds (0.5Å, 1.0Å, 2.0Å, 4.0Å) and a 15Å inclusion radius.
  `lddt model.pdb reference.pdb`
- **Stereochemical Validation**: Enable checks to penalize models with unrealistic bond lengths or angles.
  `lddt -s model.pdb reference.pdb`
- **Custom Inclusion Radius**: Adjust the local neighborhood size (default is 15.0Å).
  `lddt -r 10.0 model.pdb reference.pdb`

## Expert Tips
- **Sequence Numbering**: Ensure the model and reference structures use identical residue numbering. The algorithm relies on matching residue indices to define the distance pairs.
- **Side-Chain Accuracy**: Unlike backbone-only metrics, lDDT considers all atoms. If a model has correct backbone topology but poor side-chain placement, the lDDT score will reflect this discrepancy.
- **Multi-Domain Proteins**: Use lDDT when comparing models of flexible proteins. A high lDDT score combined with a high RMSD often indicates that the local domains are modeled correctly, but their global arrangement is different.
- **Pre-processing**: By default, the tool removes hydrogens and non-standard residues. If working with modified residues, ensure they are trimmed to their standard parent amino acid to avoid loading errors.

## Reference documentation
- [LDDT Method Overview](./references/swissmodel_expasy_org_lddt.md)
- [Installation and Bioconda Metadata](./references/anaconda_org_channels_bioconda_packages_lddt_overview.md)