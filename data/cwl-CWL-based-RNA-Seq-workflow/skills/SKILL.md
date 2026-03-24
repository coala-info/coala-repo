---
name: cwl-based-rna-seq-workflow
description: "This CWL-based transcriptomics workflow processes raw RNA-Seq FASTQ files using FastQC, Trim Galore, and HISAT2 for read alignment, followed by transcript assembly with StringTie and differential expression analysis via Ballgown and DESeq2. Use this skill when you need to identify differentially expressed genes and transcripts across experimental conditions or characterize novel isoforms within Illumina-sequenced transcriptomes."
homepage: https://workflowhub.eu/workflows/524
---
# CWL-based RNA-Seq workflow

## Overview

This [CWL-based RNA-Seq workflow](https://workflowhub.eu/workflows/524) provides a comprehensive pipeline for processing raw Illumina FASTQ files through to differential expression analysis at both the transcript and gene levels. The workflow automates quality control using FastQC and adapter trimming via Trim Galore, ensuring high-quality input for downstream alignment.

The core analysis follows two distinct paths after mapping reads to a reference genome with HISAT2 and processing files with samtools:

*   **Transcript-level analysis:** Following the [StringTie and Ballgown protocol](https://doi.org/10.1038/nprot.2016.095), the workflow assembles transcripts, estimates abundances, and performs statistical testing to identify differential expression, including potentially novel transcripts.
*   **Gene-level analysis:** The pipeline utilizes featureCounts to generate a gene-level read count matrix, which is then processed by DESeq2 for differential expression analysis.

Both analysis paths are highly configurable via CWL wrappers and YAML templates, allowing users to define experimental designs, contrasts, and thresholds. Example metadata and pre-configured templates are available in the [source repository](https://github.com/InSyBio/RNA-Seq-Analysis-CWL) to facilitate reproducible research.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| raw_files_directory |  | Directory |  |
| input_file_split |  | string? |  |
| input_file_split_fwd_single |  | string? |  |
| input_file_split_rev |  | string? |  |
| input_qc_check |  | boolean? |  |
| input_trimming_check |  | boolean? |  |
| premapping_input_check |  | string |  |
| tg_quality |  | int |  |
| tg_length |  | int |  |
| tg_compression |  | boolean |  |
| tg_do_not_compress |  | boolean |  |
| tg_trim_suffix |  | string |  |
| tg_strigency |  | int |  |
| fastx_first_base_to_keep |  | int? |  |
| fastx_last_base_to_keep |  | int? |  |
| hisat2_num_of_threads |  | int |  |
| hisat2_alignments_tailored_trans_assemb |  | boolean |  |
| hisat2_idx_directory |  | Directory |  |
| hisat2_idx_basename |  | string |  |
| hisat2_known_splicesite_infile |  | File? |  |
| samtools_view_isbam |  | boolean |  |
| samtools_view_collapsecigar |  | boolean |  |
| samtools_view_uncompressed |  | boolean |  |
| samtools_view_fastcompression |  | boolean |  |
| samtools_view_samheader |  | boolean |  |
| samtools_view_count |  | boolean |  |
| samtools_view_readswithoutbits |  | int? |  |
| samtools_view_readsingroup |  | string? |  |
| samtools_view_readtagtostrip |  | string[]? |  |
| samtools_view_readsquality |  | int? |  |
| samtools_view_readswithbits |  | int? |  |
| samtools_view_cigar |  | int? |  |
| samtools_view_iscram |  | boolean |  |
| samtools_view_threads |  | int? |  |
| samtools_view_randomseed |  | float? |  |
| samtools_view_region |  | string? |  |
| samtools_view_readsinlibrary |  | string? |  |
| samtools_sort_compression_level |  | int? |  |
| samtools_sort_threads |  | int? |  |
| samtools_sort_memory |  | string? |  |
| samtools_sort_sort_by_name |  | boolean? |  |
| stringtie_guide_gff |  | File |  |
| stringtie_transcript_merge_mode |  | boolean |  |
| stringtie_out_gtf |  | string |  |
| stringtie_expression_estimation_mode |  | boolean |  |
| stringtie_ballgown_table_files |  | boolean |  |
| stringtie_cpus |  | int? |  |
| stringtie_verbose |  | boolean? |  |
| stringtie_min_isoform_abundance |  | float? |  |
| stringtie_junction_coverage |  | float? |  |
| stringtie_min_read_coverage |  | float? |  |
| stringtie_conservative_mode |  | boolean? |  |
| bg_phenotype_file |  | File |  |
| bg_phenotype |  | string |  |
| bg_samples |  | string |  |
| bg_timecourse |  | boolean? |  |
| bg_feature |  | string? |  |
| bg_measure |  | string? |  |
| bg_confounders |  | string? |  |
| bg_custom_model |  | boolean? |  |
| bg_mod |  | string? |  |
| bg_mod0 |  | string? |  |
| featureCounts_number_of_threads |  | int? |  |
| featureCounts_annotation_file |  | File |  |
| featureCounts_output_file |  | string |  |
| featureCounts_read_meta_feature_overlap |  | boolean? |  |
| deseq2_metadata |  | File |  |
| deseq2_design |  | string |  |
| deseq2_samples |  | string |  |
| deseq2_min_sum_of_reads |  | int? |  |
| deseq2_reference_level |  | string? |  |
| deseq2_phenotype |  | string? |  |
| deseq2_contrast |  | boolean? |  |
| deseq2_numerator |  | string? |  |
| deseq2_denominator |  | string? |  |
| deseq2_lfcThreshold |  | float? |  |
| deseq2_pAdjustMethod |  | string? |  |
| deseq2_alpha |  | float? |  |
| deseq2_parallelization |  | boolean? |  |
| deseq2_cores |  | int? |  |
| deseq2_transformation |  | string? |  |
| deseq2_blind |  | boolean? |  |
| deseq2_hypothesis |  | string? |  |
| deseq2_reduced |  | string? |  |
| deseq2_hidden_batch_effects |  | boolean? |  |
| deseq2_hidden_batch_row_means |  | int? |  |
| deseq2_hidden_batch_method |  | string? |  |
| deseq2_variables |  | int? |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| get_raw_files | get_raw_files |  |
| split_single_paired | split_single_paired |  |
| trim_galore_single | trim_galore_single |  |
| trim_galore_paired | trim_galore_paired |  |
| fastqc_raw | fastqc_raw |  |
| fastqc_single_trimmed | fastqc_single_trimmed |  |
| fastqc_paired_trimmed | fastqc_paired_trimmed |  |
| cp_fastqc_raw_zip | cp_fastqc_raw_zip |  |
| cp_fastqc_single_zip | cp_fastqc_single_zip |  |
| cp_fastqc_paired_zip | cp_fastqc_paired_zip |  |
| rename_fastqc_raw_html | rename_fastqc_raw_html |  |
| rename_fastqc_single_html | rename_fastqc_single_html |  |
| rename_fastqc_paired_html | rename_fastqc_paired_html |  |
| fastx_trimmer_single | fastx_trimmer_single |  |
| fastx_trimmer_paired | fastx_trimmer_paired |  |
| check_for_fastx_and_produce_names | check_for_fastx_and_produce_names |  |
| hisat2_for_single_reads | hisat2_for_single_reads |  |
| hisat2_for_paired_reads | hisat2_for_paired_reads |  |
| collect_hisat2_sam_files | collect_hisat2_sam_files |  |
| samtools_view | samtools_view |  |
| samtools_sort | samtools_sort |  |
| stringtie_transcript_assembly | stringtie_transcript_assembly |  |
| stringtie_merge | stringtie_merge |  |
| stringtie_expression | stringtie_expression |  |
| ballgown_de | ballgown_de |  |
| featureCounts | featureCounts |  |
| DESeq2_analysis | DESeq2_analysis |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| o_trim_galore_single_fq |  | File[] |  |
| o_trim_galore_single_reports |  | File[] |  |
| o_trim_galore_paired_fq |  | File[] |  |
| o_trim_galore_paired_reports |  | File[] |  |
| o_fastqc_raw_html |  | File[]? |  |
| o_fastqc_single_html |  | File[]? |  |
| o_fastqc_paired_html |  | File[]? |  |
| o_fastqc_raw_zip |  | Directory? |  |
| o_fastqc_single_zip |  | Directory? |  |
| o_fastqc_paired_zip |  | Directory? |  |
| o_fastx_trimmer_single |  | File[] |  |
| o_fastx_trimmer_paired |  | File[] |  |
| o_hisat2_for_single_reads_reports |  | File[] |  |
| o_hisat2_for_paired_reads_reports |  | File[] |  |
| o_collect_hisat2_sam_files |  | File[] |  |
| o_samtools_view |  | File[] |  |
| o_samtools_sort |  | File[] |  |
| o_stringtie_transcript_assembly_gtf |  | File[] |  |
| o_stringtie_merge |  | File |  |
| o_stringtie_expression_gtf |  | File[] |  |
| o_stringtie_expression_outdir |  | Directory[] |  |
| o_ballgown_de_results |  | File |  |
| o_ballgown_object |  | File |  |
| o_ballgown_de_custom_model |  | File? |  |
| o_featureCounts |  | File |  |
| o_deseq2_de_results |  | File |  |
| o_deseq2_dds_object |  | File |  |
| o_deseq2_res_lfcShrink_object |  | File |  |
| o_deseq2_transformed_object |  | File? |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/524
- `RNA-Seq_workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
