---
name: cwl-based-single-sample-workflow-for-germline-variant-callin
description: "This Common Workflow Language pipeline processes Illumina whole-genome or whole-exome sequencing data to identify germline SNPs and small indels using tools like BWA-MEM, GATK HaplotypeCaller, and ANNOVAR. Use this skill when you need to identify inherited genetic variations in individual samples and annotate them with clinical or population-level information to assess their potential biological impact."
homepage: https://workflowhub.eu/workflows/527
---
# CWL-based (single-sample) workflow for germline variant calling

## Overview

This [CWL-based workflow](https://workflowhub.eu/workflows/527) is designed for calling small germline variants (SNPs and INDELs) from single-sample Whole-Genome Sequencing (WGS) or Whole-Exome Sequencing (WES) data. It automates the transition from raw Illumina reads to annotated VCF files, following best practices for genomic data processing and quality control.

The pipeline begins with comprehensive quality control using FastQC and adapter trimming via Trim Galore. Reads are then mapped to a reference genome using BWA-MEM, followed by a series of post-processing steps including coordinate sorting, Read-Group assignment, and duplicate marking. To optimize performance, the workflow utilizes GATK SplitIntervals to parallelize downstream analysis across the reference genome.

The variant calling phase employs the GATK HaplotypeCaller after performing Base Quality Score Recalibration (BQSR). Once variants are identified, the workflow applies sophisticated filtering using Convolutional Neural Network (CNN) models or optional hard-filtering criteria. The final stages include INDEL normalization via bcftools and comprehensive functional annotation using ANNOVAR to provide clinical and population-related context to the discovered variants.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| raw_files_directory |  | Directory |  |
| input_file_split |  | string? |  |
| input_file_split_fwd_single |  | string? |  |
| input_file_split_rev |  | string? |  |
| input_qc_check |  | boolean? |  |
| input_trimming_check |  | boolean? |  |
| tg_quality |  | int |  |
| tg_length |  | int |  |
| tg_compression |  | boolean |  |
| tg_do_not_compress |  | boolean |  |
| tg_strigency |  | int |  |
| tg_trim_suffix |  | string |  |
| reference_genome |  | File |  |
| bwa_mem_sec_shorter_split_hits |  | boolean |  |
| bwa_mem_num_threads |  | int |  |
| samtools_view_uncompressed |  | boolean |  |
| samtools_view_collapsecigar |  | boolean |  |
| samtools_view_readswithoutbits |  | int |  |
| samtools_view_fastcompression |  | boolean |  |
| samtools_view_samheader |  | boolean |  |
| samtools_view_count |  | boolean |  |
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
| samtools_fixmate_threads |  | int |  |
| samtools_fixmate_output_format |  | string |  |
| samtools_sort_compression_level |  | int? |  |
| samtools_sort_threads |  | int? |  |
| samtools_sort_memory |  | string? |  |
| samtools_flagstat_threads |  | int? |  |
| picard_addorreplacereadgroups_rgpl |  | string? |  |
| gatk_splitintervals_include_intervalList |  | File? |  |
| gatk_splitintervals_exclude_intervalList |  | File? |  |
| gatk_splitintervals_scatter_count |  | int |  |
| sub_bqsr_known_sites_1 |  | File |  |
| sub_bqsr_known_sites_2 |  | File |  |
| sub_bqsr_known_sites_3 |  | File |  |
| sub_bqsr_interval_padding |  | int? |  |
| sub_hc_native_pairHMM_threads |  | int? |  |
| sub_hc_java_options |  | string? |  |
| VariantFiltration_window |  | int |  |
| VariantFiltration_cluster |  | int |  |
| VariantFiltration_filter_name_snp |  | array |  |
| VariantFiltration_filter_snp |  | array |  |
| VariantFiltration_filter_name_indel |  | array |  |
| VariantFiltration_filter_indel |  | array |  |
| FilterVariantTranches_resource_1 |  | File |  |
| FilterVariantTranches_resource_2 |  | File? |  |
| FilterVariantTranches_resource_3 |  | File? |  |
| bcftools_view_include_hard_filters |  | string |  |
| bcftools_view_include_CNN_filters |  | string |  |
| bcftools_view_threads |  | int |  |
| bcftools_norm_threads |  | int? |  |
| bcftoomls_norm_multiallelics |  | string |  |
| table_annovar_database_location |  | Directory |  |
| table_annovar_build_over |  | string |  |
| table_annovar_remove |  | boolean? |  |
| table_annovar_protocol |  | string |  |
| table_annovar_operation |  | string |  |
| table_annovar_na_string |  | string? |  |
| table_annovar_vcfinput |  | boolean |  |
| table_annovar_otherinfo |  | boolean? |  |
| table_annovar_convert_arg |  | string? |  |


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
| check_trimming | check_trimming |  |
| rg_extraction_single | rg_extraction_single |  |
| bwa_mem_single | bwa_mem_single |  |
| split_paired_read1_read2 | split_paired_read1_read2 |  |
| rg_extraction_paired | rg_extraction_paired |  |
| bwa_mem_paired | bwa_mem_paired |  |
| gather_bwa_sam_files | gather_bwa_sam_files |  |
| samtools_view_conversion | samtools_view_conversion |  |
| samtools_sort_by_name | samtools_sort_by_name |  |
| samtools_fixmate | samtools_fixmate |  |
| samtools_sort | samtools_sort |  |
| picard_addorreplacereadgroups | picard_addorreplacereadgroups |  |
| picard_markduplicates | picard_markduplicates |  |
| samtools_flagstat | samtools_flagstat |  |
| samtools_view_count_total | samtools_view_count_total |  |
| gatk_splitintervals | gatk_splitintervals |  |
| samtools_index | samtools_index |  |
| gatk_bqsr_subworkflow | gatk_bqsr_subworkflow |  |
| gatk_applybqsr | gatk_applybqsr |  |
| samtools_index_2 | samtools_index_2 |  |
| gatk_haplotypecaller_subworkflow | gatk_haplotypecaller_subworkflow |  |
| gatk_SelectVariants_snps | gatk_SelectVariants_snps |  |
| gatk_SelectVariants_indels | gatk_SelectVariants_indels |  |
| gatk_VariantFiltration_snps | gatk_VariantFiltration_snps |  |
| gatk_VariantFiltration_indels | gatk_VariantFiltration_indels |  |
| bgzip_snps | bgzip_snps |  |
| tabix_snps | tabix_snps |  |
| bgzip_indels | bgzip_indels |  |
| tabix_indels | tabix_indels |  |
| bcftools_concat | bcftools_concat |  |
| bcftools_view_hard_filter | bcftools_view_hard_filter |  |
| bcftools_norm_hard_filter | bcftools_norm_hard_filter |  |
| table_annovar_hard_filtered | table_annovar_hard_filtered |  |
| gatk_CNNScoreVariants | gatk_CNNScoreVariants |  |
| gatk_FilterVariantTranches | gatk_FilterVariantTranches |  |
| bcftools_view_filter_cnn | bcftools_view_filter_cnn |  |
| bcftools_norm_cnn | bcftools_norm_cnn |  |
| table_annovar_cnn_filtered | table_annovar_cnn_filtered |  |

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
| o_gather_bwa_sam_files |  | File[] |  |
| o_samtools_view_conversion |  | File[] |  |
| o_samtools_sort_by_name |  | File[] |  |
| o_samtools_fixmate |  | File[] |  |
| o_samtools_sort |  | File[] |  |
| o_picard_addorreplacereadgroups |  | File[] |  |
| o_picard_markduplicates |  | File[] |  |
| o_picard_markduplicates_metrics |  | File[] |  |
| o_samtools_flagstat |  | File[] |  |
| o_samtools_view_count_total |  | File[] |  |
| o_samtools_index |  | File[] |  |
| o_gatk_bqsr_subworkflow |  | File[] |  |
| o_gatk_ApplyBQSR |  | File[] |  |
| o_samtools_index_2 |  | File[] |  |
| o_gatk_splitintervals |  | File[] |  |
| o_gatk_HaplotypeCaller |  | File[] |  |
| o_tabix_snps |  | File[] |  |
| o_tabix_indels |  | File[] |  |
| o_bcftools_concat |  | File[] |  |
| o_bcftools_view_hard_filter |  | File[] |  |
| o_bcftools_norm_hard_filter |  | File[] |  |
| o_gatk_CNNScoreVariants |  | File[] |  |
| o_gatk_FilterVariantTranches |  | File[] |  |
| o_bcftools_view_filter_cnn |  | File[] |  |
| o_bcftools_norm_cnn |  | File[] |  |
| o_table_annovar_cnn_filtered_multianno_vcf |  | File[] |  |
| o_table_annovar_cnn_filtered_multianno_txt |  | File[] |  |
| o_table_annovar_cnn_filtered_avinput |  | File[] |  |
| o_table_annovar_hard_filtered_multianno_vcf |  | File[] |  |
| o_table_annovar_hard_filtered_multianno_txt |  | File[] |  |
| o_table_annovar_hard_filtered_avinput |  | File[] |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/527
- `gatk_single-sample_bqsr_cnn_hard-filtering.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
