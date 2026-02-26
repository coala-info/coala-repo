---
name: dr-disco
description: Dr. Disco identifies genomic breakpoints of fusion transcripts, including exon-to-exon and intron-to-intron junctions, using RNA-seq data. Use when user asks to detect gene fusions, identify genomic breakpoints in RNA-seq data, or find novel splice junctions and fusions to non-gene regions.
homepage: https://github.com/yhoogstrate/dr-disco
---


# dr-disco

## Overview

Dr. Disco (Detection of Genomic Breakpoints of Fusion Transcripts) is a computational method designed to identify both exon-to-exon and intron-to-intron breakpoints using RNA-seq data. While standard RNA-seq analysis often misses the exact location of DNA breaks due to the lack of intronic coverage in poly-A selected libraries, Dr. Disco excels with rRNA-depleted, random-hexamer primed data. It uses a graph-based approach to separate exonic and intronic data, allowing for the detection of fusions to non-gene regions and novel splice junctions without being restricted by existing gene annotations.

## Installation and Setup

The recommended way to install Dr. Disco is via Bioconda, though manual installation from source is preferred if you need the most up-to-date blacklist files.

```bash
# Conda installation
conda install -c bioconda dr-disco

# Source installation (for latest updates and blacklists)
git clone https://github.com/yhoogstrate/dr-disco.git
cd dr-disco
pip install -r requirements.txt
python3 setup.py install --user
```

## Core Workflow

### 1. Pre-alignment Preparation
Before running the pipeline, ensure your data meets the following criteria:
- **Mate Pair Orientation**: STAR requires the default FR orientation (_R1: forward, _R2: reverse). If your library is different (e.g., Forward/Forward), use `fastx_reverse_complement` to adjust the reads before alignment.
- **NextSeq Data**: If using Illumina NextSeq, clean poly-G suffixes using a tool like `fastp` to prevent discordant reads in poly-G regions.

### 2. STAR Alignment
Dr. Disco relies on specific chimeric output from the STAR aligner. Use the following parameters (optimized for STAR ~2.4.2):

```bash
STAR --genomeDir ${star_index_dir} \
     --readFilesIn ${left_fq} ${right_fq} \
     --outSAMtype BAM SortedByCoordinate \
     --outFilterIntronMotifs None \
     --alignIntronMax 200000 \
     --alignMatesGapMax 200000 \
     --alignSJDBoverhangMin 10 \
     --alignEndsType Local \
     --chimSegmentMin 12 \
     --chimJunctionOverhangMin 12 \
     --twopassMode Basic
```
This produces the required `<prefix>.Chimeric.out.sam` file.

### 3. Dr. Disco Pipeline Execution
The pipeline typically follows these functional steps (executed via the `dr-disco` CLI):

1.  **Fix**: Prepare the Chimeric SAM file for analysis.
2.  **Detect**: Identify fusion events and merge junctions representing similar transcripts.
3.  **Classify**: Filter events based on statistical parameters and genome-specific blacklists.
4.  **Integrate**: Consolidate results from the same genomic event and apply gene name annotations.

## CLI Best Practices

- **Single Sample Processing**: The tool is designed for single-sample analysis. To scale across a cohort, use `GNU Parallel` to wrap the `dr-disco` commands.
- **GTF Handling**: When running `dr-disco integrate`, ensure your GTF file is well-formatted. Note that some versions may read the GTF file twice; ensure sufficient I/O overhead.
- **Strict Mode**: When using `bam-extract`, consider using the `--strict` mode (available in v0.18.2+) for more rigorous read extraction.
- **Blacklists**: If installed via Conda, manually verify the presence of blacklist files in the `share` directory, as they may not always ship with the pre-compiled package.

## Reference documentation
- [Dr. Disco GitHub Repository](./references/github_com_yhoogstrate_dr-disco.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dr-disco_overview.md)