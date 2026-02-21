---
name: dnp-fourier
description: The `dnp-fourier` tool is a specialized utility within the `dnpatterntools` suite used for the signal processing of genomic sequence data.
homepage: https://github.com/erinijapranckeviciene/dnpatterntools
---

# dnp-fourier

## Overview
The `dnp-fourier` tool is a specialized utility within the `dnpatterntools` suite used for the signal processing of genomic sequence data. It performs two primary functions: calculating the periodogram (power spectrum) of dinucleotide frequency patterns and applying smoothing/normalization to those patterns. By transforming spatial dinucleotide distributions into the frequency domain, it allows researchers to identify structural periodicities that govern how DNA wraps around nucleosomes.

## Core CLI Usage
The tool is available as a standalone binary (`dnp-fourier`) or through shell script wrappers that implement specific parts of the nucleosome positioning workflow.

### Computing a Periodogram
To identify periodic signals (like the 10.2–10.5 bp helical pitch of DNA) in a dinucleotide profile:
- Use the wrapper: `dnp-fourier-transform.sh [input_profile] [output_periodogram]`
- The output is a periodogram representing the strength of different frequencies within the sequence stack.

### Smoothing and Normalization
To reduce noise in dinucleotide frequency distributions before visualization or further analysis:
- Use the wrapper: `dnp-smooth.sh [input_profile] [output_smoothed_profile]`
- This process typically involves normalizing the frequency counts and applying a smoothing window to highlight the underlying pattern.

## Workflow Integration
`dnp-fourier` is rarely used in isolation. It is the final analytical step in a standard `dnpatterntools` pipeline:
1. **Extraction**: `dnp-binstrings` converts FASTA to binary occurrences.
2. **Profiling**: `dnp-diprofile` computes the frequency of occurrence across aligned sequences.
3. **Refinement**: `dnp-symmetrize` or `dnp-compute-composite` processes the forward/reverse profiles.
4. **Analysis**: `dnp-fourier` (via `dnp-fourier-transform.sh`) generates the final periodogram to confirm periodicity.

## Best Practices
- **Input Format**: Ensure input files are dinucleotide frequency profiles (typically matrices where rows are positions and columns are frequencies).
- **Data Alignment**: Fourier analysis is most effective when sequences are centered on a known genomic feature (e.g., the dyad axis of a nucleosome).
- **Interpretation**: When reviewing periodograms, look for a distinct peak at the frequency corresponding to ~10bp (frequency $\approx$ 0.1) to validate the presence of nucleosome positioning signals.

## Reference documentation
- [dnpatterntools Overview](./references/github_com_erinijapranckeviciene_dnpatterntools.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_dnp-fourier_overview.md)