---
name: sadie-antibody
description: SADIE is a framework for processing antibody sequence data through VDJ gene assignment and functional annotation. Use when user asks to perform VDJ annotation, renumber antibody sequences, or generate AIRR-compliant data tables from FASTA files and sequence strings.
homepage: https://sadie.jordanrwillis.com
metadata:
  docker_image: "quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0"
---

# sadie-antibody

## Overview
SADIE (Sequencing Analysis and Data Library for Immunoinformatics Exploration) is a specialized framework designed for the immunoinformatics community. It provides both a high-level command-line interface and a low-level Python API to process antibody sequence data. You should use this skill to perform VDJ gene assignment, identify functional antibody sequences, and generate standardized data tables from raw FASTA or sequence strings. It is particularly useful for researchers working with human and model organism antibody repertoires who require testable, reusable, and portable analysis workflows.

## Tool Usage and Best Practices

### Command Line Interface (CLI)
The `sadie` executable is the primary entry point for command-line tasks.

*   **Basic VDJ Annotation**: To annotate a FASTA file using functional human germlines:
    ```bash
    sadie airr my_sequences.fasta
    ```
*   **Specifying Output**: By default, SADIE can output to various formats. Use the `-o` flag to specify a filename, often ending in `.csv`, `.json`, or `.gz` for compressed output.
*   **Species Selection**: While human is often the default, ensure you specify the target species if working with non-human data (e.g., mouse, rat, macaque).

### Python API Integration
For more complex workflows or data exploration in notebooks (like Jupyter or Colab), use the `Airr` class.

*   **Initialization**: Always initialize the API with the desired species.
    ```python
    from sadie.airr import Airr
    airr_api = Airr("human")
    ```
*   **Single Sequence Processing**: Use `run_single` for quick checks on individual clones.
    ```python
    airr_table = airr_api.run_single("Sequence_ID", "CAGCGATTAGT...")
    ```
*   **Batch Processing**: Use `run_fasta` or `run_dataframe` to process larger datasets efficiently.

### Expert Tips
*   **Data Standards**: SADIE is built to be AIRR-compliant. When downstream tools require specific immunoinformatics fields, SADIE’s output tables will typically contain the necessary columns (e.g., `v_call`, `d_call`, `j_call`, `junction_aa`).
*   **Sequence Cleaning**: Before running annotation, ensure sequences are stripped of newlines or non-nucleotide characters if passing them as strings to the API.
*   **Environment**: If running in a restricted environment, SADIE is portable and can be installed via `pip install sadie-antibody`.



## Subcommands

| Command | Description |
|---------|-------------|
| sadie | SADIE Antibody Analysis |
| sadie airr | Run the AIRR annotation pipeline from the command line on a single file or a directory of abi files. |
| sadie renumbering | Renumber antibody sequences based on specified schemes and regions. |

## Reference documentation
- [SADIE Main README](./references/github_com_jwillis0720_sadie_blob_main_README.md)
- [Annotation Guide](./references/sadie_jordanrwillis_com_annotation.md)
- [SADIE Index](./references/sadie_jordanrwillis_com_index.md)