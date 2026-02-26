---
name: ldsc
description: ldsc is a command-line toolset for the statistical analysis of GWAS results using Linkage Disequilibrium Score Regression. Use when user asks to munge summary statistics, estimate SNP-heritability, calculate genetic correlation between traits, or perform partitioned heritability analysis.
homepage: https://github.com/bulik/ldsc/
---


# ldsc

## Overview

ldsc (LD Score Regression) is a command-line toolset designed for the statistical analysis of Genome-Wide Association Study (GWAS) results. It leverages the relationship between Linkage Disequilibrium (LD) and association test statistics to provide insights into the genetic architecture of complex traits without requiring individual-level genotype data. Its primary applications include quantifying the proportion of phenotypic variance explained by SNPs, identifying shared genetic influences between different diseases or traits, and pinpointing functional categories of the genome that contribute disproportionately to heritability.

## Installation and Setup

Install ldsc via bioconda for the most stable environment:

```bash
conda install bioconda::ldsc
```

Alternatively, clone the repository and create the environment manually:

```bash
git clone https://github.com/bulik/ldsc.git
cd ldsc
conda env create --file environment.yml
source activate ldsc
```

## Core Workflows

### 1. Munging Summary Statistics
Before analysis, raw GWAS summary statistics must be converted to the `.sumstats` format. This process standardizes column names and filters SNPs.

```bash
./munge_sumstats.py \
    --sumstats my_gwas_results.txt \
    --out my_trait \
    --merge-alleles w_hm3.snplist \
    --N 50000
```

**Best Practices:**
- **SNP List**: Always use a high-quality SNP list (like HapMap3, `w_hm3.snplist`) for the `--merge-alleles` flag to ensure variants are well-imputed and have reliable LD scores.
- **Sample Size**: If the sample size varies per SNP, ensure the input file has an `N` column; otherwise, provide a global `N`.
- **Signed Statistics**: Ensure your input has a signed statistic (Z-score, OR, or Beta).

### 2. Estimating Heritability (h2)
Calculate the SNP-heritability of a trait and the LD Score regression intercept.

```bash
./ldsc.py \
    --h2 my_trait.sumstats.gz \
    --ref-ld-chr eur_w_ld_chr/ \
    --w-ld-chr eur_w_ld_chr/ \
    --out my_trait_h2
```

**Expert Tips:**
- **Intercept**: An intercept significantly greater than 1.0 suggests population stratification or other confounding, though a high intercept can also reflect high polygenicity and large sample size.
- **Weights**: Use `--w-ld-chr` for regression weights. These are typically the same as the reference LD scores for standard heritability.

### 3. Estimating Genetic Correlation (rg)
Calculate the genetic correlation between two or more traits.

```bash
./ldsc.py \
    --rg trait1.sumstats.gz,trait2.sumstats.gz \
    --ref-ld-chr eur_w_ld_chr/ \
    --w-ld-chr eur_w_ld_chr/ \
    --out trait1_trait2_correlation
```

**Key Considerations:**
- **Sample Overlap**: ldsc is robust to sample overlap between the two GWAS; the intercept of the genetic covariance regression accounts for this.
- **Trait Order**: You can provide a comma-separated list of multiple traits to calculate a correlation matrix.

### 4. Partitioned Heritability
Estimate heritability enrichment for specific functional annotations (e.g., conserved regions, coding regions).

```bash
./ldsc.py \
    --h2 my_trait.sumstats.gz \
    --ref-ld-chr baseline_v1.2/baseline. \
    --w-ld-chr 1000G_Phase3_weights_hm3_no_hla/weights.hm3_noHLA. \
    --overlap-annot \
    --frqfile-chr 1000G_Phase3_frq/1000G.EUR.QC. \
    --out my_trait_partitioned
```

**Best Practices:**
- **Baseline Model**: Always include the full baseline model when testing a specific annotation to avoid bias.
- **Annotation Files**: Ensure your custom `.annot` files match the SNP set used in the reference LD scores.

## Common CLI Patterns

- **Help**: Use `-h` with any script (`ldsc.py -h`, `munge_sumstats.py -h`) to see all available flags.
- **Chromosomes**: Use the `--ref-ld-chr` flag with a path prefix (e.g., `path/to/folder/chr`) to automatically load files for all 22 autosomes.
- **Log Files**: ldsc automatically generates a `.log` file for every run; check this for the "Ratio" metric, which helps distinguish polygenicity from bias.

## Reference documentation
- [LDSC GitHub Repository](./references/github_com_bulik_ldsc.md)
- [LDSC Wiki and Tutorials](./references/github_com_bulik_ldsc_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ldsc_overview.md)