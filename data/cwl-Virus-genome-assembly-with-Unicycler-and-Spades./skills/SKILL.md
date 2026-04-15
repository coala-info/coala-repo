---
name: virus-genome-assembly-with-unicycler-and-spades
description: This CWL workflow assembles viral genomes from sequencing data using Unicycler and SPAdes in parallel while generating assembly graph visualizations and metrics with Bandage. Use this skill when you need to reconstruct complete viral genomes from sequencing data to characterize pathogen sequences or evaluate assembly quality for infectious disease research.
homepage: https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# virus-genome-assembly-with-unicycler-and-spades

## Overview

This [Common Workflow Language (CWL)](https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2/blob/master/Assembly/workflow/assembly-wf-virus.cwl) workflow performs de novo virus genome assembly, specifically optimized for SARS-CoV-2 data. It executes two primary assemblers, Unicycler and SPAdes, in parallel to allow for a comparative analysis of the resulting genomic contigs.

For each assembly, the pipeline utilizes Bandage to generate both high-resolution assembly graph images and detailed statistical reports. This visualization step helps researchers assess the connectivity and quality of the assembly graphs produced by both tools.

The workflow is based on the [Galaxy Project SARS-CoV-2 assembly pipeline](https://github.com/galaxyproject/SARS-CoV-2/blob/master/genomics/2-Assembly/as_wf.png) and is available under the MIT license. You can find the complete implementation and version history on [WorkflowHub](https://workflowhub.eu/workflows/3).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| fastq_file_type |  | enum | Paired and single end data |
| mode |  | enum | Bridging mode, values: conservative (smaller contigs, lower misassembly) normal (moderate contig size and misassembly rate) bold  (longest contigs, higher misassembly rate)  |
| fastq1_type |  | enum | Type of the First set of reads. Only when fastq_file_type = single  or  paired |
| fastq1 |  | File | First set of reads with forward reads. Only when fastq_file_type = single or paired |
| fastq2_type |  | null, enum | Type of the Second set of reads. Only when fastq_file_type=paired |
| fastq2 |  | File? | Second set of reads with reverse reads. Only when fastq_file_type=paired |
| libraries_metadata |  | array | reads library metadata related to   libraries_fwd_rev and libraries_mono inputs lib_index(id) must match  |
| libraries_fwd_rev |  | array | reads file orientation must be a value in  ff, fr, rf K-mer choices can be chosen by SPAdes instead of being entered manually  |
| libraries_mono |  | array | reads file file_type value must be in : interleaved, merged, unpaired  |
| pacbio_reads |  | null, array |  |
| nanopore_reads |  | null, array |  |
| sanger_reads |  | null, array |  |
| trusted_contigs |  | null, array |  |
| untrusted_contigs |  | null, array |  |
| auto_kmer_choice |  | boolean | Automatically choose k-mer values. K-mer choices can be chosen by SPAdes instead of being entered manually  |
| kmers |  | string | K-mers to use, separated by commas. Comma-separated list of k-mer sizes to be used  (all values must be odd, less than 128, listed in ascending order,  and smaller than the read length). The default value is 21,33,55  |
| cov_state |  | null, enum | Coverage cutoff ( 'auto', or 'off', or 'value'). auto if null when cov_state=value (User Specific) , cov_cutoff must be provided  |
| cov_cutoff |  | float? | coverage cutoff value (a positive float number )  |
| iontorrent |  | boolean | true if Libraries are IonTorrent reads.  |
| sc |  | boolean | This option is required for MDA.  true if single-cell data.   |
| onlyassembler |  | boolean | Run only assembly if true (without read error correction)  |
| careful |  | boolean | Careful correction. Tries to reduce number of mismatches and short indels.  Also runs MismatchCorrector, a post processing tool, which uses BWA tool (comes with SPAdes).  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| unicycler | unicycler |  |
| spades | spades |  |
| bandage_image_unicycler | bandage_image_unicycler |  |
| bandage_info_unicycler | bandage_info_unicycler |  |
| bandage_image_spades | bandage_image_spades |  |
| bandage_info_spades | bandage_info_spades |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| out_contigs_spades |  | File |  |
| out_scaffolds_spades |  | File |  |
| out_contig_stats_spades |  | File |  |
| out_scaffold_stats_spades |  | File |  |
| assembly_graph_spades |  | File |  |
| assembly_graph_with_scaffolds_spades |  | File |  |
| all_log_spades |  | File[] |  |
| assembly_image_spades |  | File |  |
| assembly_info_spades |  | File |  |
| assembly_graph_unicycler |  | File |  |
| assembly_unicycler |  | File |  |
| assembly_image_unicycler |  | File |  |
| assembly_info_unicycler |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/3
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata