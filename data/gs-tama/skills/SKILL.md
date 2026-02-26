---
name: gs-tama
description: gs-tama is a toolkit for processing long-read transcriptome data to refine gene models and merge disparate datasets into high-confidence annotations. Use when user asks to collapse redundant transcripts, merge multiple annotation sets, filter transcript fragments, or convert GTF files to BED12 format.
homepage: https://github.com/sguizard/gs-tama
---


# gs-tama

## Overview

gs-tama (Gene-Switch Transcriptome Annotation by Modular Algorithms) is a specialized toolkit for handling the complexities of long-read transcriptome data. It provides a suite of Python scripts designed to refine gene models by collapsing overlapping reads into unique isoforms and merging disparate datasets into a high-confidence annotation. Use this skill to guide the execution of modular workflows that improve the structural accuracy of transcript models.

## Core Workflows and CLI Patterns

### Collapsing Redundant Transcripts
Use `tama_collapse.py` to process mapped long reads (SAM/BAM converted to BED) into a set of unique transcripts.
- **Input**: Typically requires a BED file of mapped reads.
- **Key Output**: Generates a collapsed BED file (often suffixed with `_collapsed.bed`) and a report of read-to-transcript mappings.
- **Best Practice**: Ensure reads are properly aligned to a reference genome before collapsing.

### Merging Annotation Sets
Use `tama_merge.py` to combine multiple transcriptomes (e.g., from different tissues or sequencing technologies) into a single non-redundant set.
- **Input**: A file list containing paths to the BED files you wish to merge.
- **Function**: It identifies overlapping transcripts across sources and merges them based on user-defined thresholds for junction and end-point matching.

### Quality Control and Filtering
The toolkit includes several scripts for refining the final annotation:
- **Fragment Removal**: Use `tama_remove_fragment_models.py` to eliminate transcripts that appear to be incomplete fragments of longer models.
- **Single Read Models**: Use `tama_remove_single_read_models_levels.py` to filter out transcripts supported by only a single read, which helps reduce noise from sequencing artifacts.
- **ORF Prediction**: Use `tama_filter_primary_transcripts_orf.py` to prioritize transcripts based on Open Reading Frame (ORF) analysis.

### Format Conversion and Preparation
- **GTF to BED**: Use `tama_format_gtf_to_bed12_ncbi.py` or similar scripts in the suite to convert standard GTF files into the BED12 format required by TAMA.
- **CDS Addition**: Use `tama_cds_regions_bed_add.py` to incorporate coding sequence information into existing BED files.

## Expert Tips
- **Modular Execution**: Since TAMA is a collection of scripts rather than a single monolithic binary, chain commands together using standard shell pipes or sequential script calls.
- **Memory Management**: For very large datasets, look for "Low Mem" options or versions of the scripts (e.g., updated versions of `tama_collapse.py`) mentioned in the repository updates.
- **Naming Conventions**: TAMA often uses specific ID formats; use the formatting scripts provided in the toolkit to ensure compatibility between different modules.

## Reference documentation
- [gs-tama - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_gs-tama_overview.md)
- [GitHub - sguizard/gs-tama](./references/github_com_sguizard_gs-tama.md)
- [Commits · sguizard/gs-tama](./references/github_com_sguizard_gs-tama_commits_master.md)