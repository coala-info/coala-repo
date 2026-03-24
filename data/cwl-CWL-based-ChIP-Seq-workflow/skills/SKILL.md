---
name: cwl-based-chip-seq-workflow
description: "This Common Workflow Language pipeline processes raw FASTQ ChIP-Seq data through quality control, alignment, and peak calling using tools such as HISAT2, MACS2, and DiffBind. Use this skill when you need to identify protein-DNA binding sites, detect super-enhancer regions, and perform differential binding analysis to compare epigenetic profiles between experimental samples."
homepage: https://workflowhub.eu/workflows/525
---
# CWL-based ChIP-Seq workflow

## Overview

This [CWL-based pipeline](https://workflowhub.eu/workflows/525) provides a comprehensive solution for processing ChIP-Seq data from raw FASTQ files through to differential binding analysis. It automates standard preprocessing tasks, including quality control via FastQC, adapter trimming with Trimmomatic, and genomic alignment using HISAT2. The workflow is designed to handle both single-end and paired-end sequencing data, ensuring robust data preparation for downstream epigenomic analysis.

Following alignment, the pipeline utilizes `samtools` for coordinate sorting, indexing, and duplicate removal. It integrates `deeptools2` to generate extensive quality metrics and visualization files, such as coverage tracks (bigWig), heatmaps, and fingerprint plots. These outputs allow for rigorous inspection of sequencing depth, read distribution, and sample correlation before proceeding to peak calling.

The final stages of the workflow focus on functional genomics and comparative analysis:
*   **Peak Calling:** Identifies binding positions using MACS2.
*   **Super-Enhancer Detection:** Employs the ROSE (Rank Ordering of Super-Enhancers) algorithm to identify clusters of enhancers.
*   **Differential Binding:** Uses DiffBind to perform statistical comparisons of binding affinity across different experimental conditions for both standard peaks and super-enhancers.
*   **Consensus Mapping:** Generates peak count tables via `bedtools` to facilitate custom downstream bioinformatics analyses.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| raw_files_directory |  | Directory |  |
| input_file_split |  | string? |  |
| input_file_split_fwd_single |  | string? |  |
| input_file_split_rev |  | string? |  |
| input_qc_check |  | boolean? |  |
| input_trimming_check |  | boolean? |  |
| input_treatment_samples |  | string[] |  |
| input_control_samples |  | string[]? |  |
| trimmomatic_se_threads |  | int? |  |
| trimmomatic_se_illuminaClip |  | string? |  |
| trimmomatic_se_slidingWindow |  | string? |  |
| trimmomatic_se_leading |  | int? |  |
| trimmomatic_se_trailing |  | int? |  |
| trimmomatic_se_minlen |  | int? |  |
| trimmomatic_pe_threads |  | int? |  |
| trimmomatic_pe_illuminaClip |  | string? |  |
| trimmomatic_pe_slidingWindow |  | string? |  |
| trimmomatic_pe_leading |  | int? |  |
| trimmomatic_pe_trailing |  | int? |  |
| trimmomatic_pe_minlen |  | int? |  |
| hisat2_num_of_threads |  | int? |  |
| hisat2_idx_directory |  | Directory |  |
| hisat2_idx_basename |  | string |  |
| samtools_readswithoutbits |  | int |  |
| samtools_view_threads |  | int? |  |
| samtools_fixmate_threads |  | int? |  |
| samtools_fixmate_output_format |  | string |  |
| samtools_sort_compression_level |  | int? |  |
| samtools_sort_threads |  | int |  |
| samtools_sort_memory |  | string? |  |
| samtools_markdup_threads |  | int? |  |
| blackListFile |  | File? |  |
| multiBamSummary_threads |  | int? |  |
| plotCorrelation_numbers |  | boolean? |  |
| plotCorrelation_method |  | string? |  |
| plotCorrelation_color |  | string? |  |
| plotCorrelation_title |  | string? |  |
| plotCorrelation_plotType |  | string? |  |
| plotCorrelation_outFileName |  | string? |  |
| plotCoverage_threads |  | int? |  |
| plotCoverage_plotFileFormat |  | string? |  |
| plotCoverage_outFileName |  | string? |  |
| plotFingerprint_plotFileFormat |  | string? |  |
| plotFingerprint_threads |  | int? |  |
| plotFingerprint_outFileName |  | string? |  |
| bamCoverage_normalizeUsing |  | string? |  |
| bamCoverage_effective_genome_size |  | long? |  |
| bamCoverage_extendReads |  | int? |  |
| bamCoverage_threads |  | int? |  |
| computeMatrix_regions |  | File |  |
| computeMatrix_threads |  | int? |  |
| computeMatrix_upstream |  | int? |  |
| computeMatrix_downstream |  | int? |  |
| computeMatrix_outputFile |  | string? |  |
| computeMatrix_outFileSortedRegions |  | string? |  |
| plotHeatmap_plotFileFormat |  | string? |  |
| plotHeatmap_outputFile |  | string? |  |
| macs2_callpeak_bdg |  | boolean? |  |
| macs2_callpeak_gsize |  | string? |  |
| macs2_callpeak_format |  | string? |  |
| macs2_callpeak_broad |  | boolean? |  |
| macs2_callpeak_nomodel |  | boolean? |  |
| macs2_shift |  | int? |  |
| macs2_extsize |  | int? |  |
| macs2_pvalue |  | float? |  |
| macs2_qvalue |  | float? |  |
| metadata_table |  | File |  |
| ChIPQC_blacklist |  | File? |  |
| ChIPQC_annotation |  | string? |  |
| ChIPQC_consensus |  | boolean? |  |
| ChIPQC_bCount |  | boolean? |  |
| ChIPQC_facetBy |  | string[]? |  |
| DiffBind_consensus |  | string[]? |  |
| DiffBind_minOverlap |  | int, float |  |
| DiffBind_blacklist |  | string, boolean, File |  |
| DiffBind_greylist |  | string, boolean, File |  |
| DiffBind_cores |  | int? |  |
| DiffBind_bParallel |  | boolean? |  |
| DiffBind_normalization |  | string? |  |
| DiffBind_library |  | string? |  |
| DiffBind_background |  | boolean? |  |
| DiffBind_design |  | string |  |
| DiffBind_reorderMeta_factor |  | string[]? |  |
| DiffBind_reorderMeta_value |  | string[]? |  |
| DiffBind_retrieve_consensus |  | boolean? |  |
| DiffBind_low_read_count_filter |  | int? |  |
| DiffBind_filterFun |  | string? |  |
| rose_genome_build |  | string |  |
| rose_stitch_distance |  | int? |  |
| rose_tss_distance |  | int? |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| get_raw_files | get_raw_files |  |
| split_single_paired | split_single_paired |  |
| trimmomatic_single_end | trimmomatic_single_end |  |
| trimmomatic_paired_end | trimmomatic_paired_end |  |
| fastqc_raw | fastqc_raw |  |
| fastqc_single_trimmed | fastqc_single_trimmed |  |
| fastqc_paired_trimmed_fwd | fastqc_paired_trimmed_fwd |  |
| fastqc_paired_trimmed_rev | fastqc_paired_trimmed_rev |  |
| cp_fastqc_raw_zip | cp_fastqc_raw_zip |  |
| cp_fastqc_single_zip | cp_fastqc_single_zip |  |
| cp_fastqc_paired_zip | cp_fastqc_paired_zip |  |
| rename_fastqc_raw_html | rename_fastqc_raw_html |  |
| rename_fastqc_single_html | rename_fastqc_single_html |  |
| rename_fastqc_paired_html_fwd | rename_fastqc_paired_html_fwd |  |
| rename_fastqc_paired_html_rev | rename_fastqc_paired_html_rev |  |
| check_trimming | check_trimming |  |
| hisat2_for_single_reads | hisat2_for_single_reads |  |
| hisat2_for_paired_reads | hisat2_for_paired_reads |  |
| collect_hisat2_sam_files | collect_hisat2_sam_files |  |
| samtools_view | samtools_view |  |
| samtools_sort_by_name | samtools_sort_by_name |  |
| samtools_fixmate | samtools_fixmate |  |
| samtools_sort | samtools_sort |  |
| samtools_markdup | samtools_markdup |  |
| samtools_index | samtools_index |  |
| multiBamSummary_file | multiBamSummary_file |  |
| plotCorrelation_file | plotCorrelation_file |  |
| plotCoverage_file | plotCoverage_file |  |
| plotFingerprint_file | plotFingerprint_file |  |
| bamCoverage_norm | bamCoverage_norm |  |
| computeMatrix | computeMatrix |  |
| plotHeatmap | plotHeatmap |  |
| separate_control_treatment_files | separate_control_treatment_files |  |
| macs2_call_peaks | macs2_call_peaks |  |
| total_peaks_table | total_peaks_table |  |
| sort_peaks_table | sort_peaks_table |  |
| bedtools_merge | bedtools_merge |  |
| exclude_black_list_regions | exclude_black_list_regions |  |
| bedtools_coverage | bedtools_coverage |  |
| extract_counts | extract_counts |  |
| extract_peaks | extract_peaks |  |
| printf_header_samples | printf_header_samples |  |
| paste_content_1 | paste_content_1 |  |
| paste_content_2 | paste_content_2 |  |
| append_files | append_files |  |
| ChIPQC_macs | ChIPQC_macs |  |
| DiffBind_macs | DiffBind_macs |  |
| exclude_black_list_regions_narrowPeak | exclude_black_list_regions_narrowPeak |  |
| bed_to_rose_gff_conversion | bed_to_rose_gff_conversion |  |
| rose_main | rose_main |  |
| enhancer_bed_processing | enhancer_bed_processing |  |
| ChIPQC_rose | ChIPQC_rose |  |
| DiffBind_rose | DiffBind_rose |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| o_trimmomatic_single_end_stderr |  | File[] |  |
| o_trimmomatic_single_end_fastq |  | File[] |  |
| o_trimmomatic_paired_end_stderr |  | File[] |  |
| o_trimmomatic_paired_end_fwd_paired |  | File[] |  |
| o_trimmomatic_paired_end_fwd_unpaired |  | File[] |  |
| o_trimmomatic_paired_end_rev_paired |  | File[] |  |
| o_trimmomatic_paired_end_rev_unpaired |  | File[] |  |
| o_fastqc_raw_html |  | File[]? |  |
| o_fastqc_single_html |  | File[]? |  |
| o_fastqc_paired_html_fwd |  | File[]? |  |
| o_fastqc_paired_html_rev |  | File[]? |  |
| o_fastqc_raw_zip |  | Directory? |  |
| o_fastqc_single_zip |  | Directory? |  |
| o_fastqc_paired_zip |  | Directory? |  |
| o_hisat2_for_single_reads_sam |  | File[] |  |
| o_hisat2_for_single_reads_stderr |  | File[] |  |
| o_hisat2_for_paired_reads_sam |  | File[] |  |
| o_hisat2_for_paired_reads_stderr |  | File[] |  |
| o_samtools_sort_by_name |  | File[] |  |
| o_samtools_fixmate |  | File[] |  |
| o_samtools_sort |  | File[] |  |
| o_samtools_markdup |  | File[] |  |
| o_samtools_index |  | File[] |  |
| o_multiBamSummary_file |  | File |  |
| o_plotCorrelation_file |  | File |  |
| o_plotCoverage_file |  | File |  |
| o_plotFingerprint_file |  | File |  |
| o_bamCoverage_norm |  | File[] |  |
| o_computeMatrix_matrix |  | File |  |
| o_computeMatrix_regions |  | File |  |
| o_plotHeatmap |  | File |  |
| o_macs2_call_peaks_narrowPeak |  | File[]? |  |
| o_macs2_call_peaks_xls |  | File[]? |  |
| o_macs2_call_peaks_bed |  | File[]? |  |
| o_macs2_call_peaks_lambda |  | File[]? |  |
| o_macs2_call_peaks_pileup |  | File[]? |  |
| o_macs2_call_peaks_broadPeak |  | File[]? |  |
| o_macs2_call_peaks_gappedPeak |  | File[]? |  |
| o_macs2_call_peaks_model_r |  | File[]? |  |
| o_macs2_call_peaks_cutoff |  | File[]? |  |
| o_total_peaks_table |  | File |  |
| o_sort_peaks_table |  | File |  |
| o_bedtools_merge |  | File |  |
| o_bedtools_intersect |  | File |  |
| o_exclude_black_list_regions |  | File |  |
| o_bedtools_coverage |  | File[] |  |
| o_printf_header_samples |  | File |  |
| o_paste_content_1 |  | File |  |
| o_paste_content_2 |  | File |  |
| o_append_files |  | File |  |
| o_ChIPQC_macs_ChIPQCexperiment |  | File |  |
| o_ChIPQC_macs_outdir |  | Directory |  |
| o_ChIPQC_macs_ChIPQCreport |  | File? |  |
| o_DiffBind_macs_diffbind_results |  | File |  |
| o_DiffBind_macs_correlation_heatmap |  | File |  |
| o_DiffBind_macs_diffbind_consensus |  | File? |  |
| o_DiffBind_macs_diffbind_normalized_counts |  | File? |  |
| o_DiffBind_macs_diffbind_dba_object |  | File? |  |
| o_exclude_black_list_regions_narrowPeak |  | File[] |  |
| o_bed_to_rose_gff_conversion |  | File[] |  |
| o_rose_main_gff_dir_outputs |  | array |  |
| o_rose_main_mappedGFF_dir_outputs |  | array |  |
| o_rose_main_STITCHED_ENHANCER_REGION_MAP |  | File[]? |  |
| o_rose_main_AllEnhancers_table |  | File[]? |  |
| o_rose_main_SuperEnhancers_table |  | File[]? |  |
| o_rose_main_Plot_points |  | File[]? |  |
| o_rose_main_Enhancers_withSuper |  | File[]? |  |
| o_enhancer_bed_processing |  | File[]? |  |
| o_ChIPQC_rose_ChIPQCexperiment |  | File |  |
| o_ChIPQC_rose_outdir |  | Directory? |  |
| o_ChIPQC_rose_ChIPQCreport |  | File |  |
| o_DiffBind_rose_diffbind_results |  | File |  |
| o_DiffBind_rose_correlation_heatmap |  | File |  |
| o_DiffBind_rose_diffbind_consensus |  | File? |  |
| o_DiffBind_rose_diffbind_normalized_counts |  | File? |  |
| o_DiffBind_rose_diffbind_dba_object |  | File? |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/525
- `ChIP-Seq_workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
