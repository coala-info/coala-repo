---
name: denovogear
description: DeNovoGear is a specialized software suite designed to identify de novo variants by integrating sequence data with pedigree or phylogenetic information.
homepage: https://github.com/ultimatesource/denovogear
---

# denovogear

## Overview

DeNovoGear is a specialized software suite designed to identify de novo variants by integrating sequence data with pedigree or phylogenetic information. Unlike standard variant callers that treat samples independently, DeNovoGear uses advanced peeling algorithms and likelihood-based models to evaluate the probability of a mutation occurring within a specific familial or cellular context. It supports various experimental designs, including standard trios, multi-generational pedigrees, and somatic clones, and can process data directly from BAM or BCF/VCF files.

## Core CLI Usage

The primary interface for DeNovoGear is the `dng` command, followed by specific modules.

### Mutation Calling in Pedigrees
The `call` module is the most common entry point for identifying mutations in related individuals.

```bash
# Call mutations using a pedigree file and BAM data
dng call --ped family.ped input.bam

# Call mutations using a specific inheritance model and BCF input
dng call --model=w-linked --ped family.ped input.bcf

# View all available options for the call module
dng help call
```

### Key Parameters
- `--min-quality`: Sets the threshold for reporting a mutation. Use this to balance sensitivity and specificity.
- `--all`: Includes sites with segregating germline variation (not just de novo candidates).
- `--ped`: Specifies the required pedigree configuration file.

## The PEDNG File Format

DeNovoGear uses a specific 5-column, whitespace-separated format (PEDNG v1.0) to define relationships and sample metadata.

### Column Structure
1. **Individual ID**: Unique identifier. Can include meta-tags (e.g., `ID@haploid`).
2. **Father ID**: ID of the father. Use `id:length` to scale germline mutation rates (default length is 1.0). Use `.` if unknown.
3. **Mother ID**: ID of the mother. Use `id:length` to scale rates. Use `.` if unknown.
4. **Sex**: `1` (male), `2` (female), or `0` (autosomal).
5. **Sample IDs**: Maps the individual to the sample name in the BAM/BCF. Use `=` to match the Individual ID or a Newick-formatted tree for somatic relationships.

### Advanced Meta-Tags
Tags are appended to the Individual ID using the `@` symbol:
- **Ploidy**: `@haploid`, `@diploid`, or `@ploidy=N`.
- **Role**: `@founder` (ignores parental columns), `@clone` (somatic relationship), or `@gamete` (sets ploidy to 1).

### Example PEDNG Configuration
```text
##PEDNG v1.0
#Individual      Father    Mother    Sex    Samples
Parent1@founder  .         .         1      =
Parent2@founder  .         .         2      =
Child1           Parent1   Parent2   2      =
SomaticCell@clone Child1:2.0 .       0      Cell_A
```

## Expert Tips and Best Practices

- **Input Preparation**: Ensure your BAM files are indexed and that sample names in the BAM header match the IDs provided in the PEDNG file.
- **Scaling Mutation Rates**: If you have prior knowledge that a specific lineage has a higher mutation rate (e.g., older paternal age), use the `id:length` syntax in the Father/Mother columns to scale the expected rate accordingly.
- **Somatic Analysis**: For somatic mutation detection, use the `@clone` tag and provide a Newick tree in the Samples column if you are analyzing multiple samples from the same lineage with known relationships.
- **Haplo-Diploidy**: For organisms with haplo-diploid sex determination, explicitly set the `@haploid` tag for males and `@diploid` for females in the first column of the PEDNG file.

## Reference documentation
- [DeNovoGear README](./references/github_com_ultimatesource_denovogear.md)
- [DeNovoGear Wiki](./references/github_com_ultimatesource_denovogear_wiki.md)