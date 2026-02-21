---
name: vclean
description: vclean is an automated command-line pipeline designed to identify and mitigate contamination within viral genome assemblies.
homepage: https://github.com/TsumaR/vclean
---

# vclean

## Overview
vclean is an automated command-line pipeline designed to identify and mitigate contamination within viral genome assemblies. It is specifically tailored for environmental viromics, where a single viral bin or scaffold may inadvertently contain sequences from multiple distinct viruses. The tool calculates contamination probabilities and provides a "purified" output by isolating the longest contigs from sequences flagged as contaminated.

## Installation and Setup
vclean requires Python 3.9 and is best managed via Conda.

```bash
# Install vclean
conda install -c conda-forge -c bioconda vclean python=3.9
```

### Database Initialization
Before running the analysis, you must download the required databases. This is a one-time setup step.

```bash
# Download database to a specific directory
vclean download_database /path/to/database_dir
```

### Environment Configuration
To avoid specifying the database path in every command, set the `VCLEANDB` environment variable:

```bash
export VCLEANDB=/path/to/database_dir
```

## Command Usage

### Running the Pipeline
The primary command processes a directory of FASTA files.

```bash
vclean run <input_fasta_dir> <output_dir> [options]
```

**Key Arguments:**
- `<input_fasta_dir>`: Path to the directory containing your viral genome FASTA files.
- `<output_dir>`: Path where results will be stored.
- `-d <path>`: (Optional) Manually specify the database path if `VCLEANDB` is not set.

## Output Interpretation
The tool generates three primary outputs in the specified `<output_dir>`:

1.  **Contamination_probability.tsv**: The main report containing the calculated risk scores for each input sequence.
2.  **feature_table.tsv**: Detailed genomic features used by the model to determine contamination status.
3.  **purified_fasta/**: A subdirectory containing new FASTA files for sequences confirmed as contaminated. These files contain only the longest contigs to reduce the risk of multi-virus chimeras.

## Best Practices
- **Python Version**: Ensure your environment is strictly using Python 3.9, as newer versions may cause dependency conflicts with the underlying machine learning models.
- **Input Organization**: Place all genomes to be analyzed in a single directory. vclean processes the entire directory as a batch.
- **Resource Management**: For large datasets, ensure the machine has sufficient memory for the database to be loaded into context during the feature extraction phase.

## Reference documentation
- [vClean GitHub Repository](./references/github_com_TsumaR_vclean.md)
- [vClean Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vclean_overview.md)