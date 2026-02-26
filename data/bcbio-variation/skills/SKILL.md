---
name: bcbio-variation
description: bcbio-variation is a toolkit for normalizing, evaluating, and merging genomic variant calls to ensure consistency across different calling algorithms. Use when user asks to normalize VCF files, compare variant callsets for concordance, create ensemble callsets from multiple inputs, or generate variant statistics and annotations.
homepage: https://github.com/chapmanb/bcbio.variation
---


# bcbio-variation

## Overview

bcbio-variation is a Clojure-based toolkit built on top of the Genome Analysis Toolkit (GATK) specifically designed for the rigorous evaluation of genomic variants. Its primary strength lies in its ability to "clean" and normalize VCF files—handling issues like multi-nucleotide polymorphisms (MNPs) and inconsistent indel representations—so that different variant calling algorithms can be compared fairly. It is an essential tool for bioinformatics workflows requiring high-confidence validation or the merging of disparate variant callsets into a single ensemble output.

## Core CLI Operations

### Variant Normalization and Preparation
VCF files often represent the same biological variant in different ways. Use `variant-prep` to produce a stable, decomposed VCF suitable for downstream tools or comparison.

```bash
java -jar bcbio.variation.jar variant-prep <input_variants.vcf> <reference.fasta> [options]
```

**Key Options:**
- `--max-indel <size>`: Filter out indels larger than the specified size (e.g., 30).
- `--keep-ref`: Retain reference calls (0/0) and no-calls in the output file.
- **Automatic Fixes**: This command automatically re-orders variants to match the reference file and remaps chromosome names (e.g., hg19 to GRCh37).

### Direct Concordance Comparison
To quickly compare two VCF files within specific genomic regions without complex configuration:

```bash
java -jar bcbio.variation.jar variant-utils comparetwo <evaluation.vcf> <reference_call.vcf> <reference.fasta> <regions.bed>
```

This generates a summary of concordance and discordance between the evaluation set and the gold-standard reference set.

### Ensemble Variant Calling
To merge multiple VCFs into a single high-confidence callset, use the `variant-ensemble` command. This process normalizes all inputs and filters the combined file.

```bash
java -jar bcbio.variation.jar variant-ensemble <params.yaml> <reference.fasta> <output.vcf> <input1.vcf> <input2.vcf> [input3.vcf ...]
```

### Genomic Statistics and Annotation
Since the toolkit includes a full GATK command line, you can run custom walkers for variant metrics:

**Generate Variant Statistics:**
```bash
java -jar bcbio.variation.jar -T VcfSimpleStatsWalker -R <reference.fasta> --variant <input.vcf> --out <output_plot.png>
```

**Annotate Variants with Read Data:**
```bash
java -jar bcbio.variation.jar -T VariantAnnotator -A MeanNeighboringBaseQuality -R <reference.fasta> -I <alignments.bam> --variant <input.vcf> -o <annotated.vcf>
```

## Expert Tips

- **Java Version**: Ensure you are using Java 1.7 or 1.8. The underlying GATK libraries in bcbio-variation are incompatible with older versions and may have issues with newer Java runtimes.
- **Memory Management**: For large VCFs or complex ensemble calling, always specify heap size to avoid OutOfMemory errors: `java -Xmx4g -jar bcbio.variation.jar ...`
- **Structural Variants**: When working with structural variants, use `variant-utils sort-vcf` to ensure proper positioning without triggering the standard SNP/Indel normalization logic which can sometimes mask large deletions.
- **Sample Name Consistency**: If your input VCFs have inconsistent sample names, use the toolkit's ability to fix sample names during the prep phase to ensure the ensemble caller correctly identifies matching samples across files.

## Reference documentation
- [bcbio.variation README](./references/github_com_chapmanb_bcbio.variation.md)
- [bcbio.variation Wiki](./references/github_com_chapmanb_bcbio.variation_wiki.md)