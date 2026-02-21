---
name: biophi
description: BioPhi is an open-source platform tailored for antibody design and engineering.
homepage: https://github.com/Merck/BioPhi
---

# biophi

## Overview

BioPhi is an open-source platform tailored for antibody design and engineering. It provides two primary computational methods: **Sapiens**, a deep-learning-based antibody language model used for automated humanization, and **OASis**, a humanness evaluation tool that compares sequences against natural human antibody repertoires. 

Use this skill to perform bulk processing of antibody sequences, generate humanized variants that retain parental binding characteristics, and calculate humanness scores to assess the potential immunogenicity of therapeutic candidates.

## CLI Usage Patterns

### Antibody Humanization (Sapiens)

Sapiens generates humanized sequences by predicting the most likely human residues for a given non-human antibody framework.

*   **Generate Humanized FASTA**:
    ```bash
    biophi sapiens input_mabs.fa --fasta-only --output humanized.fa
    ```
*   **Full Pipeline (Humanization + OASis Evaluation)**:
    Requires the OASis database path.
    ```bash
    biophi sapiens input_mabs.fa --oasis-db /path/to/OASis_9mers_v1.db --output humanized_results/
    ```
*   **Extract Residue-Level Scores**:
    Generates a probability matrix for every residue at every position.
    ```bash
    biophi sapiens input_mabs.fa --scores-only --output residue_scores.csv
    ```
*   **Get Mean Sapiens Scores**:
    Provides a single confidence score per sequence.
    ```bash
    biophi sapiens input_mabs.fa --mean-score-only --output mean_scores.csv
    ```

### Humanness Evaluation (OASis)

OASis calculates the "OASis identity" by searching for 9-mer peptides within the Observed Antibody Space (OAS) database.

*   **Standard Evaluation**:
    Outputs a detailed Excel report containing humanness metrics.
    ```bash
    biophi oasis input_mabs.fa --oasis-db /path/to/OASis_9mers_v1.db --output oasis_report.xlsx
    ```

## Expert Tips and Best Practices

*   **Sequence Pairing**: For optimal results, ensure both the Heavy Chain (VH) and Light Chain (VL) of an antibody are present in the input FASTA. Use identical IDs for both chains, distinguished by a suffix (e.g., `mab1_VH` and `mab1_VL` or `mab1_HC` and `mab1_LC`).
*   **Database Management**: The OASis database is large (~22GB uncompressed). Ensure the `OASIS_DB_PATH` environment variable is set to avoid repeating the `--oasis-db` flag in every command:
    ```bash
    export OASIS_DB_PATH=/path/to/OASis_9mers_v1.db
    ```
*   **Bulk Processing**: BioPhi is designed for high-throughput tasks. When processing thousands of sequences, prefer the CLI over the web interface to avoid session timeouts and memory overhead.
*   **Interpreting Sapiens Scores**: Higher Sapiens scores indicate a higher likelihood that the residue choice matches the distribution of natural human antibodies. Use the `--scores-only` output to identify specific "non-human" "hotspots" in your framework that may require manual intervention.

## Reference documentation

- [BioPhi GitHub Repository](./references/github_com_Merck_BioPhi.md)
- [Bioconda BioPhi Package Overview](./references/anaconda_org_channels_bioconda_packages_biophi_overview.md)