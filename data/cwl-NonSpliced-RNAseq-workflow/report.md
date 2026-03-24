# NonSpliced RNAseq workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://m-unlock.com
- **Package**: https://workflowhub.eu/workflows/77
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/77/ro_crate?version=1
- **Source repository (git):** https://gitlab.com/m-unlock/cwl
- **Conda**: N/A
- **Total Downloads**: 943
- **Last updated**: 2023-01-16
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: CC0-1.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `workflows/to_check/workflow_RNAseq_NonSpliced.cwl` (Main Workflow)
- **Project**: UNLOCK
- **Views**: 4994
- **Creators**: Bart Nijsse, Jasper Koehorst
- **Discussion / source**: https://gitlab.com/m-unlock/cwl/-/issues

## Description

Workflow for NonSpliced RNAseq data with multiple aligners.

Steps:  
    - workflow_quality.cwl:
        - FastQC (control)
        - fastp (trimming)
    - bowtie2 (read mapping)
    - sam_to_sorted-bam
    - featurecounts (transcript read counts)
    - kallisto (transcript [pseudo]counts)
