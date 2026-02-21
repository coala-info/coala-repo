---
name: m-party
description: M-PARTY (Mining Protein dAtasets foR Targeted EnzYmes) is a bioinformatics tool designed to detect enzymes capable of degrading plastics (such as polyethylene).
homepage: https://github.com/ozefreitas/M-PARTY
---

# m-party

## Overview

M-PARTY (Mining Protein dAtasets foR Targeted EnzYmes) is a bioinformatics tool designed to detect enzymes capable of degrading plastics (such as polyethylene). It utilizes the HMMER package to perform structural annotations by searching query sequences against specialized Hidden Markov Models. This skill enables agents to automate the discovery of plastic-active proteins from FASTA files, KEGG orthology IDs, or InterPro families, and to generate structured reports in Excel or text formats.

## Core Workflows

### 1. Sequence Annotation
The primary workflow for searching protein sequences against an existing HMM database.

```bash
m-party.py -i <input.fasta> -o <output_dir> -rt --output_type excel --hmm_db_name <database_name> --verbose
```

*   **Input**: Must be a FASTA file containing amino acid sequences.
*   **Flags**:
    *   `-rt`: Generates a text-based summary report for easier interpretation.
    *   `--output_type excel`: Produces a detailed `.xlsx` table containing Bit scores and E-values.
    *   `--hmm_db_name`: Mandatory identifier for the run and database storage.

### 2. Database Construction
M-PARTY does not ship with a pre-built database; you must build one before annotation.

**From a FASTA file of known sequences:**
```bash
m-party.py -w database_construction --input_seqs_db_const <sequences.fasta> --hmm_db_name <db_name>
```

**From KEGG (KO ID or E.C. Number):**
```bash
m-party.py -w database_construction --kegg <KO_ID_or_EC_Number> --hmm_db_name <db_name>
```

**From InterPro (IPR ID or Protein ID):**
```bash
m-party.py -w database_construction --interpro <IPR_ID> --hmm_db_name <db_name>
```

### 3. Validation Workflow
Use this to filter potential false positives from initial annotation results.
```bash
m-party.py -w validation -i <annotation_results> -o <validation_dir> --hmm_db_name <db_name>
```

## Expert Tips and Best Practices

*   **Mandatory Database Naming**: Every command requires the `--hmm_db_name` argument. Omitting this will trigger a `ValueError`.
*   **InterPro Quality Control**: InterPro contains many unreviewed entries. When building databases from InterPro, always use the `--curated` flag to restrict the search to reviewed sequences.
*   **Nucleic vs. Amino Acids**: By default, M-PARTY downloads amino acid sequences. If building a database from nucleic sequences (available for FASTA and KEGG methods), you must explicitly set `--input_type_db_const nucleic`.
*   **Output Management**: M-PARTY will create the output folder if it doesn't exist. If it does exist, ensure you have write permissions or specify a unique name to avoid conflicts.
*   **Metagenomic Analysis**: For raw metagenomes, M-PARTY uses KMA to map reads. Ensure the environment has KMA installed and accessible in the PATH.

## Reference documentation
- [M-PARTY GitHub Documentation](./references/github_com_ozefreitas_M-PARTY.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_m-party_overview.md)