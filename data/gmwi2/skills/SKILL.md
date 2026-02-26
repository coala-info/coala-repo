---
name: gmwi2
description: GMWI2 predicts health status and calculates wellness scores from stool shotgun metagenomic data or existing taxonomic profiles. Use when user asks to predict health status from metagenomes, calculate a gut microbiome wellness index, or process MetaPhlAn results into wellness scores.
homepage: https://github.com/danielchang2002/GMWI2
---


# gmwi2

## Overview
GMWI2 (Gut Microbiome Wellness Index 2) is a command-line tool designed to predict health status based on taxonomic profiles derived from stool shotgun metagenomes. It automates a complex pipeline including sequence quality control (adapter removal and human DNA filtering), taxonomic profiling using MetaPhlAn3, and the application of a Lasso-penalized logistic regression model trained on over 8,000 samples. Use this skill to process raw sequencing data into a standardized wellness score or to compute scores from pre-existing MetaPhlAn results.

## Installation and Setup
GMWI2 should be installed in an isolated environment to avoid dependency conflicts, particularly with MetaPhlAn3.

```bash
# Create and activate environment
conda create --name gmwi2_env -c conda-forge mamba python=3.8
conda activate gmwi2_env

# Install GMWI2
mamba install -c bioconda -c conda-forge gmwi2=1.6
```

**Note**: On the first run, the tool will download necessary marker databases (approx. 20 minutes). It is recommended to run a test sample once before launching large batch jobs to ensure databases are initialized.

## Core Command Usage
The primary workflow accepts paired-end FASTQ files.

```bash
gmwi2 -f <forward.fastq> -r <reverse.fastq> -n <threads> -o <output_prefix>
```

### Required Arguments
- `-f, --forward`: Path to the forward-read file (.fastq or .fastq.gz).
- `-r, --reverse`: Path to the reverse-read file (.fastq or .fastq.gz).
- `-n, --num_threads`: Number of CPU threads to utilize.
- `-o, --output_prefix`: Prefix for the generated output files.

### Output Files
The tool produces three primary outputs:
1. `<prefix>_GMWI2.txt`: The final calculated wellness score.
2. `<prefix>_GMWI2_taxa.txt`: List of taxa identified in the sample used for the score.
3. `<prefix>_metaphlan.txt`: The raw MetaPhlAn3 taxonomic profiling results.

## Advanced Workflows

### Processing Existing MetaPhlAn Outputs
If you have already performed taxonomic profiling, you can bypass the QC and profiling steps. Ensure you used MetaPhlAn3 (v3.0.13) with the `mpa_v30_CHOCOPhlAn_201901` database.

```bash
# Download the required script and model
wget https://raw.githubusercontent.com/danielchang2002/GMWI2/main/src/gmwi2_metaphlan_output.py
wget https://raw.githubusercontent.com/danielchang2002/GMWI2/main/src/GMWI2/GMWI2_databases/GMWI2_model.joblib

# Run the computation
python3 gmwi2_metaphlan_output.py <metaphlan_output.txt> GMWI2_model.joblib <output_prefix>
```

### Merging Results for Multiple Samples
To aggregate scores from multiple runs into a single CSV for downstream analysis:

```bash
echo "Sample,GMWI2" > merged_scores.csv
for file in *_GMWI2.txt; do
    sample_name=$(basename "$file" | sed 's/_GMWI2.txt//')
    score=$(cat "$file")
    echo "$sample_name,$score" >> merged_scores.csv
done
```

## Best Practices and Tips
- **Resource Allocation**: MetaPhlAn3 and Bowtie2 (used internally) are CPU-intensive. Assign at least 8-16 threads (`-n`) for reasonable processing times on standard metagenomes.
- **Input Integrity**: Ensure FASTQ files are properly paired. The tool performs human DNA removal using the GRCh38/hg38 reference; if working with non-human primates or other hosts, the internal QC may need manual adjustment outside the standard wrapper.
- **Database Persistence**: If running in a containerized or HPC environment, ensure the directory where GMWI2 downloads its databases is persistent or pre-populated to avoid repeated 20-minute downloads.

## Reference documentation
- [GMWI2 GitHub README](./references/github_com_danielchang2002_GMWI2.md)
- [Bioconda GMWI2 Package Overview](./references/anaconda_org_channels_bioconda_packages_gmwi2_overview.md)