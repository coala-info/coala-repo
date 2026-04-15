---
name: metagenomic-gems-from-assembly
description: This CWL workflow reconstructs genome-scale metabolic models from metagenomic assemblies using Prodigal for gene prediction, CarveMe for model generation, and SMETANA for interaction analysis. Use this skill when you need to characterize the metabolic potential of microbial populations, infer inter-species metabolic interactions, and assess the quality of reconstructed models from metagenomic bins.
homepage: https://m-unlock.com
metadata:
  docker_image: "N/A"
---

# metagenomic-gems-from-assembly

## Overview

This workflow automates the reconstruction and evaluation of genome-scale metabolic models (GEMs) from metagenomic bins or assemblies. It integrates gene prediction, metabolic modeling, and quality assessment into a streamlined pipeline for analyzing microbial communities.

The process begins with gene prediction using **Prodigal**, followed by metabolic model reconstruction via **CarveMe**. To ensure model quality and consistency, the workflow generates **MEMOTE** reports and calculates comprehensive GEM statistics. For community-level analysis, **SMETANA** is utilized to perform Species METabolic interaction ANAlysis, identifying potential metabolic exchanges between organisms.

Key resources and related components include:
*   **Source Repository:** [UNLOCK CWL Tools](https://gitlab.com/m-unlock/cwl) and [Workflows](https://gitlab.com/m-unlock/cwl/workflows)
*   **Documentation:** [Setup and Usage Guide](https://m-unlock.gitlab.io/docs/setup/setup.html)
*   **Related Workflows:** [UNLOCK Project Collection](https://workflowhub.eu/projects/16/workflows?view=default) on WorkflowHub

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| identifier | Identifier used | string | Identifier for this dataset used in this workflow |
| bins | Genome/bin | File[] | Bin/genome fasta files |
| solver |  | string | Solver to be used in MEMOTE and SMETANA (defaul; cplex) |
| threads | number of threads | int? | Number of threads to use for computational processes |
| destination | Output Destination (prov only) | string? | Not used in this workflow. Output destination used for cwl-prov reporting only. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| prodigal | prodigal | prodigal gene/protein prediction |
| compress_prodigal | Compress proteins | Compress prodigal protein files |
| carveme | CarveMe | Genome-scale metabolic models reconstruction with CarveMe |
| compress_carveme | Compress GEM | Compress CarveMe GEM |
| gemstats | GEM stats | CarveMe GEM statistics |
| smetana | SMETANA | Species METabolic interaction ANAlysis |
| memote_report_snapshot | MEMOTE report snapshot | Take a snapshot of a model's state and generate a report. |
| memote_run | MEMOTE report snapshot | MEMOTE run analsis |
| carveme_files_to_folder | CarveMe GEMs to folder | Preparation of workflow output files to a specific output folder |
| prodigal_files_to_folder | Prodigal proteins to folder | Preparation of workflow output files to a specific output folder |
| memote_files_to_folder | MEMOTE output | Preparation of workflow output files to a specific output folder |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| carveme_gems_folder | CarveMe GEMs folder | Directory | CarveMe metabolic models folder |
| protein_fasta_folder | Protein files folder | Directory | Prodigal predicted proteins (compressed) fasta files |
| memote_folder | MEMOTE outputs folder | Directory | MEMOTE outputs folder |
| smetana_output | SMETANA output | File | SMETANA detailed output table |
| gemstats_out | GEMstats | File | CarveMe GEM statistics |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/372
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata