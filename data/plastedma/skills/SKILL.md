---
name: plastedma
description: PlastEDMA identifies plastic-degrading enzymes within metagenomic datasets by searching protein sequences against curated HMM models. Use when user asks to build a plastic-degrading enzyme database, annotate protein sequences for plastic degradation potential, or search metagenomic data for specific enzymatic activities.
homepage: https://github.com/ozefreitas/PlastEDMA
metadata:
  docker_image: "quay.io/biocontainers/plastedma:0.2.1--hdfd78af_0"
---

# plastedma

## Overview
PlastEDMA (also known as M-PARTY) is a specialized bioinformatics tool designed to identify enzymes capable of degrading plastics within metagenomic datasets. It leverages HMMER's `hmmsearch` against a curated database of plastic-degrading enzyme models. The tool is essential for researchers mining protein databases for targeted enzymatic activity, providing a streamlined workflow from database construction to sequence annotation and result validation.

## Core Workflows

### 1. Database Construction
Before annotation, you must build an HMM database. PlastEDMA supports three input methods:

- **From FASTA**: Use known sequences.
  ```bash
  m-party.py -w database_construction --input_seqs_db_const path/to/sequences.fasta --hmm_db_name <db_name>
  ```
- **From KEGG**: Use Orthology (KO) or E.C. numbers.
  ```bash
  m-party.py -w database_construction --kegg <KO_or_EC> --hmm_db_name <db_name>
  ```
- **From InterPro**: Use InterPro (IPR) or Protein IDs (PID).
  ```bash
  m-party.py -w database_construction --interpro <IPR_or_PID> --hmm_db_name <db_name> --curated
  ```
  *Note: Use `--curated` with InterPro to filter for reviewed entries.*

### 2. Sequence Annotation
Perform the search against your built HMM database. The input must be a FASTA file containing amino acid sequences.

```bash
m-party.py -i input.fasta -o output_folder -rt --output_type excel --hmm_db_name <db_name> --verbose
```

### 3. Processing Nucleic Sequences
If building a database from nucleic sequences (available for FASTA and KEGG methods), specify the input type:

```bash
m-party.py -w database_construction --kegg <EC/KO> --input_type_db_const nucleic --hmm_db_name <db_name>
```

## Best Practices and Tips
- **Mandatory Naming**: Every command must include `--hmm_db_name`. Failure to provide this will trigger a `ValueError`.
- **Output Interpretation**: Use the `-rt` flag to generate a text report. This provides a human-readable summary of parameters and conclusions alongside the raw data.
- **Excel Output**: Set `--output_type excel` for the most stable version of the results table, which includes Bit scores and E-values for hit significance.
- **Environment Management**: If running via a manual installation, ensure the `mparty.yaml` environment is active to satisfy dependencies like HMMER and KMA.

## Reference documentation
- [M-PARTY GitHub Documentation](./references/github_com_ozefreitas_M-PARTY.md)
- [PlastEDMA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_plastedma_overview.md)