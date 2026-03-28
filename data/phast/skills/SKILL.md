---
name: phast
description: PHAST is a collection of command-line utilities designed for comparative genomics, evolutionary modeling, and identifying conserved genomic elements. Use when user asks to fit phylogenetic models, identify conserved elements using phastCons, calculate lineage-specific selection scores with phyloP, or manipulate large-scale genomic alignments.
homepage: http://compgen.cshl.edu/phast/
---

# phast

## Overview

PHAST (Phylogenetic Analysis with Space/Time Models) is a comprehensive collection of command-line utilities designed for comparative and evolutionary genomics. It is most notably used to generate the conservation tracks seen in the UCSC Genome Browser. The suite allows researchers to fit complex evolutionary models to sequence data, identify elements under selection, and manipulate large-scale genomic alignments.

## Core Workflows and CLI Patterns

### 1. Fitting Phylogenetic Models (phyloFit)
Before running conservation analyses, you must fit a substitution model to your alignment.
- **Basic Fit**: `phyloFit --tree "((human,chimp),mouse)" alignment.fa --out-root mymodel`
- **Estimate from SS**: Use Sufficient Statistics (SS) format for large datasets to save memory.
- **Expert Tip**: Use `--subst-mod REV` for the General Reversible model, which is standard for most neutral evolution estimations.

### 2. Identifying Conserved Elements (phastCons)
phastCons uses a phylo-HMM to identify conserved regions across species.
- **Generate Scores**: `phastCons alignment.ss neutral.mod > scores.wig`
- **Identify Elements**: `phastCons --most-conserved elements.bed --score alignment.ss neutral.mod`
- **Tuning**: Use `--target-coverage` (prior probability of a site being conserved) and `--expected-length` to refine the sensitivity of element detection.

### 3. Testing for Selection (phyloP)
Unlike phastCons, phyloP calculates p-values for conservation or acceleration on a per-site or per-lineage basis.
- **Lineage Specific**: `phyloP --branch human --method LRT neutral.mod alignment.ss`
- **Whole Tree**: `phyloP --method SCORE neutral.mod alignment.ss`

### 4. Alignment Manipulation (msa_view)
`msa_view` is the primary utility for format conversion and data preparation.
- **Convert Format**: `msa_view input.maf --out-format FASTA > output.fa`
- **Extract Sufficient Statistics**: `msa_view alignment.fa --out-format SS > alignment.ss`
- **Sub-alignment**: `msa_view alignment.fa --seqs human,chimp,gorilla > primates.fa`
- **Coordinate Filtering**: Use `--start` and `--end` with `--refidx 1` to extract regions based on the reference sequence coordinates.

### 5. Working with MAF Files (maf_parse)
For large-scale genomic alignments (like those from Multiz), use `maf_parse`.
- **Extract Features**: `maf_parse --features genes.gff input.maf > genes_only.maf`
- **Split by Length**: `maf_parse --split 1000000 input.maf` (splits into 1Mb chunks).

## Expert Tips for Large Datasets

- **Sufficient Statistics (SS)**: Always convert large alignments to `.ss` format using `msa_view` before running `phyloFit` or `phastCons`. This drastically reduces the computational overhead by collapsing identical columns.
- **Tree Manipulation**: Use `tree_doctor` to prune trees, rename leaves, or scale branches before using them as input for other PHAST tools.
- **GFF/BED Handling**: PHAST tools are strict about coordinate frames. Use `msa_view --refidx` to ensure your output coordinates match the specific reference genome you are working with.



## Subcommands

| Command | Description |
|---------|-------------|
| phast | The PHAST package contains the following programs: |
| phast | The PHAST package contains the following programs: |
| phast | The PHAST package contains the following programs |
| phastBias | Calculates the bias of each base in a sequence alignment. |
| phast_chooselines | Choose lines from a MAF file based on a phylogenetic tree and conservation scores. |
| phast_consentropy | Calculate conservation scores for each column in a multiple sequence alignment. |
| phast_hmm_train | Trains a Hidden Markov Model (HMM) for use with PHAST. |
| phast_hmm_tweak | Adjusts parameters of a HMM to better fit a set of sequences. |
| phast_modfreqs | Calculates and displays allele frequency information for a given set of sites. |
| phast_msa_split | Splits a multiple sequence alignment into smaller files. |
| phast_pbsencode | Encodes a position-specific scoring matrix (PSSM) into a PSSM that is suitable for use with phastCons. |
| phast_pbstrain | Trains a PAML-style substitution model for a given set of sequences. |
| phast_phastmotif | PHAST package program for finding motifs. |
| phast_test | The PHAST package contains the following programs: all_dists, hmm_view, phastBias, base_evolve, indelFit, phastCons, chooseLines, indelHistory, phastMotif, clean_genes, maf_parse, phastOdds, consEntropy, makeHKY, phyloBoot, convert_coords, modFreqs, phyloFit, display_rate_matrix, msa_diff, phyloP, dless, msa_split, prequel, dlessP, msa_view, refeature, draw_tree, pbsDecode, stringiphy, eval_predictions, pbsEncode, test, exoniphy, pbsScoreMatrix, tree_doctor, hmm_train, pbsTrain, treeGen, hmm_tweak, phast. For help, type the program's name followed by -h in your command line window. |

## Reference documentation
- [PHAST Overview](./references/compgen_cshl_edu_phast.md)
- [phastCons Help](./references/compgen_cshl_edu_phast_help-pages_phastCons.txt.md)
- [msa_view Help](./references/compgen_cshl_edu_phast_help-pages_msa_view.txt.md)
- [phyloFit Help](./references/compgen_cshl_edu_phast_help-pages_phyloFit.txt.md)
- [maf_parse Help](./references/compgen_cshl_edu_phast_help-pages_maf_parse.txt.md)