---
name: figaro
description: Figaro automates the selection of optimal trimming parameters for microbiome sequencing data by analyzing quality scores to maximize read retention and overlap. Use when user asks to determine truncation positions for FASTQ files, optimize DADA2 trimming parameters, or calculate read filtering thresholds based on amplicon length.
homepage: https://github.com/Zymo-Research/figaro
metadata:
  docker_image: "quay.io/biocontainers/figaro:1.1.2--hdfd78af_0"
---

# figaro

## Overview
Figaro is a specialized utility that automates the selection of optimal trimming parameters for microbiome sequencing data. Instead of using trial-and-error, it performs an objective analysis of the quality scores across a directory of FASTQ files. It calculates the best positions to truncate forward and reverse reads to maximize the number of reads passing quality filters while ensuring sufficient overlap remains for successful merging in downstream tools like DADA2.

## Installation
Install via Bioconda or clone the repository for manual setup:

```bash
# Conda installation
conda install bioconda::figaro

# Manual installation
git clone https://github.com/Zymo-Research/figaro.git
cd figaro
pip3 install -r requirements.txt
```

## Command Line Usage
Run Figaro by pointing it to a directory of paired-end FASTQ files. You must provide the expected amplicon length and primer lengths.

### Basic Syntax
```bash
python3 figaro.py -i <input_directory> -o <output_directory> -a <amplicon_length> -f <forward_primer_length> -r <reverse_primer_length>
```

### Key Arguments
- `-i`: Path to the directory containing paired-end FASTQ files.
- `-o`: Path to the directory where output files (JSON) will be saved.
- `-a`: The length of the amplified sequence target (excluding primers).
- `-f`: Length of the forward primer.
- `-r`: Length of the reverse primer.
- `-m`: Minimum overlap required for merging (default is 20).
- `-p`: The percentile to target for read filtering (default is 83).

## Docker Usage
The official recommendation is to use the containerized version to avoid environment conflicts.

```bash
docker container run --rm \
  -e AMPLICONLENGTH=[length] \
  -e FORWARDPRIMERLENGTH=[length] \
  -e REVERSEPRIMERLENGTH=[length] \
  -v /path/to/fastqs:/data/input \
  -v /path/to/output:/data/output \
  figaro
```

### Environment Variables
- `AMPLICONLENGTH`: (Required) Target sequence length without primers.
- `FORWARDPRIMERLENGTH`: (Required) Forward primer length.
- `REVERSEPRIMERLENGTH`: (Required) Reverse primer length.
- `MINIMUMOVERLAP`: Overlap for merging (default 20).
- `PERCENTILE`: Target percentile for filtering (default 83).
- `OUTPUTFILENAME`: Name of the resulting JSON file (default `trimParameters.json`).

## Best Practices
- **Data Consistency**: Only process reads from the same sequencing run and library preparation method in a single directory. Different runs often require different optimal parameters.
- **Amplicon Length**: For targets with biological length variation (like ITS), use the longest expected size to ensure the tool accounts for the largest possible fragments.
- **File Naming**: Ensure files follow the Illumina naming standard (e.g., `_L001_R1_001.fastq.gz`) so Figaro can correctly pair forward and reverse reads.
- **Overlap Trade-off**: Remember that increasing the required overlap (`-m`) forces the tool to keep more of the 3' ends, which typically have lower quality scores, potentially reducing the overall number of reads that pass filtering.

## Reference documentation
- [Figaro GitHub Repository](./references/github_com_Zymo-Research_figaro.md)
- [Bioconda Figaro Overview](./references/anaconda_org_channels_bioconda_packages_figaro_overview.md)