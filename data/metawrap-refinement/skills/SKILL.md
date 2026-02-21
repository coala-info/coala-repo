---
name: metawrap-refinement
description: The `metawrap-refinement` skill provides a specialized workflow for the bin consolidation phase of metagenomic analysis.
homepage: https://github.com/bxlab/metaWRAP
---

# metawrap-refinement

## Overview
The `metawrap-refinement` skill provides a specialized workflow for the bin consolidation phase of metagenomic analysis. Instead of relying on a single binning algorithm, this tool takes the outputs of up to three different binning predictions and uses a hybrid approach to identify the best version of each bin. By evaluating bins with CheckM, it selectively merges and filters contigs to optimize the final genome-resolved metagenomic data. This module is a standalone component of the MetaWRAP suite and is recognized for outperforming other consolidation tools like DAS_Tool or Binning_refiner.

## Usage Instructions

### Core Command Pattern
The refinement module is typically invoked through the main `metawrap` wrapper:
```bash
metawrap bin_refinement -o OUTPUT_DIR -t THREADS -A BIN_SET_A -B BIN_SET_B -C BIN_SET_C [options]
```

### Input Requirements
- **Bin Sets**: You must provide at least two (and up to three) folders containing bins in FASTA format. These can come from different software (e.g., MetaBAT2, MaxBin2, CONCOCT) or the same software run with different parameters.
- **File Extensions**: Ensure all bins in the input folders end with the `.fa` or `.fasta` extension.

### Key Parameters and Thresholds
- `-c [INT]`: Minimum completion percentage (default is often 50 or 70).
- `-x [INT]`: Maximum contamination percentage (default is often 10 or 5).
- `-t [INT]`: Number of CPU cores. This process is computationally intensive; 8+ cores are recommended.

### Expert Tips and Best Practices
- **Resource Allocation**: This module requires significant memory due to its reliance on CheckM. Ensure the system has at least 64GB of RAM available for large datasets.
- **Input Cleaning**: A known issue in `bin_refinement.sh` is the accidental copying of non-FASTA files (like `.txt` or log files) into the output directory, which can cause CheckM to crash. Always ensure input directories contain only the bin FASTA files.
- **Bin Reassembly**: For maximum quality, it is recommended to follow the refinement step with the `metawrap reassemble_bins` module. This uses the refined bins to extract reads and perform a more permissive, non-metagenomic assembly to improve N50 and completion.
- **Database Configuration**: Ensure the `config-metawrap` file is correctly pointed to your CheckM and NCBI databases before running, as the refinement process will fail if it cannot locate the evaluation data.

## Reference documentation
- [MetaWRAP GitHub Repository](./references/github_com_bxlab_metaWRAP.md)
- [MetaWRAP Issues - Non-FASTA file bug](./references/github_com_bxlab_metaWRAP_issues.md)
- [Bioconda metawrap-refinement Overview](./references/anaconda_org_channels_bioconda_packages_metawrap-refinement_overview.md)