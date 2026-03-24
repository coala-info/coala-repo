# VVV2_align_SE CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.anses.fr
- **Package**: https://workflowhub.eu/workflows/517
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/517/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 679
- **Last updated**: 2025-06-19
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: GPL-3.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `20231016_Galaxy-Workflow-VVV2_align_SE.ga` (Main Workflow)
- **Project**: ANSES-Ploufragan
- **Views**: 7445
- **Creators**: Fabrice Touzain

## Description

SINGLE-END workflow. 
Align reads on fasta reference/assembly using bwa mem, get a consensus, variants, mutation explanations. 

IMPORTANT: 
* For "bcftools call" consensus step, the --ploidy file is in "Données partagées" (Shared Data) and must be imported in your history to use the worflow by providing this file (tells bcftools to consider haploid variant calling). 
* SELECT the mot ADAPTED VADR MODEL for annotation (see vadr parameters).
