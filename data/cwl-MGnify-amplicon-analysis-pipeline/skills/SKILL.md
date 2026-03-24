---
name: mgnify-amplicon-analysis-pipeline
description: "This Common Workflow Language pipeline processes amplicon sequencing data through quality control and taxonomic assignment steps to analyze microbial populations in environmental samples. Use this skill when you need to determine the taxonomic diversity of a microbiome or identify specific bacterial and fungal taxa present in diverse ecological niches."
homepage: https://workflowhub.eu/workflows/361
---
# MGnify - amplicon analysis pipeline

## Overview

This CWL workflow is part of the [MGnify](http://www.ebi.ac.uk/metagenomics) v5.0 analysis suite, specifically designed for the taxonomic analysis of amplicon sequencing data. It provides a standardized, reproducible approach for processing microbial population data from various environments, ensuring high provenance through the [Common Workflow Language](https://workflowhub.eu/workflows/361) standard.

The pipeline focuses on quality control and data integrity, processing raw reads through discrete `before-qc` and `after-qc` stages. This version of the MGnify pipeline is tailored to provide precise taxonomic assertions, including specialized support for ribosomal internal transcribed spacer regions (ITS1/2) and expanded functional annotations.

Detailed technical specifications and implementation details regarding the underlying algorithms are available in the official [MGnify documentation](https://docs.mgnify.org/en/latest/analysis.html#amplicon-analysis-pipeline). The workflow is structured to facilitate clear tracking of data transformations, ensuring that all outputs meet the requirements for archiving and public distribution within the MGnify resource.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| single_reads |  | File? |  |
| forward_reads |  | File? |  |
| reverse_reads |  | File? |  |
| qc_min_length |  | int |  |
| stats_file_name |  | string |  |
| ssu_db |  | File |  |
| lsu_db |  | File |  |
| ssu_tax |  | string |  |
| lsu_tax |  | string |  |
| ssu_otus |  | string |  |
| lsu_otus |  | string |  |
| rfam_models |  | string[] |  |
| rfam_model_clans |  | string |  |
| ssu_label |  | string |  |
| lsu_label |  | string |  |
| 5s_pattern |  | string |  |
| 5.8s_pattern |  | string |  |
| unite_db |  | File |  |
| unite_tax |  | string |  |
| unite_otu_file |  | string |  |
| unite_label |  | string |  |
| itsonedb |  | File |  |
| itsonedb_tax |  | string |  |
| itsonedb_otu_file |  | string |  |
| itsonedb_label |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| before-qc | before-qc |  |
| after-qc | after-qc |  |
| touch_file_flag | touch_file_flag |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| qc-statistics |  | Directory |  |
| qc_summary |  | File |  |
| qc-status |  | File |  |
| hashsum_paired |  | File[]? |  |
| hashsum_single |  | File? |  |
| fastp_filtering_json_report |  | File? |  |
| gz_files |  | File[] |  |
| sequence-categorisation_folder |  | Directory? |  |
| taxonomy-summary_folder |  | Directory? |  |
| rna-count |  | File? |  |
| ITS-length |  | File? |  |
| suppressed_upload |  | Directory? |  |
| completed_flag_file |  | File? |  |
| no_tax_flag_file |  | File? |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/361
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
