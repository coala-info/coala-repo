---
name: snakealtpromoter
description: SnakeAltPromoter is a Snakemake-based pipeline that automates the identification and quantification of alternative promoter usage from RNA-seq or CAGE data. Use when user asks to set up genomic references for promoter analysis, execute a multi-sample pipeline for differential promoter activity, or process raw sequencing data through alignment and quantification.
homepage: https://github.com/YidanSunResearchLab/SnakeAltPromoter
---

# snakealtpromoter

## Overview

SnakeAltPromoter is a Snakemake-based bioinformatics pipeline designed to streamline the identification and quantification of alternative promoter usage. It automates the complex transition from raw sequencing data to biological insights by integrating preprocessing (FastQC, TrimGalore), alignment (STAR), and specialized promoter analysis modules. Use this skill when you need to set up genomic references for promoter analysis or execute a reproducible, multi-sample pipeline for differential promoter activity studies.

## Core Workflows

### 1. Genome Environment Setup
Before running an analysis, you must prepare the organism-specific indices and promoter annotations using the `Genomesetup` command.

```bash
Genomesetup \
  --organism <Organism_Name> \
  --organism_fasta /path/to/genome.fa \
  --genes_gtf /path/to/genes.gtf \
  --main_chr_file /path/to/main.chr.txt \
  -o ./genome_output_dir \
  --threads 30
```

### 2. Executing the Analysis Pipeline
The main `Snakealtpromoter` command handles the end-to-end processing. The behavior changes significantly based on the input data type (RNA-seq vs. CAGE).

**Standard RNA-seq Analysis:**
```bash
Snakealtpromoter \
  -i /path/to/fastq_directory \
  --genome_dir /path/to/prepared_genome \
  -o ./analysis_results \
  --sample_sheet /path/to/samplesheet.tsv \
  --organism <Organism_Name> \
  --threads 30 \
  --trim
```

**CAGE Data Analysis:**
When working with CAGE data, you must specify the method and read type.
```bash
Snakealtpromoter \
  -i /path/to/cage_fastqs \
  --genome_dir /path/to/prepared_genome \
  -o ./cage_results \
  --sample_sheet /path/to/samplesheet.tsv \
  --method cage \
  --reads single
```

## Expert Tips and Best Practices

- **Sample Sheet Formatting**: Ensure your TSV sample sheet correctly maps sample IDs to their respective FASTQ files. This is the primary mechanism the pipeline uses to resolve wildcards in the Snakemake backend.
- **Resource Allocation**: The `--threads` flag is passed to underlying tools like STAR and Salmon. On HPC clusters, match this value to your requested CPU cores to optimize alignment speed.
- **Preprocessing**: Always use the `--trim` flag for RNA-seq data to invoke TrimGalore, especially if adapter contamination or low-quality bases are suspected, as promoter quantification is sensitive to alignment precision near TSS sites.
- **GUI Alternative**: If you prefer a graphical interface for configuration, use the `sap-ui` command to launch the Streamlit-based web interface.
- **Verification**: Run `Snakealtpromoter --help` to verify the installation and view all available parameters, including specific quantification tool toggles.



## Subcommands

| Command | Description |
|---------|-------------|
| Genomesetup | Execute the AltPromoterFlow genome setup pipeline to generate genome indices and annotations. |
| Snakealtpromoter | Run a comprehensive pipeline for alternative promoter analysis. |

## Reference documentation
- [SnakeAltPromoter README](./references/github_com_YidanSunResearchLab_SnakeAltPromoter_blob_main_README.md)
- [Snakealtpromoter CLI Guide](./references/github_com_YidanSunResearchLab_SnakeAltPromoter_blob_main_snakealtpromoter_docs_Snakealtpromoter.md)
- [Genomesetup Documentation](./references/github_com_YidanSunResearchLab_SnakeAltPromoter_blob_main_snakealtpromoter_docs_Genomesetup.md)