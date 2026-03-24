# Molecular Dynamics Simulation CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://mmb.irbbarcelona.org/biobb/
- **Package**: https://workflowhub.eu/workflows/121
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/121/ro_crate?version=1
- **Source repository (git):** https://github.com/bioexcel/biobb_hpc_workflows
- **Conda**: N/A
- **Total Downloads**: 739
- **Last updated**: 2023-01-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `md_list.cwl` (Main Workflow)
- **Project**: BioBB Building Blocks
- **Views**: 4060
- **Discussion / source**: https://github.com/bioexcel/biobb_hpc_workflows

## Description

CWL version of the md_list.py workflow for HPC. This performs a system setup and runs a molecular dynamics simulation on the structure passed to this workflow. This workflow uses the md\_gather.cwl sub-workflow to gather the outputs together to return these.
To work with more than one structure this workflow can be called from either the md\_launch.cwl workflow, or the md\_launch\_mutate.cwl workflow. These use scatter for parallelising the workflow. md\_launch.cwl operates on a list of individual input molecule files. md\_launch\_mutate.cwl operates on a single input molecule file, and a list of mutations to apply to that molecule. Within that list of mutations, a value of 'WT' will indicate that the molecule should be simulated without any mutation being applied.
