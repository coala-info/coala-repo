---
name: vardict-java
description: VarDictJava identifies genomic variations including SNPs, MNPs, and structural variants directly from BAM files. Use when user asks to identify genomic variations, perform single-sample variant calling, perform paired/somatic variant calling, or call variants in specific genomic regions.
homepage: https://github.com/AstraZeneca-NGS/VarDictJava
---


# vardict-java

## Overview

VarDictJava is a high-performance Java port of the VarDict variant caller. It is designed to identify a wide range of genomic variations—including single nucleotide polymorphisms, multi-nucleotide polymorphisms, and structural variants like inversions or duplications—directly from BAM files. It is approximately 10x faster than the original Perl implementation and excels at detecting low-frequency variants and complex mutations that require local realignment.

## Core Workflows

VarDictJava typically operates in a pipeline, piping its tabular output into R scripts for bias testing and then into Perl scripts for VCF conversion.

### Single Sample Variant Calling
Use this pattern for germline or single-sample somatic analysis.

```bash
# Define Allele Frequency threshold
AF_THR="0.01"

VarDict -G /path/to/reference.fa \
    -f $AF_THR \
    -N sample_name \
    -b /path/to/sample.bam \
    -c 1 -S 2 -E 3 -g 4 /path/to/regions.bed \
    | teststrandbias.R \
    | var2vcf_valid.pl -N sample_name -E -f $AF_THR > output.vcf
```

### Paired/Somatic Variant Calling
Use the pipe `|` symbol between BAM files to trigger paired mode.

```bash
VarDict -G /path/to/reference.fa \
    -f $AF_THR \
    -N tumor_name \
    -b "/path/to/tumor.bam|/path/to/normal.bam" \
    -c 1 -S 2 -E 3 -g 4 /path/to/regions.bed \
    | testsomatic.R \
    | var2vcf_paired.pl -N "tumor_name|normal_name" -f $AF_THR > somatic.vcf
```

### Calling Specific Regions
Use the `-R` flag to call variants in a specific genomic window without a BED file. Format: `chr:start-end:gene_symbol`.

```bash
VarDict -G ref.fa -f 0.01 -N sample -b sample.bam -R chr7:55270300-55270348:EGFR | ...
```

## Command Line Options

| Option | Description |
| :--- | :--- |
| `-G` | Path to the reference genome FASTA file. |
| `-f` | Minimum allele frequency threshold (e.g., 0.01 for 1%). |
| `-N` | Sample name for the VCF header. |
| `-b` | Path to BAM file(s). Use `BAM1|BAM2` for paired mode. |
| `-c` | Column index in BED file for Chromosome (1-based). |
| `-S` | Column index in BED file for Region Start. |
| `-E` | Column index in BED file for Region End. |
| `-g` | Column index in BED file for Gene Name. |
| `-th` | Number of threads (default is 1). |

## Expert Tips & Best Practices

- **BED Column Mapping**: Ensure your `-c`, `-S`, `-E`, and `-g` flags match your BED file structure. If your BED file only has 3 columns, you may need to omit `-g` or point it to a dummy column.
- **Memory Management**: For large BAM files or high-depth regions, if you encounter `java.lang.OutOfMemoryError`, increase the JVM heap size using `java -Xmx8g -jar ...` or ensure the environment has sufficient RAM.
- **Amplicon Sequencing**: VarDict is uniquely capable of handling amplicon bias. Ensure you use the provided `teststrandbias.R` script in your pipeline to filter out false positives resulting from PCR bias.
- **Pathing**: The distribution package places helper scripts (`teststrandbias.R`, `var2vcf_valid.pl`) in the `bin/` directory. Ensure these are in your `$PATH` or referenced by their full path.
- **Local Realignment**: VarDict performs realignment on-the-fly. This allows it to "rescue" long indels (up to 125bp) from soft-clipped reads that other callers might ignore.

## Reference documentation
- [VarDictJava Main Documentation](./references/github_com_AstraZeneca-NGS_VarDictJava.md)
- [VarDictJava Wiki and Best Practices](./references/github_com_AstraZeneca-NGS_VarDictJava_wiki.md)