---
name: dipcall
description: dipcall identifies genomic variations by aligning two phased haplotype assemblies to a common reference genome. Use when user asks to call small variants and long INDELs from assembly contigs, generate high-confidence VCF and BED files, or process phased haplotype assemblies for male or female samples.
homepage: https://github.com/lh3/dipcall
metadata:
  docker_image: "quay.io/biocontainers/dipcall:0.3--hdfd78af_0"
---

# dipcall

## Overview
dipcall is a specialized pipeline designed to identify genomic variations by aligning two phased haplotype assemblies to a common reference. By utilizing assembly contiguity rather than short-read data, it can reliably call small variants and long INDELs that are captured within minimap2 alignments. The tool produces both a VCF of variant calls and a BED file defining high-confidence regions where the assemblies provide reliable coverage for both haplotypes.

## Installation and Setup
The most efficient way to install dipcall is via Bioconda:
```bash
conda install -c bioconda dipcall
```
Alternatively, you can download the pre-compiled binary package from the GitHub releases page.

## Common CLI Patterns

### Standard Workflow (Female Sample)
The pipeline operates by generating a Makefile which is then executed using `make`.
```bash
# 1. Generate the Makefile
run-dipcall prefix reference.fa paternal_asm.fa.gz maternal_asm.fa.gz > prefix.mak

# 2. Execute the pipeline (using 2 threads)
make -j2 -f prefix.mak
```

### Male Sample (Handling Sex Chromosomes)
For male samples, you must provide a BED file containing the Pseudoautosomal Regions (PAR) to handle the X and Y chromosomes correctly.
```bash
run-dipcall -x hs38.PAR.bed prefix reference.fa paternal_asm.fa.gz maternal_asm.fa.gz > prefix.mak
make -f prefix.mak
```
*Note: In male samples, Parent 1 is assumed to be the father and Parent 2 the mother.*

## Expert Tips and Best Practices

### Understanding the Output
- **prefix.dip.vcf.gz**: Contains the variant calls. A "HET1" filter indicates the first parent is heterozygous at that site; a "GAP1" filter indicates a lack of alignment coverage (>=50kb) from the first parent.
- **prefix.dip.bed**: Defines the "confident regions." A region is included if it is covered by exactly one >=50kb alignment (mapQ >=5) from each parent and no other >=10kb alignments.

### Filtering Logic
- The BED file is more stringent than the VCF. While most filtered VCF calls are excluded from the BED, some unfiltered VCF calls may also be excluded if they fall outside the high-confidence criteria. Always use the BED file to define the callable genome when calculating sensitivity or precision.

### Reference Masking
- To ensure proper calls on sex chromosomes for male samples, it is recommended to hard-mask PAR regions on the reference Y chromosome.

### Alignment Requirements
- dipcall (version 0.3+) uses `minimap2` by default. It can call INDELs as long as they are contained within the minimap2 alignment. If an INDEL is too long to be aligned, it will not be called.

## Reference documentation
- [GitHub README](./references/github_com_lh3_dipcall_blob_master_README.md)
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dipcall_overview.md)