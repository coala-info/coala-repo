# ChIP-Seq data processing workflow CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://eosc4cancer.eu
- **Package**: https://workflowhub.eu/workflows/1761
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1761/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 304
- **Last updated**: 2025-06-27
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Common Workflow Language
- **Main workflow (WorkflowHub):** `CWL/workflows/ChIPseq.cwl` (Main Workflow)
- **Project**: EOSC4Cancer
- **Views**: 1092
- **Creators**: Kersten Breuer

## Description

This workflow supports primary processing of ChIP-Seq data from raw reads to genome-wide ChIP signal tracks and ChIP peaks.  The main steps include read trimming using trimGalore, alignment with bowtie2, coverage generation using samtools and peak calling with MACS2.
