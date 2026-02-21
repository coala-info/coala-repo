---
name: virprof
description: VirProf is a specialized bioinformatics tool designed to bridge the gap between host transcriptomics and pathogen discovery.
homepage: https://github.com/seiboldlab/virprof
---

# virprof

## Overview
VirProf is a specialized bioinformatics tool designed to bridge the gap between host transcriptomics and pathogen discovery. It integrates host read depletion with unguided metagenomic assembly and BLAST-based classification. While optimized for respiratory viruses, it is capable of identifying commensal microbes and other viral sequences within poly-A selected or total RNA-seq datasets.

## Installation and Setup
VirProf is primarily distributed via Bioconda and containerized environments.

- **Conda**: `conda install bioconda::virprof`
- **Apptainer/Singularity**: `apptainer pull library://epruesse/default/virprof`
- **Database Requirement**: Requires the NCBI NT BLAST database (approx. 100GB unpacked). Use a symlink to point the tool to your local copy:
  ```bash
  cd databases && ln -s /path/to/your/NT_folder nt
  ```

## Core CLI Patterns

### Initializing Test Environments
To verify installation and directory structure, use the `init-test` command:
```bash
virprof init-test --force .
```
This populates the current directory with a tiny example dataset, a mock BLAST database, and default configuration files.

### Running the Pipeline
VirProf uses `ymp` (a Snakemake wrapper) to manage its stages. The standard execution follows this pattern:
```bash
./virprof_latest.sif ymp make <project>.<reference>.<pipeline>.pathogen --ri -j <threads>
```

**Common Pipeline Slugs:**
- `rnaseq_salmon`: Standard RNA-seq processing.
- `salmon_sa`: Salmon in Selective Alignment mode.
- `pathogen`: The final stage for virus identification and genome recovery.

### Sample Configuration
Samples must be defined in a CSV, TSV, or Excel sheet.
- **Required Column**: `sample` (unique identifier).
- **Standard Columns**: `unit`, `fq1` (forward reads), `fq2` (reverse reads).
- **Metadata**: Any additional columns added to the sample sheet will be preserved in the final RDS output.

## Interpreting Results
Outputs are consolidated in the `reports/` directory with the naming convention: `<project>.<pipeline>.<version>.<result>.<date>.<ext>`.

- **pathogens.xlsx**: The primary human-readable summary of detected viruses.
- **pathogens.rds**: Complete R object for downstream statistical analysis.
- **genomes/**: A directory containing multi-FASTA files of recovered viral genomes, grouped by species.
- **gene_counts.rds**: A `SummarizedExperiment` object containing host gene expression data, compatible with DESeq2.
- **vp_multiqc_report.html**: Quality control metrics specifically for the pathogen detection workflow.

## Expert Tips
- **Rerunning**: Always use the `--ri` (rerun interrupted) flag when resuming a job to ensure Snakemake correctly identifies and completes unfinished tasks.
- **Resource Management**: Use the `-j` flag to specify thread count. For large-scale NT BLAST searches, ensure the system has sufficient RAM to handle the database index.
- **Whitelisting**: The tool uses a `respiratory_virus_whitelist.txt` by default. This can be modified to focus the classification on specific pathogens of interest.

## Reference documentation
- [VirProf GitHub Repository](./references/github_com_seiboldlab_virprof.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_virprof_overview.md)