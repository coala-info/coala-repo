---
name: 3seq
description: "Could not get help from Singularity for: 3seq"
homepage: https://mol.ax/software/3seq/
---

# 3seq

## Overview

3seq is a specialized bioinformatics tool used to identify mosaic recombination signals within sequence alignments. By analyzing every possible triplet in a dataset, it determines if one sequence (the child) is a recombinant of the other two (the parents). This tool is particularly useful for viral and bacterial evolutionary studies where horizontal gene transfer or recombination events are suspected. It relies on pre-computed or self-generated p-value tables to provide statistical significance for detected mosaicism.

## Usage Instructions

### 1. Initial Setup and Verification
Before running a full analysis, verify your alignment file and the 3seq installation.
- **Check alignment:** Use the `-i` flag to get basic information about your sequences.
  ```bash
  3seq -i input_alignment.fasta
  ```

### 2. Managing P-Value Tables
3seq requires a p-value table to perform statistical tests. You must either download a pre-computed table or generate one for your specific dataset size.
- **Generate a table:** If your dataset has up to 500 sequences, generate a 500x500x500 table.
  ```bash
  3seq -g myPvalueTable500 500
  ```
- **Note:** Keep the p-value table on the same filesystem type (e.g., ext4, NTFS) as the executable to prevent read errors.

### 3. Running Recombination Analysis
To perform the actual recombination test, provide the alignment, the p-value table, and a run identifier.
- **Standard Run:**
  ```bash
  3seq -f input_alignment.aln -ptable myPvalueTable500 -id myAnalysisRun
  ```
- **Subsampling Mode:** Newer versions (v1.7+) support a mode where the alignment can be repeatedly subsampled and tested.

### 4. Interpreting Results
3seq generates several output files prefixed with your `-id` string:
- **.3s.log:** Contains the screen output and summary statistics. Look for the rejection of "clonal evolution" to confirm recombination.
- **.3s.rec:** A tab-delimited file containing the core results:
  - **Columns 1 & 2:** Potential parent sequences.
  - **Column 3:** The identified recombinant (child) sequence.
  - **Columns 7-11:** Various p-value formats.
  - **Final Columns:** Estimated breakpoint ranges.

## Best Practices and Tips
- **Input Formats:** 3seq accepts both Phylip and aligned FASTA formats. Ensure your sequences are properly aligned before processing.
- **Performance:** For large datasets, building the p-value table is a one-time cost. Once generated, 3seq will remember the table association, and you may omit the `-ptable` flag in subsequent runs within the same environment.
- **System Compatibility:** If using the pre-computed binary tables, ensure you are on a 64-bit system.
- **Citation:** When publishing results, cite Lam et al. (2018) for the algorithmic complexity improvements and Boni et al. (2007) for the core statistical method.

## Reference documentation
- [3SEQ Recombination Detection Algorithm](./references/mol_ax_software_3seq.md)
- [3seq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_3seq_overview.md)