---
name: variantcaller_gatk36
description: This CWL workflow processes raw FASTQ sequencing data through adapter removal, alignment, and duplicate marking using tools like Cutadapt, BWA-MEM, Picard, and GATK 3.6. Use this skill when you need to identify genetic variants and generate gVCF files from raw genomic data to characterize potential disease-causing mutations in rare disease research.
homepage: https://www.eosc-life.eu/services/demonstrators/
metadata:
  docker_image: "N/A"
---

# variantcaller_gatk36

## Overview

The [VariantCaller_GATK3.6](https://workflowhub.eu/workflows/107) workflow is a Common Workflow Language (CWL) implementation of the RD-Connect pipeline, designed for rare disease research. It processes raw genomic data (FASTQ) to produce unannotated gvcf files, following the standards described by [Laurie et al. (2016)](https://www.ncbi.nlm.nih.gov/pubmed/27604516). The pipeline is optimized for interoperability using Docker containers and is aligned with GA4GH standards for cloud-based genomic analysis.

The workflow executes a standard germline variant calling progression:
*   **Preprocessing:** Performs adapter removal via Cutadapt and prepares reference files using BWA indexing and Picard dictionary tools.
*   **Alignment & Sorting:** Maps reads to the reference genome using BWA-MEM and sorts the resulting BAM files with Samtools.
*   **Post-processing:** Marks duplicates using Picard and performs Base Quality Score Recalibration (BQSR) via GATK 3.6.
*   **Variant Discovery:** Executes HaplotypeCaller to generate per-sample gvcf files suitable for downstream integration into the RD-Connect GPAP or independent analysis.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| fastq_files |  | File[] | List of paired-end input FASTQ files |
| reference_genome |  | File[] | Compress FASTA files with the reference genome chromosomes |
| known_indels_file |  | File | VCF file correlated to reference genome assembly with known indels |
| known_sites_file |  | File | VCF file correlated to reference genome assembly with know sites (for instance dbSNP) |
| chromosome |  | string | Label of the chromosome to be used for the analysis. By default all the chromosomes are used |
| readgroup_str |  | string | Parsing header which should correlate to FASTQ files |
| sample_name |  | string | Sample name |
| gqb |  | int[] | Exclusive upper bounds for reference confidence GQ bands (must be in [1, 100] and specified in increasing order) |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| unzipped_known_sites | unzipped_known_sites |  |
| unzipped_known_indels | unzipped_known_indels |  |
| gunzip | gunzip |  |
| picard_dictionary | picard_dictionary |  |
| cutadapt2 | cutadapt2 |  |
| bwa_index | bwa_index |  |
| samtools_index | samtools_index |  |
| bwa_mem | bwa_mem |  |
| samtools_sort | samtools_sort |  |
| picard_markduplicates | picard-MD |  |
| gatk3-rtc | gatk3-rtc |  |
| gatk-ir | gatk-ir |  |
| gatk-base_recalibration | gatk-base_recalibration |  |
| gatk-base_recalibration_print_reads | gatk-base_recalibration_print_reads |  |
| gatk_haplotype_caller | gatk-haplotype_caller |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| metrics |  | File | Several metrics about the result |
| gvcf |  | File | unannotated gVCF output file from the mapping and variant calling pipeline |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/107
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata