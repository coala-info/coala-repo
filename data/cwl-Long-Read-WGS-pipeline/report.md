# Long Read WGS pipeline CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.wur.nl/en/research-results/chair-groups/agrotechnology-and-food-sciences/biomolecular-sciences/laboratory-of-systems-and-synthetic-biology.htm
- **Package**: https://workflowhub.eu/workflows/1868
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1868/ro_crate?version=1
- **Source repository (git):** https://git.wur.nl/ssb/automated-data-analysis/cwl
- **Conda**: N/A
- **Total Downloads**: 255
- **Last updated**: 2025-08-12
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC-BY-4.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflows/workflow_ada.cwl` (Main Workflow)
- **Project**: Systems and Synthetic Biology
- **Views**: 1216
- **Creators**: Martijn Melissen

## Description

**Workflow for long read quality control, contamination filtering, assembly, variant calling and annotation.**

Steps:  
- Preprocessing of reference file : https://workflowhub.eu/workflows/1818  
- LongReadSum before and after filtering (read quality control)  
- Filtlong filter on quality and length  
- Flye assembly  
- Minimap2 mapping of reads and assembly  
- Clair3 variant calling of reads  
- Freebayes variant calling of assembly  
- Optional Bakta annotation of genomes with no reference  
- SnpEff building or downloading of a database  
- SnpEff functional annotation  
- Liftoff annotation lift over  

**All tool CWL files and other workflows can be found here:**
  Tools: https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/tools
  Workflows: https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/workflows
