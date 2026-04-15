---
name: aster
description: ASTER is a suite of optimization algorithms designed to infer accurate species trees from diverse biological data types including gene trees, alignments, and raw sequencing reads. Use when user asks to estimate species trees from unrooted gene trees, handle multi-copy gene families, analyze SNP supermatrices, or infer phylogenies directly from raw short reads.
homepage: https://github.com/chaoszhang/ASTER
metadata:
  docker_image: "quay.io/biocontainers/aster:1.23--h9948957_0"
---

# aster

## Overview
ASTER (Accurate Species Tree EstimatoR) is a high-performance suite of C++ optimization algorithms designed for phylogenomic inference. It transforms various types of biological data—including unrooted gene trees, multi-copy gene families, whole-genome alignments, and even raw sequencing reads—into accurate species trees. It is specifically engineered to handle the challenges of large-scale datasets and biological processes like incomplete lineage sorting that often confound traditional concatenation-based methods.

## Tool Selection Guide
Choose the specific ASTER component based on your input data:

*   **ASTRAL-IV**: Use for standard unrooted gene tree topologies. It includes CASTLES-II for estimating branch lengths.
*   **ASTRAL-Pro3**: Use for gene family trees where multi-copy genes are present. It does not require pre-labeling orthologs.
*   **Weighted ASTRAL (wASTRAL)**: Use when gene trees include branch lengths and/or bootstrap/Bayesian support values to improve accuracy.
*   **CASTER-site**: Use for SNP supermatrices (FASTA/PHYLIP) or whole-genome alignments. It is significantly faster than concatenation-based Maximum Likelihood.
*   **CASTER-pair**: Use for aligned genomes when higher accuracy is required over the speed of CASTER-site.
*   **WASTER**: Use for raw short reads (even with coverage as low as 1.5X) to infer family-level trees or guide trees for alignment.
*   **D* statistic**: Use for detecting interspecific hybridization.

## Common CLI Patterns and Best Practices

### Installation
The most reliable way to access the suite is via Conda:
```bash
conda install bioconda::aster
```
Binaries are typically located in the `bin/` directory after installation or compilation.

### Working with Gene Trees (ASTRAL)
When using ASTRAL-IV or ASTRAL-Pro, ensure your input file contains one Newick-formatted tree per line.
*   **Rooting**: Use the `--root` option to specify outgroups for the final species tree.
*   **Multi-copy genes**: If using ASTRAL-Pro3, you do not need to resolve orthology manually; the algorithm handles gene duplication and loss internally.

### Working with Alignments (CASTER)
*   **Quick Trees**: For large SNP datasets, CASTER-site is the preferred "quick-and-dirty" method that remains robust to ILS.
*   **Sliding Windows**: When using CASTER on whole genomes, consider the density of your sampling; CASTER-pair is recommended for datasets with high average nucleotide identity (>80%).

### Working with Raw Reads (WASTER)
*   **Guide Trees**: WASTER is exceptionally useful for creating guide trees for tools like CACTUS without requiring prior sequence alignment.
*   **Low Coverage**: It is effective even at 1.5X coverage for family-level inference.

## Expert Tips
*   **Memory Management**: For extremely large input files (thousands of gene trees or millions of sites), ensure you are using the latest version (v1.23+), which includes specific bug fixes for "huge input files."
*   **Hybridization**: If you suspect horizontal gene transfer or hybridization, use the D* statistic tool rather than standard ASTRAL, as ASTRAL assumes a bifurcating species tree model.
*   **Branch Lengths**: If your gene trees have reliable support values, always prefer `wASTRAL` over standard `ASTRAL-IV`, as the weighting significantly reduces the impact of poorly resolved gene tree branches.

## Reference documentation
- [ASTER GitHub Repository](./references/github_com_chaoszhang_ASTER.md)
- [Bioconda ASTER Overview](./references/anaconda_org_channels_bioconda_packages_aster_overview.md)
- [ASTER Issues and Troubleshooting](./references/github_com_chaoszhang_ASTER_issues.md)