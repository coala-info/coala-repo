---
name: pydamage
description: PyDamage is a bioinformatics tool that assesses ancient DNA authenticity by modeling C-to-T transition patterns and performing statistical significance testing. Use when user asks to estimate DNA damage parameters, filter ancient DNA contigs from modern contaminants, or perform likelihood ratio tests on alignment files.
homepage: https://github.com/maxibor/pydamage
---


# pydamage

## Overview

PyDamage is a specialized bioinformatics tool for assessing the authenticity of ancient DNA. It models the characteristic C-to-T transitions found at the ends of ancient DNA fragments and applies a likelihood ratio test to determine if the observed damage pattern is statistically significant. This helps researchers filter out modern contaminants from their datasets by providing a robust statistical framework for damage estimation at the contig level.

## Installation

The recommended way to install pydamage is via Conda:

```bash
conda install -c bioconda pydamage
```

Alternatively, it can be installed via pip:

```bash
pip install pydamage
```

## Command Line Usage

### Core Analysis
The primary command for estimating damage parameters from an alignment file.

```bash
pydamage --outdir <output_directory> analyze <aligned.bam>
```

### Filtering Results
After running the analysis, use the filter subcommand to process the resulting CSV file based on statistical significance.

```bash
pydamage --outdir <output_directory> filter pydamage_results.csv
```

## Expert Tips and Best Practices

- **Argument Ordering**: A critical syntax requirement in pydamage is that global options, such as `--outdir`, must be specified **before** the subcommand (analyze or filter).
- **Input Requirements**: Ensure your BAM files are properly aligned to a reference. PyDamage relies on the C-to-T transition patterns relative to the reference sequence.
- **Likelihood Ratio Test (LRT)**: Use the LRT results provided in the output CSV to discriminate between truly ancient contigs and modern sequences. A higher likelihood ratio typically indicates a more confident ancient origin.
- **Output Interpretation**: The tool generates a `pydamage_results.csv` file. Key columns include the damage estimates and the p-values from the likelihood ratio test.
- **Visualization**: Recent versions of pydamage include features for generating bin damage plots to visualize the distribution of damage across contigs.

## Reference documentation

- [PyDamage GitHub Repository](./references/github_com_maxibor_pydamage.md)
- [PyDamage Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pydamage_overview.md)