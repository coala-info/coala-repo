---
name: sierra-local
description: The sierra-local tool runs the Stanford HIVdb drug resistance prediction algorithm on local hardware to process genomic sequences. Use when user asks to run HIV drug resistance predictions, update local algorithm rules, or process HIV-1 sequences for resistance reports while maintaining data privacy.
homepage: https://github.com/PoonLab/sierra-local
---


# sierra-local

## Overview
The `sierra-local` tool is a Python-based implementation of the Stanford HIVdb Sierra web service. It allows researchers and clinicians to run the HIV drug resistance prediction algorithm on local hardware. By utilizing the Algorithm Specification Interface (ASI), it processes genomic sequences of HIV-1 (specifically regions targeting antiretroviral therapy) to generate resistance reports in JSON format, ensuring data privacy and provenance.

## Core Workflows

### 1. Data Synchronization
Before running predictions, you must ensure the local algorithm rules and mutation databases are up to date.
- **Update Command**: Run the updater script to fetch the latest HIVDB XML and reference files.
  ```bash
  python3 -m sierralocal.updater
  ```
- **Note**: This requires the `requests` library and an active internet connection for the update phase only.

### 2. Running Resistance Predictions
The primary interface is the `sierralocal` command, which takes a FASTA file as input.
- **Basic Usage**:
  ```bash
  sierralocal input_sequences.fasta
  ```
- **Output**: The tool generates a JSON file (e.g., `input_sequences_results.json`) containing the alignment details, identified mutations, and resistance scores.

### 3. Data Retrieval Examples
If you need to retrieve specific HIVdb data for reference or testing:
```bash
python3 scripts/retrieve_hivdb_data.py [Gene] [Output_File]
# Example for Reverse Transcriptase
python3 scripts/retrieve_hivdb_data.py RT RT_reference.fa
```

## Expert Tips and Best Practices
- **Alignment Engines**: By default, the tool uses `Post-Align`. Ensure `minimap2` is in your PATH for optimal performance during the alignment phase.
- **Environment Management**: It is highly recommended to use a dedicated Conda environment to manage dependencies like `Cython` and `NucAmino`.
  ```bash
  conda create --name sierralocal -c bioconda sierra-local
  conda activate sierralocal
  ```
- **Handling Large Batches**: The tool reports processing speed (iterations per second). For very large FASTA files, monitor the "Time elapsed" output to estimate completion.
- **Data Privacy**: Use this tool as the default alternative to the Sierra web API when working with sequences that fall under strict jurisdictional privacy regulations (e.g., GDPR, HIPAA) or criminal case evidence.

## Reference documentation
- [sierra-local GitHub Repository](./references/github_com_PoonLab_sierra-local.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sierra-local_overview.md)