---
name: longcalld
description: longcalld performs joint calling of small variants and structural variants using local haplotagging on long-read sequencing data. Use when user asks to call variants from PacBio or ONT reads, detect mosaic variants, identify mobile element insertions, or generate phased VCFs.
homepage: https://github.com/yangao07/longcallD
metadata:
  docker_image: "quay.io/biocontainers/longcalld:0.0.9--hbc58adc_0"
---

# longcalld

## Overview

`longcalld` is a specialized genomic tool that utilizes local haplotagging to perform joint calling of small variants and structural variants (SVs) in a single pass. Unlike many callers that separate these tasks, `longcalld` phases long reads into haplotypes using SNPs and small indels to improve the accuracy of SV detection (specifically insertions and deletions). It is highly effective for generating phased VCFs and refined read alignments, especially in challenging low-complexity regions like homopolymers and tandem repeats.

## Command Line Usage

### Basic Variant Calling

The primary command is `longcallD call`. By default, the tool is optimized for PacBio HiFi reads.

**For PacBio HiFi reads:**
```bash
longcallD call -t 16 reference.fa input.bam > output.vcf
```

**For Oxford Nanopore (ONT) reads:**
```bash
longcallD call --ont -t 16 reference.fa input.bam > output.vcf
```

### Handling Multiple Inputs

If you have multiple BAM/CRAM files for the same sample, use the `-X` flag or an input list.

**Using multiple flags:**
```bash
longcallD call -t 16 reference.fa part1.bam -X part2.bam -X part3.bam > merged_sample.vcf
```

**Using a list file:**
```bash
# input_list.txt contains one BAM path per line
longcallD call -t 16 --input-is-list reference.fa input_list.txt > merged_sample.vcf
```

### Mosaic and Somatic Variant Calling

To detect low-allele-fraction mosaic variants (SNVs and large indels), use the `-s` or `--mosaic` flag.

**Basic mosaic calling:**
```bash
longcallD call -s -t 16 reference.fa input.bam > mosaic.vcf
```

**Enhanced Mobile Element Insertion (MEI) detection:**
When calling mosaic variants, it is highly recommended to provide annotation sequences for common mobile elements (Alu, L1, SVA) using the `-T` flag.
```bash
longcallD call -s -t 16 reference.fa input.bam -T mobile_elements.fa > mosaic_mei.vcf
```

### Targeted Calling (Regions)

Limit calling to specific genomic coordinates or regions to save time and resources.

**Coordinate string:**
```bash
longcallD call reference.fa input.bam chr11:10,000,000-11,000,000 > region.vcf
```

**BED file:**
```bash
longcallD call reference.fa input.bam --region-file targets.bed > targeted.vcf
```

**Autosomes only:**
```bash
longcallD call reference.fa input.bam --autosome > autosomes.vcf
```

## Expert Tips and Best Practices

- **Refined Alignments**: Use the `--refine-aln` flag to generate refined read alignments based on haplotype-specific multiple sequence alignment. This is particularly beneficial for visualizing variants in IGV within homopolymer runs or tandem repeats.
- **Thread Scaling**: Use the `-t` parameter to match your available CPU cores. The tool is optimized for speed and scales well with additional threads.
- **Memory Efficiency**: `longcalld` is designed to be lightweight. If working with extremely large datasets, ensure your environment has sufficient memory for the reference genome index and local assembly buffers.
- **Output Interpretation**: In mosaic mode (`-s`), variants identified as somatic/mosaic will have a `SOMATIC` tag added to the INFO field in the output VCF.
- **Platform Optimization**: Always specify `--ont` for Nanopore data; the default parameters are specifically tuned for the higher accuracy profile of PacBio HiFi reads.

## Reference documentation
- [longcallD GitHub Repository](./references/github_com_yangao07_longcallD.md)
- [longcalld Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_longcalld_overview.md)