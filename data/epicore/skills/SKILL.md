---
name: epicore
description: The epicore tool is a specialized bioinformatics utility designed to identify shared consensus epitopes from sets of overlapping peptides.
homepage: https://github.com/AG-Walz/epicore
---

# epicore

## Overview

The epicore tool is a specialized bioinformatics utility designed to identify shared consensus epitopes from sets of overlapping peptides. It transforms raw peptide evidence—typically from mass spectrometry search engines—into a structured map of core epitopes by grouping sequences based on their genomic or proteomic coordinates. This skill enables the identification of immunogenic "hotspots" and provides the necessary commands to generate both tabular data (consensus sequences, start/end positions) and visual landscape plots of protein coverage.

## Core Workflows

### 1. Generating Consensus Epitopes
The primary command `generate-epicore-csv` processes an evidence file against a reference proteome to identify core epitopes.

```bash
epicore --reference_proteome <PROTEOME_FASTA> \
        --out_dir <OUTPUT_DIRECTORY> \
        generate-epicore-csv \
        --evidence_file <INPUT_FILE> \
        --seq_column <SEQUENCE_COL> \
        --protacc_column <ACCESSION_COL> \
        --start_column <START_POS_COL> \
        --end_column <END_POS_COL> \
        --sample_column <SAMPLE_ID_COL> \
        --condition_column <CONDITION_COL> \
        --min_epi_length 8 \
        --min_overlap 1 \
        --max_step_size 5 \
        --delimiter ","
```

### 2. Visualizing Protein Landscapes
Once the CSV results are generated, use `plot-landscape` to create visual representations of peptide distribution across specific proteins.

```bash
epicore --reference_proteome <PROTEOME_FASTA> \
        --out_dir <OUTPUT_DIRECTORY> \
        plot-landscape \
        --epicore_csv <PATH_TO_epicore_result.csv> \
        --protacc <PROTEIN_ACCESSION_1,PROTEIN_ACCESSION_2>
```

## Parameter Best Practices

### Grouping Logic
*   **`--min_epi_length`**: Sets the minimum length for a peptide group to be considered an epitope.
*   **`--min_overlap`**: Defines the minimum number of amino acids that must overlap between peptides to group them.
*   **`--max_step_size`**: Controls the maximum distance allowed between peptides to maintain a group.
*   **`--strict`**: Use this flag to ensure the defined minimal overlap is maintained between *all* peptides within a group, rather than just adjacent ones.

### Handling Modifications
If your peptide sequences contain modification markers (e.g., `AAAPAIM/+15.99\SY`), use the `mod_pattern` parameter to define the delimiters.
*   Example: `--mod_pattern "/, \"` tells the tool that modifications start with `/` and end with `\`.
*   Note: Content inside `()` or `[]` is handled as a modification by default.

### Input Requirements
*   **Evidence File**: Supports `.csv`, `.tsv`, and `.xlsx`.
*   **Proteome File**: Must be in FASTA format and contain all accessions listed in your evidence file.
*   **Column Mapping**: You must explicitly define the headers for sequence, accession, start, end, sample, and condition columns as they appear in your input file.

## Key Outputs
*   **`epitopes.csv`**: Contains the identified consensus sequences, their coordinates, and the list of contributing peptides.
*   **`epicore_result.csv`**: A protein-centric summary mapping all peptides to their respective accessions.
*   **`consensus_sequence_coverage.png`**: A visual summary of the average coverage across identified epitopes.
*   **`pep_cores_mapping.tsv`**: A detailed mapping file linking individual input peptides to their resulting core epitopes.

## Reference documentation
- [epicore GitHub Repository](./references/github_com_AG-Walz_epicore.md)
- [epicore Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_epicore_overview.md)