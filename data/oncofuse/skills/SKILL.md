---
name: oncofuse
description: Oncofuse is a Bayesian classifier designed to distinguish between driver and passenger gene fusions in cancer genomics data. Use when user asks to prioritize gene fusions, predict the oncogenic potential of fusion candidates, or annotate fusion detection results from tools like TopHat, FusionCatcher, or STAR-Fusion.
homepage: https://github.com/mikessh/oncofuse
---


# oncofuse

## Overview
Oncofuse is a Bayesian classifier framework designed to distinguish between "driver" gene fusions (those contributing to oncogenesis) and "passenger" fusions. It analyzes hallmark features of gene fusions, such as protein domain retention and expression gain, to provide a probability score. This tool is essential in cancer genomics workflows after initial fusion detection to prioritize candidates for experimental validation.

## Installation and Setup
The most reliable way to install Oncofuse is via Bioconda:
```bash
conda install bioconda::oncofuse
```
Alternatively, use the Java executable directly (requires Java 7 or higher):
```bash
java -jar Oncofuse.jar [arguments]
```

## Command Line Usage
The basic execution pattern follows a positional argument structure:
```bash
java -Xmx1G -jar Oncofuse.jar <input_file> <input_type> <tissue_type> <output_file>
```

### Positional Arguments
1.  **input_file**: Path to the fusion detection results.
2.  **input_type**: The format of the input file. Supported types:
    *   `coord`: Standard Oncofuse tab-delimited format.
    *   `tophat`: Output from Tophat-fusion or Tophat2 (`fusions.out`).
    *   `tophat-post`: Output from Tophat-fusion-post.
    *   `fcatcher`: Output from FusionCatcher.
    *   `rnastar`: Output from RNA-STAR.
    *   `starfusion`: Output from STAR-Fusion.
3.  **tissue_type**: The tissue of origin for the sample:
    *   `EPI`: Epithelial
    *   `HEM`: Hematopoietic
    *   `MES`: Mesenchymal
    *   `AVG`: Averaged (use if the specific tissue type is unknown)
4.  **output_file**: Path for the resulting tab-delimited annotation table.

### Optional Flags
*   `-a <assembly>`: Specify genome assembly. Supported: `hg18`, `hg19` (default), or `hg38`.
*   `-p <threads>`: Number of threads to use for parallel processing.

## Common Workflow Patterns

### Processing FusionCatcher Results
When using FusionCatcher output, ensure you specify the correct assembly if it differs from hg19 (e.g., hg38 is common in newer versions):
```bash
java -Xmx1G -jar Oncofuse.jar fusions.txt fcatcher EPI output_annotated.txt -a hg38
```

### Using the Coordinate (coord) Format
If your fusion caller is not natively supported, format your data into a tab-delimited file with the following columns:
`5' chrom | 5' coord | 3' chrom | 3' coord | tissue_type`

When using `coord` as the input type, set the third positional argument (`tissue_type`) to `-` because the tissue type is read from the file itself:
```bash
java -Xmx1G -jar Oncofuse.jar my_fusions.coord coord - output_annotated.txt
```

## Interpreting Results
Focus on these key columns in the output:
*   **DRIVER_PROB**: The Bayesian probability (0 to 1) that the fusion is a driver. Higher values indicate higher oncogenic potential.
*   **P_VAL_CORR**: Bonferroni-corrected P-value indicating the probability that the fusion is a passenger.
*   **EXPRESSION_GAIN**: Calculated expression change resulting from the fusion.
*   **5_DOMAINS_RETAINED / 3_DOMAINS_RETAINED**: Lists of functional protein domains preserved in the fusion product.

## Expert Tips
*   **Memory Allocation**: For large datasets, increase the Java heap size (e.g., `-Xmx4G`) to prevent OutOfMemory errors during annotation.
*   **Assembly Matching**: Always verify the genome assembly used by your upstream fusion caller. Providing hg38 coordinates to Oncofuse while it defaults to hg19 will result in incorrect or empty annotations.
*   **Frame Awareness**: Oncofuse reports whether a fusion is in-frame (`FPG_FRAME_DIFFERENCE = 0`) but calculates driver probability regardless of frame, as biological mechanisms (like internal ribosome entry sites) can sometimes rescue out-of-frame fusions.

## Reference documentation
- [Oncofuse GitHub Repository](./references/github_com_mikessh_oncofuse.md)
- [Bioconda Oncofuse Package](./references/anaconda_org_channels_bioconda_packages_oncofuse_overview.md)