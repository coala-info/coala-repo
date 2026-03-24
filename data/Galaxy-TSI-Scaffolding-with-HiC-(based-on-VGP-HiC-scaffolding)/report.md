# TSI-Scaffolding-with-HiC (based on VGP-HiC-scaffolding) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.biocommons.org.au/
- **Package**: https://workflowhub.eu/workflows/1054
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1054/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 584
- **Last updated**: 2024-06-21
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: GPL-3.0+
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `TSI-Scaffolding-with-HiC.ga` (Main Workflow)
- **Project**: Australian BioCommons
- **Views**: 5609
- **Creators**: VGP Project

## Description

# Scaffolding using HiC data with YAHS

This workflow has been created from a Vertebrate Genomes Project (VGP) scaffolding workflow. 

* For more information about the VGP project see https://galaxyproject.org/projects/vgp/. 
* The scaffolding workflow is at https://dockstore.org/workflows/github.com/iwc-workflows/Scaffolding-HiC-VGP8/main:main?tab=info
* Please see that link for the workflow diagram. 

Some minor changes have been made to better fit with TSI project data: 

* optional inputs of SAK info and sequence graph have been removed
* the required input format for the genome is changed from gfa to fasta
* the estimated genome size now requires user input rather than being extracted from output of a previous workflow.  

Inputs: 

* assembly.fasta  [note - scaffolding is done only one haplotype at a time. eg hap1 or primary]
* Concatenated HiC forward reads in fastqsanger.gz
* Concatenated HiC reverse reads in fastqsanger.gz
* Restriction enzyme sequence
* Estimated genome size (enter as integer)
* Lineage for busco 

Outputs: the main outputs are: 

* scaffolded_assmbly.fasta
* comparison of pre- post- scaffolding contact maps
