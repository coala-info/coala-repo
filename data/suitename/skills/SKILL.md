---
name: suitename
description: Suitename classifies RNA backbone suite conformations by mapping dihedral angle data to predefined clusters and calculating a suiteness score. Use when user asks to classify RNA backbone suites, calculate suiteness scores, or identify structural outliers in RNA models.
homepage: https://github.com/rlabduke/suitename
---


# suitename

## Overview
The `suitename` tool is a specialized utility for RNA structural biology that classifies the conformation of each suite in an RNA backbone. It maps 7-dimensional dihedral angle data to a set of 53 predefined clusters established through empirical study. By calculating a "suiteness" score (a measure of fit quality), it helps researchers distinguish between standard, well-modeled RNA folds and problematic or unique structural outliers.

## Command Line Usage

### Basic Execution
Run the tool using a Python 3 interpreter. It reads from a file or standard input and writes to standard output.

```bash
python3 suitename.py [input_file] > [output_file]
```

### Input Formats
The tool supports two primary input methods:

1.  **Residue Dihedrals (Default):** Expects 6 dihedral angles ($\alpha, \beta, \gamma, \delta, \epsilon, \zeta$) per residue. The tool automatically re-parses these into the 7 angles required for a suite ($\delta_{n-1}, \epsilon_{n-1}, \zeta_{n-1}, \alpha_n, \beta_n, \gamma_n, \delta_n$).
    *   **Format:** Colon-separated fields. The first 6 fields are ID info, followed by the angles.
    *   **Example:** `1: A: 7: : : U:-75.533:-154.742:48.162:80.895:-148.423:-159.688`

2.  **Suite Dihedrals:** Use the `--suitein` flag if providing the 7 or 9 dihedral angles directly for each suite.
    *   **9-angle input:** Includes $\chi_{n-1}$ and $\chi_n$.

### Output Options
*   **Text Report (Default):** Provides the cluster assignment, the "suiteness" score (0 to 1), and a statistical summary.
*   **Kinemage File (`--kinemage`):** Generates a 7D data point visualization for use in Mage or KiNG. Points are color-coded by cluster.
*   **Brief String (`--string`):** Outputs a condensed 3-character string per suite (e.g., `1a`), useful for secondary structure-like notation.

## Expert Tips and Best Practices

*   **Interpreting Suiteness:** The "suiteness" value is the cosine of the normalized distance from the cluster boundary to its center. A value of 1.0 indicates a perfect fit at the cluster center, while lower values indicate the suite is near the edge of the defined conformational space.
*   **Handling Outliers:** Suites that do not fit into any of the 53 defined clusters are labeled as outliers. High numbers of outliers in a model often suggest errors in the atomic coordinates or the need for local rebuilding.
*   **CCTBX Integration:** While this standalone Python version is functional, `suitename` is also integrated into the CCTBX library and can be invoked as `phenix.suitename` or `molprobity.suitename` in those environments.
*   **Standard Input:** For pipeline integration, you can pipe dihedral data directly into the tool:
    ```bash
    cat angles.txt | python3 suitename.py --string
    ```

## Reference documentation
- [Suitename README](./references/github_com_rlabduke_suitename.md)