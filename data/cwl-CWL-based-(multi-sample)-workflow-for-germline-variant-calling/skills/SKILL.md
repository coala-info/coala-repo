---
name: cwl-based-multi-sample-workflow-for-germline-variant-calling
description: "This Common Workflow Language pipeline processes Illumina whole-genome or whole-exome sequencing data to identify germline SNPs and small INDELs using tools like BWA-MEM, GATK, and ANNOVAR. Use this skill when you need to identify inherited genetic variations across multiple samples, assess their clinical or population-level significance, and characterize the genomic landscape of a cohort."
homepage: https://workflowhub.eu/workflows/526
---
# CWL-based (multi-sample) workflow for germline variant calling

## Overview

This CWL-based pipeline automates the identification of germline variants (SNPs and small INDELs) from Whole-genome (WGS) or Targeted Sequencing (WES) data. It is designed to process multiple samples simultaneously, ultimately producing a single, unified VCF file. The workflow is available on [WorkflowHub](https://workflowhub.eu/workflows/526) and includes pre-configured YAML templates for validation.

The process begins with raw read quality control and adapter trimming using FastQC and Trim Galore. Reads are then mapped to a reference genome via BWA-MEM, followed by extensive post-processing with Samtools and Picard. This stage includes coordinate sorting, read-group assignment, and the marking of PCR or optical duplicates to ensure data integrity before variant discovery.

Variant calling is performed using the GATK HaplotypeCaller in gVCF mode, utilizing interval-based parallelization for efficiency. The workflow then executes the following multi-sample steps:
* **Base Recalibration:** BQSR is applied to adjust systematic errors in base quality scores.
* **Joint Genotyping:** Individual gVCFs are merged and processed via GATK CombineGVCFs and GenotypeGVCFs to produce a unified cohort VCF.
* **Refinement and Filtering:** Variants undergo Variant Quality Score Recalibration (VQSR), followed by custom filtering and INDEL normalization using bcftools.
* **Annotation:** The final filtered dataset is annotated with clinical and population-related information using ANNOVAR.

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
| samtools_view_readswithbits |  | int? |  |
| samtools_view_readswithoutbits |  | int |  |
| samtools_view_fastcompression |  | boolean |  |
| samtools_view_samheader |  | boolean |  |
| samtools_view_count |  | boolean |  |
| samtools_view_readsingroup |  | string? |  |
| samtools_view_readtagtostrip |  | string[]? |  |
| samtools_view_readsquality |  | int? |  |
| samtools_view_cigar |  | int? |  |
| samtools_view_iscram |  | boolean |  |
| samtools_view_threads |  | int? |  |
| samtools_view_randomseed |  | float? |  |
| samtools_view_region |  | string? |  |
| samtools_view_readsinlibrary |  | string? |  |
| samtools_view_target_bed_file |  | File? |  |
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
| sub_bqsr_known_sites_2 |  | File? |  |
| sub_bqsr_known_sites_3 |  | File? |  |
| sub_bqsr_interval_padding |  | int? |  |
| sub_bqsr_hc_native_pairHMM_threads |  | int? |  |
| sub_bqsr_hc_java_options |  | string? |  |
| VariantRecalibrator_use_annotation |  | string[] |  |
| VariantRecalibrator_trust_all_polymorphic |  | boolean? |  |
| VariantRecalibrator_truth_sensitivity_trance_indels |  | float[]? |  |
| vqsr_arguments_indels_1 |  | string |  |
| vqsr_known_sites_indels_1 |  | File |  |
| vqsr_arguments_indels_2 |  | string? |  |
| vqsr_known_sites_indels_2 |  | File? |  |
| vqsr_arguments_indels_3 |  | string? |  |
| vqsr_known_sites_indels_3 |  | File? |  |
| VariantRecalibrator_truth_sensitivity_trance_snps |  | float[]? |  |
| vqsr_arguments_snps_1 |  | string |  |
| vqsr_known_sites_snps_1 |  | File |  |
| vqsr_arguments_snps_2 |  | string? |  |
| vqsr_known_sites_snps_2 |  | File? |  |
| vqsr_arguments_snps_3 |  | string? |  |
| vqsr_known_sites_snps_3 |  | File? |  |
| vqsr_arguments_snps_4 |  | string? |  |
| vqsr_known_sites_snps_4 |  | File? |  |
| ApplyVQSR_ts_filter_level |  | float? |  |
| bcftools_view_include_VQSR_filters |  | string |  |
| bcftools_view_threads |  | int? |  |
| bcftools_norm_threads |  | int? |  |
| bcftools_norm_multiallelics |  | string |  |
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
| gatk_CombineGVCFs | gatk_CombineGVCFs |  |
| gatk_GenotypeGVCFs | gatk_GenotypeGVCFs |  |
| gatk_MakeSitesOnlyVcf | gatk_MakeSitesOnlyVcf |  |
| gatk_VariantRecalibrator_indel | gatk_VariantRecalibrator_indel |  |
| gatk_VariantRecalibrator_snp | gatk_VariantRecalibrator_snp |  |
| gatk_ApplyVQSR_indel | gatk_ApplyVQSR_indel |  |
| gatk_ApplyVQSR_snp | gatk_ApplyVQSR_snp |  |
| gatk_VQSR_MergeVCFs | gatk_VQSR_MergeVCFs |  |
| bcftools_view_filter_vqsr | bcftools_view_filter_vqsr |  |
| bcftools_norm_vqsr | bcftools_norm_vqsr |  |
| table_annovar_filtered | table_annovar_filtered |  |

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
| o_bwa_mem_single |  | File[] |  |
| o_bwa_mem_paired |  | File[] |  |
| o_gather_bwa_sam_files |  | File[] |  |
| o_samtools_view_conversion |  | File[] |  |
| samtools_sort_by_name |  | File[] |  |
| o_samtools_fixmate |  | File[] |  |
| o_samtools_sort |  | File[] |  |
| o_picard_addorreplacereadgroups |  | File[] |  |
| o_picard_markduplicates |  | File[] |  |
| o_picard_markduplicates_metrics |  | File[] |  |
| o_samtools_flagstat |  | File[] |  |
| o_samtools_view_count_total |  | File[] |  |
| o_samtools_index |  | File[] |  |
| o_gatk_splitintervals |  | File[] |  |
| o_gatk_bqsr_subworkflowbqsr_tables |  | array |  |
| o_gatk_bqsr_subworkflowbqsr_bqsr_bam |  | array |  |
| o_gatk_bqsr_subworkflowbqsr_hc |  | array |  |
| o_gatk_bqsr_subworkflowbqsr_mergevcfs |  | File[] |  |
| o_gatk_CombineGVCFs |  | File |  |
| o_gatk_GenotypeGVCFs |  | File |  |
| o_gatk_MakeSitesOnlyVcf |  | File |  |
| o_gatk_VariantRecalibrator_indel_recal |  | File[] |  |
| o_gatk_VariantRecalibrator_indel_tranches |  | File[] |  |
| o_gatk_VariantRecalibrator_snp_recal |  | File[] |  |
| o_gatk_VariantRecalibrator_snp_tranches |  | File[] |  |
| o_gatk_ApplyVQSR_indel |  | File[] |  |
| o_gatk_ApplyVQSR_snp |  | File[] |  |
| o_gatk_VQSR_MergeVCFs |  | File |  |
| o_bcftools_view_filter_vqsr |  | File |  |
| o_bcftools_norm_vqsr |  | File |  |
| o_table_annovar_filtered_multianno_vcf |  | File |  |
| o_table_annovar_filtered_multianno_txt |  | File |  |
| o_table_annovar_filtered_avinput |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/526
- `gatk_multi-sample_bqsr_vqsr.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
