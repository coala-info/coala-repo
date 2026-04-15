---
name: sistr_cmd
description: The SISTR command-line tool predicts Salmonella serovars and performs high-resolution subtyping from draft genome assemblies. Use when user asks to predict serotypes from Salmonella genomes, perform cgMLST subtyping, or identify antigen gene alleles.
homepage: https://github.com/phac-nml/sistr_cmd/
metadata:
  docker_image: "quay.io/biocontainers/sistr_cmd:1.1.3--pyhdc42f0e_2"
---

# sistr_cmd

## Overview

The Salmonella In Silico Typing Resource (SISTR) command-line tool is a bioinformatics utility designed to replace or augment traditional phenotypic serotyping. It processes draft Salmonella genome assemblies to predict serovars by identifying antigen gene alleles and performing cgMLST subtyping using BLAST. It provides high-resolution subtyping that is critical for outbreak investigations and routine surveillance.

## Installation and Setup

The recommended installation method is via Bioconda to ensure all external dependencies (BLAST+, MAFFT, and Mash) are correctly configured.

```bash
conda install -c bioconda sistr_cmd
```

On the first execution, the tool will automatically download and initialize the required database (antigen genes, cgMLST profiles, and Mash sketches).

## Common CLI Patterns

### Basic Serovar Prediction
To run a standard analysis on a single assembly and output the results in JSON format:
```bash
sistr -f json -o prediction.json input_genome.fasta
```

### Batch Processing
SISTR supports multiple input files. You can process several genomes at once and save the summary to a CSV:
```bash
sistr -f csv -o batch_results.csv genome1.fasta genome2.fasta genome3.fasta
```

### High-Resolution Subtyping
To include cgMLST allelic profiles and novel allele detection in your output:
```bash
sistr -p cgmlst_profiles.csv -n novel_alleles.fasta -o results.json input.fasta
```

## Expert Tips and Best Practices

*   **Performance Optimization**: By default, SISTR uses a "centroid" allele database which is ~10% the size of the full set. Only use the `--use-full-cgmlst-db` flag if you require exhaustive allele matching, as it significantly increases processing time without typically changing the serovar call.
*   **Quality Control**: Always include the `--qc` flag to generate quality control metrics. This helps determine if the assembly quality is sufficient for a reliable serovar prediction.
*   **Mash Integration**: Use the `-m` flag to enable Mash MinHash prediction. This provides an independent line of evidence for the serovar call, which is useful for cross-verifying BLAST-based results.
*   **Parallelization**: Use the `-t` (threads) argument to speed up the BLAST and MAFFT alignment steps, especially when processing large batches of genomes.
*   **Output Formats**: While CSV is good for spreadsheets, the `json` format provides the most comprehensive data structure, including detailed metadata about the antigen and cgMLST matches.

## Reference documentation
- [SISTR Command-line Tool Overview](./references/github_com_phac-nml_sistr_cmd.md)
- [Bioconda sistr_cmd Package](./references/anaconda_org_channels_bioconda_packages_sistr_cmd_overview.md)