---
name: confindr
description: ConFindr identifies bacterial sequencing sample contamination by detecting multiple alleles of core, single-copy genes. Use when user asks to check for sample contamination, identify multiple strains in a sequencing run, or run contamination reports using rMLST databases.
homepage: https://github.com/lowandrew/ConFindr
metadata:
  docker_image: "quay.io/biocontainers/confindr:0.8.2--pyhdfd78af_0"
---

# confindr

## Overview

ConFindr is a bioinformatics tool designed to identify whether a bacterial sequencing sample is contaminated with DNA from another strain of the same species or a different species. It achieves this by identifying multiple alleles of core, single-copy genes (such as rMLST genes). If more than one allele is found for these genes, it indicates the presence of multiple organisms. This skill provides guidance on executing ConFindr via the command line, managing databases, and interpreting the contamination reports.

## Installation and Setup

Install ConFindr using Conda from the Bioconda channel:

```bash
conda create -n confindr -c bioconda confindr
conda activate confindr
```

Note: While ConFindr includes experimental databases for *Escherichia*, *Salmonella*, and *Listera*, it is highly recommended to use the rMLST database for validated results.

## Common CLI Patterns

### Basic Contamination Check
Run ConFindr on a directory containing paired-end FastQ files. By default, it looks for `_R1` and `_R2` identifiers.

```bash
confindr -i /path/to/fastq_folder -o /path/to/output_report --rmlst
```

### Handling Custom Read Naming
If your sequencing files use different naming conventions (e.g., `_1.fastq.gz` and `_2.fastq.gz`), specify the identifiers:

```bash
confindr -i ./reads -o ./results --forward_id _1 --reverse_id _2 --rmlst
```

### Resource Management
For large datasets, increase the thread count to speed up the conserved gene searching process:

```bash
confindr -i ./reads -o ./results --threads 8 --rmlst
```

### Running without rMLST (Experimental)
If you do not have the rMLST database, you can run ConFindr on *Escherichia*, *Salmonella*, or *Listera* samples using the built-in core-gene databases:

```bash
confindr -i ./test_samples -o ./test_out
```

## Interpreting Results

The primary output is `confindr_report.csv` located in the specified output folder. Key columns to inspect include:

- **Sample**: The name of the analyzed sample.
- **ContamStatus**: Indicates "Clean" or "Contaminated".
- **NumContamSNVs**: The number of single nucleotide variants found in core genes.
- **NumGenesPresent**: How many core genes were successfully identified.

## Expert Tips

- **Database Location**: If you have downloaded the rMLST database to a specific location, point ConFindr to it using the `-d` or `--databases` flag to avoid re-downloading or path errors.
- **Input Structure**: Ensure the input directory contains only the reads you wish to analyze. ConFindr will attempt to pair all files matching the forward and reverse identifiers.
- **Python Integration**: For automated pipelines, ConFindr can be imported as a Python module. Use `confindr.find_paired_reads()` to locate files and `confindr.find_contamination()` to execute the logic within a script.

## Reference documentation
- [ConFindr GitHub Repository](./references/github_com_OLC-Bioinformatics_ConFindr.md)
- [ConFindr Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_confindr_overview.md)