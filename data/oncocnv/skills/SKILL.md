---
name: oncocnv
description: ONCOCNV identifies copy number changes in high-depth sequencing data such as targeted panels and whole-exome sequencing. Use when user asks to detect genomic gains and losses, identify copy number variations, or perform gene-level copy number assessment.
homepage: https://github.com/BoevaLab/ONCOCNV/blob/master/README.md
---


# oncocnv

## Overview
ONCOCNV is a specialized tool designed to identify copy number changes in high-depth sequencing data, such as targeted panels and whole-exome sequencing. It utilizes a baseline of control samples to normalize read counts, accounting for GC content and other biases, and applies segmentation algorithms to predict genomic gains and losses. It is particularly effective for clinical sequencing where precise gene-level copy number assessment is required.

## Input Requirements and Preparation

### 1. Reference Genome
*   Provide the fasta sequence as a single, unzipped file (e.g., `hg19.fa`).
*   Ensure the reference matches the one used for BAM alignment.

### 2. Amplicon BED File
The BED file must follow a specific 6-column format. ONCOCNV relies on the 4th and 6th columns for identification:
*   **Column 4**: Amplicon ID (must be unique).
*   **Column 6**: Gene Symbol (mandatory).
*   **Constraint**: Gene names must represent genomic loci; do not use the same string for both Amplicon ID and Gene Name, as the tool expects multiple amplicons per gene.
*   **Sorting**: Coordinates must be sorted and duplicates removed before running.

### 3. Sample Files
*   **Test Samples**: Aligned reads in `.bam` format.
*   **Control Samples**: At least 3 control BAM files are recommended to construct a reliable baseline. While the tool can run with as few as 1 or 2 controls in newer versions, performance and specificity improve significantly with 3 or more.

## Execution Workflow

ONCOCNV is typically executed via a master shell script (`ONCOCNV.sh`).

### Configuration
Before execution, edit the top section of `ONCOCNV.sh` to define:
1.  **Paths**: Locations for `samtools`, `bedtools`, and `R`.
2.  **Files**: Paths to the reference fasta, the amplicon BED file, and the directories containing BAM files.
3.  **Permissions**: Ensure the script is executable:
    ```bash
    chmod +rwx PathToONCOCNV/scripts/ONCOCNV.sh
    ```

### Running the Tool
Execute from the command line:
```bash
cd PathToONCOCNV/scripts
./ONCOCNV.sh
```

## Interpreting Results

The tool generates three primary output files per sample:

### 1. Gene Summary (`*.summary.txt`)
This is the primary file for clinical interpretation.
*   **copy.number**: Predicted copy number (raw prediction).
*   **p.value / q.values**: Statistical significance of the CNV status for the region encompassing the gene.
*   **comments**: Indicates if there is a "break" within a gene (where the gene's copy number doesn't match the surrounding segment).

### 2. Amplicon Profile (`*.profile.txt`)
Provides granular data for every targeted region.
*   **ratio**: Logarithm of the normalized read count (0 = neutral).
*   **predLargeCorrected**: Final segment-based prediction.
*   **perGeneEvaluation**: Prediction based solely on the gene, independent of segmentation.

### 3. Visual Profile (`*.profile.png`)
A graphical representation of the copy number across the genome.
*   **Brown**: Gain (>1 level gain is dark brown).
*   **Blue**: Loss (>1 level loss is dark blue).
*   **Green**: One-point outlier (potential technical artifact or very small focal event).

## Best Practices
*   **Environment**: Ensure `MASS`, `mclust`, `PSCBS`, and `DNAcopy` R libraries are installed.
*   **Path Management**: If tools are not in the global PATH, use `export PATH=$PATH:/your/path` within the `ONCOCNV.sh` script to ensure the Perl and R components can find their dependencies.
*   **Baseline Consistency**: Use controls processed with the same library preparation and sequencing run as the test samples to minimize batch effects.

## Reference documentation
- [ONCOCNV GitHub README](./references/github_com_BoevaLab_ONCOCNV_blob_master_README.md)
- [ONCOCNV Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_oncocnv_overview.md)