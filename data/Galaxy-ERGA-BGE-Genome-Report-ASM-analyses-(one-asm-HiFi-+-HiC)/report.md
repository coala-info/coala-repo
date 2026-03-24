# ERGA-BGE Genome Report ASM analyses (one-asm HiFi + HiC) CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://www.erga-biodiversity.eu/
- **Package**: https://workflowhub.eu/workflows/1104
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/1104/ro_crate?version=2
- **Conda**: N/A
- **Total Downloads**: 921
- **Last updated**: 2024-12-05
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 2
- **License**: MIT
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-ERGA-BGE_Genome_Report_ASM_analyses_(one-asm_HiFi___HiC).ga` (Main Workflow)
- **Project**: ERGA Assembly
- **Views**: 5523
- **Creators**: Diego De Panis
- **Discussion / source**: https://github.com/ERGA-consortium/pipelines/discussions

## Description

**Assembly Evaluation for ERGA-BGE Reports**

_One Assembly, HiFi WGS reads + HiC reads_

The workflow requires the following:
* Species Taxonomy ID number
* NCBI Genome assembly accession code
* BUSCO Lineage
* WGS accurate reads accession code
* NCBI HiC reads accession code

The workflow will get the data and process it to generate genome profiling (genomescope, smudgeplot -optional-), assembly stats (gfastats), merqury stats (QV, completeness), BUSCO, snailplot, contamination blobplot, and HiC heatmap.

**Use this workflow for HiFi-based assemblies where the WGS accurate reads are PacBio HiFi**
