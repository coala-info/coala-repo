---
name: var-pe
description: "This CWL workflow identifies genomic variations in SARS-CoV-2 paired-end sequencing data using fastp, Picard, Samtools, and LoFreq. Use this skill when you need to characterize intra-host viral diversity, identify low-frequency mutations, or monitor the evolution of specific viral lineages within individual samples."
homepage: https://workflowhub.eu/workflows/28
---
# var-PE

## Overview

This Common Workflow Language (CWL) pipeline is designed for the analysis of genomic variation within individual COVID-19 samples. Originally ported from a [Galaxy Project workflow](https://github.com/galaxyproject/SARS-CoV-2/tree/master/genomics/4-Variation), this implementation is maintained in the [cwl-workflow-SARS-CoV-2](https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/tree/master/Variation) repository and is available on [WorkflowHub](https://workflowhub.eu/workflows/28).

The workflow begins with data preprocessing and quality control using `fastp` and `MultiQC`. It then processes alignment files through a series of `samtools` and `Picard` operations, including filtering, sorting, and marking duplicates to ensure high-quality inputs for variant detection.

For the identification of genomic variants, the pipeline utilizes `lofreq_viterbi` to perform sensitive variation analysis. The final steps involve sorting and indexing the resulting files with `samtools` to facilitate downstream visualization and reporting.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| reads_reverse |  | File[] |  |
| reads_forward |  | File[] |  |
| reference_in |  | File |  |
| unqualified_phred_quality |  | int? |  |
| threads |  | int? |  |
| qualified_phred_quality |  | int? |  |
| min_length_required |  | int? |  |
| force_polyg_tail_trimming |  | boolean? |  |
| disable_trim_poly_g |  | boolean? |  |
| base_correction |  | boolean? |  |
| sort_order |  | null, enum |  |
| validation_stringency |  | null, enum |  |
| exclude_unmapped |  | boolean? |  |
| count |  | boolean |  |
| alignments_are_sorted |  | boolean |  |
| remove_duplicates |  | boolean |  |
| validation_stringency_1 |  | null, enum |  |
| comment |  | string[]? |  |
| duplicate_scoring_strategy |  | null, enum |  |
| optical_duplicate_pixel_distance |  | int? |  |
| barcode_tag |  | string? |  |
| keepflags |  | boolean? |  |
| defqual |  | int? |  |
| bq2_handling |  | null, enum |  |
| bed |  | File? |  |
| bonferroni |  | string? |  |
| call_indels |  | boolean? |  |
| def_alt_bq |  | int? |  |
| def_alt_jq |  | int? |  |
| del_baq |  | boolean? |  |
| enable_source_qual |  | boolean? |  |
| ignore_vcf |  | File[]? |  |
| illumina_1_3 |  | boolean? |  |
| max_depth_cov |  | int? |  |
| max_mapping_quality |  | int? |  |
| min_bq |  | int? |  |
| min_cov |  | int? |  |
| min_mq |  | int? |  |
| use_orphan |  | boolean? |  |
| threads_lf_call |  | int? |  |
| replace_non_match |  | int? |  |
| region |  | string? |  |
| pvalue_cutoff |  | float? |  |
| only_indels |  | boolean? |  |
| no_idaq |  | boolean? |  |
| no_default_filter |  | boolean? |  |
| no_baq |  | boolean? |  |
| no_mapping_quality |  | boolean? |  |
| no_ext_base_alignment_quality |  | boolean? |  |
| min_jq |  | int? |  |
| min_alt_jq |  | int? |  |
| min_alt_bq |  | int? |  |
| genome_reference |  | string |  |
| udLength |  | int |  |
| transcripts |  | File? |  |
| strict |  | boolean? |  |
| spliceSiteSize |  | int? |  |
| spliceRegionIntronMin |  | int? |  |
| spliceRegionIntronMax |  | int? |  |
| spliceRegionExonSize |  | int? |  |
| sequenceOntology |  | boolean? |  |
| outputFormat |  | null, enum |  |
| onlyReg |  | boolean? |  |
| onlyProtein |  | boolean? |  |
| oicr |  | boolean? |  |
| noStats |  | boolean? |  |
| noShiftHgvs |  | boolean? |  |
| noNextProt |  | boolean? |  |
| noMotif |  | boolean? |  |
| bankfile |  | File? |  |
| cancer |  | boolean? |  |
| cancerSamples |  | File? |  |
| canon |  | boolean? |  |
| classic |  | boolean? |  |
| csvFile |  | boolean? |  |
| filterInterval |  | File[]? |  |
| hgvs |  | boolean? |  |
| formatEff |  | boolean? |  |
| html_report_1 |  | boolean? |  |
| importGenome |  | boolean |  |
| interval |  | File[]? |  |
| lof |  | boolean? |  |
| motif |  | boolean? |  |
| nextProt |  | boolean? |  |
| no_downstream |  | boolean? |  |
| no_EffectType |  | boolean? |  |
| no_intergenic |  | boolean? |  |
| no_intron |  | boolean? |  |
| no_upstream |  | boolean? |  |
| no_utr |  | boolean? |  |
| noGenome |  | boolean? |  |
| noHgvs |  | boolean? |  |
| noLof |  | boolean? |  |
| geneId |  | boolean? |  |
| separator |  | string? |  |
| empty_text |  | string? |  |
| extractFields |  | string[]? |  |
| IndexName |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| fastp | fastp |  |
| multiqc_fastp | multiqc_fastp |  |
| samtools_view_filter | samtools_view_filter |  |
| picard_sortsam | picard_sortsam |  |
| picard__mark_duplicates | picard__mark_duplicates |  |
| multiqc_markdups | multiqc_markdups |  |
| lofreq_viterbi | lofreq_viterbi |  |
| samtools_sort | samtools_sort |  |
| samtools_faidx | samtools_faidx |  |
| samtool_index | samtool_index |  |
| bwa_index_cwl | bwa_index_cwl |  |
| get_secondaryfiles | get_secondaryfiles |  |
| get_tab | get_tab |  |
| bwa_mem | bwa_mem |  |
| samtools_stats | samtools_stats |  |
| multiqc_stats | multiqc_stats |  |
| lofreq_call | LoFreq Call Variants |  |
| snpeff_build_ann | snpeff_build_ann |  |
| snpsift_extract | snpsift_extract |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| multiqc_fastp |  | File |  |
| stats_bam |  | File[] |  |
| multiqc_markdups |  | File |  |
| multiqc_samtoolsstats |  | File |  |
| statsFile_snpeff |  | File[] |  |
| out_snpsift |  | File[] |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/28
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
