---
name: dnp-corrprofile
description: This tool calculates the Pearson correlation coefficient between dinucleotide frequency distributions on forward and reverse-complement DNA strands to identify structural symmetry. Use when user asks to evaluate nucleosome positioning symmetry, pinpoint the dyad axis of a nucleosome signal, or compute correlation profiles from dinucleotide frequency matrices.
homepage: https://github.com/erinijapranckeviciene/dnpatterntools
---


# dnp-corrprofile

## Overview

The `dnp-corrprofile` tool is a core component of the `dnpatterntools` suite. It calculates the Pearson correlation coefficient between dinucleotide frequency distributions on the forward strand and their corresponding patterns on the reverse-complement strand. 

In the context of chromatin research, this tool is essential for validating the rotational and translational symmetry of nucleosome-bound DNA. By correlating these profiles, researchers can pinpoint the dyad axis (center) of a nucleosome positioning signal. It typically operates on frequency matrices generated from aligned FASTA sequences.

## Installation and Setup

The tool is available via Bioconda and is built using the SeqAn C++ library.

```bash
# Install via conda
conda install dnp-corrprofile -c bioconda
```

## Usage Patterns

### Core Workflow Integration
`dnp-corrprofile` is designed to be used after dinucleotide frequencies have been calculated. The standard pipeline is:
1. **Generate Profiles**: Use `dnp-diprofile` to create frequency distributions from aligned FASTA sequences.
2. **Compute Correlation**: Run `dnp-corrprofile` on the resulting profile to evaluate symmetry.

### Command Line Execution
While specific flags for the binary follow SeqAn conventions, the tool is often invoked through the provided shell wrapper in the `dnpatterntools` suite:

```bash
# Using the shell wrapper for correlation analysis
dnp-correlation-between-profiles.sh [input_profile] [output_correlation]
```

### Functional Details
- **Input**: A matrix or distribution file representing dinucleotide frequencies (e.g., AA, TT, or WW/SS patterns).
- **Output**: A correlation profile that indicates the strength of the relationship between the two strands across the sequence length.
- **Key Metric**: High Pearson correlation at specific offsets indicates strong structural symmetry, characteristic of high-quality nucleosome positioning sequences.

## Expert Tips and Best Practices

- **Data Preparation**: Ensure sequences are properly aligned (e.g., centered on a known genomic feature) before generating the profiles that `dnp-corrprofile` will analyze.
- **Symmetrization**: Use this tool to verify the success of symmetrization operations. A successful symmetrization should result in a high correlation between the forward and reverse-complement profiles.
- **Composite Profiles**: When working with WW (A/T) or SS (C/G) dinucleotides, use the correlation profile to identify the 10-11 bp periodicity typical of nucleosomal DNA.
- **Troubleshooting**: If correlation is unexpectedly low, check for strand-specific biases in the input MNase-Seq data or errors in the initial dinucleotide frequency calculation step (`dnp-diprofile`).

## Reference documentation
- [dnpatterntools Main Repository](./references/github_com_erinijapranckeviciene_dnpatterntools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dnp-corrprofile_overview.md)