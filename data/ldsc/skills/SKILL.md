---
name: ldsc
description: ldsc is a command-line toolset for estimating heritability and genetic correlations using GWAS summary statistics and linkage disequilibrium patterns. Use when user asks to munge summary statistics, estimate SNP heritability, calculate genetic correlations between traits, or perform partitioned and cell-type-specific heritability enrichment analyses.
homepage: https://github.com/bulik/ldsc/
---


# ldsc

## Overview

`ldsc` is a command-line toolset designed for large-scale genetic analysis using summary-level data. It leverages the relationship between Linkage Disequilibrium (LD) and GWAS test statistics to estimate trait architecture without requiring individual-level genotype data. This skill provides guidance on data preparation (munging), estimating heritability ($h^2$), calculating genetic correlations ($r_g$), and performing partitioned or cell-type-specific heritability analyses.

## Core Workflows

### 1. Preparing Summary Statistics (Munging)
Before running regressions, GWAS results must be formatted into `.sumstats.gz` files.

```bash
python munge_sumstats.py \
    --sumstats gwas_results.txt \
    --merge-alleles w_hm3.snplist \
    --out trait_name \
    --column-names SNP:rsid,P:p-value,N:sample_size
```
- **Best Practice**: Always use `--merge-alleles` with a standard SNP list (like HapMap3) to ensure alleles are aligned and strand-ambiguous SNPs are removed.
- **Expert Tip**: Ensure the `N` (sample size) is accurate for each SNP, especially in meta-analyses where $N$ varies across the genome.

### 2. Estimating Heritability ($h^2$)
Calculate the proportion of phenotypic variance explained by SNPs.

```bash
python ldsc.py \
    --h2 trait.sumstats.gz \
    --ref-ld-chr eur_w_ld_chr/ \
    --w-ld-chr eur_w_ld_chr/ \
    --out trait_h2
```
- **Liability Scale**: For binary/disease traits, use `--samp-prev` and `--pop-prev` to convert observed-scale heritability to the liability scale.
- **Intercept**: The intercept provides an estimate of confounding (e.g., population stratification). An intercept significantly $> 1$ suggests remaining bias or extreme polygenicity.

### 3. Genetic Correlation ($r_g$)
Estimate the genetic overlap between two traits.

```bash
python ldsc.py \
    --rg trait1.sumstats.gz,trait2.sumstats.gz \
    --ref-ld-chr eur_w_ld_chr/ \
    --w-ld-chr eur_w_ld_chr/ \
    --out trait1_trait2_correlation
```
- **Requirement**: Traits must have sufficient polygenic signal (Mean $\chi^2 > 1.02$) for stable $r_g$ estimates.

### 4. Partitioned Heritability
Identify enrichment of heritability in specific functional annotations (e.g., enhancers, conserved regions).

```bash
python ldsc.py \
    --h2 trait.sumstats.gz \
    --ref-ld-chr baseline_v1.2/baseline. \
    --w-ld-chr weights_hm3_no_hla/weights. \
    --overlap-annot \
    --out trait_partitioned
```
- **Note**: Use `--overlap-annot` when categories in the baseline model overlap (which is standard for the provided baseline models).

### 5. Cell-Type-Specific Analysis
Test for enrichment in specific cell-type gene sets or chromatin marks.

```bash
python ldsc.py \
    --h2-cts trait.sumstats.gz \
    --ref-ld-chr baseline. \
    --ref-ld-chr-cts cell_type.ldcts \
    --w-ld-chr weights. \
    --out trait_cts
```
- **Input**: The `.ldcts` file is a two-column control file mapping cell-type names to their specific LD score file paths.

## Expert Tips and Troubleshooting

- **Sample Size**: LD Score regression is generally underpowered for datasets with $N < 5,000$. For small samples, results will be noisy with high standard errors.
- **Negative LD Scores**: It is normal for a small percentage of LD scores to be negative. This is a result of using an unbiased estimator for $r^2$. If a large percentage are negative, check if your window size is too large or sample size for LD estimation is too small.
- **Out of Bounds $r_g$**: If $r_g$ is reported as $> 1$ or $< -1$, it usually indicates that one of the traits has very low heritability, making the denominator of the correlation unstable.
- **Parallelization**: Always run LD score estimation or regressions by chromosome (using the `@` or `--ref-ld-chr` prefix pattern) to manage memory efficiently.



## Subcommands

| Command | Description |
|---------|-------------|
| ldsc.py | LD Score regression |
| munge_sumstats.py | munge_sumstats.py is a script for munging summary statistics for LD Score Regression. |

## Reference documentation
- [LDSC README](./references/github_com_bulik_ldsc.md)
- [Heritability and Genetic Correlation Tutorial](./references/github_com_bulik_ldsc_wiki_Heritability-and-Genetic-Correlation.md)
- [Cell-type-specific analyses](./references/github_com_bulik_ldsc_wiki_Cell-type-specific-analyses.md)
- [Partitioned Heritability](./references/github_com_bulik_ldsc_wiki_Partitioned-Heritability.md)
- [LDSC FAQ](./references/github_com_bulik_ldsc_wiki_FAQ.md)