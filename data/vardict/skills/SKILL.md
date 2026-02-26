---
name: vardict
description: VarDict identifies genetic alterations like SNPs, MNPs, and indels from BAM files. Use when user asks to call variants, call variants for a single sample, call somatic mutations, or perform amplicon-aware variant calling.
homepage: https://github.com/AstraZeneca-NGS/VarDict
---


# vardict

## Overview

VarDict is a versatile variant caller designed to identify a wide range of genetic alterations, including SNPs, MNPs, and complex indels, from BAM files. It is particularly distinguished by its ability to perform on-the-fly local realignment, which allows it to rescue long indels that other callers often miss. VarDict operates on a "call everything" philosophy, providing high sensitivity that is then refined through downstream statistical scripts for strand bias and somatic validation.

## Core Workflows

### Single Sample Variant Calling
The standard pipeline involves piping VarDict's raw output through a strand bias filter and a VCF conversion script.

```bash
# Set Allele Frequency threshold (e.g., 0.01 for 1%)
AF_THR="0.01"

vardict -G /path/to/reference.fa \
        -f $AF_THR \
        -N sample_name \
        -b /path/to/my.bam \
        -c 1 -S 2 -E 3 -g 4 /path/to/regions.bed \
        | teststrandbias.R \
        | var2vcf_valid.pl -N sample_name -E -f $AF_THR > output.vcf
```

### Paired (Tumor/Normal) Variant Calling
For somatic mutation discovery, provide both BAM files separated by a pipe character and use the somatic-specific R script and VCF converter.

```bash
AF_THR="0.01"

vardict -G /path/to/reference.fa \
        -f $AF_THR \
        -N tumor_sample_name \
        -b "/path/to/tumor.bam|/path/to/normal.bam" \
        -c 1 -S 2 -E 3 -g 4 /path/to/regions.bed \
        | testsomatic.R \
        | var2vcf_paired.pl -N "tumor_sample_name|normal_sample_name" -f $AF_THR > somatic.vcf
```

## Expert Tips and Best Practices

### 1. Java vs. Perl Implementation
While the original implementation is in Perl (`vardict.pl`), a Java drop-in replacement (`VarDictJava`) is available.
- **Performance**: The Java version is approximately 10x faster.
- **Dependencies**: The Java version does not require `samtools` in the PATH, whereas the Perl version does.

### 2. Amplicon-Aware Calling
To enable amplicon bias awareness (single sample mode only), you must provide an 8-column BED file.
- **BED Format**: Columns 7 and 8 must contain the insert interval (a subset of the 2nd and 3rd column interval).
- **Example Row**: `chr1 115247094 115247253 NRAS 0 . 115247117 115247232`

### 3. Column Mapping Parameters
VarDict requires explicit mapping of BED file columns if they deviate from defaults:
- `-c`: Chromosome column (1-based)
- `-S`: Region start column
- `-E`: Region end column
- `-g`: Gene/Region name column

### 4. Handling "Everything"
VarDict is designed to be ultra-sensitive. If the output is too noisy:
- Increase the Allele Frequency threshold (`-f`).
- Ensure `teststrandbias.R` or `testsomatic.R` is included in the pipe to filter out artifacts.
- Use the `vcf2txt.pl` script provided in the repository to annotate variants with dbSNP, Cosmic, or ClinVar context for better prioritization.

### 5. Memory and Scaling
VarDict scales better than many other Java-based callers, but when processing large whole-genome files, it is recommended to parallelize by chromosome or use the `splitBed.pl` utility to chunk the workload.

## Reference documentation
- [VarDict Main Repository](./references/github_com_AstraZeneca-NGS_VarDict.md)
- [VarDict Wiki Overview](./references/github_com_AstraZeneca-NGS_VarDict_wiki.md)