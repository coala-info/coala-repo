# NMR pipe CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://workflowhub.eu/workflows/43
- **Package**: https://workflowhub.eu/workflows/43
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/43/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 1.5K
- **Last updated**: 2023-01-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `nmrpipe_workflow.cwl` (Main Workflow)
- **Project**: NMR Workflow
- **Views**: 4467

## Description

CWL workflow for NMR spectra Peak Picking
The workflow takes as input a series of 2D 1H 15N HSQC NMR spectra and uses nmrpipe tools to convert the spectra in nmrpipe format and performs an automatic peak picking.
This test uses a protein MDM2 with different ligands and peptide and generates a peak list with 1H and 15N chemical shift values for each spectrum. The difference among these peak lists can be used to characterize the ligand binding site on the protein.
