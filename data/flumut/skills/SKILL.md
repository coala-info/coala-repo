---
name: flumut
description: FluMut scans H5N1 avian influenza sequences against a database of molecular markers to predict host adaptation and antiviral resistance. Use when user asks to update the marker database, analyze influenza sequences for mutations, generate reports in Excel or TSV format, or perform relaxed searches for partial markers.
homepage: https://github.com/izsvenezie-virology/FluMut
metadata:
  docker_image: "quay.io/biocontainers/flumut:0.6.4--pyhdfd78af_0"
---

# flumut

## Overview
FluMut is a specialized bioinformatics tool designed for the surveillance of H5N1 avian influenza. It scans nucleotide sequences against a curated database of known molecular markers to predict potential impacts on viral behavior, such as host adaptation or antiviral resistance. The tool supports both complete and partial genomes and provides outputs in either user-friendly Excel formats or machine-readable TSV files for downstream analysis.

## Installation
FluMut can be installed via Pip or Bioconda:

```bash
# Via Pip
pip install flumut

# Via Conda
conda install -c bioconda flumut
```

## Core Workflows

### 1. Database Maintenance
Before running any analysis, ensure the local marker database is current to include the latest literature and identified mutations.
```bash
flumut --update
```

### 2. Standard Analysis (Excel Output)
For a comprehensive, human-readable report with navigation features, use the Excel output option.
```bash
flumut -x results.xlsm input_sequences.fa
```
*   **Tip**: Use the `.xlsm` extension to enable internal navigation features within the report. Use `.xlsx` if navigation is not required.

### 3. Pipeline Integration (Text Output)
For automated workflows or large-scale data processing, generate machine-readable TSV files.
```bash
flumut -m markers.tsv -M mutations.tsv -l literature.tsv input_sequences.fa
```
*   `-m`: List of detected markers.
*   `-M`: List of specific amino acids found at positions of interest.
*   `-l`: List of literature references associated with the detected markers.

### 4. Relaxed Search
By default, FluMut only reports markers where **all** required mutations are present. To identify markers where at least one mutation is found, use the relaxed flag:
```bash
flumut -r -x results_relaxed.xlsm input_sequences.fa
```

## Input Requirements and Best Practices

### FASTA Header Formatting
FluMut relies strictly on the FASTA header to map sequences to specific samples and segments. Headers must contain:
1.  **Sample ID**: A consistent identifier for all segments belonging to the same virus sample.
2.  **Segment Name**: Must be one of the following: `PB2`, `PB1`, `PA`, `HA`, `NP`, `NA`, `MP`, `NS`.

**Example Header:**
`>Sample123_HA`

### Sequence Quality
*   **IUPAC Codes**: Sequences must adhere to standard IUPAC nucleotide codes.
*   **Partial Sequences**: The tool can handle partial genome segments, but the accuracy of marker detection depends on the coverage of the specific positions of interest.

## Reference documentation
- [FluMut GitHub Repository](./references/github_com_izsvenezie-virology_FluMut.md)
- [FluMut Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_flumut_overview.md)