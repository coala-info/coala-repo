# Metagenomic Binning from Assembly CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://m-unlock.com
- **Package**: https://workflowhub.eu/workflows/64
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/64/ro_crate?version=12
- **Source repository (git):** https://gitlab.com/m-unlock/cwl
- **Conda**: N/A
- **Total Downloads**: 3.2K
- **Last updated**: 2025-10-03
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 12
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflows/workflow_metagenomics_binning.cwl` (Main Workflow)
- **Project**: UNLOCK
- **Views**: 17373
- **Creators**: Jasper Koehorst, Bart Nijsse
- **Discussion / source**: https://git.wur.nl/unlock/cwl/-/issues

## Description

**Workflow for Metagenomics binning from assembly.<br>**

  Minimal inputs are: Identifier, assembly (fasta) and an associated sorted BAM file

  Summary<br>
    - MetaBAT2 (binning)<br>
    - MaxBin2 (binning)<br>
    - SemiBin2 (binning)<br>
    - Binette (bin merging)<br>
    - EukRep (eukaryotic classification)<br>
    - CheckM2 (bin completeness and contamination)<br>
    - BUSCO (bin completeness)<br>
    - GTDB-Tk (bin taxonomic classification)<br>
    - CoverM (bin abundances)<br>
    
Including:<br>
   **Bin annotation (workflow: https://workflowhub.eu/workflows/1170):**<br>
        - Bakta<br>
        - Interproscan<br>
        - Eggnog<br>
        - KOfamscan<br>
        - To RDF conversion with SAPP (optional, default on) --> https://workflowhub.eu/workflows/1174/<br>

  Other UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br>
  
  **All tool CWL files and other workflows can be found here:**<br>
    https://gitlab.com/m-unlock/cwl<br>

  **How to setup and use an UNLOCK workflow:**<br>
  https://docs.m-unlock.nl/docs/workflows/setup.html<br>
