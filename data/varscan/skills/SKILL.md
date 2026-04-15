---
name: varscan
description: VarScan is a Java tool designed for robust variant calling across various genomic study designs. Use when user asks to call germline variants, discover somatic mutations, call copy number alterations, or identify de novo mutations in trios.
homepage: http://dkoboldt.github.io/varscan/
metadata:
  docker_image: "quay.io/biocontainers/varscan:2.4.6--hdfd78af_0"
---

# varscan

## Overview
VarScan is a platform-independent Java tool designed for robust variant calling across various genomic study designs. Unlike probabilistic callers, VarScan employs a heuristic approach followed by Fisher's Exact Test to validate variants based on user-defined thresholds for read depth, base quality, and allele frequency. It is highly versatile, supporting single-sample germline calling, multi-sample mpileup analysis, and comparative tumor-normal analysis for somatic mutations and copy number changes.

## Core Workflows

### 1. Germline Variant Calling (Single or Multi-sample)
Use `mpileup2snp`, `mpileup2indel`, or `mpileup2cns` (for both) with SAMtools mpileup input.

```bash
# Recommended: Pipe SAMtools mpileup directly to VarScan
samtools mpileup -B -f reference.fasta sample.bam | \
java -jar VarScan.jar mpileup2cns --variants 1 --output-vcf 1
```
*   **Key Parameter**: `-B` in `samtools mpileup` is critical to disable BAQ computation, which can be too stringent for VarScan's heuristic filters.

### 2. Somatic Mutation Discovery (Tumor-Normal)
Identifies Somatic, Germline, and LOH (Loss of Heterozygosity) events.

```bash
# Using a single mpileup stream for both samples (Recommended)
samtools mpileup -q 1 -B -f ref.fa normal.bam tumor.bam | \
java -jar VarScan.jar somatic output.basename --mpileup 1
```
*   **Post-Processing**: Always run `processSomatic` to separate calls into high-confidence (.hc) and low-confidence (.lc) files.
    ```bash
    java -jar VarScan.jar processSomatic output.basename.snp
    ```

### 3. Copy Number Alteration (CNA) Calling
Compares read depths between matched tumor-normal pairs.

```bash
samtools mpileup -q 1 -f ref.fa normal.bam tumor.bam | \
java -jar VarScan.jar copynumber output.basename --mpileup 1

# Adjust for GC content and filter
java -jar VarScan.jar copyCaller output.basename.copynumber --output-file output.called
```

### 4. Trio Calling (De Novo Mutations)
Requires father, mother, and child BAMs in that specific order.

```bash
samtools mpileup -B -q 1 -f ref.fa dad.bam mom.bam child.bam | \
java -jar VarScan.jar trio trio.mpileup output.basename
```

## Expert Tips and Best Practices

*   **Input Requirements**: VarScan requires SAMtools pileup or mpileup format. It expects Phred+33 (Sanger) base qualities.
*   **P-value Calculation**: By default, p-values are often skipped (set to 0.98) to save time. Explicitly set `--p-value 0.05` to trigger the Fisher's Exact Test calculation.
*   **Strand Bias Filter**: For initial discovery, set `--strand-filter 1` to remove variants supported by only one strand (a common sequencing artifact).
*   **Memory Management**: Since it's a Java app, for large datasets, increase the heap size: `java -Xmx4g -jar VarScan.jar ...`.
*   **Minimum Coverage**: The default is often 8x or 20x. For low-depth WGS or rare variant detection in pools, lower this to 6x and adjust `--min-var-freq` accordingly.
*   **VCF Output**: Always use `--output-vcf 1` for compatibility with downstream tools like VEP or SnpEff.

## Reference documentation
- [Germline Variant Calling](./references/dkoboldt_github_io_varscan_germline-calling.html.md)
- [Somatic Mutation Calling](./references/dkoboldt_github_io_varscan_somatic-calling.html.md)
- [Copy Number Variant Calling](./references/dkoboldt_github_io_varscan_copy-number-calling.html.md)
- [Trio Calling for de novo Mutations](./references/dkoboldt_github_io_varscan_trio-calling-de-novo-mutations.html.md)
- [Support FAQ](./references/dkoboldt_github_io_varscan_support-faq.html.md)