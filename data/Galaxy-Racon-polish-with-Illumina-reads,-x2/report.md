# Racon polish with Illumina reads, x2 CWL Workflow Report

### Metadata
- **Docker Image**: N/A
- **Homepage**: https://usegalaxy.org.au/
- **Package**: https://workflowhub.eu/workflows/228
- **Validation**: N/A

- **RO-Crate download**: https://workflowhub.eu/workflows/228/ro_crate?version=1
- **Conda**: N/A
- **Total Downloads**: 768
- **Last updated**: 2023-01-30
- **GitHub**: N/A
- **Stars**: N/A
- **Version**: 1
- **License**: Apache-2.0
- **Workflow type**: Galaxy
- **Main workflow (WorkflowHub):** `Galaxy-Workflow-Racon_polish_with_Illumina_reads_x2.ga` (Main Workflow)
- **Project**: Galaxy Australia
- **Views**: 8378
- **Creators**: Anna Syme

## Description

Assembly polishing subworkflow: Racon polishing with short reads

Inputs: short reads and assembly (usually pre-polished with other tools first, e.g. Racon + long reads; Medaka)

Workflow steps: 
* minimap2: short reads (R1 only) are mapped to the assembly => overlaps.paf. Minimap2 setting is for short reads.
* overlaps + short reads + assembly => Racon => polished assembly 1
* using polished assembly 1 as input; repeat minimap2 + racon => polished assembly 2
* Racon short-read polished assembly => Fasta statistics

Infrastructure_deployment_metadata: Galaxy Australia (Galaxy)
