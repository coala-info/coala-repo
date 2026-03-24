# Quality assessment, amplicon classification and functional prediction CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://m-unlock.com
- **Package**: https://workflowhub.eu/workflows/154
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/154/ro_crate?version=2
- **Source repository (git):** https://gitlab.com/m-unlock/cwl
- **Conda**: N/A
- **Total Downloads**: 1.5K
- **Last updated**: 2025-09-11
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: AFL-3.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflows/workflow_ngtax_picrust2.cwl` (Main Workflow)
- **Project**: UNLOCK
- **Views**: 6282
- **Creators**: Bart Nijsse, Jasper Koehorst
- **Discussion / source**: https://gitlab.com/m-unlock/cwl/-/issues

## Description

Workflow for quality assessment of paired reads and classification using NGTax 2.0 and functional annotation using picrust2.<br>
In addition files are exported to their respective subfolders for easier data management in a later stage.<br><br>

Steps:
  - Quality plots (FastQC)
  - NG-TAX 2 High-throughput Amplicon Analysis
  - PICRUSt 2 - Function prediction from marker gene sequences
  - Export module for ngtax
