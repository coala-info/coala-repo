---
name: malder
description: MALDER infers the timing and proportions of multiple ancestral admixture events by fitting exponential decay curves to linkage disequilibrium data. Use when user asks to estimate admixture dates, analyze complex population histories with multiple migration waves, or fit weighted LD decay curves.
homepage: https://github.com/joepickrell/malder
---


# malder

## Overview
MALDER (Multiple ALDER) is a specialized population genetics tool designed to infer the timing and proportions of multiple ancestral admixture events. While the original ALDER framework is primarily optimized for single-pulse admixture, MALDER fits multiple exponential decay curves to weighted linkage disequilibrium (LD) data. This allows researchers to characterize populations with complex histories, such as those that have experienced successive waves of migration or distinct historical contact events.

## Installation
The most reliable way to install MALDER is via Bioconda:

```bash
conda install bioconda::malder
```

Alternatively, it can be compiled from source using `make` within the repository directory on Unix-based systems.

## Command Line Usage
MALDER is executed by passing a parameter file:

```bash
malder -p <parfile>
```

### Parameter File Requirements
The parameter file structure is identical to ALDER when used in "multiple admixture test" mode. It requires paths to genomic data in EIGENSTRAT or PACKEDANCESTRYMAP format:
- **genotypename**: Genotype file
- **snpname**: SNP file
- **indivname**: Individual/Sample file
- **admixpop**: The target population to be tested
- **refpops**: A list of reference populations used as proxies for ancestral sources

## Interpreting Results
MALDER outputs its findings directly to the terminal. Understanding the "X+1" fitting logic is critical for correct interpretation.

### The X+1 Rule
The program identifies the number of admixture pulses by attempting to fit one more exponential curve than is statistically supported by the data.
- **Output Lines**: Look for lines starting with `RESULT_X`, where `X` represents the number of curves fitted.
- **Selection Logic**: If the output provides a `RESULT_3` block, the actual inferred demographic model is the two-pulse model found in the `RESULT_2` block.
- **Significance**: Always look at the `RESULT_(N-1)` output, where `N` is the highest number of curves the program successfully attempted to fit before stopping.

## Expert Tips and Best Practices
- **Data Format**: Ensure your input files strictly follow the EIGENSTRAT format. Inconsistent SNP counts or malformed individual files will cause the program to fail during the LD calculation phase.
- **Reference Selection**: The accuracy of the dating (measured in generations) depends heavily on the quality of the reference populations. Use references that are as close as possible to the true ancestral sources to minimize "noise" in the LD decay curve.
- **Chromosome Limits**: Standard versions of the software are often configured for 22 or 23 chromosomes. If working with non-human data or specific scaffolds, verify the source configuration if the program ignores higher-indexed chromosomes.
- **Decay Curve Validation**: If the decay curves do not appear exponential or if the standard errors in the `RESULT` blocks are extremely high, the population may have experienced continuous gene flow rather than discrete pulses, or the reference populations may be poorly matched.

## Reference documentation
- [MALDER Overview](./references/anaconda_org_channels_bioconda_packages_malder_overview.md)
- [MALDER GitHub README](./references/github_com_joepickrell_malder_blob_master_README.md)