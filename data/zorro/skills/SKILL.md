---
name: zorro
description: ZORRO identifies and scores the reliability of individual columns within a multiple sequence alignment. Use when user asks to score a multiple sequence alignment, specify sampling parameters, use a custom guide tree, ignore gaps, or adjust weighting for alignment scoring.
homepage: https://sourceforge.net/projects/probmask/
metadata:
  docker_image: "quay.io/biocontainers/zorro:2011.12.01--h7b50bb2_5"
---

# zorro

## Overview
ZORRO is a probabilistic masking tool designed to identify and score the reliability of individual columns within a multiple sequence alignment. By applying a pair-HMM model, it generates a confidence score between 0 and 10 for every position in the alignment. These scores provide a quantitative basis for "masking" or removing poorly aligned regions that could introduce noise or bias into downstream phylogenetic analyses.

## Command Line Usage

The basic syntax for running ZORRO is:
`zorro [options] inputfile > outputfile`

### Common Patterns

**Basic scoring:**
Process a multi-FASTA alignment using default settings (uses all pairs for calculation).
`zorro alignment.fasta > alignment.mask`

**Large alignments (Sampling):**
For alignments with a high number of sequences, use sampling to improve performance. This samples 10 * N sequences by default.
`zorro -sample alignment.fasta > alignment.mask`

**Custom sampling size:**
Specify a specific number of pairs to sample for reliability calculations.
`zorro -Nsample 50 alignment.fasta > alignment.mask`

**Using a custom guide tree:**
By default, ZORRO uses FastTree to generate a guide tree. You can provide your own Newick-formatted tree instead.
`zorro -guide my_tree.nwk alignment.fasta > alignment.mask`

## Expert Tips and Best Practices

- **Dependency Requirement:** ZORRO requires **FastTree** to be installed and available in your system's executable PATH to generate guide trees unless you provide a manual guide tree with the `-guide` option.
- **Output Format:** The output is a simple text file containing one score per line, corresponding to the columns of the input alignment in order (1, 2, 3...).
- **Interpreting Scores:** Scores range from 0 to 10. A common practice is to use a threshold (e.g., 4 or 5) to filter out low-confidence columns before running phylogenetic software like RAxML or IQ-TREE.
- **Handling Gaps:** If your alignment is gap-heavy and you believe gaps are informative or should not penalize the score as heavily, consider using the `-ignoregaps` flag.
- **Weighting:** By default, ZORRO uses a weighted sum of pairs. Use `-noweighting` if you prefer a simple sum of pairs calculation, though weighted sums are generally more robust against over-represented sequences.

## Reference documentation
- [ZORRO Files and README](./references/sourceforge_net_projects_probmask_files.md)
- [ZORRO Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_zorro_overview.md)