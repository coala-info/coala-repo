---
name: bold-identification
description: This tool performs automated taxonomic assignment by matching input sequences against the BOLD Systems reference libraries via API. Use when user asks to identify species from DNA sequences, perform taxonomic classification using COI, ITS, or MATK_RBCL markers, or detect chimeric sequences in barcoding data.
homepage: https://github.com/linzhi2013/bold_identification
---


# bold-identification

## Overview
The `bold-identification` tool is a specialized utility for automated taxonomic assignment. It interfaces with the BOLD Systems API to match input sequences (typically in FASTA format) against curated reference libraries. It is designed to handle common bioinformatics challenges such as network-related timeouts and potential chimeric sequences, providing a robust workflow for high-throughput barcoding projects.

## Command Line Usage

### Basic Identification
To run a standard identification against the default COX1 database:
```bash
bold_identification -i input.fasta -o output_prefix
```

### Database Selection
Specify the target database based on your marker or taxonomic group using the `-d` flag:
*   **Animals (COI):** `COX1`, `COX1_SPECIES`, `COX1_SPECIES_PUBLIC`, or `COX1_L640bp`
*   **Fungi:** `ITS`
*   **Plants:** `MATK_RBCL`

Example for plant sequences:
```bash
bold_identification -i plants.fasta -d MATK_RBCL -o plant_results
```

### Handling Network Issues and Resuming
The tool is sensitive to network stability. If a run is interrupted or encounters `TimeoutException` errors:
1.  **Increase Retries:** Use `-r` to increase the maximum submission attempts per sequence (default is 4).
2.  **Continuous Mode:** Use `-c` to skip sequences already present in the output file and resume the search.
3.  **Aggressive Skip:** Use `-cc` to skip both successful matches and sequences previously flagged as having no BOLD match.

```bash
bold_identification -i input.fasta -o results -c -r 10
```

### Chimera Detection
For quality control, use the `-C` flag to perform a chimera check. The tool will query the BOLD database using subsequences from the 5' and 3' ends separately.
*   **Subsequence Length:** Adjust the length of the end-sequences with `-q` (default is 400bp).

```bash
bold_identification -i sequences.fasta -o check_results -C -q 300
```

## Expert Tips and Best Practices
*   **Output Files:** The tool generates several files based on the prefix provided with `-o`. Monitor `*.TimeoutException.fasta` for sequences that failed due to network issues and `*.NoBoldMatchError.fasta` for sequences with no database hits.
*   **Top Hits:** By default, only the top hit is returned. Use `-n <int>` to retrieve multiple top hits if you need to evaluate taxonomic ambiguity.
*   **Input Format:** While FASTA is the default, ensure your headers are unique and concise to avoid parsing issues in downstream analysis.
*   **Conda Installation:** If using the Bioconda version, ensure your environment is updated to avoid dependency conflicts with Python 3 requirements.

## Reference documentation
- [GitHub Repository and Usage Guide](./references/github_com_linzhi2013_bold_identification.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bold-identification_overview.md)