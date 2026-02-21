---
name: mutserve
description: Mutserve is a specialized variant caller optimized for the unique characteristics of the mitochondrial genome.
homepage: https://github.com/seppinho/mutserve
---

# mutserve

## Overview
Mutserve is a specialized variant caller optimized for the unique characteristics of the mitochondrial genome. While standard callers often struggle with the circular nature and varying levels of heteroplasmy (the presence of multiple mtDNA genotypes in one sample), Mutserve provides high-sensitivity detection of both homoplasmic and low-level heteroplasmic sites. It processes alignment data (BAM/CRAM) and can produce either detailed tab-delimited reports or standard VCF files compatible with downstream phylogenetic tools like HaploGrep.

## Command Line Usage

### Variant Calling
The `call` command is the primary tool for identifying variants. It requires sorted and indexed BAM or CRAM files.

```bash
# Basic variant calling to VCF
mutserve call --reference rCRS.fasta --output results.vcf.gz --threads 4 input.bam

# High-sensitivity calling (detecting heteroplasmy down to 0.5%)
mutserve call --reference rCRS.fasta --level 0.005 --output sensitive_results.txt input.bam
```

### Variant Annotation
The `annotate` command adds functional context to the variants identified during the calling step.

```bash
mutserve annotate \
  --input variantfile.txt \
  --annotation rCRS_annotation_2020-08-20.txt \
  --reference rCRS.fasta \
  --output AnnotatedVariants.txt
```

## Expert Tips and Best Practices

### Input Requirements
* **Indexing**: Always ensure your BAM/CRAM files have corresponding `.bai` or `.crai` index files in the same directory.
* **Reference Alignment**: Use the Revised Cambridge Reference Sequence (rCRS) for human mtDNA studies to ensure compatibility with standard annotation files.

### Parameter Optimization
* **Heteroplasmy Level (`--level`)**: The default is `0.01` (1%). Lowering this increases sensitivity but may increase false positives depending on the sequencing chemistry and depth.
* **Quality Filters**: Use `--mapQ`, `--baseQ`, and `--alignQ` (default 20, 20, and 30 respectively) to tune the stringency of the reads processed.
* **Indels**: Calling insertions (`--insertions`) and deletions (`--deletions`) is currently in beta. For high-confidence indel calling, consider using Mutserve in conjunction with mtDNA-Server 2.

### Output Formats
* **Tab-delimited (.txt)**: Best for manual inspection. Includes `MajorBase`, `MajorLevel`, `MinorBase`, and `MinorLevel`. The `VariantLevel` column always reports the non-reference variant level.
* **VCF (.vcf or .vcf.gz)**: Required for integration with HaploGrep. Heteroplasmies are coded as `1/0` genotypes, with the heteroplasmy level stored in the `AF` (Allele Frequency) attribute. Note that indels are currently excluded from VCF output.

### Variant Types
The output includes a type classification column:
1. **1**: Homoplasmy
2. **2**: Heteroplasmy or Low-Level Variant
3. **3**: Low-Level Deletion
4. **4**: Deletion
5. **5**: Insertion

## Reference documentation
- [Mutserve Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mutserve_overview.md)
- [Mutserve GitHub Repository](./references/github_com_seppinho_mutserve.md)