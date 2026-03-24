---
name: mgnify-assembly-analysis-pipeline
description: "This Common Workflow Language pipeline performs quality control, taxonomic classification of ribosomal regions, and functional annotation of proteins for assembled metagenomic data. Use this skill when you need to characterize the taxonomic diversity, metabolic potential, and biochemical pathways of microbial communities within environmental or clinical samples."
homepage: https://workflowhub.eu/workflows/360
---
# MGnify - assembly analysis pipeline

## Overview

The MGnify assembly analysis pipeline is a [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/360) workflow designed for the functional and taxonomic annotation of assembled metagenomic contigs. As part of the MGnify v5.0 framework, this pipeline provides a standardized, reproducible environment for processing microbiome data, enabling researchers to archive and analyze microbial populations from diverse environments.

The workflow focuses on generating high-resolution insights from assembled data, including expanded protein functional annotations and biochemical pathway predictions. It also features specialized taxonomic assertions based on ribosomal internal transcribed spacer regions (ITS1/2). These outputs are designed to integrate with the MGnify contig viewer for fine-grained visualization of enriched annotations.

The execution logic is structured around quality control phases and conditional flag handling:
* **Quality Control:** Initial and post-processing steps (`before-qc` and `after-qc`) ensure data integrity throughout the analysis.
* **Flag Management:** Utility steps (`touch_file_flag` and `touch_no_cds_flag`) manage workflow state and handle cases where no coding sequences are detected.

For detailed implementation specifics and versioning information, refer to the [official MGnify documentation](https://docs.mgnify.org/en/latest/analysis.html#assembly-analysis-pipeline).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| contigs |  | File |  |
| contig_min_length |  | int |  |
| ssu_db |  | File |  |
| lsu_db |  | File |  |
| ssu_tax |  | string |  |
| lsu_tax |  | string |  |
| ssu_otus |  | string |  |
| lsu_otus |  | string |  |
| rfam_models |  | string[] |  |
| rfam_model_clans |  | string |  |
| other_ncrna_models |  | string[] |  |
| ssu_label |  | string |  |
| lsu_label |  | string |  |
| 5s_pattern |  | string |  |
| 5.8s_pattern |  | string |  |
| CGC_config |  | string |  |
| CGC_postfixes |  | string[] |  |
| cgc_chunk_size |  | int |  |
| protein_chunk_size_eggnog |  | int |  |
| protein_chunk_size_hmm |  | int |  |
| protein_chunk_size_IPS |  | int |  |
| func_ann_names_ips |  | string |  |
| func_ann_names_hmmer |  | string |  |
| HMM_gathering_bit_score |  | boolean |  |
| HMM_omit_alignment |  | boolean |  |
| HMM_name_database |  | string |  |
| hmmsearch_header |  | string |  |
| EggNOG_db |  | string |  |
| EggNOG_diamond_db |  | string |  |
| EggNOG_data_dir |  | string |  |
| InterProScan_databases |  | string |  |
| InterProScan_applications |  | string[] |  |
| InterProScan_outputFormat |  | string[] |  |
| ips_header |  | string |  |
| ko_file |  | string |  |
| Uniref90_db_txt |  | string |  |
| diamond_maxTargetSeqs |  | int |  |
| diamond_databaseFile |  | string |  |
| diamond_header |  | string |  |
| go_config |  | string |  |
| graphs |  | string |  |
| pathways_names |  | string |  |
| pathways_classes |  | string |  |
| gp_flatfiles_path |  | string |  |
| clusters_glossary |  | string |  |


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
| qc-status |  | File |  |
| qc_summary |  | File |  |
| hashsum_input |  | File |  |
| qc-statistics_folder |  | Directory |  |
| compressed_files |  | File[] |  |
| index_fasta_file |  | File? |  |
| bgzip_index |  | File? |  |
| bgzip_fasta_file |  | File? |  |
| chunking_nucleotides |  | File[]? |  |
| chunking_proteins |  | File[]? |  |
| functional_annotation_folder |  | Directory? |  |
| stats |  | Directory? |  |
| pathways_systems_folder |  | Directory? |  |
| pathways_systems_folder_antismash |  | Directory? |  |
| pathways_systems_folder_antismash_summary |  | Directory? |  |
| sequence-categorisation_folder |  | Directory? |  |
| taxonomy-summary_folder |  | Directory? |  |
| rna-count |  | File? |  |
| completed_flag_file |  | File? |  |
| no_cds_flag_file |  | File? |  |
| no_tax_flag_file |  | File? |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/360
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
