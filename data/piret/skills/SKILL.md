---
name: piret
description: PiReT is a bioinformatics pipeline that automates RNA-seq data processing by integrating tools for alignment, quantification, and differential expression analysis. Use when user asks to process raw sequencing reads, perform gene expression analysis, or identify differentially expressed genes across experimental groups.
homepage: https://github.com/mshakya/PyPiReT
metadata:
  docker_image: "quay.io/biocontainers/piret:0.3.4--r44hdfd78af_3"
---

# piret

## Overview
PiReT is a specialized pipeline designed to streamline RNA-seq data processing. It acts as a wrapper that orchestrates several bioinformatics tools (such as HISAT2, STAR, StringTie, and DESeq2) into a cohesive workflow. You should use this skill when you need to transform raw sequencing reads into biological insights, specifically focusing on gene expression levels and differential analysis. It handles the complexity of tool integration, ensuring that data flows correctly from quality control through to statistical testing.

## Execution Patterns

### Core Command Structure
The primary way to interact with PiReT is through its CLI. Every run requires three main components: a working directory, an experimental design file, and a configuration file.

```bash
piret -d <working_directory> -e <experimental_design.txt> -c <config_file.cfg>
```

### Experimental Design File (-e)
The experimental design file is a tab-delimited text file. It is the most common source of execution errors.
- **Required Columns**: `SampleID`, `Files`, and `Group`.
- **File Paths**: Use absolute paths for the FASTQ files in the `Files` column to avoid path resolution issues.
- **Naming Conventions**: Use only alphanumeric characters and underscores for `SampleID` and `Group`. 
  - **Good**: `samp_1`, `control_group`
  - **Bad**: `samp.1`, `control group`, `samp 1` (these will likely cause pipeline failures).
- **Format**: Always export as "Tab-delimited text". Avoid Excel-specific formatting which introduces hidden characters.

### Configuration File (-c)
PiReT uses Luigi for task management. The configuration file (`.cfg`) defines the parameters for the underlying tools (e.g., aligner settings, feature counting options).
- Ensure the `LUIGI_CONFIG_PATH` environment variable points to your configuration file if you are running complex multi-step tasks or debugging specific modules.

## Expert Tips and Best Practices

### Environment Management
PiReT has specific dependencies (Python 3.6, R, and various bioinformatics binaries). Always ensure you are working within the dedicated conda environment:
```bash
conda activate piret_env
```

### Handling Different Organism Types
PiReT supports Prokarya, Eukarya, or mixed datasets. This is typically toggled within the configuration file and the choice of reference files (GFF/GTF vs. GBK).
- For **Prokaryotes**: Ensure your reference includes functional annotations if you intend to use the `emapper` integration for KO (KEGG Orthology) assignments.
- For **Eukaryotes**: Ensure your configuration specifies an aligner capable of spliced alignment (like STAR or HISAT2).

### Troubleshooting Common Issues
- **Path Errors**: If PiReT cannot find a tool, verify that `samtools`, `hisat2`, and `stringtie` are in your system `$PATH`.
- **Memory/CPU**: RNA-seq alignment is resource-intensive. Ensure the configuration file reflects the available threads on your system to prevent crashes during the alignment phase.
- **Database Setup**: If using functional annotation features, the `eggnog-mapper` database must be downloaded separately using `download_eggnog_data.py` before the first run.

## Reference documentation
- [PiReT GitHub Repository](./references/github_com_mshakya_piret.md)
- [Bioconda PiReT Overview](./references/anaconda_org_channels_bioconda_packages_piret_overview.md)