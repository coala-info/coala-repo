---
name: enabrowsertools
description: enabrowsertools is a set of Python scripts used to automate the retrieval of raw reads, sequence records, and assembly data from the European Nucleotide Archive. Use when user asks to download FastQ files, fetch genomic data using ENA accession numbers, or retrieve all runs associated with a specific study or sample.
homepage: https://github.com/enasequence/enaBrowserTools
metadata:
  docker_image: "quay.io/biocontainers/enabrowsertools:1.7.2--hdfd78af_0"
---

# enabrowsertools

## Overview

enabrowsertools is a specialized set of Python scripts that interface with ENA web services to automate data retrieval. Instead of manual downloads or complex API scripting, this tool allows for direct command-line fetching of raw reads (FastQ), submitted files, and sequence records using standard ENA accession numbers. It is particularly useful for bioinformaticians needing to pull large datasets for secondary analysis or local storage.

## Installation and Setup

The most reliable way to install the tools is via Bioconda:

```bash
conda install bioconda::enabrowsertools
```

**Mac Users Note:** If you encounter SSL/authentication errors on macOS, you must run the certificate installation command included with your Python distribution:
`open "/Applications/Python 3.x/Install Certificates.command"`

## Core Command Usage

### enaDataGet
Use this tool to download all data associated with a specific accession (sequence, assembly, read, or analysis).

*   **Basic Download (FastQ):**
    `enaDataGet -f fastq [ACCESSION]`
*   **Download Assembly (FASTA):**
    `enaDataGet -f fasta [ACCESSION]`
*   **Specify Destination:**
    `enaDataGet -d /path/to/directory [ACCESSION]`

### enaGroupGet
Use this tool to download all data associated with a group accession, such as a Study (PRJEB/PRJNA) or a Sample.

*   **Download all runs in a study:**
    `enaGroupGet -f fastq [STUDY_ACCESSION]`

## Advanced Transfer Options

### Using Aspera for High-Speed Downloads
Aspera is significantly faster than FTP for large genomic files. To use it, you must have the Aspera CLI installed and configured.

1.  **Configuration:** Create or edit `aspera_settings.ini` to point to your binary and private key:
    ```ini
    [aspera]
    ASPERA_BIN = /path/to/ascp
    ASPERA_PRIVATE_KEY = /path/to/aspera_dsa.openssh
    ```
2.  **Execution:**
    *   Using the flag: `enaDataGet -f fastq -a [ACCESSION]`
    *   Specifying the config file: `enaDataGet -f fastq -as /path/to/aspera_settings.ini [ACCESSION]`

**Pro Tip:** Set the environment variable `ENA_ASPERA_INIFILE` to your settings path to avoid passing the `-as` flag every time:
`export ENA_ASPERA_INIFILE="/path/to/aspera_settings.ini"`

## Common Accession Types
*   **Reads:** ERR, SRR, DRR (Runs); ERX, SRX, DRX (Experiments)
*   **Analysis:** ERZ (Analysis accessions)
*   **Assemblies:** GCA_ (GenBank), GCF_ (RefSeq)
*   **Sequences:** Single accessions like BN000001

## Reference documentation
- [enaBrowserTools Main Repository](./references/github_com_enasequence_enaBrowserTools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_enabrowsertools_overview.md)