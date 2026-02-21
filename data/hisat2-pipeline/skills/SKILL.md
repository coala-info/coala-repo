---
name: hisat2-pipeline
description: The `hisat2-pipeline` is a streamlined wrapper designed to automate the standard RNA-seq bioinformatics workflow.
homepage: https://github.com/mcamagna/HISAT2-pipeline
---

# hisat2-pipeline

## Overview
The `hisat2-pipeline` is a streamlined wrapper designed to automate the standard RNA-seq bioinformatics workflow. It integrates HISAT2 for alignment and StringTie for transcript quantification into a single execution path. This tool is ideal for users who require a rapid, "best-practices" analysis without writing custom bash scripts. It handles index generation, read mapping, BAM conversion, and the merging of expression data (FPKM and TPM) into final tables.

## Directory Setup
By default, the pipeline expects a specific folder structure in your current working directory. Organizing your data this way allows you to run the tool without any arguments.

```text
project_root/
├── genome/
│   ├── reference.fasta (or .gz, .bz2, .xz)
│   └── annotation.gff (or .gz)
└── reads/
    └── sample_R1.fastq.gz (supports .fq, .fastq, and subfolders)
```

## Common CLI Patterns

### Basic Execution
Run the pipeline using default settings and the standard directory structure:
```bash
hisat2-pipeline
```
*Note: The tool will prompt for confirmation of inferred settings before starting unless suppressed.*

### Custom Paths
If your data is organized differently, specify the paths manually:
```bash
hisat2-pipeline --reads_folder /path/to/reads --genome_folder /path/to/genome --outfolder /path/to/results
```

### Passing Advanced Tool Options
You can pass specific flags directly to the underlying engines. Ensure options are enclosed in quotes:
```bash
hisat2-pipeline --hisat_options "--very-sensitive --no-spliced-alignment" --stringtie_options "-m 150 -t"
```

### Non-Interactive/Automated Runs
For use in larger scripts or HPC environments where user input is not possible:
```bash
hisat2-pipeline --yes
```

## Expert Tips & Best Practices

- **Read Trimming:** The pipeline does not include a trimming step (e.g., Trimmomatic or Cutadapt). HISAT2 handles soft-clipping well, but if your library has significant adapter contamination, trim your reads *before* running this pipeline.
- **Compressed Files:** The pipeline natively supports various compression formats for both reads and genomes, including `.gz`, `.bz2`, and `.xz`. There is no need to decompress files beforehand.
- **Recursive Detection:** The tool automatically searches for reads in subfolders within the designated reads directory, making it useful for complex project structures.
- **Output Analysis:** 
    - Check `./mapping/mapping_summary` for a consolidated alignment report across all samples.
    - Expression values are provided in both tab-separated (`.tsv`) and Excel (`.xlsx`) formats in the `./abundance` folder, including merged matrices for easy downstream differential expression analysis.

## Reference documentation
- [HISAT2-pipeline GitHub Repository](./references/github_com_mcamagna_HISAT2-pipeline.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hisat2-pipeline_overview.md)