---
name: lissero
description: The `lissero` skill enables the rapid identification of *Listeria monocytogenes* serogroups from FASTA files.
homepage: https://github.com/MDU-PHL/lissero
---

# lissero

## Overview
The `lissero` skill enables the rapid identification of *Listeria monocytogenes* serogroups from FASTA files. It replaces traditional multiplex PCR methods by searching for five specific genetic markers. This tool is essential for public health surveillance and food safety investigations to categorize isolates into major serotypes like 1/2a, 1/2b, 1/2c, and 4b.

## Basic Usage
The primary command for running an analysis is:
```bash
lissero [FASTA_FILE]
```
You can provide multiple FASTA files at once to process them in a single run.

## Command Line Options
- `--min_id [0-100]`: Sets the minimum percent identity for a gene match (default: 95.0).
- `--min_cov [0-100]`: Sets the minimum coverage of the gene required (default: 95.0).
- `--logfile [FILE]`: Redirects logs to a specific file instead of stderr.
- `--debug`: Enables verbose output for troubleshooting.

## Interpreting Results
The output is a tab-delimited format with the following key columns:
- **SEROTYPE**: The predicted group (e.g., `1/2a, 3a` or `4b, 4d, 4e`).
- **Gene Columns (PRS, LMO0737, etc.)**:
    - `FULL`: Complete match meeting identity and coverage thresholds.
    - `PARTIAL`: Match found but falls below thresholds.
    - `NONE`: No match detected.
- **COMMENT**: Provides context for "Nontypeable" results or unusual patterns (e.g., "Unusual 4b with lmo0737").

## Serogroup Reference Table
| Serogroup | lmo1118 | lmo0737 | ORF2110 | ORF2819 | Prs |
|-----------|:-------:|:-------:|:-------:|:-------:|:---:|
| 1/2a, 3a | - | + | - | - | + |
| 1/2b, 3b, 7 | - | - | - | + | + |
| 1/2c, 3c | + | + | - | - | + |
| 4b, 4d, 4e | - | - | + | + | + |
| 4b, 4d, 4e* | - | + | + | + | + |

*Note: If only the `Prs` gene is detected, the isolate is likely serotype 4a or 4c, but will be reported as "Nontypable".*

## Expert Tips
- **Input Quality**: Ensure your FASTA files are high-quality assemblies. While `lissero` checks if a file is a valid FASTA, fragmented assemblies may lead to `PARTIAL` matches if genes are split across contigs.
- **Species Confirmation**: If `Prs` is not found, the tool will flag that the isolate is likely not *Listeria monocytogenes*.
- **Threshold Adjustments**: If you receive "Nontypeable" results due to `PARTIAL` matches in a known *Listeria* sample, consider slightly lowering `--min_id` or `--min_cov` to account for sequence divergence, though 95% is the validated standard.

## Reference documentation
- [LisSero GitHub Repository](./references/github_com_MDU-PHL_lissero.md)