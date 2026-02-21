---
name: mitosalt
description: MitoSAlt is a specialized bioinformatics pipeline for detecting large-scale mitochondrial structural alterations.
homepage: https://sourceforge.net/projects/mitosalt/
---

# mitosalt

## Overview
MitoSAlt is a specialized bioinformatics pipeline for detecting large-scale mitochondrial structural alterations. It automates the workflow of aligning sequencing reads to both nuclear and mitochondrial genomes, extracting potential mitochondrial reads, and identifying breakpoints that indicate deletions or duplications. It is a critical tool for researchers investigating mitochondrial diseases, molecular signatures, and heteroplasmy levels in circular genomes.

## Installation and Environment
The most efficient way to install MitoSAlt is via Bioconda:
```bash
conda install bioconda::mitosalt
```

### Database Setup
Before running the pipeline, you must download the reference genomes and indices. Use the provided helper script:
- **Human only**: `download-mitosalt-db.sh -h`
- **Mouse only**: `download-mitosalt-db.sh -m`
- **Both**: `download-mitosalt-db.sh -h -m`

Set the `MITOSALTDATA` environment variable to point to your reference data directory:
```bash
export MITOSALTDATA=/path/to/mitosalt/genomedata
```

## Core CLI Usage
The primary script is `MitoSAlt.pl` for paired-end data and `MitoSAlt_SE.pl` for single-end data.

### Standard Execution
```bash
perl MitoSAlt.pl <config_file> <fastq_1> <fastq_2> <study_name>
```
- **config_file**: Path to the organism-specific configuration (e.g., `config_human.txt`).
- **study_name**: A prefix used for all output files and directories.

### Handling Enriched Data
If your sequencing data is already enriched for mtDNA (e.g., via long-range PCR or bait capture), you should modify the configuration file:
1. Set `enriched` to `yes`.
2. Set `nu_mt` and `cn_mt` to `no` to skip nuclear-mitochondrial filtering and copy number estimation.

## Expert Workflow: Iterative Analysis
You can re-run the scoring and filtering steps without re-aligning the raw reads, which saves significant time.

1. **Initial Run**: Execute the full pipeline to generate the `.tab` alignment file.
2. **Adjustment**: Edit the "SCORING AND FILTERING FEATURES" section in your configuration file (e.g., change heteroplasmy thresholds or clustering distance).
3. **Optimized Re-run**:
   - Set `nu_mt` and `o_mt` to `no` in the config file.
   - Back up previous results in the `indel`, `plot`, and `log` folders.
   - Run the command again using the same `study_name`. The script will detect the existing `.tab` file and jump straight to variant calling.

## Custom Circular Genomes
To use MitoSAlt for non-standard circular genomes:
1. Place the nuclear+mitochondria and mitochondria-only FASTA files in the `genome` directory.
2. Generate indices using `hisat2-build`, `lastdb`, and `samtools faidx`.
3. Update the configuration file with the new genome size and origin of replication coordinates (`orihs`, `orihe`, `orils`, `orile`). Set these to `0` if unknown.

## Interpreting Key Outputs
- **.breakpoint (indel directory)**: Raw list of split-read breakpoints.
- **.cluster (indel directory)**: Grouped breakpoints representing a single deletion/duplication event.
- **.tsv (indel directory)**: The final filtered results including estimated heteroplasmy, event classification (deletion vs. duplication), and repeat sequences at boundaries.
- **Circular Plot**: A visual representation of detected variants color-coded by heteroplasmy.

## Reference documentation
- [MitoSAlt Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mitosalt_overview.md)
- [MitoSAlt README and Technical Manual](./references/sourceforge_net_projects_mitosalt_files.md)