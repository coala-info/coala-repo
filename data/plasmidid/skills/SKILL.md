---
name: plasmidid
description: PlasmidID is a mapping-based and assembly-assisted tool designed to identify and visualize plasmids within bacterial samples by reconstructing them against a reference database. Use when user asks to identify plasmids in genomic data, map reads to a plasmid database, or generate circular visualizations of plasmidic composition.
homepage: https://github.com/BU-ISCIII/plasmidID
---

# plasmidid

## Overview

PlasmidID is a mapping-based and assembly-assisted tool designed to identify plasmids within bacterial samples. It works by mapping genomic reads against a reference plasmid database, using the most covered sequences as scaffolds for reconstruction. The tool integrates mapping, assembly, and annotation data into a circular visualization (Circos-based), allowing for a clear determination of the plasmidic composition of a sample. It is particularly useful for identifying known plasmids, determining their coverage, and visualizing how assembly contigs align with reference sequences.

## Core Workflows

### 1. Standard Illumina Paired-End Analysis
The most common use case involves providing raw or trimmed reads along with a reference database.

```bash
plasmidID.sh -1 SAMPLE_R1.fastq.gz -2 SAMPLE_R2.fastq.gz -d plasmid_db.fasta -s SAMPLE_NAME
```

### 2. Assembly-Assisted Analysis (Recommended)
If you already have an assembly, providing the contigs significantly speeds up the process and improves accuracy by allowing the tool to skip the internal assembly step.

```bash
plasmidID.sh -1 R1.fq.gz -2 R2.fq.gz -d database.fasta -c assembled_contigs.fasta -s SAMPLE_NAME --no-trim
```

### 3. Long-Read / Contig-Only Mode
For SMRT sequencing or when only assembled sequences are available, you can run the tool without raw reads.

```bash
plasmidID.sh -d database.fasta -c SAMPLE_contigs.fasta -s SAMPLE_NAME --only-reconstruct
```

## Expert Tips and Best Practices

- **Database Preparation**: Use the provided utility script to fetch the latest plasmid sequences: `download_plasmid_database.py -o FOLDER`.
- **Parameter Tuning**:
    - **--explore**: Use this flag if you suspect distant relationships or low-homology plasmids; it relaxes default alignment parameters.
    - **-C (Coverage Cutoff)**: Default is 80%. If you are looking for partial plasmids or mobile elements, lower this value.
    - **-f (Clustering)**: Default is 0.8 (80%). Adjust this to group similar reference plasmids together in the output.
- **Relaunching**: PlasmidID is designed to be "restart-aware." If you change visualization parameters (like `-i` or `-l`) and rerun the command in the same directory, it will skip the expensive mapping/assembly steps and only regenerate the images and tables.
- **Sample Names**: Keep sample names under 37 characters and avoid using dots (`.`) in the name to prevent potential parsing issues in the pipeline.
- **Output Interpretation**:
    - The `SAMPLE_final_results.html` is the primary file for results.
    - **MAPPING %**: Indicates how much of the reference is covered by reads.
    - **Contig Track**: Shows how your assembly matches the reference scaffold. If the "complete contig track" matches the "contig track," it indicates high-quality, full-length alignment.

## Common CLI Options

| Option | Description | Default |
| :--- | :--- | :--- |
| `-g | --group` | Group name for organizing multiple samples | `NO_GROUP` |
| `-o` | Output directory | Current directory |
| `-T | --threads` | Number of CPU threads to use | 1 |
| `-M | --memory` | Maximum memory allowed | - |
| `--no-trim` | Skip Trimmomatic quality trimming | Off |
| `-i` | Minimum identity % for contig annotation | 90 |
| `-l` | Minimum length % for contig annotation | 20 |



## Subcommands

| Command | Description |
|---------|-------------|
| download_plasmid_database.py | Download up to date plasmid database from ncbi ftp |
| plasmidID | reconstruct and annotate the most likely plasmids present in one sample |
| summary_report_pid.py | Creates a summary report in tsv and hml from plasmidID execution |

## Reference documentation
- [Execution Guide](./references/github_com_BU-ISCIII_plasmidID_wiki_Execution.md)
- [How to choose the right plasmids](./references/github_com_BU-ISCIII_plasmidID_wiki_How-to-chose-the-right-plasmids.md)
- [Plasmid Database Setup](./references/github_com_BU-ISCIII_plasmidID_wiki_Plasmid-Database.md)
- [Summary Table and Images](./references/github_com_BU-ISCIII_plasmidID_wiki_Summary-table-and-summary-image.md)