---
name: cnv_pipeline
description: This Common Workflow Language pipeline processes raw sequencing reads using BWA, Samtools, and Manta to perform alignment and structural variant calling. Use this skill when you need to identify copy number variations and large-scale genomic rearrangements to characterize the mutational landscape of cancer samples.
homepage: https://inb-elixir.es/transbionet
metadata:
  docker_image: "N/A"
---

# cnv_pipeline

## Overview

The [CNV_pipeline](https://workflowhub.eu/workflows/278) is a Common Workflow Language (CWL) implementation designed for the detection of structural variants (SVs) and copy number variations (CNVs) in genomic data. Developed within the TransBioNet framework, this pipeline is optimized for cancer research and provides a standardized path from raw sequencing reads to high-confidence variant calls.

The workflow follows a rigorous data processing sequence:
* **Alignment and Processing:** Raw FASTQ files are aligned to a reference genome using `bwa_mem`. The resulting data is processed through `samtools` for conversion, sorting, and merging, followed by `picard_markduplicates` to ensure library quality.
* **Filtering and Calling:** After initial processing, the pipeline performs BAM filtering to remove artifacts. Structural variant calling is primarily executed via `cnv_manta`, though the pipeline is architected for compatibility with other tools in the ecosystem such as CODEX2, ExomeDepth, and GRIDSS.

This pipeline automates the complex dependencies required for structural variant analysis, ensuring reproducible results across different computational environments. It is licensed under Apache-2.0 and maintained on [WorkflowHub](https://workflowhub.eu/workflows/278).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| fastq1 |  | File[] | FASTQ 1 list of files |
| fastq2 |  | File[] | FASTQ 2 list of files |
| generate_bwa_indexes |  | boolean? | enable generation of reference genome indexes |
| reference_fasta |  | File | reference genome |
| reference_fai |  | File? | fai index for reference genome |
| reference_amb |  | File? | amb index for reference genome |
| reference_ann |  | File? | ann index for reference genome |
| reference_bwt |  | File? | bwt index for reference genome |
| reference_pac |  | File? | pac index reference genome |
| reference_sa |  | File? | sa index reference genome |
| bed |  | File | capture kit |
| samples |  | File | TXT file mapping cases ID, samples ID and batch |
| threads_fastqc |  | int? | number of threads for fastqc |
| threads_fastp |  | int? | number of threads for fastp |
| threads_bwa_mem |  | int? | number of threads for bwa-mem |
| threads_samtools |  | int? | number of threads for samtools |
| threads_gridss |  | int? | number of threads for GRIDSS |
| bwt_algorithm |  | string? | BWT construction algorithm: bwtsw or is (Default: auto) |
| read_group |  | string? | FASTA read group (used to fix BAM files) |
| min_mapping_quality |  | int | skip alignments with MAPQ smaller than this minimum |
| bits_set |  | int | skip output alignments with this bits set |
| manta_exome |  | boolean | provide appropriate settings for WES |
| manta_min_len |  | string | minimum CNV lenght for MANTA |
| manta_max_len |  | string | maximum CNV lenght for MANTA |
| manta_min_q |  | string | minimum CNV quality for MANTA |
| blacklist |  | File? | BED file containing regions to ignore |
| gridss_min_len |  | string | minimum CNV lenght for GRIDSS |
| gridss_max_len |  | string | maximum CNV lenght for GRIDSS |
| gridss_min_q |  | string | minimum CNV quality for GRIDSS |
| exomeDepth_min_len |  | string | minimum CNV lenght for EXOME_DEPTH |
| exomeDepth_max_len |  | string | maximum CNV lenght for EXOME_DEPTH |
| exomeDepth_min_bf |  | string | minimum CNV Bayes factor for EXOME_DEPTH |
| codex_min_len |  | string | minimum CNV lenght for CODEX |
| codex_max_len |  | string | maximum CNV lenght for CODEX |
| codex_min_lratio |  | string | minimum CNV lratio for CODEX |
| enable_manta |  | boolean | execute MANTA predictions |
| enable_gridss |  | boolean | execute GRIDSS predictions |
| enable_exomeDepth |  | boolean | execute EXOME_DEPTH predictions |
| enable_codex |  | boolean | execute CODEX predictions |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| bwa_index | bwa_index |  |
| trimmed_fastq | trimmed_fastq |  |
| bwa_mem | bwa_mem |  |
| samtools_view_sam2bam | samtools_view_sam2bam |  |
| samtools_sort | samtools_sort |  |
| samtools_merge | samtools_merge |  |
| samtools_index | samtools_index |  |
| picard_markduplicates | picard_markduplicates |  |
| bam_filtering | bam_filtering |  |
| cnv_manta | cnv_manta |  |
| cnv_gridss | cnv_gridss |  |
| cnv_exomedepth | cnv_exomedepth |  |
| cnv_codex | cnv_codex |  |
| final_filtering | final_filtering |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| fastqc_raw_zip |  | File[] |  |
| fastqc_raw_html |  | File[] |  |
| html_report |  | File[] |  |
| json_report |  | File[] |  |
| fastqc_paired_zip |  | File[] |  |
| fastqc_paired_html |  | File[] |  |
| output_bam_filtering |  | File[] |  |
| output_manta |  | File? |  |
| output_gridss |  | File? |  |
| output_exomedepth |  | File? |  |
| output_codex |  | File? |  |
| output_all |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/278
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata