---
name: snakealtpromoter
description: SnakeAltPromoter is a Snakemake-powered bioinformatics pipeline designed to automate the complex workflow of alternative promoter analysis.
homepage: https://github.com/YidanSunResearchLab/SnakeAltPromoter
---

# snakealtpromoter

## Overview

SnakeAltPromoter is a Snakemake-powered bioinformatics pipeline designed to automate the complex workflow of alternative promoter analysis. It handles the entire process from raw read preprocessing (QC and trimming) to the statistical identification of differential promoter usage. This skill helps users navigate the two-step command-line process: preparing the genomic environment and executing the analysis pipeline. It is ideal for researchers who need a reproducible and scalable way to compare promoter activity in large multi-sample datasets using established quantification methods.

## Core Commands and Workflow

The pipeline follows a strict two-step execution pattern.

### 1. Genome Environment Setup
Before processing sequencing data, you must generate the necessary indices and promoter annotations.

```bash
Genomesetup \
  --organism <org_id> \
  --organism_fasta /path/to/genome.fa \
  --genes_gtf /path/to/genes.gtf \
  -o /path/to/genome_index_dir \
  --threads 30
```

### 2. Pipeline Execution
Once the genome directory is prepared, run the main analysis. The tool supports both RNA-seq and CAGE data.

**Standard RNA-seq Analysis:**
```bash
Snakealtpromoter \
  -i /path/to/fastq_directory \
  --genome_dir /path/to/genome_index_dir \
  -o /path/to/output_results \
  --sample_sheet /path/to/samplesheet.tsv \
  --organism <org_id> \
  --threads 30 \
  --trim
```

**CAGE Data Analysis:**
For CAGE data, you must specify the method and read type:
```bash
Snakealtpromoter \
  -i /path/to/cage_fastqs \
  --genome_dir /path/to/genome_index_dir \
  -o /path/to/output_results \
  --sample_sheet /path/to/samplesheet.tsv \
  --method cage \
  --reads single \
  --organism <org_id>
```

## Best Practices and Expert Tips

- **Sample Sheet Configuration**: Ensure your `samplesheet.tsv` is a tab-separated file. It is the primary way the pipeline maps FASTQ files to experimental conditions for differential analysis.
- **Read Trimming**: Always use the `--trim` flag for RNA-seq data to invoke TrimGalore, especially if the data has not been pre-processed for adapters.
- **Resource Management**: The pipeline is highly parallelized. Match the `--threads` argument to your HPC or workstation capabilities to significantly reduce processing time for STAR alignment and quantification.
- **Quantification Methods**: By default, the pipeline integrates ProActiv, DEXSeq, and Salmon. If you are looking for specific promoter classifications (major vs. minor), check the generated tables in the output directory.
- **GUI Alternative**: If you prefer a graphical interface for configuration, you can launch the built-in UI using the command `sap-ui`.
- **Pathing**: Use absolute paths for the input directory (`-i`), genome directory (`--genome_dir`), and sample sheet to avoid Snakemake execution errors related to working directory shifts.

## Reference documentation
- [SnakeAltPromoter Overview](./references/anaconda_org_channels_bioconda_packages_snakealtpromoter_overview.md)
- [SnakeAltPromoter GitHub Repository](./references/github_com_YidanSunResearchLab_SnakeAltPromoter.md)