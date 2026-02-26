---
name: phast
description: PHAST is a toolkit for comparative genomics that models evolutionary processes to identify conserved elements and estimate phylogenetic parameters. Use when user asks to fit phylogenetic models, identify conserved elements with phastCons, compute site-specific conservation p-values with phyloP, or manipulate alignments and trees.
homepage: http://compgen.cshl.edu/phast/
---


# phast

## Overview

PHAST (Phylogenetic Analysis with Space/Time models) is a specialized toolkit for comparative genomics that models evolutionary processes across both phylogeny (time) and sequence position (space). It is the engine behind the conservation tracks in the UCSC Genome Browser. This skill provides guidance on using the core PHAST utilities to fit phylogenetic models, compute site-specific conservation p-values, and identify conserved elements using phylogenetic Hidden Markov Models (phylo-HMMs).

## Core Workflows and CLI Patterns

### 1. Fitting Phylogenetic Models (phyloFit)
Use `phyloFit` to estimate branch lengths and substitution rates from an alignment.

*   **Basic REV model fitting:**
    `phyloFit --tree "(human,(mouse,rat))" --subst-mod REV --out-root my_model alignment.fa`
*   **Using Sufficient Statistics (SS):** For large genomic datasets, convert alignments to `.ss` format first using `msa_view` to speed up processing.
    `phyloFit --msa-format SS --tree tree.nh --subst-mod HKY85 my_data.ss`
*   **Codon-position specific models:**
    `phyloFit --tree tree.nh --features genes.gff --do-cats 1,2,3 --out-root codon_model alignment.fa`

### 2. Conservation Scoring (phastCons)
`phastCons` uses a two-state phylo-HMM (conserved vs. non-conserved) to identify elements and scores.

*   **Standard conservation track generation:**
    `phastCons --target-coverage 0.25 --expected-length 12 alignment.ss noncons.mod > scores.wig`
*   **Predicting discrete conserved elements (BED/GFF):**
    `phastCons --most-conserved elements.bed --score alignment.ss cons.mod,noncons.mod > scores.wig`
*   **Estimating rho (scaling factor):** If you only have a neutral model, use `--estimate-rho` to scale it for the conserved state.
    `phastCons --estimate-rho new_model --target-coverage 0.3 alignment.ss neutral.mod`

### 3. Site-Specific P-values (phyloP)
`phyloP` computes p-values for conservation or acceleration at individual sites or over features.

*   **Base-by-base conservation scores (LRT method):**
    `phyloP --wig-scores --method LRT --mode CON neutral.mod alignment.fa > scores.wig`
*   **Lineage-specific acceleration (Subtree test):**
    `phyloP --method LRT --subtree primate_node --mode ACC neutral.mod alignment.fa`
*   **Scoring specific features (BED/GFF):**
    `phyloP --features elements.bed --method SCORE --mode CONACC neutral.mod alignment.fa > results.txt`

### 4. Utility Operations
*   **Alignment Conversion:** Use `msa_view` to convert between MAF, FASTA, and SS formats.
    `msa_view alignment.maf --out-format SS > alignment.ss`
*   **Tree Manipulation:** Use `tree_doctor` to prune trees, rename nodes, or scale branches.
    `tree_doctor --prune mouse,rat --name-ancestors tree.nh`

## Expert Tips and Best Practices

*   **Neutral Model Selection:** For `phastCons` and `phyloP`, always start with a high-quality neutral model (e.g., fitted to four-fold degenerate sites or ancestral repeats) using `phyloFit`.
*   **LRT vs. SPH:** Use `--method LRT` in `phyloP` for better power in identifying selection at individual sites or short intervals. Use the default `SPH` method when you need exact distributions of substitution counts.
*   **Coordinate Frames:** By default, PHAST uses the first sequence in the alignment as the reference. Use `--refidx <N>` to change the reference sequence or `--refidx 0` for the coordinate frame of the entire alignment.
*   **Memory Efficiency:** For genome-wide analysis, always work with Sufficient Statistics (`.ss`) files. Use `msa_split` to process large alignments in manageable chunks.
*   **Gaps and Missing Data:** By default, gaps are treated as missing data. If gaps are phylogenetically informative for your study, use the `--gaps-as-bases` flag in `phyloFit`.

## Reference documentation
- [PHAST Resources](./references/compgen_cshl_edu_phast_resources.php.md)
- [phastCons Help](./references/compgen_cshl_edu_phast_help-pages_phastCons.txt.md)
- [phyloFit Help](./references/compgen_cshl_edu_phast_help-pages_phyloFit.txt.md)
- [phyloP Help](./references/compgen_cshl_edu_phast_help-pages_phyloP.txt.md)
- [Getting Started with PHAST](./references/compgen_cshl_edu_phast_gettingstarted.php.md)