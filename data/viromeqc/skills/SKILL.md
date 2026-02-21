---
name: viromeqc
description: ViromeQC is a quality control tool designed to benchmark the enrichment of viral metagenomes.
homepage: https://github.com/SegataLab/viromeqc
---

# viromeqc

## Overview
ViromeQC is a quality control tool designed to benchmark the enrichment of viral metagenomes. It quantifies contamination by mapping reads against a curated collection of prokaryotic markers, including SSU rRNA, LSU rRNA, and single-copy bacterial genes. By comparing these abundances to reference metagenomes, it calculates an enrichment score that indicates how many times more "viral" a sample is compared to a standard metagenome.

## Installation and Setup
The tool is available via Bioconda. Before the first run, you must download and index the required marker databases.

```bash
# Install via conda
conda install bioconda::viromeqc

# Mandatory: Install the database (required once)
viromeQC.py --install
```

## Core Usage Patterns

### Basic Enrichment Analysis
Run ViromeQC on raw FASTQ reads (supports `.gz` and `.bz2`).

```bash
viromeQC.py -i sample_R1.fastq.gz sample_R2.fastq.gz -o enrichment_report.txt
```

### Selecting Enrichment Presets
The tool uses different reference medians based on the sample source. Use the `-w` or `--enrichment_preset` flag to match your sample type:
*   `human`: (Default) Uses human microbiome metagenomes as the baseline.
*   `environmental`: Uses environmental metagenomes as the baseline.

```bash
viromeQC.py -i env_sample.fq -w environmental -o env_report.txt
```

### Performance Tuning
ViromeQC utilizes Bowtie2 and Diamond. Adjust threads to speed up the alignment phases:

```bash
viromeQC.py -i input.fq -o report.txt --bowtie2_threads 8 --diamond_threads 8
```

### Quality and Length Filtering
By default, the tool filters reads shorter than 75bp and with an average Phred quality below 20. Adjust these if working with specific sequencing technologies:

```bash
viromeQC.py -i input.fq -o report.txt --minlen 50 --minqual 25
```

## Interpreting Results
The output is a TSV file containing alignment percentages for SSU, LSU, and bacterial markers.

*   **Total Enrichment Score**: The final value represents the enrichment factor.
*   **Score > 10**: Generally reflects high VLP enrichment.
*   **Score ~ 1**: Indicates the sample has a similar prokaryotic load to a standard metagenome (low enrichment).
*   **Score < 1**: Indicates the sample is less enriched for viruses than a typical metagenome.

## Expert Tips
*   **Single Sample Processing**: While you can pass multiple files (e.g., R1 and R2) to the `-i` flag, ViromeQC processes them as a single sample. To process multiple distinct samples, use a loop or a parallelization tool like GNU Parallel.
*   **Custom Baselines**: If the default human or environmental medians are not suitable, you can modify the `medians.csv` file in the installation directory to provide your own reference data.
*   **Temporary Files**: Use `--tempdir` if your system's default `/tmp` directory has limited space, as the alignment steps can generate large intermediate files.

## Reference documentation
- [ViromeQC GitHub Repository](./references/github_com_SegataLab_viromeqc.md)
- [ViromeQC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_viromeqc_overview.md)