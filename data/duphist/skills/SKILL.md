---
name: duphist
description: The duphist toolkit provides an automated pipeline for reconstructing the duplication history of gene families.
homepage: https://github.com/minjeongjj/DupHIST
---

# duphist

## Overview

The duphist toolkit provides an automated pipeline for reconstructing the duplication history of gene families. It operates by calculating pairwise synonymous substitution rates (Ks) between paralogous genes and using these values as a proxy for evolutionary time. By applying hierarchical clustering to these distance matrices, the tool determines the most likely sequence of duplication events. This skill helps you prepare the necessary input files, configure the substitution models, and interpret the resulting dendrograms and Ks tables.

## Installation and Setup

Install duphist via Bioconda to ensure all dependencies (PRANK, KaKs_Calculator 2.0, R) are correctly managed:

```bash
conda create -n duphist -c bioconda duphist
conda activate duphist
```

## Input Requirements

The tool requires two primary input files. Data integrity is critical as the pipeline performs a strict precheck.

### 1. Coding Sequence (CDS) File
- **Format**: Multi-FASTA.
- **Constraint**: Sequence lengths must be a multiple of 3. Sequences not meeting this requirement are automatically excluded.
- **Naming**: Use unique gene IDs. Avoid special characters like colons (:) or pipes (|) which can break downstream tools like PRANK.

### 2. Gene Group Information File
- **Format**: Tab-delimited (TSV).
- **Structure**: `Species_Abbreviation` | `Group_ID` | `Gene_ID`
- **Critical Rule**: Species abbreviations and Group IDs **must not contain underscores (_)**. The tool uses underscores as internal delimiters (e.g., `Species_Group`).

## Configuration (config.txt)

The pipeline is driven by a configuration file. Below is a template for a standard execution:

```ini
[required_option]
CDS_path = ./data/genes.cds.fa
Group_information = ./data/groups.tsv
Output_directory = ./results

[statistical_option]
# Options: average, median, complete, ward.D, single, or 'all'
Hcluster_method = all
preferred_method_order = average,complete

[kaks_cal_option]
genetic_code = 1
method = MYN

[PRANK_option]
iteration = 5

[program_path]
# Use default names if installed via conda
PRANK = prank
perl = perl
kaks = KaKs_Calculator
R = Rscript

[Result]
result_filename = duplication_summary.txt
result_dendrogram_dir = dendrograms
temp_path = temp_files

[Thread]
thread_num = 4
```

## Execution and Troubleshooting

Run the pipeline by passing the config file:
```bash
duphist config.txt
```

### Expert Tips
- **Precheck Log**: If the tool terminates immediately, check `duphist_precheck.log`. It identifies mismatched gene IDs, invalid group sizes (minimum 2 genes required), or naming convention violations.
- **KaKs_Calculator Versions**: The Bioconda package includes version 2.0. If you require version 3.0, you must install it manually and update the `kaks` path in the `[program_path]` section of your config.
- **Internal Nodes**: In the output `result_table_all.txt`, IDs like `G1`, `G2`, etc., represent inferred internal nodes (duplication events) created during clustering, not actual genes.
- **Clustering Selection**: When `Hcluster_method = all` is used, the tool uses the Cophenetic Correlation Coefficient (CCC) to automatically select the optimal clustering method for your data.

## Reference documentation
- [DupHIST GitHub Repository](./references/github_com_minjeongjj_DupHIST.md)
- [Bioconda duphist Overview](./references/anaconda_org_channels_bioconda_packages_duphist_overview.md)