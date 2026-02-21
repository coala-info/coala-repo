---
name: marge
description: MARGE (Model-based Analysis of Regulation of Gene Expression) is a framework that leverages a comprehensive library of H3K27ac ChIP-seq profiles to interpret the cis-regulation of gene expression.
homepage: http://cistrome.org/MARGE
---

# marge

## Overview
MARGE (Model-based Analysis of Regulation of Gene Expression) is a framework that leverages a comprehensive library of H3K27ac ChIP-seq profiles to interpret the cis-regulation of gene expression. It is particularly useful when you have gene expression data but lack matched chromatin profiling, as it can "borrow" information from its internal compendium of hundreds of human and mouse datasets to predict regulatory potentials and cis-elements.

## Core Functions
- **MARGE-potential**: Calculates Regulatory Potential (RP) for genes based on H3K27ac signals and genomic distance.
- **MARGE-express**: Uses regression to link gene expression changes with RPs from the library to identify the most relevant regulatory environments.
- **MARGE-cistrome**: Predicts specific cis-regulatory elements (1kb windows) consistent with the identified expression perturbations.

## Workflow Execution

### 1. Initialization
Create a dedicated workflow directory and initialize the necessary Snakemake and configuration files.
```bash
marge init /path/to/workflow_dir
```

### 2. Configuration (`config.json`)
The `marge init` command generates a `config.json` file. You must manually edit this file to define the analysis parameters. Key fields include:
- `ASSEMBLY`: Specify the genome (e.g., `hg38`, `mm10`, `hg19`, `mm9`). Note that cis-region prediction is only supported for `hg38` and `mm10`.
- `MARGEdir`: Path to the MARGE source code.
- `REFdir`: Path to the MARGE reference library (downloaded from Cistrome).
- `SAMPLESDIR` / `SAMPLES`: Path and filenames for BAM files.
- `EXPSDIR` / `EXPS`: Path and filenames for Gene List files.
- `EXPTYPE`: Format of the gene list (`Gene_Only` or `Gene_Response`) and ID type (`RefSeq` or `GeneSymbol`).

### 3. Execution
MARGE runs via Snakemake. Always perform a dry-run first to validate the configuration.
```bash
cd /path/to/workflow_dir
# Dry-run
snakemake -n
# Actual execution (e.g., using 8 cores)
snakemake --cores 8
```

## Input File Requirements

### BAM Files (ChIP-seq)
- Must have the `.bam` suffix.
- Should be mapped to the same assembly defined in the config.
- Multiple files in the same directory can be processed simultaneously.

### Gene Lists
- Must have the `.txt` suffix.
- **Do not include headers.**
- **Gene_Only format**: A single column of Gene Symbols or RefSeq IDs.
- **Gene_Response format**: Two columns (tab-delimited). Column 1 is the Gene ID; Column 2 is `1` (target) or `0` (non-target).

## Expert Tips & Best Practices
- **Assembly Limitations**: If using `hg19` or `mm9`, MARGE only outputs Regulatory Potential. To access the full suite of cis-regulatory predictions, use `hg38` or `mm10`.
- **UCSC Tools**: Ensure `bedClip`, `bigWigToBedGraph`, `bigWigSummary`, and `bigWigAverageOverBed` are in your PATH or explicitly defined in `config.json`.
- **Library Matching**: The power of MARGE-express comes from its internal library. Ensure you have downloaded the correct reference library for your species (365 human datasets or 267 mouse datasets).
- **BAM Pre-processing**: While MARGE handles the analysis, ensure your BAM files are sorted and indexed for optimal performance with the underlying tools like MACS2.

## Reference documentation
- [MARGE Tutorial](./references/cistrome_org_MARGE_tutorial.html.md)
- [MARGE Overview](./references/cistrome_org_MARGE_index.html.md)
- [Installation Guide](./references/cistrome_org_MARGE_installation.html.md)
- [Download & Resources](./references/cistrome_org_MARGE_download.html.md)