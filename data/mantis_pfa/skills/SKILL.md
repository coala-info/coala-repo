---
name: mantis_pfa
description: MANTIS is a protein functional annotation tool that integrates multiple reference databases to provide high-quality consensus results for genomes and metagenomes. Use when user asks to annotate protein sequences, set up or manage reference databases, and execute functional annotation workflows for single or multiple samples.
homepage: https://github.com/PedroMTQ/Mantis
---

# mantis_pfa

## Overview
MANTIS is a standalone protein functional annotation tool that integrates multiple reference databases to provide high-quality consensus results. It is particularly useful for researchers who need to annotate assembled genomes or metagenomes by matching protein-coding regions against HMM or Diamond databases. This skill provides the necessary command-line workflows to set up the environment, manage reference databases, and execute annotation runs for single or multiple samples.

## Core Workflows

### 1. Environment Setup and Initialization
Before running annotations, the local environment and databases must be prepared.
- **Installation**: Ensure the tool is available via bioconda: `conda install -c bioconda mantis_pfa`.
- **Database Setup**: Download and index the required reference datasets:
  ```bash
  mantis setup
  ```
- **Verification**: Confirm the installation and SQL metadata integrity:
  ```bash
  mantis check
  mantis check_sql
  ```

### 2. Running Annotations
MANTIS requires protein sequences in FASTA format (`.faa`). If you have raw reads, they must be assembled and genes predicted (e.g., via Prodigal) before using this tool.

- **Single Sample**:
  ```bash
  mantis run -i target.faa -o output_folder -od "Organism Name"
  ```
- **Multiple Samples**: Use a TSV file containing paths to multiple FASTA files:
  ```bash
  mantis run -i samples_list.tsv -o output_folder
  ```

### 3. Customization and Configuration
You can extend MANTIS by adding custom HMM or Diamond references.
- **Custom References**: Add paths to `config/MANTIS.cfg` or place files in the `Mantis/References/Custom_references/` directory.
- **Metadata**: For custom references to be fully integrated, include a `metadata.tsv` file within the specific reference folder.

## Output Interpretation
MANTIS generates three primary TSV files in the output directory:
- `output_annotation.tsv`: Raw hits with coordinates and e-values.
- `integrated_annotation.tsv`: Hits combined with their respective metadata.
- `consensus_annotation.tsv`: The final "best-hit" consensus (one line per query sequence).

## Expert Tips
- **MacOS Compatibility**: If running on macOS, ensure you are using Python 3.7.
- **Resource Management**: Use the `-et` (e-value threshold) and `-ov` (overlap value) flags to fine-tune the sensitivity and specificity of the annotation if the default consensus is too broad or too strict.
- **Metagenomes**: MANTIS scales well for metagenomic data; ensure your input is a protein FASTA derived from your metagenome assembly.



## Subcommands

| Command | Description |
|---------|-------------|
| mantis | Mantis is a k-mer based sequence analysis tool. |
| mantis | Mantis is a k-mer based sequence analysis tool. |
| mantis | Mantis is a k-mer based sequence analysis tool. |
| mantis | Mantis is a k-mer based sequence analysis tool. |

## Reference documentation
- [MANTIS GitHub Home](./references/github_com_PedroMTQ_Mantis.md)
- [MANTIS Wiki](./references/github_com_PedroMTQ_Mantis_wiki.md)