---
name: talon
description: "TALON identifies and quantifies transcripts in long-read sequencing datasets by categorizing alignments into known or novel isoforms. Use when user asks to label internal priming artifacts, initialize a transcript database from a GTF, run the TALON annotator, or filter and quantify isoforms from long-read SAM files."
homepage: https://github.com/mortazavilab/TALON
---


# talon

## Overview
TALON is a technology-agnostic pipeline for the identification and quantification of transcripts in long-read datasets. It processes mapped SAM files to categorize reads into known models or various categories of novelty (e.g., NIC, NNC, Antisense). Use this skill to navigate the multi-step workflow required to transform raw alignments into a filtered, quantified isoform database.

## Core Workflow

### 1. Pre-requisites and Alignment
Reads must be aligned to the reference genome and oriented in the forward direction (5'->3').
- **Aligner**: Minimap2 is recommended.
- **Critical Flag**: You must use the `--MD` flag in Minimap2 (or equivalent) to generate the MD tag, which TALON requires for internal priming checks.
- **Optional**: Use `TranscriptClean` prior to TALON to correct non-canonical splice junctions.

### 2. Flagging Internal Priming
Identify potential artifacts where oligo-dT primers bound to internal A-rich sequences.
```bash
talon_label_reads --f input.sam \
                  --g reference_genome.fasta \
                  --t 8 \
                  --ar 20 \
                  --o output_prefix
```
- `--ar`: Size of the post-transcript interval to check for fraction of As (default is 20bp).
- The output is a SAM file with an `fA:f` custom tag.

### 3. Initializing the TALON Database
Create a SQLite database from a reference GTF (e.g., GENCODE). This is a one-time setup per annotation.
```bash
talon_initialize_database --f annotation.gtf \
                          --g hg38 \
                          --a gencode_v38 \
                          --l 0 \
                          --idprefix TALON \
                          --o my_talon_db
```
- **GTF Requirement**: The file must explicitly contain `gene`, `transcript`, and `exon` entries.
- **Parameters**: `--5p` (default 500bp) and `--3p` (default 300bp) define the allowable distance from known ends.

### 4. Running the Annotator
The main `talon` command modifies the database in place to track and quantify transcripts.
- **Configuration File**: Create a CSV with four columns: `name, sample_description, platform, sam_path`.
- **Execution**:
```bash
talon --f config.csv \
      --db my_talon_db.db \
      --build hg38 \
      --threads 8 \
      --o experiment_output
```
- Use `--cb` if your SAM files contain cell barcodes in the `CB` tag; the config file format then changes to `sample_description, platform, sam_path`.

### 5. Post-Processing and Filtering
After running TALON, use the utility scripts to extract usable data.
- **Filtering**: Use `talon_filter_transcripts` to remove low-confidence models based on internal priming or reproducibility across datasets.
- **Abundance**: Use `talon_abundance` to generate a matrix of gene and transcript counts.
- **AnnData**: Use `talon_create_GTF` or specific scripts to generate AnnData objects for single-cell analysis.

## Expert Tips
- **Database Persistence**: TALON modifies the SQLite database in place. Always keep a backup of your initialized database before running a new experiment if you intend to reuse the base annotation.
- **GTF Troubleshooting**: If the database tables are empty after initialization, verify that your GTF includes the third column "feature" types for genes and transcripts; many "minimal" GTFs only include exons.
- **Multithreading**: TALON v4.4+ supports multithreading. Ensure your environment has sufficient memory, as SQLite operations can become a bottleneck with very high thread counts.

## Reference documentation
- [TALON Main Documentation](./references/github_com_mortazavilab_TALON.md)
- [TALON Wiki and Troubleshooting](./references/github_com_mortazavilab_TALON_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_talon_overview.md)