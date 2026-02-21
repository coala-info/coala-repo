---
name: perl-snap
description: The `perl-snap` tool (Synonymous Non-synonymous Analysis Program) provides a command-line implementation of the Nei-Gojobori algorithm.
homepage: https://www.hiv.lanl.gov/content/sequence/SNAP/SNAP.html
---

# perl-snap

## Overview
The `perl-snap` tool (Synonymous Non-synonymous Analysis Program) provides a command-line implementation of the Nei-Gojobori algorithm. It is used to determine whether a set of sequences is undergoing purifying selection, neutral evolution, or positive selection by comparing the rates of substitutions that change amino acids versus those that do not. It is most effective when working with high-quality, codon-aware alignments in table or FASTA-like formats.

## Usage Guidelines

### Input Requirements
*   **Codon Alignment**: Sequences must be pre-aligned and the alignment must be "in-frame." The total length of each sequence must be a multiple of three.
*   **Format**: While the web version accepts various formats, the CLI tool typically expects a simple interleaved or sequential alignment format (often referred to as "table format" in the documentation).

### Common CLI Patterns
Since `perl-snap` is often distributed as a Perl script via Bioconda, it is typically invoked as:
```bash
snap [input_file]
```
If the environment requires explicit Perl invocation:
```bash
perl snap.pl [input_file]
```

### Best Practices
*   **Handle Stop Codons**: Ensure your sequences do not contain internal stop codons unless you specifically intend to analyze truncated proteins, as these can skew the Nei-Gojobori calculations.
*   **Gap Treatment**: Be consistent with how gaps are treated. Most implementations of SNAP exclude codons where any of the sequences in the pairwise comparison have a gap.
*   **Large Datasets**: For large alignments, the number of pairwise comparisons grows quadratically ($N(N-1)/2$). Consider subsetting sequences if the computational time becomes prohibitive.
*   **Output Interpretation**:
    *   **dN > dS**: Suggests positive (diversifying) selection.
    *   **dN < dS**: Suggests purifying (negative) selection.
    *   **dN ≈ dS**: Suggests neutral evolution.

### Expert Tips
*   **Cumulative Analysis**: When analyzing specific domains (like HIV Env), look for the cumulative behavior of substitutions across the coding region to identify specific "hotspots" of selection.
*   **Transition/Transversion Bias**: Note that the basic Nei-Gojobori method assumes a transition/transversion ratio of 0.5. If your organism has a high transition bias, consider using more complex models (like PAML or HyPhy) to validate critical findings.

## Reference documentation
- [SNAP: Synonymous Non-synonymous Analysis Program](./references/www_hiv_lanl_gov_content_sequence_SNAP_SNAP.html.md)
- [Bioconda perl-snap Overview](./references/anaconda_org_channels_bioconda_packages_perl-snap_overview.md)