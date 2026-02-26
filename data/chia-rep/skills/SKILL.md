---
name: chia-rep
description: The chia-rep tool quantifies the reproducibility and similarity between ChIA-PET datasets by comparing genomic loop and peak adjacency matrices. Use when user asks to calculate similarity scores between ChIA-PET samples, prepare sample configuration files, or assess the reproducibility of genomic interaction data.
homepage: https://github.com/c0ver/chia_rep
---


# chia-rep

## Overview
The `chia-rep` tool is a Python-based package designed to quantify the similarity between ChIA-PET datasets. It processes genomic loops and peaks to create adjacency matrices, which are then compared across non-overlapping windows. This skill helps users navigate the multi-step workflow of preparing input files (bedgraph, broadpeak, and loop files), defining comparison pairs, and executing the reproducibility script to obtain genome-wide or chromosome-specific similarity scores.

## Input Data Requirements
Before running the analysis, ensure your data directory contains the following file types for each sample:
- **Bedgraph files** (`.bedgraph`): Used to determine peak values and anchor intensities.
- **Peak files** (`.broadpeak`): Used to identify peak intervals.
- **Loop files** (`.cis.be3`): Containing the interaction data between genomic intervals.

## Workflow and CLI Patterns

### 1. Prepare Sample Lists and Pairs
Create a `sample_list.txt` containing one sample ID per line. Use the `commands.py` utility (found in the `example/` directory of the repository) to generate the necessary configuration files.

```bash
# Generate a pairs file for comparison
python commands.py make-pairs sample_list.txt pairs.txt

# Generate the master sample input file mapping IDs to file paths
# This assumes standard extensions: .bedgraph, .broadpeak, and .cis.be3
python commands.py make-sample-input-file sample_list.txt sample_input_file.txt data_directory/
```

### 2. Execute Reproducibility Analysis
The core analysis is typically performed via `script.py`. The tool requires specific parameters for window size and binning.

**Command Syntax:**
`python script.py <sample_input_file> <chrom_sizes> <pairs_file> <window_size> <bin_size> <chromosomes>`

**Common Patterns:**
- **Analyze a specific chromosome:**
  ```bash
  python script.py sample_input_file.txt hg38.chrom.sizes pairs.txt 3000000 5000 chr1
  ```
- **Analyze the entire genome:**
  ```bash
  python script.py sample_input_file.txt hg38.chrom.sizes pairs.txt 3000000 5000 all
  ```

### 3. Interpreting Results
- **Threshold:** The tool transforms divergence values to a scale of -1 to 1.
- **Positive Values:** Generally indicate biological or technical replicates (similar).
- **Negative Values:** Generally indicate non-replicates (dissimilar).
- **Zero:** Often used as the baseline threshold for determining similarity.

## Expert Tips
- **Deadzone Filtering:** The tool automatically removes "deadzone" loops (loops starting and ending on the same peak or with inverted coordinates) to reduce noise.
- **Peak Filtering:** By default, the tool filters out peaks smaller than a specific value and ignores loops where neither anchor overlaps with a kept peak.
- **Memory Management:** When running "all" chromosomes, ensure sufficient RAM is available for adjacency matrix construction, or process chromosomes individually to reduce the memory footprint.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_TheJacksonLaboratory_chia_rep.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_chia-rep_overview.md)