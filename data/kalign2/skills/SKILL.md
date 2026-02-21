---
name: kalign2
description: Kalign2 is a command-line utility optimized for speed and scalability in biological sequence alignment.
homepage: http://msa.sbc.su.se/cgi-bin/msa.cgi
---

# kalign2

## Overview
Kalign2 is a command-line utility optimized for speed and scalability in biological sequence alignment. It employs a distance-based alignment strategy that allows it to handle massive datasets—often exceeding 10,000 sequences—without sacrificing significant accuracy. This skill provides the necessary CLI patterns to execute alignments, adjust gap penalties, and manage different sequence types.

## Usage Patterns

### Basic Alignment
To align a set of sequences in a FASTA file and output the results to a new file:
```bash
kalign -i input.fasta -o output.afa
```

### Adjusting Alignment Parameters
For sequences with high divergence, increasing gap penalties can prevent over-gapping:
- **Gap Open Penalty (`-g`):** Default is usually 11.0.
- **Gap Extension Penalty (`-e`):** Default is usually 0.85.
- **Terminal Gap Penalties (`-tg`, `-te`):** Use these to specifically penalize gaps at the ends of sequences.

Example with custom penalties:
```bash
kalign -i input.fasta -o output.afa -g 20.0 -e 1.5
```

### Sequence Type Specification
While kalign2 often detects sequence types automatically, you can force the mode:
- **Protein:** `-p` (default)
- **DNA/RNA:** `-d`

```bash
kalign -d -i genome_fragments.fasta -o aligned_dna.afa
```

### Output Formats
Kalign2 supports several common alignment formats using the `-f` flag:
- **FASTA:** `-f fasta` (default)
- **MSF:** `-f msf`
- **Clustal:** `-f clustal`
- **PHYLIP:** `-f phylip`

```bash
kalign -i input.fasta -o output.aln -f clustal
```

## Expert Tips
- **Large Scale Alignments:** Kalign is one of the few tools that can handle >50,000 sequences on standard hardware. If memory becomes an issue, ensure you are not using the "quiet" mode (`-q`) so you can monitor progress.
- **Quiet Mode:** Use `-q` in automated pipelines to suppress STDOUT progress updates.
- **Feature Detection:** Kalign uses a "LCS" (Longest Common Subsequence) approach for distance calculation, which is why it is significantly faster than hidden Markov model-based aligners.

## Reference documentation
- [Kalign2 Overview](./references/anaconda_org_channels_bioconda_packages_kalign2_overview.md)
- [Kalign Web and Tool Info](./references/msa_sbc_su_se_cgi-bin_msa.cgi.md)