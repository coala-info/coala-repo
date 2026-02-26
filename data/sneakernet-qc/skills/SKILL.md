---
name: sneakernet-qc
description: SneakerNet is a modular pipeline that automates quality control, assembly, and genomic analysis for primary sequencing data. Use when user asks to initialize a project directory from raw reads, run QC plugins, detect contamination, or perform AMR genotyping.
homepage: https://github.com/lskatz/sneakernet
---


# sneakernet-qc

## Overview
SneakerNet is a modular Perl-based pipeline designed to automate the QC process for primary genomic and metagenomic read data. It transforms raw sequencing folders into standardized project directories and executes a series of plugins to assess read quality, detect contamination, perform assembly, and predict antimicrobial resistance (AMR) genotypes. It is optimized for high-throughput environments where consistent, multi-step analysis is required for every sequencing run.

## Project Initialization
Before running the QC pipeline, raw data must be organized into a SneakerNet-formatted project directory.

- **Standard Initialization**: Use `SneakerNet.roRun.pl` to parse a raw MiSeq/HiSeq/Ion Torrent directory.
  ```bash
  SneakerNet.roRun.pl --createsamplesheet -o ProjectName-Year-Ordinal /path/to/raw/run/dir
  ```
- **Naming Convention**: Project folders should ideally follow a dash-delimited format: `[Machine]-[Year]-[Ordinal]-[OptionalName]`.
- **File Requirements**: Fastq files must use the `_R1_` and `_R2_` naming convention for the parser to correctly identify pairs.

## Running the Pipeline
The primary execution engine is `SneakerNetPlugins.pl`.

- **Basic Execution**:
  ```bash
  SneakerNetPlugins.pl --numcpus 8 /path/to/SneakerNet/project/dir
  ```
- **Logging**: It is best practice to redirect output to a log file and monitor it.
  ```bash
  SneakerNetPlugins.pl --numcpus 8 /path/to/project > project/SneakerNet.log 2>&1 &
  tail -f project/SneakerNet.log
  ```
- **Docker Usage**: When using the containerized version, ensure the Kraken database and project directories are correctly mounted.
  ```bash
  docker run --rm -v $PWD:/data -v $KRAKEN_DB:/kraken-database lskatz/sneakernet:latest SneakerNetPlugins.pl --numcpus 12 /data/project_folder
  ```

## Configuration and Customization
SneakerNet behavior is controlled via a configuration file named `snok.txt` located within the project directory.

- **Email Notifications**: Add a comma-separated list of recipients.
  ```bash
  echo "emails = analyst@example.com, supervisor@example.com" > project_dir/snok.txt
  ```
- **Workflow Selection**: Define which set of plugins to run (e.g., `default`, `assembly-only`).
  ```bash
  echo "workflow = default" >> project_dir/snok.txt
  ```
- **Disabling Steps**: Use CLI flags to skip specific post-processing steps like file transfers or emails.
  ```bash
  SneakerNetPlugins.pl --no email --no transfer project_dir
  ```

## Expert Tips
- **Plugin Architecture**: Each step (Kraken, StarAMR, Shovill) is a standalone plugin. If a specific analysis fails, you can often re-run just that plugin script if the environment is sourced correctly.
- **Base Balance**: Pay close attention to the base balance report; a significant deviation from a 1:1 ratio in A/T or C/G can indicate library prep issues or sequencing artifacts.
- **Contamination Checks**: SneakerNet uses a dual-check system: Kraken for taxonomic distribution and ColorID/MLST to ensure only one instance of conserved genes exists. If these disagree, manual inspection of the assembly is required.

## Reference documentation
- [SneakerNet GitHub Repository](./references/github_com_lskatz_SneakerNet.md)
- [Bioconda SneakerNet-QC Overview](./references/anaconda_org_channels_bioconda_packages_sneakernet-qc_overview.md)