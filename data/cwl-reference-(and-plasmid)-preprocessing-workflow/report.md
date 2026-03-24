# reference (and plasmid) preprocessing workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.wur.nl/en/research-results/chair-groups/agrotechnology-and-food-sciences/biomolecular-sciences/laboratory-of-systems-and-synthetic-biology.htm
- **Package**: https://workflowhub.eu/workflows/1818
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1818/ro_crate?version=1
- **Source repository (git):** https://git.wur.nl/ssb/automated-data-analysis/cwl
- **Conda**: N/A
- **Total Downloads**: 291
- **Last updated**: 2025-08-12
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflows/workflow_preprocess_reference.cwl` (Main Workflow)
- **Project**: Systems and Synthetic Biology
- **Views**: 1022
- **Creators**: Martijn Melissen

## Description

**Workflow for preprocessing a reference file. **

Steps:  
-When a GenBank file is not provided, it is downloaded from NCBI based on a accession number.  
-When multiple plasmid GenBank files are provided, they are merged into one file.  
-When any amount of plasmid GenBank files are provided, the reference is merged with the plasmid GenBank file(s) into one file. A FASTA file is also extracted.  
-When no plasmid Genbank files are provided, a FASTA file is extracted from the reference GenBank file.  
-A GFF3 file is extracted from the final GenBank file.  
-The final step determines the relevant outputs.  

**All tool CWL files and other workflows can be found here:**  
  Tools: https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/tools  
  Workflows: https://git.wur.nl/ssb/automated-data-analysis/cwl/-/tree/main/workflows
