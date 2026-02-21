---
name: phynder
description: phynder is a high-performance tool designed to assign samples to specific branches within a phylogeny.
homepage: https://github.com/richarddurbin/phynder
---

# phynder

## Overview
phynder is a high-performance tool designed to assign samples to specific branches within a phylogeny. It calculates the likelihood of a sample's genotypes across all possible positions in a provided Newick tree. It is optimized for ancient DNA research where samples often have significant missingness, allowing for robust placement of degraded sequences into reference trees (like the human Y-chromosome phylogeny).

## Installation
The most efficient way to install phynder is via Bioconda:
```bash
conda install bioconda::phynder
```

## Common CLI Patterns

### Sample Placement
To place query samples into a reference tree, you need a Newick tree file and a VCF file containing the genotypes of the samples already in that tree.

```bash
phynder -q query.vcf -p 0.01 -o output.phy tree.nwk tree.vcf.gz
```
*   `-q`: The VCF containing the samples you want to place.
*   `-p`: Posterior probability threshold. Suboptimal assignments with a posterior higher than this value will be reported.
*   `-o`: Output file (ONEcode format).

### Mapping SNPs to Branches
To identify which branch in the tree a specific mutation likely occurred on:

```bash
phynder -B -o branches.snp tree.nwk tree.vcf.gz
```
*   `-B`: Triggers the branch-SNP mapping mode.
*   The resulting file lists the most likely branch for each variant site in the reference VCF.

### Adjusting Mutation Parameters
For non-human or specific evolutionary models, you may need to adjust the transition/transversion rates. The defaults (Ts=1.33, Tv=0.33) are optimized for the human Y chromosome.

```bash
phynder -ts 1.5 -tv 0.5 -q query.vcf tree.nwk tree.vcf.gz
```

## Expert Tips and Best Practices

### Handling Missing Data
phynder is designed to tolerate high levels of missingness. However, if compute time is an issue, note that analysis is significantly faster when the reference tree VCF has minimal missing data. High missingness in the *query* sample is handled gracefully but will naturally result in lower placement resolution (wider posterior distributions).

### Understanding ONEcode Output
The output is a ONEcode file, which is a self-documenting format. Key line types include:
*   **I lines**: Sample identifiers.
*   **B lines**: The "Best" branch assignment, including the posterior probability and likelihood score.
*   **S lines**: "Suboptimal" assignments that passed the `-p` threshold.
*   **C lines**: The most specific "Clade" (node) that contains at least `1 - p` of the total posterior probability. This is often the most reliable summary of the sample's position.

### Likelihood Thresholding
The `-T` option (default -10.0) sets a log-likelihood threshold for sites.
*   Sites with very low likelihoods often indicate genotype errors or multiple independent mutations (homoplasy).
*   If you want to use all sites regardless of fit (e.g., when using `-B`), set `-T 0` to disable the threshold.

### Tree Requirements
*   The Newick tree should ideally have branch lengths representing time or expected mutations.
*   The tree can be rooted (two branches from the root) or unrooted (three branches from the root).
*   Only biallelic SNPs are used; multi-allelic sites and non-SNP variants are ignored during processing.

## Reference documentation
- [phynder GitHub Repository](./references/github_com_richarddurbin_phynder.md)
- [phynder Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phynder_overview.md)