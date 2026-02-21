---
name: structureharvester
description: The `structureharvester` skill provides a streamlined workflow for parsing large batches of STRUCTURE results.
homepage: http://alumni.soe.ucsc.edu/~dearl/software/structureHarvester/
---

# structureharvester

## Overview
The `structureharvester` skill provides a streamlined workflow for parsing large batches of STRUCTURE results. Instead of manually extracting likelihood values from individual text files, this tool automates the harvesting of Run Numbers, Assumed Populations (K), Estimated Ln Probabilities, and Likelihood Variances. It is essential for researchers performing population structure analysis who need to calculate Delta K (the Evanno method) or prepare data for downstream cluster matching in CLUMPP.

## Command Line Usage

The primary script is `structureHarvester.py`. It requires a directory containing STRUCTURE results (typically files ending in `_f`) and an output directory.

### Basic Data Harvesting
Extract summary statistics from all results in a folder:
```bash
python structureHarvester.py --dir=path/to/results/ --out=path/to/output/
```
*   **Output**: Generates `summary.txt` containing a tab-delimited table of all runs.

### Implementing the Evanno Method
To calculate Delta K and identify the most likely number of genetic clusters:
```bash
python structureHarvester.py --dir=path/to/results/ --out=path/to/output/ --evanno
```
*   **Requirement**: Requires at least 3 sequential values of K and multiple replicates per K.
*   **Output**: Generates `evanno.txt`.

### Preparing for CLUMPP
To generate `.indfile` resources for cluster alignment:
```bash
python structureHarvester.py --dir=path/to/results/ --out=path/to/output/ --clumpp
```
*   **Output**: Generates one `K*.indfile` for each value of K.

## Expert Tips & Best Practices

*   **File Naming**: Ensure your STRUCTURE result files follow the standard naming convention (e.g., `project_run_K_f`). If files have inconsistent naming or whitespace, use the `--rename` flag (available in the perl version `struct_harvest.pl`) to standardize them before processing.
*   **Sequential K**: The Evanno method relies on second-order rates of change. If your results folder is missing a K value in a sequence (e.g., you have K=2, 3, 5 but missing 4), the `--evanno` analysis will fail or produce incomplete results.
*   **Permissions**: On Linux/macOS, ensure the script is executable: `chmod +755 structureHarvester.py`.
*   **Python Version**: This tool is designed for Python 2.x environments (specifically 2.5–2.7). If running in a modern environment, ensure you are using a compatible interpreter or a bioconda environment.

## Reference documentation
- [structureHarvester.py Main Documentation](./references/alumni_soe_ucsc_edu__dearl_software_structureHarvester.md)
- [structureHarvester.py Script Reference](./references/alumni_soe_ucsc_edu__dearl_software_structureHarvester_structureHarvester.md)
- [struct_harvest.pl Perl Legacy Reference](./references/alumni_soe_ucsc_edu__dearl_software_structureHarvester_struct_harvest.md)