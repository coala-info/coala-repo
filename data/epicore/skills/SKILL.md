---
name: epicore
description: Epicore identifies and visualizes shared consensus epitopes by grouping overlapping peptide sequences from evidence files against a reference proteome. Use when user asks to generate consensus epitopes, visualize protein landscapes, map immunogenic regions, or group overlapping peptides from peptide data.
homepage: https://github.com/AG-Walz/epicore
metadata:
  docker_image: "quay.io/biocontainers/epicore:0.1.7--pyhdfd78af_0"
---

# epicore

## Overview

The epicore tool is a specialized bioinformatics utility designed to identify and visualize shared consensus epitopes from peptide data. It processes evidence files (from search engines) alongside a reference proteome to group overlapping peptides into consensus sequences. This is particularly useful for mapping immunogenic regions across different samples or conditions and understanding the "landscape" of protein coverage.

## Installation

Install epicore using pip or conda:

```bash
pip install epicore
# OR
conda install bioconda::epicore
```

## Core Workflows

### 1. Generating Consensus Epitopes

Use the `generate-epicore-csv` command to process your peptide evidence. This command requires mapping your input file columns to the tool's expected parameters.

**Basic Pattern:**
```bash
epicore --reference_proteome <PROTEOME.fasta> --out_dir <OUTPUT_DIR> generate-epicore-csv \
  --evidence_file <INPUT_FILE> \
  --seq_column <SEQUENCE_COL> \
  --protacc_column <ACCESSION_COL> \
  --start_column <START_COL> \
  --end_column <END_COL> \
  --sample_column <SAMPLE_ID_COL> \
  --condition_column <CONDITION_COL> \
  --min_epi_length 8 \
  --min_overlap 7 \
  --max_step_size 3 \
  --delimiter ","
```

### 2. Visualizing Protein Landscapes

After generating the results, use `plot-landscape` to create visualizations for specific proteins.

**Basic Pattern:**
```bash
epicore --reference_proteome <PROTEOME.fasta> --out_dir <OUTPUT_DIR> plot-landscape \
  --epicore_csv <OUTPUT_DIR>/epicore_result.csv \
  --protacc <PROTEIN_ACCESSION>
```

## Tool-Specific Best Practices

### Handling Peptide Modifications
If your sequences contain modification markers (e.g., `AAAPAIM/+15.99\SY`), use the `--mod_pattern` flag to define the delimiters.
- Example: `--mod_pattern "/,\"` tells the tool that modifications start with `/` and end with `\`.
- Note: Sequences inside `()` or `[]` are handled as modifications by default.

### Tuning Grouping Parameters
The quality of consensus epitopes depends on three primary parameters:
- `--min_epi_length`: The minimum length required for a sequence to be considered an epitope.
- `--min_overlap`: The minimum number of overlapping amino acids required to group two peptides.
- `--max_step_size`: The maximum distance allowed between peptides to maintain a group.

### High-Confidence Grouping
Use the `--strict` flag to ensure that the defined minimal overlap is maintained between *all* peptides within a group, rather than just adjacent ones. This is recommended for high-stringency epitope discovery.

### Output Analysis
Monitor the following files in your output directory:
- `epitopes.csv`: Contains the identified consensus sequences and their contributing peptides.
- `pep_cores_mapping.tsv`: Provides the direct mapping between input peptides and identified cores.
- `epicore.log`: Check this file to see which peptides were removed (e.g., those not found in the reference proteome).



## Subcommands

| Command | Description |
|---------|-------------|
| epicore | epicore |
| epicore | Epicore is a tool for analyzing and visualizing genomic data. |

## Reference documentation
- [Epicore README](./references/github_com_AG-Walz_epicore_blob_main_README.md)
- [Epicore Changelog](./references/github_com_AG-Walz_epicore_blob_main_CHANGELOG.md)