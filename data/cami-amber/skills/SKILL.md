---
name: cami-amber
description: AMBER (Assessment of Metagenome BinnERs) provides a standardized framework for evaluating genome reconstructions from metagenomic data.
homepage: https://github.com/CAMI-challenge/AMBER
---

# cami-amber

## Overview
AMBER (Assessment of Metagenome BinnERs) provides a standardized framework for evaluating genome reconstructions from metagenomic data. It transforms raw binning outputs into actionable insights by measuring how closely they match a known gold standard. This skill assists in executing the `amber.py` tool, managing input formats, and interpreting the resulting metrics like the Adjusted Rand Index and UniFrac distances.

## Core CLI Usage
The primary entry point is the `amber.py` script.

### Basic Evaluation
To evaluate one or more binning results against a gold standard:
`amber.py -g gold_standard.binning -l "Tool_A, Tool_B" tool_a_results.binning tool_b_results.binning -o output_directory/`

### Key Arguments
- `-g, --gold_standard_file`: Path to the ground truth mapping file (Bioboxes format).
- `-l, --labels`: Comma-separated names for the programs being evaluated (must match the order of positional bin files).
- `-o, --output_dir`: Directory where HTML reports and metrics will be saved.
- `-p, --filter`: Filter out the [X]% smallest genome bins (e.g., `-p 1` to filter the smallest 1%).
- `-n, --min_length`: Minimum length of sequences to consider.
- `-x, --min_completeness`: Comma-separated list of thresholds (default: 50, 70, 90).
- `-y, --max_contamination`: Comma-separated list of thresholds (default: 10, 5).

## Taxonomic Binning
When assessing taxonomic assignments, AMBER requires the NCBI taxonomy database.
`amber.py -g gold_standard.binning --ncbi_dir /path/to/ncbi_taxonomy/ bin_files -o output_dir/`
*Note: The NCBI directory must contain `nodes.dmp`, `merged.dmp`, and `names.dmp`.*

## Data Preparation Tips
- **Input Format**: All input files must follow the CAMI binning Bioboxes format.
- **Adding Lengths**: The gold standard requires a `LENGTH` column. If missing, use the utility script:
  `python3 src/utils/add_length_column.py -g input.binning -f sequences.fasta > gold_standard.binning`
- **FASTA to Biobox**: If your bins are currently separate FASTA files, convert them using:
  `python3 src/utils/convert_fasta_bins_to_biobox_format.py bin_*.fasta > predicted_bins.binning`
- **Multi-sample Datasets**: For datasets with multiple samples, concatenate the binnings of different samples into a single file per program. Ensure the `@SampleID` header tag uniquely identifies each sample and matches between the gold standard and predictions.

## Expert Best Practices
- **Filtering Noise**: Use the `-p` flag to remove very small bins that can skew purity and completeness metrics, especially in high-complexity datasets.
- **Removing Specific Genomes**: Use the `-r` flag with a list of genomes to exclude specific organisms (e.g., contaminants or common elements) from the evaluation.
- **Silent Mode**: Use `--silent` when running AMBER in automated pipelines to suppress non-essential output.
- **Visualization**: The tool generates an `index.html` file in the output directory. This is the most effective way to view results rankings and comparative visualizations.

## Reference documentation
- [AMBER GitHub Repository](./references/github_com_CAMI-challenge_AMBER.md)
- [Bioconda AMBER Overview](./references/anaconda_org_channels_bioconda_packages_cami-amber_overview.md)