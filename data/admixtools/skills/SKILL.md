---
name: admixtools
description: AdmixTools is a bioinformatics toolkit used to detect and quantify gene flow and reconstruct population histories using genomic data. Use when user asks to perform f-statistics tests, estimate admixture proportions, or fit complex phylogenetic admixture graphs.
homepage: https://github.com/DReichLab/AdmixTools
---


# admixtools

## Overview

AdmixTools is a specialized bioinformatics toolkit designed to detect and quantify gene flow between populations using genomic data. It allows researchers to determine if a population is a mixture of other groups, estimate the timing of these mixture events, and build complex phylogenetic models. The suite is the industry standard for analyzing ancient and modern DNA to reconstruct human evolutionary history.

## Core Programs and Usage

Most AdmixTools programs follow a standard execution pattern using a parameter file (parfile):
`executable -p parfile`

### 1. Data Preparation (convertf)
Use `convertf` to transform genotype data between formats (e.g., PACKEDANCESTRY, EIGENSTRAT, PED).
*   **Key Parameter:** `genotypename`, `snpname`, `indivname` (input) and `outputformat`.
*   **Tip:** Use `PACKEDANCESTRY` or the newer `transpose_geno` (tgeno) format for large datasets to reduce memory overhead and improve speed.

### 2. Formal Tests of Admixture
*   **qp3Pop:** Performs the $f_3$ test. A significantly negative $f_3(Target; Source1, Source2)$ is definitive evidence that the Target is admixed from groups related to Source1 and Source2.
*   **qpDstat:** Calculates $D$-statistics (4-population test). Use this to test if a tree $((A, B), (C, D))$ is consistent with the data or if there is evidence of gene flow between specific branches.
*   **qpF4Ratio:** Estimates the admixture proportion ($\alpha$) by calculating the ratio of two $f_4$ statistics.

### 3. Advanced Modeling
*   **qpAdm:** Models a "left" (target) population as a mixture of various source populations relative to a set of "right" (outgroup) populations. It provides p-values for model fit and estimated admixture weights.
*   **qpGraph:** Fits a complex admixture graph to the data. 
*   **qpfstats:** A performance-oriented tool that precomputes $f$-statistics. Use this before running `qpAdm` or `qpGraph` on large datasets to drastically reduce computation time.

## Expert Tips and Best Practices

*   **Handling Chromosomes:** By default, AdmixTools assumes 22 human autosomes. For other species, specify `numchrom: <N>` in your parfile.
*   **SNP Selection:** Use `allsnps: YES` in `qpAdm` or `qpWave` to maximize the number of SNPs used in the analysis, especially when working with "pseudo-haploid" ancient DNA where data is sparse.
*   **Jackknife Blocks:** AdmixTools uses a block jackknife to estimate standard errors. If you have specific requirements for block sizes, use `blgsize` (default is 0.05 Morgans).
*   **Memory Management:** For very large datasets, ensure you are using the 64-bit versions of the tools and consider pre-calculating basis statistics with `qpfstats`.
*   **Ingroup/Outgroup Logic:** In `qpAdm`, the choice of "Right" populations (outgroups) is critical. They must be differentially related to the sources but should not have experienced recent gene flow from the "Left" populations.



## Subcommands

| Command | Description |
|---------|-------------|
| convertf | A tool from the AdmixTools suite used to convert between different genetic data formats (e.g., EIGENSTRAT, PACKEDANCESTRYMAP, PED, etc.) using a parameter file. |
| qp3Pop | Compute the f3-statistic, also known as the 3-population test, to test for admixture or shared genetic history. |
| qpAdm | qpAdm is used to estimate the proportions of ancestry from a set of source populations for a target population. |
| qpDstat | Compute D-statistics for population genetics analysis |
| qpGraph | qpGraph is a tool for fitting population graphs to f-statistics. |
| qpWave | qpWave is a tool for testing whether a set of 'left' populations is consistent with being descended from a specified number of waves of admixture relative to a set of 'right' populations. |
| qpfstats | Compute f-statistics for AdmixTools |

## Reference documentation

- [AdmixTools Main README](./references/github_com_DReichLab_AdmixTools.md)
- [Format Conversion (convertf)](./references/github_com_DReichLab_AdmixTools_tree_master_convertf.md)