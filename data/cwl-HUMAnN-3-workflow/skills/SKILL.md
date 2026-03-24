---
name: humann-3-workflow
description: "This CWL workflow processes paired-end metagenomic reads using MetaPhlAn 4 and HUMAnN 3 to perform taxonomic profiling and functional metabolic pathway quantification. Use this skill when you need to characterize the metabolic potential and functional diversity of microbial communities within complex environmental or clinical samples."
homepage: https://workflowhub.eu/workflows/2013
---
# HUMAnN 3 workflow

## Overview

This [HUMAnN 3 workflow](https://workflowhub.eu/workflows/2013) performs taxonomic and functional profiling of microbial communities from metagenomic data. It integrates MetaPhlAn 4 for species identification and HUMAnN 3 for metabolic pathway analysis, processing paired-end reads through a standardized pipeline of merging, interleaving, and profiling.

The workflow includes comprehensive downstream processing to facilitate comparative analysis. It automatically handles the unpacking of pathways, renormalization of gene families and pathways, and regrouping of results into various functional categories such as Enzyme Commission (EC) numbers and KEGG Orthology (KO) terms.

*   **Optional QC:** Users can integrate a [short read quality control workflow](https://workflowhub.eu/workflows/336) for initial data preprocessing.
*   **Requirements:** The pipeline requires paired-end FASTQ files and the relevant MetaPhlAn and HUMAnN databases.
*   **Resources:** Tool definitions and related UNLOCK workflows are maintained in the [m-unlock/cwl GitLab repository](https://gitlab.com/m-unlock/cwl).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| identifier | identifier used | string | Identifier for this dataset used in this workflow |
| threads | Number of threads | int | Number of threads to use for computational processes |
| memory | Memory usage (MB) | int | Maximum memory usage in megabytes (default 8000) |
| forward_reads | Forward reads | File[] | Forward sequence fastq file |
| reverse_reads | Reverse reads | File[] | Reverse sequence fastq file |
| skip_read_filter | Skip quality filtering | boolean | Skip quality filtering. (Default false) |
| humandb | Filter human reads | Directory? | Bowtie2 index folder. Provide the folder in which the in index files are located. |
| reference_filter_db | Filter reference file(s) | Directory? | Custom reference database for filtering with Hostile.  Provide the folder in which the bowtie2 index files are located. (default false)  |
| use_reference_mapped_reads | Use mapped reads | boolean | Use mapped reads mapped to the custom reference db. (Default false, discard mapped) |
| output_filtered_reads | Output filtered reads | boolean | Output filtered reads when filtering is applied. (Default false) |
| metaphlan4_bt2_database | MetaPhlAn4 database | Directory | MetaPhlAn4 database location |
| uniref_dbtype | UniRef database type | enum | uniref50 or uniref90. Match this with your selected database! |
| humann3_nucleotide_database | HUMAnN3 nucleotide database | Directory | HUMAnN3 nucleotide database location |
| humann3_protein_database | HUMAnN3 protein database | Directory | HUMAnN3 protein database location |
| destination | Output Destination | string? | Optional output destination only used for cwl-prov reporting. |
| source | Input URLs used for this run | string[]? | A provenance element to capture the original source of the input data |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| workflow_merge_reads | Merge paired reads | This is workflow specific step and creates a single file object.  Also merges reads if multiple files are given. (not interleaving)  |
| workflow_illumina_quality | Shortreads quality workflow | Quality and contamination filtering of short reads |
| interleave_fastq | Interleave fastq | Interleave QC forward and reverse files for subsequent tools |
| metaphlan | MetaPhlAn 4 | Profiling the composition of microbial communities |
| humann | HUMAnN 3 | HMP Unified Metabolic Analysis Network. |
| humann_unpack_pathways | Unpack pathways | HUMAnN 3 Unpack pathways |
| humann_renorm_table_genefamilies | Renorm gene families | HUMAnN 3 renormalize genefamilies |
| humann_renorm_table_pathways | Renorm pathways | HUMAnN 3 renormalize pathways |
| humann_regroup_table | Regroup unnormalized | HUMAnN 3 regroup genefamily |
| humann_regroup_renorm_table | Regroup renormalized | HUMAnN 3 regroup renormalized genefamilies |
| renorm_groups_to_array | Merge file arrays | Merges arrays of files in an array to an array of files |
| files_to_folder_normalized | Normalized tables | Normalized tables folder |
| out_fwd_reads | Output fwd reads | Step needed to output filtered reads because there is an option to not to. |
| out_rev_reads | Output rev reads | Step needed to output filtered reads because there is an option to not to. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| humann_genefamilies_out | Gene families | File | HUMAnN 3 Gene families abundances |
| humann_pathabundance_out | Pathway abundances | File | HUMAnN 3 pathway abundances |
| humann_pathcoverage_out | Pathway coverage | File | HUMAnN 3 pathway coverage |
| humann_log_out | HUMAnN 3 log | File | HUMAnN 3 |
| humann_stdout_out | HUMAnN 3 stdout | File | HUMAnN 3 standard out |
| humann_pathways_unpacked | Pathways unpacked | File | HUMAnN 3 pathways gene abundances |
| regrouped_tables | Regrouped tables | File[] | Regrouped tabes unnormalized |
| normalized_tables | Normalized tables | Directory | Normalized tables Director |
| metaphlan_profile | MetaPhlAn4 profile | File | MetaPhlAn4 profile tsv |
| metaphlan_bt2out | MetaPhlAn4 bt2out | File | MetaPhlAn4 bowtie 2 output |
| QC_forward_reads | Filtered forward read | File? | Filtered forward read |
| QC_reverse_reads | Filtered reverse read | File? | Filtered reverse read |
| quality_reports |  | Directory? | Quality reports output directory |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/2013
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
