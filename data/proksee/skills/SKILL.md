---
name: proksee
description: Proksee is an expert-system command-line suite for the automated assembly and evaluation of microbial genomes. Use when user asks to assemble raw sequencing reads into high-quality genomes, evaluate the quality of existing assemblies, or initialize the Mash sketch database.
homepage: https://github.com/proksee-project/proksee-cmd
metadata:
  docker_image: "quay.io/biocontainers/proksee:1.0.0a2--pyhdfd78af_0"
---

# proksee

---

## Overview

Proksee is an expert-system command-line suite designed for the automated assembly and evaluation of microbial genomes. It streamlines the process of turning raw sequencing reads into high-quality assemblies by employing a tiered pipeline approach. The system is capable of identifying sequencing platforms, estimating species, filtering reads, and performing comparative evaluations between fast and expert assembly stages. It is an essential tool for bioinformaticians requiring a standardized, reproducible workflow for bacterial genome reconstruction.

## Core Workflows

### 1. Database Initialization
Before running any assembly or evaluation tasks, the Mash sketch database must be downloaded and installed.
```bash
proksee updatedb
```

### 2. Genome Assembly
The `assemble` command runs a three-stage pipeline: Pre-Assembly (validation and species estimation), Fast Assembly (approximate metrics and contamination check), and Expert Assembly (high-quality final output).

**Basic Usage:**
```bash
proksee assemble -o output_directory forward_reads.fastq reverse_reads.fastq
```

**Key Options:**
- **Species Specification**: Use `-s` or `--species` with the exact scientific name (e.g., `'Listeria monocytogenes'`) to bypass automated species estimation.
- **Platform Selection**: Use `-p` or `--platform` to specify 'Illumina', 'Pac Bio', or 'Ion Torrent'.
- **Resource Management**: Control performance with `-t` (threads) and `-m` (memory in GB).
- **Bypassing Safeguards**: Use `--force` to continue the pipeline if Proksee detects contamination or unusual assembly statistics that would normally trigger termination.

### 3. Assembly Evaluation
The `evaluate` command assesses the quality of existing assembled contigs using metrics like N50 and L50.

**Basic Usage:**
```bash
proksee evaluate -o output_directory assembly.fasta
```

## Best Practices and Expert Tips

- **Input Validation**: Proksee will terminate early if it detects incorrect sequence encoding during the Pre-Assembly stage. Ensure your FASTQ files are properly formatted and not corrupted.
- **Handling Contamination**: If the pipeline terminates during Fast Assembly, it is often because large contigs disagree with the estimated species. Review the `assembly_info.json` to identify the source of the conflict.
- **Expert Assembly Deviations**: The Expert Assembly stage compares results against RefSeq-included assemblies. If your assembly falls outside the 5th to 95th percentile for that species, the pipeline may stop unless `--force` is used.
- **Output Interpretation**:
    - `contigs.fasta`: Your final high-quality expert assembly.
    - `assembly_statistics.csv`: Contains comparative metrics for all stages.
    - `assembly_info.json`: Use this for downstream automated parsing of the assembly results.



## Subcommands

| Command | Description |
|---------|-------------|
| proksee assemble | Assemble reads into a genome. |
| proksee evaluate | Evaluate assembly quality |
| proksee updatedb | Update the proksee database |

## Reference documentation
- [Proksee README](./references/github_com_proksee-project_proksee-cmd_blob_develop_README.md)
- [Assemble Tool Documentation](./references/github_com_proksee-project_proksee-cmd_blob_develop_docs_tools_assemble.md)
- [Evaluate Tool Documentation](./references/github_com_proksee-project_proksee-cmd_blob_develop_docs_tools_evaluate.md)