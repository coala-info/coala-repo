---
name: merlin
description: Merlin performs multipoint linkage analysis, error detection, and haplotyping for dense genetic maps in pedigrees. Use when user asks to perform non-parametric or parametric linkage analysis, estimate identity-by-descent sharing, detect genotype errors, or generate most likely haplotypes.
homepage: http://csg.sph.umich.edu/abecasis/merlin
---


# merlin

## Overview
Merlin (Multipoint Engine for Rapid Likelihood INference) is a high-performance software package designed for the analysis of dense genetic maps in pedigrees. It uses sparse gene flow trees to represent inheritance patterns efficiently, making it suitable for large-scale genomic studies. This skill provides guidance on executing core Merlin workflows, managing input files, and interpreting statistical outputs for both discrete and quantitative traits.

## Core Workflow and Input Files
Merlin requires three primary input files to run. Ensure these are formatted correctly before execution:
- **Pedigree File (`.ped`)**: Contains family structure, individual IDs, parental information, sex, and phenotypes/genotypes.
- **Data File (`.dat`)**: Describes the contents of the pedigree file (e.g., `M` for marker, `T` for trait, `C` for covariate).
- **Map File (`.map`)**: Specifies the chromosome, marker name, and genetic position (in centiMorgans).

### Basic Execution
```bash
merlin -d [datafile] -p [pedfile] -m [mapfile] [options]
```

## Common Analysis Patterns

### Linkage Analysis
- **Non-Parametric (NPL)**: Use `--npl` for discrete traits to identify allele sharing among affected individuals.
- **Quantitative Traits**: 
  - `--vc`: Variance components analysis for unselected, normally distributed traits.
  - `--qtl` or `--deviates`: Non-parametric sharing analysis for traits in the tails of the distribution.
- **Parametric**: Use `--parametric` to specify a specific inheritance model (requires a model file).

### Data Quality and Error Detection
- **Error Checking**: Use `--error` to identify unlikely genotypes or "impossible" recombination patterns.
- **IBD Estimation**: Use `--ibd` to estimate Identity-By-Descent sharing between relative pairs.
- **Haplotyping**: Use `--best` to generate the most likely haplotype configuration for each individual.

### Simulation
- **Gene Dropping**: Use `--simulate` to generate random marker data under the null hypothesis of no linkage, useful for determining empirical p-values.

## Expert Tips and Best Practices
- **Handling Large Pedigrees**: If a pedigree is too large for exact analysis, Merlin will provide an approximation. Use the `--bits:n` option to increase the complexity limit if memory allows.
- **Skipping Markers/Traits**: Instead of regenerating files, edit the `.dat` file. Change `M` to `S2` to skip a marker, or `T`/`C` to `S` to skip a trait or covariate.
- **Output Management**: Use `> filename` to redirect output to a file. Add `--quiet` to suppress screen output for faster processing during large runs.
- **X-Chromosome**: For X-linked analysis, use the `minx` (Merlin in X) executable instead of the standard `merlin` command.
- **Map Positions**: Ensure every marker has a unique map position. Identical positions for markers with obligate recombinants will trigger "Requires impossible recombination pattern" errors.



## Subcommands

| Command | Description |
|---------|-------------|
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |
| merlin | MERLIN 1.1.2 - (c) 2000-2007 Goncalo Abecasis |

## Reference documentation
- [Merlin FAQ](./references/csg_sph_umich_edu_abecasis_merlin_FAQ.html.md)
- [Merlin Tutorial](./references/csg_sph_umich_edu_abecasis_merlin_tour.md)
- [Merlin Reference Topics](./references/csg_sph_umich_edu_abecasis_merlin_reference.md)