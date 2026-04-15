---
name: atac-seq-data-processing-workflow
description: This Common Workflow Language pipeline processes raw bulk ATAC-Seq reads into genome-wide accessibility tracks and peak calls using trimGalore, bowtie2, and MACS2. Use this skill when you need to identify open chromatin regions and map regulatory elements across the genome to characterize the epigenetic landscape of your samples.
homepage: https://eosc4cancer.eu
metadata:
  docker_image: "N/A"
---

# atac-seq-data-processing-workflow

## Overview

This CWL workflow provides a comprehensive pipeline for processing bulk ATAC-Seq data, transforming raw sequencing reads into genome-wide accessibility tracks and peak calls. It is designed to handle the standard epigenomics requirements for sequence read processing, ensuring data quality and reproducibility from initial trimming through to final analysis.

The core processing begins with read trimming via TrimGalore and alignment to a reference genome using Bowtie2. Following alignment, the workflow performs duplicate removal, filtering, and name sorting. These processed alignments are then converted into BEDPE format to generate signal tags and bigWig coverage tracks for visualization.

For downstream analysis, the pipeline utilizes MACS2 to perform both broad and narrow peak calling, identifying regions of open chromatin. Integrated quality control steps generate fragment size distribution plots and fingerprint plots to assess library complexity and enrichment. The complete workflow is available on [WorkflowHub](https://workflowhub.eu/workflows/1760) under the Apache-2.0 license.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| sample_id |  | string | Sample ID used for naming the output files.  |
| fastq1 |  | array | List of fastq files containing the first mate of raw reads.  Muliple files are provided if  multiplexing of the same library has been done  on multiple lanes. The reads comming from different fastq files are pooled  after alignment. Also see parameter "fastq2".   |
| fastq2 |  | array | List of fastq files containing the second mate of raw reads.  Important: this list has to be of same length as parameter "fastq1".  |
| adapter1 |  | string? | Adapter sequence for first reads.  If not specified (set to "null"), trim_galore will try to autodetect whether ...\n - Illumina universal adapter (AGATCGGAAGAGC)\n - Nextera adapter (CTGTCTCTTATA)\n - Illumina Small RNA 3-prime Adapter (TGGAATTCTCGG)\n ... was used.\n You can directly choose one of the above configurations  by setting the string to "illumina", "nextera", or "small_rna".  Or you specify the adaptor string manually (e.g. "AGATCGGAAGAGC").  |
| adapter2 |  | string? | Adapter sequence for second reads.  If not specified (set to "null"), trim_galore will try to autodetect whether ...\n - Illumina universal adapter (AGATCGGAAGAGC)\n - Nextera adapter (CTGTCTCTTATA)\n - Illumina Small RNA 3-prime Adapter (TGGAATTCTCGG)\n ... was used.\n You can directly choose one of the above configurations  by setting the string to "illumina", "nextera", or "small_rna".  Or you specify the adaptor string manually (e.g. "AGATCGGAAGAGC").  |
| genome |  | File | Path to reference genome in fasta format.  Bowtie2 index files (".1.bt2", ".2.bt2", ...) as well as a samtools index (".fai")  has to be located in the same directory.\n All of these files can be downloaded for the most common genome builds at   https://support.illumina.com/sequencing/sequencing_software/igenome.html.  Alternatively, you can use "bowtie2-build" or "samtools index" to create them yourself.  |
| genome_info |  | File | Path to a tab-delimited file listing chromosome sizes in following fashion:\n "chromosome_name<tab>total_number_of_bp".\n For the most common UCSC genome build, you can find corresponding files at:  https://github.com/CompEpigen/ATACseq_workflows/tree/master/chrom_sizes.  Or you can generate them yourself using UCSC script fetchChromSizes  (http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/fetchChromSizes) in following fashion:\n "fetchChromSizes hg38 > hg38.chrom.sizes".\n If you are dealing with a non-UCSC build, you can generate such a file from a samtools index using:\n "awk -v OFS='\t' {'print $1,$2'} hg38.fa.fai > hg38.chrom.sizes".  |
| max_mapping_insert_length |  | long | Maximum insert length between two reads of a pair. In case of ATACseq,  very long insert sizes are possible. So it is recommended to use at least  a value of 1500. However, please note that alignment will take significantly  longer for higher insert sizes. The default is 2500.  |
| macs2_qvalue |  | float | Q-value cutoff used for peak calling by MACS2.  The default is 0.05.  |
| effective_genome_size |  | long | The effectively mappable genome size, please see:  https://deeptools.readthedocs.io/en/latest/content/feature/effectiveGenomeSize.html  |
| bin_size |  | int | Bin size used for generation of coverage tracks.  The larger the bin size the smaller are the coverage tracks, however,  the less precise is the signal. For single bp resolution set to 1.  |
| ignoreForNormalization |  | string? | List of space-delimited chromosome names that shall be ignored  when calculating the scaling factor.  Specify as space-delimited string.  Default: "chrX chrY chrM"  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| trim_and_map | trim_and_map |  |
| merge_duprem_filter | merge_duprem_filter |  |
| name_sorting_filtered_bam | name_sorting_filtered_bam | samtools sort - sorting of filtered bam file by read name |
| converting_bam_to_bedpe | converting_bam_to_bedpe | bedtools bamtobed |
| generating_atac_signal_tags | generating_atac_signal_tags |  |
| generating_coverage_tracks | generating_coverage_tracks |  |
| peak_calling_macs2_broad | peak_calling_macs2_broad | peak calling using macs2 |
| peak_calling_macs2_narrow | peak_calling_macs2_narrow | peak calling using macs2 |
| plot_fragment_size_distribution | plot_fragment_size_distribution |  |
| qc_plot_fingerprint | qc_plot_fingerprint |  |
| qc_phantompeakqualtools | qc_phantompeakqualtools |  |
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
| merged_flagstat_output |  | File |  |
| filtered_flagstat_output |  | File |  |
| duprem_flagstat_output |  | File |  |
| bam |  | File |  |
| picard_markdup_log |  | File |  |
| frag_size_stats_tsv |  | File |  |
| filtering_stats_tsv |  | File |  |
| fragment_sizes_tsv |  | File |  |
| irreg_mappings_bedpe |  | File |  |
| bam_signal_tags |  | array |  |
| bigwig_signal_tags |  | array |  |
| peaks_bed_macs2_broad |  | array |  |
| peaks_xls_macs2_broad |  | array |  |
| peaks_bed_macs2_narrow |  | array |  |
| peaks_xls_macs2_narrow |  | File |  |
| frag_size_distr_plot |  | File |  |
| frag_size_distr_tsv |  | File |  |
| qc_plot_fingerprint_plot |  | File? |  |
| qc_plot_fingerprint_tsv |  | File? |  |
| qc_plot_fingerprint_stderr |  | File |  |
| qc_crosscorr_summary |  | File? |  |
| qc_crosscorr_plot |  | File? |  |
| qc_phantompeakqualtools_stderr |  | File? |  |
| multiqc_zip |  | File |  |
| multiqc_html |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/1760
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata