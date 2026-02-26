---
name: merlin
description: Merlin performs genetic analysis on pedigree data to calculate linkage and association statistics. Use when user asks to calculate LOD scores, identify genotyping errors, estimate IBD states, perform haplotyping, or conduct variance component analysis.
homepage: http://csg.sph.umich.edu/abecasis/merlin
---


# merlin

## Overview
The `merlin` skill provides a specialized workflow for analyzing genetic data within pedigrees. It excels at handling dense marker maps by using sparse inheritance trees to represent gene flow efficiently. You should use this skill to perform complex genetic computations including LOD score calculation (parametric and non-parametric), identifying genotyping errors, estimating kinship and Identity By Descent (IBD) states, and performing association analysis. It also includes `minx` for X-linked analysis and `merlin-regress` for population-based regression of quantitative traits.

## Core CLI Usage
The standard execution pattern requires three primary input files: a data file (`-d`), a pedigree file (`-p`), and a map file (`-m`).

```bash
merlin -d [datafile] -p [pedfile] -m [mapfile] [options]
```

### Common Analysis Commands
- **Non-Parametric Analysis**: Use `--npl` for discrete traits or `--qtl` for quantitative traits.
- **Variance Components**: Use `--vc` to estimate heritability and linkage for normally distributed quantitative traits.
- **Haplotyping**: Use `--best` to estimate the most likely haplotype configuration or `--all` to sample all possible configurations.
- **IBD Estimation**: Use `--ibd` to generate files containing estimated IBD sharing between all pairs of individuals.
- **Error Detection**: Use `--error` to identify unlikely genotypes that may represent laboratory errors or mutations.
- **Simulation**: Use `--simulate` to generate random marker data through gene dropping based on the provided pedigree and map.

## Input File Management
- **Data File (.dat)**: Describes the contents of the pedigree file. Use `M` for markers, `T` for traits, `C` for covariates, and `S` to skip a column.
- **Pedigree File (.ped)**: Contains family structure and genotypes. Format: FamilyID, IndividualID, PaternalID, MaternalID, Sex, Phenotypes, Genotypes.
- **Map File (.map)**: Contains marker locations. Format: Chromosome, MarkerName, Position (in centiMorgans).

## Expert Tips and Best Practices
- **Handling Zero Likelihood**: If you see "SKIPPED: Requires impossible recombination pattern," check for markers at the exact same map position. Ensure every marker has a unique position in the `.map` file.
- **X-Chromosome Analysis**: Use the `minx` executable instead of `merlin` for any analysis involving the X chromosome.
- **Output Redirection**: For large analyses, use the `--quiet` flag and redirect output to a file: `merlin -d dat -p ped -m map --quiet > results.out`.
- **Quantitative Traits**: 
    - For unselected, normal distributions: Use `--vc`.
    - For selected samples (e.g., only extreme tails): Use `merlin-regress`.
    - For non-normal distributions: Use `--qtl` or `--deviates` (non-parametric).
- **Memory Management**: If pedigrees are too large, use the `--bits: [n]` option to limit the complexity of the inheritance tree, though this may result in approximate rather than exact solutions.
- **Filtering Data**: You can disable markers or traits without editing the `.ped` file by changing the label in the `.dat` file to `S` (Skip).

## Reference documentation
- [MERLIN Frequently Asked Questions](./references/csg_sph_umich_edu_abecasis_merlin_FAQ.html.md)
- [MERLIN Tutorial and Input Formats](./references/csg_sph_umich_edu_abecasis_merlin_tour.md)
- [MERLIN Reference Guide](./references/csg_sph_umich_edu_abecasis_merlin_reference.md)