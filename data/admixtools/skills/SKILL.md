---
name: admixtools
description: The provided text does not contain help information for the tool. It is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build the image due to insufficient disk space ('no space left on device').
homepage: https://github.com/DReichLab/AdmixTools
---

# admixtools

## Overview

ADMIXTOOLS is a specialized software suite designed for formal statistical testing of population relationships and admixture history using genomic data. It is the standard toolset for calculating f-statistics, which quantify shared genetic drift between populations. Use this skill to navigate the various programs within the suite—such as `qpDstat` for D-statistics or `qpAdm` for modeling ancestry—and to manage the specific file formats (EIGENSTRAT, PACKEDANCESTRYMAP) required for paleogenomics and population genetics workflows.

## Core Programs and Usage

The suite consists of several distinct executables, each targeting a specific statistical test:

- **convertf**: Essential for data preparation. Converts between formats like EIGENSTRAT, PACKEDANCESTRYMAP, and PED.
- **qp3Pop**: Performs the $f_3$-test. Used as a test for admixture (negative $f_3$) or as an "outgroup $f_3$" to measure shared drift between two populations relative to an outgroup.
- **qpDstat**: Implements D-statistics (ABBA-BABA). A formal test for whether a 4-population tree $((P1, P2), (P3, P4))$ is consistent with simple branching or requires gene flow.
- **qpF4Ratio**: Estimates admixture proportions ($\alpha$) by calculating the ratio of two $f_4$ statistics.
- **qpAdm**: Models a target population as a mixture of "source" populations relative to a set of "outgroup" (right) populations.
- **rolloff**: Estimates the date of an admixture event based on the decay of linkage disequilibrium.
- **qpfstats**: A performance-oriented tool that precomputes an $f$-statistic basis, significantly reducing computation time for `qpAdm`, `qpWave`, and `qpGraph`.

## Common CLI Patterns

Most ADMIXTOOLS programs are invoked by passing a parameter file:

```bash
qpDstat -p parfile
```

### Parameter File Essentials
While specific to each program, common parameters include:
- `genotypename`: Path to the .geno or .packedancestrymap file.
- `snpname`: Path to the .snp file.
- `indivname`: Path to the .ind or .indiv file.
- `poplistname`: File containing the populations to be tested.
- `allsnps: YES`: Recommended when using `qpfstats` or version 7+ to maximize data usage.
- `numchrom: 22`: Default for humans; adjust this if working with non-human species.

## Expert Tips and Best Practices

- **Performance Optimization**: For large datasets, use `qpfstats` to precompute statistics. This allows you to run multiple `qpAdm` or `qpGraph` models without re-reading the raw genotype files every time.
- **Data Formats**: Version 8.0+ supports the `transpose_geno` (or `tgeno`) format, which is more efficient for certain large-scale analyses.
- **Jackknife Blocks**: Use `blgsize` to control the block size for Weighted Jackknife (default is 0.05 Morgans). If you need custom blocks, use `blockname` to provide a file mapping SNPs to specific block integers.
- **Handling Missing Data**: When using `qpAdm`, the `allsnps: YES` option allows the program to use all available SNPs for each f-statistic calculation rather than only the intersection of SNPs across all populations, which is crucial for low-coverage ancient DNA.
- **Graph Validation**: When using `qpGraph`, consider the `halfscore: YES` feature (v7+) to compare two phylogenies and obtain a goodness-of-fit score.

## Reference documentation
- [ADMIXTOOLS GitHub Repository](./references/github_com_DReichLab_AdmixTools.md)
- [Bioconda Admixtools Overview](./references/anaconda_org_channels_bioconda_packages_admixtools_overview.md)