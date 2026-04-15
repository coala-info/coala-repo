---
name: chip-seq-data-processing-workflow
description: This Common Workflow Language pipeline processes raw ChIP-Seq reads into genome-wide signal tracks and peaks using trimGalore, bowtie2, and MACS2. Use this skill when you need to identify protein-DNA binding sites or characterize histone modification patterns across the genome to understand epigenetic regulation.
homepage: https://eosc4cancer.eu
metadata:
  docker_image: "N/A"
---

# chip-seq-data-processing-workflow

## Overview

This [Common Workflow Language (CWL) workflow](https://workflowhub.eu/workflows/1761) provides a standardized pipeline for the primary processing of ChIP-Seq data. It automates the transition from raw sequencing reads to genome-wide signal tracks and peak calls, facilitating epigenomics research through a reproducible sequence of processing steps.

The workflow follows a modular structure:
* **Preprocessing and Alignment:** Raw reads are trimmed using Trim Galore and aligned to a reference genome with Bowtie2.
* **Post-processing:** Aligned reads are merged, filtered for duplicates, and processed to generate coverage tracks using Samtools.
* **Analysis and Reporting:** The pipeline performs peak calling via MACS2 and generates comprehensive quality control metrics, culminating in a summary QC report.

Licensed under Apache-2.0, this workflow ensures data consistency by integrating standard bioinformatics tools into a single executable pipeline. It is designed to output both the final enrichment peaks and the intermediate signal tracks required for visualization and downstream analysis.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| sample_id |  | string | Sample ID used for naming the output files.  |
| fastq1 |  | array | List of fastq files containing the first mate of raw reads.  Muliple files are provided if  multiplexing of the same library has been done  on multiple lanes. The reads comming from different fastq files are pooled  after alignment. Also see parameter "fastq2".   |
| fastq2 |  | array | List of fastq files containing the second mate of raw reads in case of paired end  (also see parameter "fastq1").  Important: this list has to be of same length as parameter "fastq1" no matter if paired or single end is used.  In case of single end data specify "null" for every entry of fastq1.   |
| is_paired_end |  | boolean | If paired end data is used set to true, else set to false.  |
| adapter1 |  | string? | Adapter sequence for first reads.  If not specified (set to "null"), trim_galore will try to autodetect whether ...\n - Illumina universal adapter (AGATCGGAAGAGC)\n - Nextera adapter (CTGTCTCTTATA)\n - Illumina Small RNA 3-prime Adapter (TGGAATTCTCGG)\n ... was used.\n You can directly choose one of the above configurations  by setting the string to "illumina", "nextera", or "small_rna".  Or you specify the adaptor string manually (e.g. "AGATCGGAAGAGC").  |
| adapter2 |  | string? | Adapter sequence for second reads (only relevant for paired end data).  If it is not specified (set to "null"), trim_galore will try to autodetect whether ...\n - Illumina universal adapter (AGATCGGAAGAGC)\n - Nextera adapter (CTGTCTCTTATA)\n - Illumina Small RNA 3-prime Adapter (TGGAATTCTCGG)\n ... was used.\n You can directly choose one of the above configurations  by setting the string to "illumina", "nextera", or "small_rna".  Or you specify the adaptor string manually (e.g. "AGATCGGAAGAGC").  |
| genome |  | File | Path to reference genome in fasta format.  Bowtie2 index files (".1.bt2", ".2.bt2", ...) as well as a samtools index (".fai")  has to be located in the same directory.\n All of these files can be downloaded for the most common genome builds at   https://support.illumina.com/sequencing/sequencing_software/igenome.html.  Alternatively, you can use "bowtie2-build" or "samtools index" to create them yourself.  |
| fragment_size |  | int? | Mean library fragment size, used to reconstruct entire  fragments from single end reads. Not relevant in case of paired end data.  |
| effective_genome_size |  | long | The effectively mappable genome size, please see:  https://deeptools.readthedocs.io/en/latest/content/feature/effectiveGenomeSize.html  |
| bin_size |  | int | Bin size used for generation of coverage tracks.  The larger the bin size the smaller are the coverage tracks, however,  the less precise is the signal. For single bp resolution set to 1.  |
| ignoreForNormalization |  | string? | List of space-delimited chromosome names that shall be ignored  when calculating the scaling factor.  Specify as space-delimited string.  Default: "chrX chrY chrM"  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| trim_and_map | trim_and_map |  |
| merge_duprem_filter | merge_duprem_filter |  |
| chip_qc | chip_qc |  |
| generate_coverage_tracks | generate_coverage_tracks |  |
| create_summary_qc_report | create_summary_qc_report | multiqc summarizes the qc results from fastqc  and other tools  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| raw_fastqc_zip |  | array |  |
| raw_fastqc_html |  | array |  |
| trim_galore_log |  | array |  |
| trimmed_fastqc_html |  | array |  |
| trimmed_fastqc_zip |  | array |  |
| bowtie2_log |  | array |  |
| duprem_fastqc_zip |  | array |  |
| duprem_fastqc_html |  | array |  |
| bam |  | File |  |
| picard_markdup_log |  | File |  |
| bigwig |  | File |  |
| qc_plot_coverage_plot |  | File |  |
| qc_plot_coverage_tsv |  | File |  |
| qc_plot_fingerprint_plot |  | File? |  |
| qc_plot_fingerprint_tsv |  | File? |  |
| qc_plot_fingerprint_stderr |  | File |  |
| qc_crosscorr_summary |  | File? |  |
| qc_crosscorr_plot |  | File? |  |
| qc_phantompeakqualtools_stderr |  | File? |  |
| multiqc_zip |  | File |  |
| multiqc_html |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1761
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata