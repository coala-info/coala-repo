# Longread 16S classification workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://m-unlock.com
- **Package**: https://workflowhub.eu/workflows/1952
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1952/ro_crate?version=1
- **Source repository (git):** https://gitlab.com/m-unlock/cwl
- **Conda**: N/A
- **Total Downloads**: 313
- **Last updated**: 2025-09-10
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflows/workflow_amplicon_longread.cwl` (Main Workflow)
- **Project**: UNLOCK
- **Views**: 1150
- **Creators**: Bart Nijsse, Jasper Koehorst
- **Discussion / source**: https://gitlab.com/m-unlock/cwl/-/issues

## Description

Workflow for quality assessment and taxonomic classification of amplicon long read sequences.<br>
In addition files are exported to their respective subfolders for easier data management in a later stage.<br>
<br>
Inputs are expected to be basecalled fastq files<br>
<br>
**Steps:**<br>
    - NanoPlot read quality control, before and after filtering<br>
    - fastplong read quality and length filtering<br>
    - Emu abundance; species-level taxonomic abundance for full-length 16S read <br>
