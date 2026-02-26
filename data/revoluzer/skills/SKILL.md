---
name: revoluzer
description: "Revoluzer analyzes genome rearrangements and evolutionary scenarios. Use when user asks to analyze genome rearrangements, compare evolutionary scenarios, or calculate evolutionary distances between genomes."
homepage: https://gitlab.com/Bernt/revoluzer/
---


# revoluzer

yaml
name: revoluzer
description: Tools for genome rearrangement analysis, including CREx and TreeREx. Use when Claude needs to analyze genome rearrangements, compare evolutionary scenarios, or calculate evolutionary distances between genomes.
```
## Overview
The revoluzer tool is designed for analyzing genome rearrangements. It provides functionalities for comparing evolutionary scenarios (like CREx and TreeREx) and calculating evolutionary distances between genomes. This skill is useful when you need to perform complex phylogenetic analyses involving genome evolution.

## Usage Instructions

Revoluzer is a command-line tool. The primary executables are `crex` and `trex` for scenario analysis, and `distmat` for distance matrix calculations.

### Core Commands and Options

*   **`crex`**: Analyzes evolutionary scenarios.
    *   **Input**: Requires a list of genomes in a specific format (often FASTA or a custom format representing gene content and order).
    *   **Key Options**:
        *   `-f <file>`: Specify the input file containing genome information.
        *   `-o <file>`: Output file for results.
        *   `-b`: Print header.
        *   `-i`: Reset options.
        *   `-c`: (Specific usage may vary, consult documentation for detailed behavior).
        *   `--version`: Display the version of CREx.

*   **`trex`**: Similar to `crex`, likely for Tree Rearrangement analysis.
    *   **Input**: Similar genome representation as `crex`.
    *   **Key Options**:
        *   `-f <file>`: Input file.
        *   `-o <file>`: Output file.
        *   `--version`: Display the version of TreeREx.

*   **`distmat`**: Computes a distance matrix between genomes.
    *   **Input**: Typically takes a list of genomes or a pre-computed scenario file.
    *   **Key Options**:
        *   `-f <file>`: Input file.
        *   `-o <file>`: Output file for the distance matrix.
        *   `--version`: Display the version of distmat.
        *   `--crex-distance`: Option to compute CREx distance.

### Common Workflow Patterns

1.  **Analyzing CREx Scenarios**:
    To analyze a set of genomes for evolutionary scenarios using CREx, you would typically use:
    ```bash
    crex -f input_genomes.txt -o crex_results.txt
    ```
    Ensure `input_genomes.txt` is formatted correctly according to revoluzer's specifications.

2.  **Generating a Distance Matrix**:
    To compute pairwise evolutionary distances between genomes:
    ```bash
    distmat -f input_genomes.txt -o distance_matrix.txt
    ```
    If you need to compute distances specifically using the CREx metric:
    ```bash
    distmat -f input_genomes.txt -o crex_distance_matrix.txt --crex-distance
    ```

### Expert Tips

*   **Input File Format**: The most critical aspect of using revoluzer is understanding the expected input file format for genomes. This often involves specifying gene content and their order. Refer to the project's README or documentation for precise formatting requirements.
*   **Version Checking**: Always use the `--version` flag for `crex`, `trex`, and `distmat` to ensure you are using the expected version and to help with debugging if issues arise.
*   **Output Interpretation**: The output of `crex` and `distmat` can be complex. Familiarize yourself with the meaning of different rearrangement types, scenario scores, and distance metrics to correctly interpret the results.
*   **Error Handling**: Pay close attention to error messages. Common issues include incorrect input file formatting, missing dependencies, or incompatible command-line arguments.

## Reference documentation
- [README](./references/gitlab_com_Bernt_revoluzer_-_blob_main_README.md)
- [Overview](./references/anaconda_org_channels_bioconda_packages_revoluzer_overview.md)