---
name: snver
description: SNVer is a statistical framework for identifying common and rare genetic variants in individual or pooled next-generation sequencing datasets. Use when user asks to call variants from BAM or SAM files, perform pooled variant calling, or calculate p-values for candidate loci using a binomial-binomial model.
homepage: http://snver.sourceforge.net/
metadata:
  docker_image: "quay.io/biocontainers/snver:0.5.3--0"
---

# snver

## Overview

SNVer is a Java-based statistical framework designed to identify common and rare variants in both individual and pooled NGS datasets. Unlike many callers that rely on heuristic filters, SNVer calculates a formal p-value for each candidate locus using a binomial-binomial model. This approach allows for quantitative integration of depth of coverage and base quality into the final significance calculation, making it highly effective for low-coverage regions and complex pooled samples where allele frequencies are low.

## Core CLI Patterns

### Individual Variant Calling
Use `SNVerIndividual.jar` for single-sample BAM or SAM files.

```bash
java -jar SNVerIndividual.jar -i input.bam -r reference.fa -o output_prefix
```

### Pooled Variant Calling
Use `SNVerPool.jar` for directories containing multiple BAM/SAM files. You must specify the number of haploids (e.g., 2 * number of individuals).

```bash
# Using a fixed haploid count for all pools
java -jar SNVerPool.jar -i ./bam_dir/ -r reference.fa -n 100 -o pooled_output

# Using a configuration file for heterogeneous pools
java -jar SNVerPool.jar -i ./bam_dir/ -r reference.fa -c pool_info.ini -o pooled_output
```

## Expert Tips and Best Practices

### 1. Reference Consistency
The reference FASTA file must match the headers of the BAM/SAM files exactly (chromosome names and lengths). Use `samtools view -H <file>.bam` to verify the `@SQ` lines before running SNVer to avoid `ReferenceNotMatchException`.

### 2. Pooled Configuration (`-c` option)
When pools have different sizes or require specific quality thresholds, use a tab-delimited `.ini` file with the following columns:
`#names  no.haploids  no.samples  mq  bq`
- **mq**: Mapping quality threshold (default 20).
- **bq**: Base quality threshold (default 17).

### 3. Significance and Multiplicity Control
- **P-value Threshold (`-p`)**: The default uses Bonferroni correction (`0.05 / number of tests`). You can override this with a specific value (e.g., `-p 0.01`).
- **Output Files**: SNVer always generates two VCF files: `.raw.vcf` (all tested loci) and `.filter.vcf` (loci passing the p-value threshold).

### 4. Filtering False Positives
- **Strand Bias (`-s`)**: Uses a one-sided binomial test. Default is `0.0001`.
- **Allele Imbalance (`-f`)**: Uses Fisher's exact test. Default is `0.0001`.
- **Minimum Support (`-a`)**: Requires at least `n` reads supporting the alternative allele on *each* strand. Default is 1.
- **Reference Bias (`-b`)**: For individual data, requires the alt/ref ratio to exceed a threshold (default 0.25).

### 5. Performance Optimization
- **Targeted Regions (`-l`)**: Always provide a BED file of target regions if performing exome or targeted sequencing to significantly reduce runtime and improve the Bonferroni-corrected p-value.
- **Memory**: For whole-genome analysis, ensure the JVM has sufficient heap space (e.g., `java -Xmx4g -jar ...`).

## Reference documentation
- [SNVer Manual](./references/snver_sourceforge_net_manual.html.md)
- [Pipeline Guide](./references/snver_sourceforge_net_pipeline.html.md)
- [Getting Started](./references/snver_sourceforge_net_start.html.md)