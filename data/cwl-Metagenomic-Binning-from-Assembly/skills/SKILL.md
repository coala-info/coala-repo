---
name: metagenomic-binning-from-assembly
description: This CWL workflow processes metagenomic assembly FASTA and BAM files using tools like MetaBAT2, MaxBin2, and Binette to group contigs into discrete bins. Use this skill when you need to reconstruct high-quality metagenome-assembled genomes from complex microbial communities to characterize taxonomic diversity and metabolic potential.
homepage: https://m-unlock.com
metadata:
  docker_image: "N/A"
---

# metagenomic-binning-from-assembly

## Overview

This [Common Workflow Language](https://workflowhub.eu/workflows/64) (CWL) workflow performs metagenomic binning from pre-assembled sequences. It requires a unique identifier, a FASTA assembly file, and a corresponding sorted BAM file to calculate contig depths and coverage statistics using tools like samtools.

The pipeline utilizes multiple binning algorithms, including MetaBAT2, MaxBin2, and SemiBin2, to group contigs into metagenome-assembled genomes (MAGs). These results are refined using Binette for bin merging and EukRep for eukaryotic classification. Quality assessment and taxonomic identification are conducted via CheckM2, BUSCO, and GTDB-Tk, while CoverM provides bin abundance estimations.

Users can optionally extend the workflow to include comprehensive [bin annotation](https://workflowhub.eu/workflows/1170) (using Bakta, Interproscan, and Eggnog) and [RDF conversion](https://workflowhub.eu/workflows/1174/) via SAPP. The complete set of CWL tool definitions is maintained in the [UNLOCK GitLab repository](https://gitlab.com/m-unlock/cwl), and detailed setup instructions are available in the [official documentation](https://docs.m-unlock.nl/docs/workflows/setup.html).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| identifier | Identifier used | string | Identifier for this dataset used in this workflow |
| assembly | Assembly fasta | File | Assembly in fasta format |
| bam_file | Bam file | File | Mapping file in sorted bam format containing reads mapped to the assembly |
| threads | Threads | int? | Number of threads to use for computational processes |
| memory | memory usage (MB) | int? | Maximum memory usage in megabytes |
| gtdbtk_data | gtdbtk data directory | Directory? | Directory containing the GTDB database. When none is given GTDB-Tk will be skipped. |
| busco_data | BUSCO dataset | Directory? | Directory containing the BUSCO dataset location. |
| run_semibin | Run SemiBin | boolean? | Run with SemiBin binner |
| semibin_environment | SemiBin Environment | string? | Semibin Built-in models (human_gut/dog_gut/ocean/soil/cat_gut/human_oral/mouse_gut/pig_gut/built_environment/wastewater/global) |
| sub_workflow | Sub workflow Run | boolean | Use this when you need the output bins as File[] for subsequent analysis workflow steps in another workflow. |
| step | CWL base step number | int? | Step number for order of steps |
| destination | Output destination (not used in the workflow itself) | string? | Optional output destination path for cwl-prov reporting. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| metabat2_contig_depths | contig depths | MetabatContigDepths to obtain the depth file used in the MetaBat2 and SemiBin binning process |
| contig_read_counts | samtools idxstats | Reports alignment summary statistics |
| assembly_read_counts | samtools flagstat | Reports alignment summary statistics |
| eukrep | EukRep | EukRep, eukaryotic sequence classification |
| eukrep_stats | EukRep stats | EukRep fasta statistics |
| metabat2 | MetaBAT2 binning | Binning procedure using MetaBAT2 |
| metabat2_filter_bins | Filter MetBAT2 Bins | Removed unwanted fasta files from the MetaBAT2 bin directory (like TooShort.fa) |
| metabat2_contig2bin | MetaBAT2 to contig to bins | List the contigs and their corresponding bin. |
| maxbin2 | MaxBin2 binning | Binning procedure using MaxBin2 |
| maxbin2_to_folder | MaxBin2 bins to folder | Create folder with MaxBin2 bins |
| maxbin2_contig2bin | MaxBin2 to contig to bins | List the contigs and their corresponding bin. |
| semibin | Sembin binning | Binning procedure using SemiBin |
| semibin_contig2bin | SemiBin to contig to bins | List the contigs and their corresponding bin. |
| das_tool | DAS Tool integrate predictions from multiple binning tools | DAS Tool |
| das_tool_bins | Bin dir to files[] | DAS Tool bins folder to File array for further analysis |
| aggregate_bin_depths | Depths per bin | Depths per bin |
| bins_summary | Bins summary | Table of all bins and their statistics like size, contigs, completeness etc |
| bin_readstats | Bin and assembly read stats | Table general bin and assembly read mapping stats |
| checkm | CheckM | CheckM bin quality assessment |
| busco | BUSCO | BUSCO assembly completeness workflow |
| merge_busco_summaries | Merge BUSCO summaries |  |
| gtdbtk | GTDBTK | Taxomic assigment of bins with GTDB-Tk |
| compress_gtdbtk | Compress GTDB-Tk | Compress GTDB-Tk output folder |
| metabat2_files_to_folder | MetaBAT2 output folder | Preparation of MetaBAT2 output files + unbinned contigs to a specific output folder |
| maxbin2_files_to_folder | MaxBin2 output folder | Preparation of maxbin2 output files to a specific output folder. |
| semibin_files_to_folder | SemiBin output folder | Preparation of SemiBin output files to a specific output folder. |
| das_tool_files_to_folder | DAS Tool output folder | Preparation of DAS Tool output files to a specific output folder. |
| checkm_files_to_folder | CheckM output | Preparation of CheckM output files to a specific output folder |
| busco_files_to_folder | BUSCO output folder | Preparation of BUSCO output files to a specific output folder |
| gtdbtk_files_to_folder | GTBD-Tk output folder | Preparation of GTDB-Tk output files to a specific output folder |
| output_bin_files | Bin files | Bin files for subsequent workflow runs when sub_worflow = true |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| bins | Bin files | File[]? | Bins files in fasta format. To be be used in other workflows. |
| metabat2_output | MetaBAT2 | Directory | MetaBAT2 output directory |
| maxbin2_output | MaxBin2 | Directory | MaxBin2 output directory |
| semibin_output | SemiBin | Directory? | MaxBin2 output directory |
| das_tool_output | DAS Tool | Directory | DAS Tool output directory |
| checkm_output | CheckM | Directory | CheckM output directory |
| busco_output | BUSCO | Directory | BUSCO output directory |
| gtdbtk_output | GTDB-Tk | Directory? | GTDB-Tk output directory |
| bins_summary_table | Bins summary | File | Summary of info about the bins |
| bins_read_stats | Assembly/Bin read stats | File | General assembly and bin coverage |
| eukrep_fasta | EukRep fasta | File | EukRep eukaryotic classified contigs |
| eukrep_stats_file | EukRep stats | File | EukRep fasta statistics |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/64
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata