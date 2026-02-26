---
name: pseqsid
description: pseqsid calculates pairwise identity, similarity, and Normalized Similarity Scores from protein multiple sequence alignments. Use when user asks to calculate sequence identity matrices, evaluate protein similarity based on custom amino acid groups, or compute normalized similarity scores for structural template selection.
homepage: https://github.com/amaurypm/pseqsid
---


# pseqsid

## Overview
pseqsid is a specialized tool for protein sequence analysis that processes Multiple Sequence Alignments in FASTA format. It provides three primary metrics to evaluate sequence relationships: identity (exact matches), similarity (matches based on amino acid groupings), and Normalized Similarity Scores (NSS), which incorporate substitution matrices and gap penalties. The tool is particularly effective for selecting structural templates or quantifying conservation levels across large datasets.

## Command Line Usage

### Basic Calculations
To generate pairwise matrices, provide a protein MSA in FASTA format and specify the desired metrics:

*   **Identity only**: `pseqsid --identity input.fasta`
*   **Similarity only**: `pseqsid --similarity input.fasta`
*   **Normalized Similarity Score (NSS)**: `pseqsid --nss input.fasta`
*   **All metrics**: `pseqsid -i -s -n input.fasta`

### Controlling Sequence Length Logic
The denominator used for percentage calculations significantly impacts results. Use the `-l` or `--length` option to choose the logic:

*   `smallest`: Best for homology modeling (e.g., comparing a short query to a long template).
*   `mean`: Standard for general evolutionary distance.
*   `largest`: Conservative estimate of identity/similarity.
*   `alignment`: Includes gap-only columns in the length calculation.

Example:
`pseqsid -i -l mean alignment.fasta`

### Advanced Similarity and NSS Configuration
*   **Custom Similarity Groups**: Use `-g <file>` to provide a custom amino acid grouping file. If not provided, the tool generates a `default_aa_similarity_groups.txt` file.
*   **Substitution Matrices**: For NSS calculations, choose between `blosum62` (default), `pam250`, or `gonnet`.
    `pseqsid -n -m pam250 alignment.fasta`
*   **Gap Penalties**: Fine-tune NSS results by matching the penalties used during the initial alignment:
    `pseqsid -n -p 12.0 -e 1.0 alignment.fasta`

## Expert Tips and Best Practices
*   **Input Validation**: Ensure the input is a protein alignment. While the tool will process DNA, the similarity and NSS values will be biologically meaningless as it treats nucleotides as specific amino acids.
*   **Output Format**: Results are saved as CSV files derived from the input filename (e.g., `input_identity.csv`). The tool only saves the lower half of the symmetric matrix to reduce file size.
*   **Performance**: By default, the tool uses all available CPU threads. For shared HPC environments, limit thread usage with `-t <number>`.
*   **Homology Modeling**: When assessing if a template is suitable for a shorter sequence, always use `-l smallest` to ensure the identity percentage reflects the coverage of your specific sequence of interest.

## Reference documentation
- [pseqsid GitHub Repository](./references/github_com_amaurypm_pseqsid.md)
- [pseqsid Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pseqsid_overview.md)