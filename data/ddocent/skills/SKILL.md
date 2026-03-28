---
name: ddocent
description: dDocent is a population genomics pipeline that transforms raw sequencing reads into high-quality SNP and INDEL calls for non-model organisms. Use when user asks to perform de novo or reference-based assembly, optimize clustering parameters, or call and filter variants from RADseq data.
homepage: https://ddocent.com
---


# ddocent

## Overview

dDocent is a specialized bash-based pipeline designed for population genomics, particularly optimized for non-model organisms. It serves as a wrapper for several high-performance bioinformatics tools (such as BWA, FreeBayes, and VCFtools) to transform raw sequencing reads into high-quality SNP and INDEL calls. Use this skill to guide the multi-step process of demultiplexing, trimming, optimizing assembly parameters, and filtering variants. It is especially useful when dealing with complex polymorphisms and INDELs that traditional pipelines might miss.

## Installation and Environment

The recommended way to use dDocent is via Bioconda to ensure all dependencies (FreeBayes, BWA, STACKS, etc.) are correctly versioned.

```bash
# Create and activate environment
conda create -n ddocent_env ddocent
source activate ddocent_env

# Run the pipeline
dDocent
```

## Data Preparation

dDocent requires specific naming conventions for paired-end data:
- Forward reads: `SampleName.F.fq.gz`
- Reverse reads: `SampleName.R.fq.gz`

### Demultiplexing and Renaming
If starting from raw multiplexed data, use `process_radtags` from the Stacks package. Use the `Rename_for_dDocent.sh` script to convert barcode-named files to the required format:
```bash
bash Rename_for_dDocent.sh Barcode_File
```

## Core Workflow Best Practices

### 1. Reference Optimization (Crucial Step)
Do not run the full pipeline on your entire dataset immediately. Instead, create a `RefOpt` directory with a subset of individuals (e.g., 1-5 per locality) to capture total variability.

- **Run `ReferenceOpt.sh`**: This script tests different clustering parameters.
- **Similarity Threshold**: Look for the "point of inflection" in the `kopt.data` plot. This is the threshold where you maximize the capture of unique loci without over-splitting alleles into separate contigs.
- **Mapping Optimization**: Run `RefMapOpt.sh` using the chosen similarity threshold to pick optimal `K1` (within-individual coverage) and `K2` (number of individuals) cutoffs.

### 2. Assembly
- **De Novo**: dDocent uses `CD-HIT` and `rainbow` for assembly.
- **Reference-based**: If a reference genome exists, place `reference.fasta` in the working directory. dDocent will detect it and skip the assembly steps.

### 3. SNP Calling with FreeBayes
dDocent uses FreeBayes, which is haplotype-based. This allows it to call SNPs, INDELs, and complex events simultaneously.
- Ensure `pearRM` is in your PATH for merging paired-end reads before assembly.
- The pipeline is "population-aware," meaning it uses the combined information from all individuals to improve call accuracy at low-coverage sites.

## SNP Filtering Patterns

After the pipeline produces a raw VCF file (usually `TotalRawSNPs.vcf`), rigorous filtering is required:

1.  **Missing Data**: Filter by individuals and then by loci.
2.  **Minor Allele Frequency (MAF)**: Typically set between 0.01 and 0.05 depending on sample size.
3.  **Quality/Depth**: Use VCFtools to filter for site quality (e.g., `--minQ 30`) and minimum depth per genotype (e.g., `--minDP 5`).
4.  **HWE**: Filter for Hardy-Weinberg Equilibrium within populations to remove paralogs or multi-copy loci.
5.  **Complex Variants**: Use `vcflib` to decompose complex variants into primary SNPs and INDELs if required for downstream software.

## Expert Tips
- **Memory Management**: dDocent is resource-intensive. Always specify the maximum number of processors and available memory when prompted by the interactive CLI.
- **Troubleshooting**: If the pipeline fails, check `dDocent_main.LOG` and the `dDocent.runs` file for the specific command that errored.
- **Random Shearing**: If using PE RADseq with random shearing, ensure you are using dDocent version 2.1 or higher, which includes specific assembly options for these libraries.



## Subcommands

| Command | Description |
|---------|-------------|
| ReferenceOpt.sh | Scales similarity parameters for reference-based assembly. |
| ddocent | dDocent 2.9.8 |
| ddocent_RefMapOpt.sh | RefMapOpt |

## Reference documentation
- [Full User Guide](./references/ddocent_com_UserGuide.md)
- [Assembly Tutorial](./references/ddocent_com_assembly.md)
- [Quick Start Guide](./references/ddocent_com_quick.md)
- [SNP Filtering Tutorial](./references/ddocent_com_filtering.md)
- [Bioconda Install](./references/ddocent_com_bioconda.md)