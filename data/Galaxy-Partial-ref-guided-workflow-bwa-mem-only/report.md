# Partial ref-guided workflow - bwa mem only CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.org.au/
- **Package**: https://workflowhub.eu/workflows/351
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/351/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 686
- **Last updated**: 2023-01-30
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Partial_ref-guided_workflow_bwa_mem_only.ga` (Main Workflow)
- **Project**: Galaxy Australia
- **Views**: 7465
- **Creators**: Anna Syme

## Description

# workflow-partial-bwa-mem

These workflows are part of a set designed to work for RAD-seq data on the Galaxy platform, using the tools from the Stacks program. 

Galaxy Australia: https://usegalaxy.org.au/

Stacks: http://catchenlab.life.illinois.edu/stacks/

This workflow is part of the reference-guided stacks workflow, https://workflowhub.eu/workflows/347

Inputs
* demultiplexed reads in fastq format, may be output from the QC workflow. Files are in a collection. 
* reference genome in fasta format

Outputs
* A set of filtered bam files, ready for the next part of the stacks workflow (e.g. gstacks). 
* Statistics on the bam files.
