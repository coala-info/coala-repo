# Short read quality control, trimming and contamination filter CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://m-unlock.com
- **Package**: https://workflowhub.eu/workflows/336
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/336/ro_crate?version=2
- **Source repository (git):** https://gitlab.com/m-unlock/cwl
- **Conda**: N/A
- **Total Downloads**: 1.0K
- **Last updated**: 2025-11-06
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflows/workflow_illumina_quality.cwl` (Main Workflow)
- **Project**: UNLOCK
- **Views**: 6151
- **Creators**: Bart Nijsse, Jasper Koehorst, Changlin Ke
- **Discussion / source**: https://gitlab.com/m-unlock/cwl/-/issues

## Description

**Workflow for short paired end reads quality control, trimming and filtering.**<br />
Multiple paired datasets will be merged into single paired dataset.<br />
Summary:
- Sequali QC on raw data files<br />
- fastp for read quality trimming<br />
- BBduk for phiX and rRNA filtering (optional)<br />
- Filter human reads using Hostile (optional)<br />
- Custom read filtering using Hostile (optional)<br />
- Sequali QC on filtered (merged) data<br />

Other UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>

**All tool CWL files and other workflows can be found at:**<br>
https://gitlab.com/m-unlock/cwl

**How to setup and use an UNLOCK workflow:**<br>
https://docs.m-unlock.nl/docs/workflows/setup.html<br>
