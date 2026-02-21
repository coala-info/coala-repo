---
name: pindel
description: Pindel is a specialized bioinformatic tool for the high-resolution detection of structural variants.
homepage: http://gmt.genome.wustl.edu/packages/pindel/index.html
---

# pindel

## Overview
Pindel is a specialized bioinformatic tool for the high-resolution detection of structural variants. While many callers struggle with the exact boundaries of insertions and deletions, Pindel uses a pattern growth algorithm to pinpoint breakpoints precisely. It is most effective when you have paired-end genomic data and need to characterize variants that are too large for standard indels callers but require more precision than basic depth-based SV callers.

## Core Workflow

### 1. Input Configuration
Pindel requires a specific configuration file (often named `pindel_conf.txt`) rather than direct BAM input on the command line. Each line in the file represents a library:
`[BAM_PATH] [INSERT_SIZE] [SAMPLE_LABEL]`

Example configuration:
```text
/path/to/sample1.bam 400 Sample1
```

### 2. Running the Analysis
The primary command executes the detection algorithm. You must provide the reference genome and the configuration file.

```bash
pindel -f reference.fa -i pindel_conf.txt -c ALL -o output_prefix
```

**Key Parameters:**
- `-f`: Path to the reference genome in FASTA format.
- `-i`: The configuration file listing BAMs and insert sizes.
- `-c`: The chromosome/contig to analyze (use `ALL` for the whole genome).
- `-o`: Prefix for the multiple output files generated (e.g., `_D` for deletions, `_SI` for small insertions).
- `-T`: Number of threads to use for parallel processing.

### 3. Converting Output to VCF
Pindel produces raw text files for different variant types. To use these in standard downstream pipelines, convert them to VCF format using `pindel2vcf`.

```bash
pindel2vcf -p output_prefix_D -r reference.fa -R reference_name -d date -v output.vcf
```

## Expert Tips and Best Practices
- **Insert Size Accuracy**: Ensure the insert size provided in the configuration file is as accurate as possible, as Pindel uses this to identify "anchor" reads where one end maps and the other is unmapped or clipped.
- **Memory Management**: For large genomes or high coverage, process by chromosome (using `-c`) rather than `ALL` to manage memory consumption and runtime.
- **Breakpoint Refinement**: Pindel is particularly strong at "medium-sized" insertions (up to 100-500bp) that are often missed by standard assembly-based or split-read callers.
- **Filtering**: Raw Pindel output can be noisy. Always use `pindel2vcf` with quality filters or post-process the VCF to filter based on the number of supporting reads (the `AD` or `SR` fields).

## Reference documentation
- [Pindel Overview](./references/anaconda_org_channels_bioconda_packages_pindel_overview.md)
- [Pindel Home and Documentation](./references/gmt_genome_wustl_edu_packages_pindel_index.html.md)