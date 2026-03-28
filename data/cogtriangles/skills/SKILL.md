---
name: cogtriangles
description: The cogtriangles tool assembles Clusters of Orthologous Groups (COGs) by processing intergenomic symmetric best matches between protein sequences. Use when user asks to identify orthologous protein clusters, assemble COGs, or process reciprocal best hits for functional annotation and evolutionary analysis.
homepage: https://ftp.ncbi.nih.gov/pub/wolf/COGs/COGsoft/
---

# cogtriangles

## Overview
The `cogtriangles` tool is a specialized utility within the COGsoft suite designed to implement a low-polynomial algorithm for the assembly of Clusters of Orthologous Groups (COGs). It processes intergenomic symmetric best matches (also known as reciprocal best hits) to identify and cluster orthologous proteins across different species. This is a critical step in functional annotation and evolutionary analysis, allowing researchers to group proteins that likely share a common ancestral function.

## Usage Instructions

### Data Preparation
Before running the clustering algorithm, the COGsoft workflow typically requires pre-processing of BLAST results.

1.  **Create ID Hashes**: Use `COGmakehash` to create a mapping of protein identifiers.
    ```bash
    COGmakehash -i input_file -o hash.csv
    ```
2.  **Process BLAST Hits**: Use `COGreadblast` to convert standard BLAST output into the format required by the clustering tools.
    ```bash
    COGreadblast -d output_dir -u unfiltered_hits -f filtered_hits -e 1e-10
    ```

### Running cogtriangles
The `cogtriangles` program typically takes the processed hit files and produces the clusters. While specific flags for the `cogtriangles` binary are often environment-dependent, the standard execution pattern involves:

*   **Input**: A file containing symmetric best matches (BeTs) between genomes.
*   **Output**: A list of clusters where each line represents a COG and its constituent protein members.

### Best Practices
*   **E-value Thresholds**: When pre-processing with `COGreadblast`, use a stringent e-value (e.g., `-e 1e-10`) to ensure that only high-confidence orthologs are used for triangle formation.
*   **Symmetric Matches**: Ensure that your input data consists of reciprocal best hits. The algorithm relies on the "triangle" property (if A matches B, B matches C, and C matches A) to form stable clusters.
*   **Genome Coverage**: The algorithm is most effective when comparing a diverse set of genomes; however, ensure that the "self-hits" (paralogs within the same genome) are handled correctly during the `COGreadblast` stage using the `-s` flag.



## Subcommands

| Command | Description |
|---------|-------------|
| COGmakehash | Create a hash file from a list of IDs for COG processing |
| COGreadblast | Processes and filters BLAST results for COG analysis, including options for handling non-contiguous blocks and reciprocal hits. |

## Reference documentation
- [cogtriangles - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cogtriangles_overview.md)
- [Index of /pub/wolf/COGs/COGsoft](./references/ftp_ncbi_nih_gov_pub_wolf_COGs_COGsoft.md)
- [COGsoft.201204.tar Source Code](./references/ftp_ncbi_nih_gov_pub_wolf_COGs_COGsoft_COGsoft.201204.tar.md)