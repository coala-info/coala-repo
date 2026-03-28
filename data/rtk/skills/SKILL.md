---
name: rtk
description: RTK performs rarefaction on large-scale count matrices to normalize sampling depth and calculate diversity statistics. Use when user asks to estimate sampling depths, perform rarefaction, generate rarefied count tables, or calculate alpha diversity measures.
homepage: https://github.com/hildebra/Rarefaction/
---


# rtk

## Overview
The Rarefaction Tool Kit (RTK) is a C++11 based utility optimized for processing large-scale count matrices. It allows researchers to normalize sampling depth across different samples to ensure fair comparisons of diversity. This skill provides the necessary command-line patterns to estimate sampling depths, perform rarefaction, and generate diversity statistics.

## Core Workflows

### 1. Estimating Rarefaction Depth
Before rarefying, determine the column sums to identify the minimum library size.
```bash
rtk colsums -i input.csv -o output_dir/
```
*   **Tip**: Check the `sums.txt` file in the output directory. A common practice is to rarefy to ~95% of the minimum column sum or a specific biological threshold (e.g., 1000 counts).

### 2. Performing Rarefaction
Choose a mode based on your hardware constraints:
*   **memory**: Faster, but requires enough RAM to hold the dataset.
*   **swap**: Uses temporary files; slower but handles datasets larger than available RAM.

**Basic Rarefaction:**
```bash
rtk swap -i input.csv -o output_dir/ -d 1000 -r 100
```
*   `-d`: Depth to rarefy to (can be a comma-separated list for multiple depths).
*   `-r`: Number of iterations (repeats) to calculate diversity measures (default is 10).

**Generating Rarefied Tables:**
By default, RTK only outputs diversity measures. To write the actual rarefied count matrices to disk, use the `-w` flag:
```bash
rtk memory -i input.csv -o output_dir/ -d 1000 -w 1
```
*   `-w`: Number of rarefied tables to export.
*   `-ns`: Use this flag with `-w` to prevent the creation of temporary swap files during table writing if RAM is sufficient.

### 3. Multithreading
For large datasets, always specify the number of threads to significantly reduce processing time:
```bash
rtk swap -i input.csv -o output_dir/ -t 8
```

## Input Data Requirements
*   **Format**: `.csv` or `.tsv` count tables.
*   **Structure**: Rows must be taxa (OTUs/Features) and columns must be Samples.
*   **Uniqueness**: Row and column names must be unique.
*   **Orientation**: Rarefaction is performed on **columns**. If your samples are in rows, you must transpose the data before using RTK.

## Output Files
*   `median_alpha_diversity.tsv`: The primary output containing median diversity measures across all repeats.
*   `richness.tsv`, `evenness.tsv`, etc.: Detailed tables containing results for every individual repeat.
*   `global_diversity.tsv`: Contains ACE, ICE, and Chao2 estimators.
*   `rarefied_to_X_n_Y.tsv`: The actual rarefied matrix (only if `-w > 0`).



## Subcommands

| Command | Description |
|---------|-------------|
| rtk | Reports the column sums of all columns in form of a sorted and an unsorted file. |
| rtk | rarefaction tool kit (rtk) |

## Reference documentation
- [Rarefaction Tool Kit Overview](./references/github_com_hildebra_Rarefaction.md)
- [RTK Tutorial and Examples](./references/github_com_hildebra_Rarefaction_wiki_RTK-Tutorial.md)