---
name: mgnify-raw-reads-analysis-pipeline
description: "This Common Workflow Language pipeline processes raw metagenomic sequencing reads through quality control, taxonomic classification, and functional annotation to analyze microbiome data. Use this skill when you need to characterize the taxonomic diversity and metabolic potential of microbial communities within environmental or clinical samples."
homepage: https://workflowhub.eu/workflows/362
---
# MGnify - raw-reads analysis pipeline

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/362) pipeline is part of the MGnify v5.0 analysis framework, designed for the systematic processing of raw metagenomic sequencing reads. It provides a standardized environment for the analysis and archiving of microbiome data, ensuring reproducibility and provenance through formal workflow descriptions.

The pipeline focuses on generating taxonomic assertions and functional annotations. Key features include taxonomic identification based on ribosomal internal transcribed spacer regions (ITS1/2) and expanded protein functional annotations. It also supports biochemical pathway and systems predictions to characterize the metabolic potential of the sampled microbial populations.

The workflow execution is structured into the following primary stages:
* **Quality Control:** Initial data validation and filtering performed through `before-qc` and `after-qc` steps.
* **Conditional Flagging:** Management of downstream processing logic via `touch_file_flag` and `touch_no_cds_flag` to handle specific data states or missing coding sequences.

For detailed implementation details and configuration options, refer to the [official MGnify documentation](https://docs.mgnify.org/en/latest/analysis.html#raw-reads-analysis-pipeline).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| single_reads |  | File? |  |
| forward_reads |  | File? |  |
| reverse_reads |  | File? |  |
| qc_min_length |  | int |  |
| ssu_db |  | File |  |
| lsu_db |  | File |  |
| ssu_tax |  | string |  |
| lsu_tax |  | string |  |
| ssu_otus |  | string |  |
| lsu_otus |  | string |  |
| rfam_models |  | string[] |  |
| rfam_model_clans |  | string |  |
| other_ncRNA_models |  | string[] |  |
| ssu_label |  | string |  |
| lsu_label |  | string |  |
| 5s_pattern |  | string |  |
| 5.8s_pattern |  | string |  |
| CGC_config |  | string |  |
| CGC_postfixes |  | string[] |  |
| cgc_chunk_size |  | int |  |
| protein_chunk_size_hmm |  | int |  |
| protein_chunk_size_IPS |  | int |  |
| func_ann_names_ips |  | string |  |
| func_ann_names_hmmer |  | string |  |
| HMM_gathering_bit_score |  | boolean |  |
| HMM_omit_alignment |  | boolean |  |
| HMM_name_database |  | string |  |
| hmmsearch_header |  | string |  |
| EggNOG_db |  | string? |  |
| EggNOG_diamond_db |  | string? |  |
| EggNOG_data_dir |  | string? |  |
| InterProScan_databases |  | string |  |
| InterProScan_applications |  | string[] |  |
| InterProScan_outputFormat |  | string[] |  |
| ips_header |  | string |  |
| ko_file |  | string |  |
| go_config |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| before-qc | before-qc |  |
| after-qc | after-qc |  |
| touch_file_flag | touch_file_flag |  |
| touch_no_cds_flag | touch_no_cds_flag |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| qc-statistics |  | Directory |  |
| qc_summary |  | File |  |
| qc-status |  | File |  |
| hashsum_paired |  | File[]? |  |
| hashsum_single |  | File? |  |
| fastp_filtering_json_report |  | File? |  |
| sequence-categorisation_folder |  | Directory? |  |
| taxonomy-summary_folder |  | Directory? |  |
| rna-count |  | File? |  |
| motus_output |  | File? |  |
| compressed_files |  | File[] |  |
| functional_annotation_folder |  | Directory? |  |
| stats |  | Directory? |  |
| chunking_nucleotides |  | File[]? |  |
| chunking_proteins |  | File[]? |  |
| completed_flag_file |  | File? |  |
| no_cds_flag_file |  | File? |  |
| no_tax_flag_file |  | File? |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/362
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
