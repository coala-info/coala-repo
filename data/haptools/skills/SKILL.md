---
name: haptools
description: "haptools simulates and analyzes complex traits by accounting for local ancestry and specific haplotype effects in admixed populations. Use when user asks to simulate admixed genotypes, generate phenotypes from haplotype effects, transform genotypes into haplotype variants, or visualize chromosomal ancestry tracks."
homepage: https://github.com/cast-genomics/haptools
---


# haptools

## Overview
The `haptools` skill provides a specialized workflow for simulating and analyzing complex traits within the context of ancestry and haplotypes. It is designed for researchers working with admixed populations who need to account for local ancestry and specific haplotype effects rather than just individual SNPs. Use this skill to generate realistic simulated genotypes, transform haplotypes into phenotype effects, and visualize chromosomal ancestry tracks.

## Core Commands and Workflows

### Genotype Simulation (`simgenotype`)
Simulate admixed genomes based on a recombination map and a set of founder haplotypes.
- **Basic Usage**: `haptools simgenotype --recomb <map.txt> --hap <founders.hap> --out <output.vcf>`
- **Expert Tip**: Ensure your recombination map matches the coordinate system (e.g., GRCh38) of your founder files to avoid simulation artifacts.

### Phenotype Simulation (`simphenotype`)
Generate phenotypes based on specific haplotype effects or local ancestry.
- **Basic Usage**: `haptools simphenotype --genotypes <input.vcf> --haplotypes <effects.hap> --out <output.pheno>`
- **Key Parameters**:
  - `--heritability`: Specify the narrow-sense heritability of the simulated trait.
  - `--prevalence`: Use for case-control (binary) trait simulation.

### Haplotype Transformation (`transform`)
Convert a VCF of genotypes into a "haplotype VCF" where multi-site haplotypes are treated as single variants.
- **Basic Usage**: `haptools transform --genotypes <input.vcf> --haplotypes <definitions.hap> --out <transformed.vcf>`
- **Utility**: This is essential for downstream GWAS or association testing where the unit of interest is a specific combination of alleles.

### Visualization (`karyogram`)
Create a visual representation of local ancestry (admixture tracks) for simulated or real individuals.
- **Basic Usage**: `haptools karyogram --bp <input.bp> --out <output.png>`
- **Input**: Requires a `.bp` file (breakpoints) typically generated during the `simgenotype` process.

## Common CLI Patterns

- **Filtering by Region**: Most commands support `--region` to restrict analysis to specific chromosomes or genomic coordinates, saving significant compute time.
- **Standardized Formats**: `haptools` relies heavily on the `.hap` format for defining haplotypes and their effects. Always validate your `.hap` file structure before running long-running simulations.
- **Memory Management**: For large-scale simulations, use the `--chunk-size` parameter (where available) to process the genome in segments.

## Reference documentation
- [Haptools GitHub Repository](./references/github_com_CAST-genomics_haptools.md)
- [Bioconda Haptools Overview](./references/anaconda_org_channels_bioconda_packages_haptools_overview.md)