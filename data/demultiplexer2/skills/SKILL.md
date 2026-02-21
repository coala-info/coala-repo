---
name: demultiplexer2
description: The `demultiplexer2` tool is designed for bioinformatics workflows where Illumina reads must be sorted based on internal barcode sequences (inline tags) rather than standard Illumina indices.
homepage: https://github.com/DominikBuchner/demultiplexer2
---

# demultiplexer2

## Overview
The `demultiplexer2` tool is designed for bioinformatics workflows where Illumina reads must be sorted based on internal barcode sequences (inline tags) rather than standard Illumina indices. It utilizes a three-step process involving the creation and population of Excel-based configuration files to manage primer sequences, tag combinations, and sample metadata. This skill helps navigate the CLI commands required to initialize these templates and run the final demultiplexing engine.

## Installation
Install the tool via pip or conda:
```bash
pip install demultiplexer2
# OR
conda install bioconda::demultiplexer2
```

## Core Workflow

### 1. Initialize the Primer Set
Generate the template Excel file that defines your primers and tag sequences.
```bash
demultiplexer2 create_primerset --name MyProject_Primers --n_primers 2
```
**Expert Tips:**
* The resulting Excel file contains three sheets: **General Information**, **Forward Tags**, and **Reverse Tags**.
* You must manually fill these sheets with your specific sequences before proceeding.
* Ensure tag sequences are entered accurately, as the tool uses exact matches to sort reads.

### 2. Generate the Tagging Scheme
Create a mapping file that links your raw input FASTQ files to specific sample names.
```bash
demultiplexer2 create_tagging_scheme --name MyStudy_Scheme --data_dir ./raw_data --primerset_path ./MyProject_Primers.xlsx
```
**Expert Tips:**
* `--data_dir` should point to the directory containing your gzipped FASTQ files.
* Open the generated tagging scheme Excel file and enter the desired **Sample Names** for each file/tag combination.
* This file acts as the final bridge between raw data and organized output.

### 3. Execute Demultiplexing
Run the algorithm to sort reads into the output directory.
```bash
demultiplexer2 demultiplex --primerset_path ./MyProject_Primers.xlsx --tagging_scheme_path ./MyStudy_Scheme.xlsx --output_dir ./demultiplexed_results
```

## Best Practices and Constraints
* **Input Format**: The tool specifically expects gzipped FASTQ files (`.fastq.gz`).
* **Read Handling**: Reads that do not match the provided tag sequences in the Excel configuration are discarded automatically.
* **Output**: The tool generates gzipped FASTQ files for each sample defined in your tagging scheme.
* **Statistics**: Upon completion, the tool provides a summary of the percentage of reads successfully assigned to tags (e.g., "16865 of 100000 sequences matched"). Low match percentages often indicate errors in the tag sequences provided in the Excel sheets.

## Reference documentation
- [demultiplexer2 GitHub README](./references/github_com_DominikBuchner_demultiplexer2.md)
- [demultiplexer2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_demultiplexer2_overview.md)