# CUT'N'RUN data processing workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://eosc4cancer.eu
- **Package**: https://workflowhub.eu/workflows/1765
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1765/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 280
- **Last updated**: 2025-06-30
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `CWL/workflows/CUTnRUN.cwl` (Main Workflow)
- **Project**: EOSC4Cancer
- **Views**: 1062
- **Creators**: Kersten Breuer

## Description

This workflow supports processing of bulk CUT'N'RUN data from raw reads to genome-wide accessiblity tracks (bigWig) and CUT'N'RUN peaks. The main steps include read trimming using trimGalore, alignment with bowtie2, coverage generation using samtools and peak calling with MACS2.
