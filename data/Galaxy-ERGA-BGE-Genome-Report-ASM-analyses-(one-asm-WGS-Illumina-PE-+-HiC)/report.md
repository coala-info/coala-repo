# ERGA-BGE Genome Report ASM analyses (one-asm WGS Illumina PE + HiC) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/1103
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1103/ro_crate?version=3
- **Conda**: N/A
- **Total Downloads**: 1.3K
- **Last updated**: 2024-12-05
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 3
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA-BGE_Genome_Report_ASM_analyses_(one-asm_WGS_Illumina_PE___HiC).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 6303
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

**Assembly Evaluation for ERGA-BGE Reports**

_One Assembly, Illumina WGS reads + HiC reads_

The workflow requires the following:
* Species Taxonomy ID number
* NCBI Genome assembly accession code
* BUSCO Lineage
* WGS accurate reads accession code
* NCBI HiC reads accession code

The workflow will get the data and process it to generate genome profiling (genomescope, smudgeplot -optional-), assembly stats (gfastats), merqury stats (QV, completeness), BUSCO, snailplot, contamination blobplot, and HiC heatmap.

**Use this workflow for ONT-based assemblies where the WGS accurate reads are Illumina PE**
