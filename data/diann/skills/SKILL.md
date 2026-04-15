---
name: diann
description: DIA-NN is a specialized software suite for the high-speed automated processing and quantification of DIA proteomics datasets. Use when user asks to create predicted spectral libraries from protein sequences, identify and quantify proteins in raw mass spectrometry files, or process large-scale proteomics experiments.
homepage: https://github.com/vdemichev/DiaNN
metadata:
  docker_image: "biocontainers/diann:v1.8.1_cv1"
---

# diann

## Overview

DIA-NN is a specialized software suite designed for the automated processing of DIA proteomics datasets. It focuses on statistical reliability and high-speed analysis, often processing up to 1000 runs per hour. This skill assists in executing the two primary DIA-NN workflows: creating a predicted spectral library from protein sequence databases and using those libraries to identify and quantify proteins within raw mass spectrometry files. It is particularly useful for researchers needing to set up reproducible pipelines for large-scale proteomics experiments.

## Core Workflows

### 1. Predicted Library Generation
This step converts protein sequences (FASTA) into a searchable spectral library. This is required if an empirical library is not already available for your organism.

*   **Input**: One or more FASTA files in UniProt format.
*   **Key Parameters**:
    *   Set the mode to **Prediction from FASTA**.
    *   The output is typically a `.predicted.speclib` file, which is a compact binary format.
*   **CLI Logic**: Use `--fasta [file]` and specify the output library path.

### 2. Library Search and Quantification
This step matches raw mass spec data against a spectral library to produce protein and precursor reports.

*   **Inputs**: 
    *   Spectral library (`.predicted.speclib`, `.parquet`, or compatible third-party formats).
    *   Raw data files (`.raw` for standard files or `.d` folders for Bruker timsTOF).
    *   FASTA files (used for protein reannotation).
*   **Key Flags**:
    *   `--reannotate`: Essential when using third-party libraries to ensure protein information matches your specific FASTA database.
    *   `--mbr`: Enables Match Between Runs to increase identification consistency across multiple samples.
    *   `--gen-spec-lib`: Generates an empirical library based on the current DIA experiment.

## CLI Usage Patterns

### Basic Library Search
```bash
diann.exe --raw sample1.raw --raw sample2.raw --lib human.predicted.speclib --fasta human_uniprot.fasta --out report.parquet --threads 16
```

### Processing Bruker timsTOF (PASEF) Data
For timsTOF data, use the `--d` flag to point to the `.d` acquisition folders.
```bash
diann.exe --d data_folder.d --lib library.speclib --fasta database.fasta --out output_report.parquet
```

### FASTA Prediction Mode
```bash
diann.exe --fasta uniprot_human.fasta --predict --out-lib human_library.predicted.speclib
```

## Expert Tips and Best Practices

*   **Output Formats**: The main report is generated in `.parquet` format. This is a compressed columnar format that should be accessed using the `arrow` package in R or `pyarrow`/`polars` in Python for downstream analysis.
*   **Reannotation**: Always check the "Reannotate" option (or use the corresponding CLI flag) if your spectral library comes from a different source than your FASTA file. This ensures that the `Protein.Group` column in your output is consistent with your sequence database.
*   **Performance**: For initial testing or troubleshooting, uncheck **MBR** and **Generate spectral library** to significantly reduce processing time.
*   **Memory Management**: When processing hundreds of files, ensure the system has sufficient RAM, as DIA-NN loads significant portions of the data for cross-run alignment.
*   **Linux Usage**: The Linux version is command-line only. Ensure `.NET SDK 8.0` or later is installed. For HPC environments, using the provided `make_docker.sh` to create a container is the recommended approach for dependency management.

## Reference documentation
- [DIA-NN Main Documentation](./references/github_com_vdemichev_DiaNN.md)