---
name: gvcfgenotyper
description: gvcfgenotyper performs cohort-level variant calling by merging individual Illumina GVCF files into a unified multisample VCF or BCF. Use when user asks to perform joint genotyping, merge GVCF files into a cohort, or address the N+1 problem in genomics.
homepage: https://github.com/Illumina/gvcfgenotyper
metadata:
  docker_image: "quay.io/biocontainers/gvcfgenotyper:2019.02.26--h13024bc_6"
---

# gvcfgenotyper

## Overview
`gvcfgenotyper` is a high-performance tool for cohort-level variant calling from individual Illumina GVCF files. It addresses the "N+1" problem in genomics by merging individual sample data into a unified multisample BCF or VCF. The tool is unique in that it normalizes and decomposes variants during the merge process and uses depth-block heuristics to estimate homozygous reference confidence (GQ and DP) for samples lacking a specific variant call. It is primarily designed for use with Illumina pipelines and Strelka2 outputs.

## Usage Instructions

### Input Preparation
The tool requires a list of input GVCF files. The most efficient way to provide this is via a text file containing one file path per line.
```bash
find /path/to/gvcfs/ -name '*.genome.vcf.gz' > gvcfs.txt
```

### Basic Execution
To generate a merged BCF file from a list of GVCFs:
```bash
gvcfgenotyper -f reference_genome.fa -l gvcfs.txt -Ob -o cohort_output.bcf
```
*   `-f`: Path to the reference genome FASTA file.
*   `-l`: Text file listing input GVCF paths.
*   `-Ob`: Specifies output format as compressed BCF (use `-Ov` for uncompressed VCF).
*   `-o`: Output file name.

### Parallelization by Region
`gvcfgenotyper` does not have internal multi-threading for a single region, but it is highly efficient when parallelized across chromosomes using `xargs`:
```bash
for i in {1..22} X Y; do 
    echo "-r $i -f genome.fa -l gvcfs.txt -Ob -o output.chr${i}.bcf"
done | xargs -l -P 24 ./gvcfgenotyper
```
*   `-r`: Restricts processing to a specific genomic region or chromosome.
*   `-P`: Number of parallel processes to run (e.g., 24).

### Expert Tips and Best Practices
*   **Format Compatibility**: This tool is strictly for Illumina-style GVCFs. It may not function correctly with GVCFs produced by GATK or other non-Illumina callers due to differences in how depth blocks and reference confidence are represented.
*   **Variant Normalization**: Because the tool normalizes and decomposes variants on-the-fly, the resulting multisample file is often more consistent for downstream analysis than simple VCF merging.
*   **Homozygous Reference Likelihoods**: Be aware that for homozygous reference sites, the tool currently provides dummy PL values (e.g., `0,255,255`). Avoid using these specific values for sensitive de novo mutation calling or sophisticated Bayesian genotype refinement.
*   **Memory Management**: When merging very large cohorts (thousands of samples), ensure the system's file descriptor limit (`ulimit -n`) is set high enough to accommodate all input files simultaneously.

## Reference documentation
- [gvcfgenotyper GitHub Repository](./references/github_com_Illumina_gvcfgenotyper.md)
- [Bioconda gvcfgenotyper Overview](./references/anaconda_org_channels_bioconda_packages_gvcfgenotyper_overview.md)