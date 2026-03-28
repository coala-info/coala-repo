---
name: tapestry
description: Tapestry is a toolkit for the manual and automated refinement of close-to-complete eukaryotic genome assemblies using long-read alignment and telomere identification. Use when user asks to assess genome assembly quality, generate interactive assembly reports, or filter and order contigs to produce a finalized FASTA file.
homepage: https://github.com/johnomics/tapestry
---

# tapestry

## Overview

Tapestry is a specialized toolkit for the manual and automated refinement of "close-to-complete" eukaryotic genome assemblies, typically those under 50 Mb and with fewer than 500 contigs. It bridges the gap between raw assembly output and a finished, validated genome by integrating long-read alignment data and telomeric sequence identification into a visual, interactive report. The workflow involves two primary stages: generating a comprehensive assembly report using `weave` and then applying user-defined filters to produce a finalized FASTA file using `clean`.

## Core Workflow

### 1. Generating the Assembly Report
Use the `weave` command to analyze the assembly. This process subsamples reads, maps them to the assembly, and calculates ploidy and telomere presence.

```bash
weave -a assembly.fasta -r reads.fastq.gz -t TTAGGG -o output_dir -c 8
```

**Expert Tips for `weave`:**
- **Telomere Identification**: If the telomere sequence is unknown, inspect the first and last 5kb of your largest contigs; patterns like `TTAGGG` are usually prominent in successful assemblies. You can provide multiple sequences: `-t TTAGGG CTTATT`.
- **Large Assemblies (>50 Mb)**: By default, `weave` disables read alignment plots for assemblies over 50 Mb to keep the HTML report responsive. Use `-f` to force these plots, but significantly reduce depth (e.g., `-d 20`) to prevent browser crashes.
- **Subsampling**: The default depth is 50x. For high-coverage datasets, increasing the minimum read length (`-l`) is often more effective than further subsampling to resolve complex repeats.

### 2. Filtering and Cleaning
After reviewing the `.tapestry_report.html` and exporting the filtered CSV from the browser interface, use the `clean` command to generate the final assembly.

```bash
clean -a assembly.fasta -c assembly_filtered.csv -o final_assembly.fasta
```

**Expert Tips for `clean`:**
- **Contig Ordering**: The `clean` tool respects the order of contigs in the CSV file. If you sorted your contigs in the Tapestry report before exporting, the resulting FASTA will follow that specific order.
- **Validation**: Always check the stderr output of `clean` to ensure the number of "kept" contigs matches your expectations from the manual filtering step.

## Troubleshooting and Requirements
- **Input Format**: Reads must be in FASTQ format and **must be gzipped** (`.fastq.gz`).
- **Dependencies**: Ensure `minimap2` and `samtools` are in your PATH, as Tapestry relies on them for the underlying alignments and BAM processing.
- **Memory/Performance**: For assemblies near the 500-contig limit, increase the core count (`-c`) to speed up the window-based ploidy calculations.



## Subcommands

| Command | Description |
|---------|-------------|
| clean | filter and order assembly from list of contigs |
| weave | assess quality of one genome assembly |

## Reference documentation
- [Tapestry README](./references/github_com_johnomics_tapestry_blob_master_README.md)
- [Weave CLI Reference](./references/github_com_johnomics_tapestry_blob_master_weave.md)
- [Clean CLI Reference](./references/github_com_johnomics_tapestry_blob_master_clean.md)