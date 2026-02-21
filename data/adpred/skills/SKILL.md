---
name: adpred
description: The provided text does not contain help information for the tool 'adpred'. It contains error logs from a container runtime (Apptainer/Singularity) indicating a failure to build the image due to lack of disk space.
homepage: https://github.com/FredHutch/adpred
---

# adpred

## Overview
adpred is a bioinformatics tool used to identify and analyze Transcription Activation Domains (ADs) within protein sequences. It allows researchers to pinpoint functional regions and conduct in silico saturated mutagenesis to understand how specific amino acid changes impact AD function.

## Installation
The tool is available via the Bioconda channel:
```bash
conda install bioconda::adpred
```

## Command Line Usage
The primary interface for the tool is the `run-adpred` script.

### Basic Prediction
To run a standard prediction on a protein sequence:
```bash
run-adpred -i <input_fasta_or_sequence> -o <output_directory>
```

### Saturated Mutagenesis
To perform a saturated mutagenesis study on identified regions to reveal critical residues:
```bash
run-adpred -i <input_sequence> -sm
```
*Note: The `-sm` flag triggers the saturated mutagenesis workflow.*

### Output Files
*   **Predictions**: Results are typically saved in a CSV format (e.g., `.predictions.csv`).
*   **Columns**: The output includes probability scores for AD function across the sequence, often with additional labels for identified regions.

## Best Practices and Tips
*   **Sequence Length**: For saturated mutagenesis, ensure the target sequence region is appropriately sized (ideally around 30 amino acids or as specified by the model constraints).
*   **Model Files**: The tool relies on a pre-trained model file (`ADpred.h5`). Ensure the environment is correctly set up so the script can locate the model directory.
*   **Data Interpretation**: High probability scores in the output CSV indicate potential activation domains. Use these regions as the starting point for further mutagenesis analysis.

## Reference documentation
- [adpred - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_adpred_overview.md)
- [GitHub - FredHutch/adpred](./references/github_com_FredHutch_adpred.md)
- [Commits · FredHutch/adpred](./references/github_com_FredHutch_adpred_commits_master.md)