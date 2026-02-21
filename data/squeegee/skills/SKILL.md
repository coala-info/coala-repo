---
name: squeegee
description: Squeegee is a computational tool designed for the de novo detection of contaminants in metagenomic sequencing data.
homepage: https://gitlab.com/treangenlab/squeegee
---

# squeegee

## Overview
Squeegee is a computational tool designed for the de novo detection of contaminants in metagenomic sequencing data. Unlike database-dependent methods that look for specific known contaminants, Squeegee identifies potential contaminants by analyzing the distribution, prevalence, and genomic characteristics of taxa across a set of samples. It integrates k-mer based distances (via Mash), read alignment (via Bowtie2), and statistical scoring to differentiate between true sample constituents and contaminants.

## Installation and Setup
Install Squeegee using Conda from the Bioconda channel:
```bash
conda install bioconda::squeegee
```
Note: If `kmer-mask` is not found during execution, ensure you are using `meryl` version 2013-0, as newer versions (like 1.2) may cause compatibility issues.

## Core Workflow and CLI Usage
The tool typically requires a metadata file describing the samples and the metagenomic read files (FastQ).

### Key Parameters and Thresholds
When running Squeegee or interpreting its scoring logic, the following parameters significantly impact the sensitivity of contamination detection:
- **Prevalence (`min_prevalence`)**: The minimum frequency a taxon must appear across samples to be considered a potential contaminant (default is often 0.6).
- **Abundance (`min_abundance`)**: The minimum relative abundance (e.g., 0.0005) required for a taxon to be included in the analysis.
- **Read Count (`min_reads`)**: The minimum number of reads (e.g., 30) required for a taxon to be processed.
- **Alignment Score (`min_align`)**: Threshold for the alignment-based evidence (default ~0.075).
- **Combined Score (`min_score`)**: The final threshold (default ~0.75) that integrates Mash scores, alignment scores, and prevalence to make a final prediction.

### Output Files
Squeegee generates several key files in the specified output directory:
- `final_predictions.txt`: The primary output containing taxa flagged as contaminants with their associated scores.
- `potential_contaminants.txt`: A list of candidate taxa identified before final scoring.
- `genome_depth.txt` and `genome_coverage.txt`: Detailed metrics on how reads map to the candidate contaminant genomes.

## Expert Tips and Troubleshooting
- **Large SAM Files**: Squeegee uses Bowtie2 for alignment. If you encounter extremely large SAM files (e.g., >1TB) or excessive runtimes, it is often due to the `-a` (report all alignments) flag. Consider modifying the underlying call to use `--end-to-end` or `--very-fast` if the tool allows parameter passthrough, or ensure your input dataset is subsampled if appropriate.
- **Empty Sequence Errors**: If the tool fails with `ValueError: max() arg is an empty sequence` during the Mash scoring phase, it usually indicates that no taxa in your samples met the initial `min_reads` or `min_abundance` thresholds. Lower these thresholds for very small or low-diversity datasets.
- **TaxID Inconsistency**: If you encounter a `KeyError` related to TaxIDs during the final prediction phase, check for inconsistencies between `potential_contaminants.txt` and `genome_depth.txt`. This can occur if the genome fetching step fails to properly clean up false-positive microbe entries.
- **Memory Management**: For large-scale metagenomic projects, monitor the Mash and Bowtie2 stages, as these are the most resource-intensive components of the Squeegee pipeline.

## Reference documentation
- [squeegee - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_squeegee_overview.md)
- [Squeegee activity (GitLab Atom Feed)](./references/gitlab_com_treangenlab_squeegee.atom.md)
- [treangenlab / Squeegee · GitLab](./references/gitlab_com_treangenlab_squeegee.md)