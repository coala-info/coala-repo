---
name: fusioncatcher
description: FusionCatcher identifies somatic fusion genes in RNA-seq data while automatically filtering out false positives. Use when user asks to find candidate fusion genes, process raw NGS reads for gene fusions, or detect chromosomal rearrangements in diseased samples.
homepage: https://github.com/ndaniel/fusioncatcher
metadata:
  docker_image: "quay.io/biocontainers/fusioncatcher:1.33--hdfd78af_6"
---

# fusioncatcher

## Overview
FusionCatcher is a specialized bioinformatic pipeline designed to identify somatic fusion genes in RNA-seq data from diseased samples. It is highly automated, performing adapter detection, quality trimming, and exon-exon junction building without requiring extensive manual parameter tuning. It excels at filtering out false positives by leveraging databases of known fusions in healthy samples and biological knowledge (e.g., ignoring fusions between a gene and its pseudogene). Use this skill when you need to process raw NGS reads to find candidate fusion genes with high RT-PCR validation potential.

## Installation and Setup

### 1. Environment Installation
The preferred method is via Conda/Bioconda to manage the complex dependencies (Python 2.7, BioPython, Java, etc.):
```bash
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda create -n fusioncatcher fusioncatcher
source activate fusioncatcher
```

Alternatively, use the automated bootstrap script:
```bash
wget http://sf.net/projects/fusioncatcher/files/bootstrap.py -O bootstrap.py
python bootstrap.py -t --download -y
```

### 2. Database Preparation
FusionCatcher requires a specific organism database (typically human) to function. This must be downloaded before running the analysis:
```bash
# If installed via Conda, the script should be in your PATH
download-human-db.sh
```

## Common CLI Patterns

### Basic Analysis
FusionCatcher is designed to be "point and shoot." You typically point it at a directory containing your FASTQ files:
```bash
fusioncatcher -i /path/to/fastq/files/ -o /path/to/output/directory/
```

### Expert Configuration
*   **Input Formats**: Supports paired-end or single-end reads from Illumina platforms (Solexa, HiSeq, NextSeq, MiSeq, MiniSeq).
*   **Matched Normal**: While optional, providing a matched normal sample can improve the detection of somatic mutations.
*   **Automatic Optimization**: The tool automatically detects adapters and trims reads based on quality. It also builds exon-exon junctions dynamically based on the input read length.

## Best Practices and Tips
*   **System Requirements**: Ensure you have sufficient disk space for the human database and intermediate alignment files.
*   **Dependencies**: If installing from source, ensure `Python 2.7.x`, `BioPython (>v1.5)`, and `JRE 1.8` are available.
*   **Validation**: FusionCatcher is optimized for a high RT-PCR validation rate. When reviewing results, prioritize candidates that have passed the internal biological filters (e.g., those not flagged as pseudogene fusions).
*   **Troubleshooting**: If the database download fails, check the Ensembl FTP status, as the `get_synonyms.py` and `get_genome.py` scripts rely on active Ensembl connections.

## Reference documentation
- [FusionCatcher GitHub README](./references/github_com_ndaniel_fusioncatcher.md)
- [FusionCatcher Wiki Home](./references/github_com_ndaniel_fusioncatcher_wiki.md)
- [Bioconda FusionCatcher Overview](./references/anaconda_org_channels_bioconda_packages_fusioncatcher_overview.md)