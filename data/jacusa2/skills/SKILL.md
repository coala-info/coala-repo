---
name: jacusa2
description: JACUSA2 is a high-performance Java-based framework designed for the accurate assessment of variants in NGS data.
homepage: https://github.com/dieterich-lab/JACUSA2
---

# jacusa2

## Overview

JACUSA2 is a high-performance Java-based framework designed for the accurate assessment of variants in NGS data. It provides a specialized suite of tools to detect single nucleotide variants (SNVs) and reverse transcriptase-induced arrest events. It is particularly effective for comparative analysis between two conditions (e.g., treated vs. control), making it a preferred choice for RNA editing studies and specialized assays that measure read-through vs. arrest ratios.

## Core CLI Usage

The general syntax for JACUSA2 is:
`java -jar jacusa2.jar <METHOD> <METHOD-OPTIONS> <BAMs>`

### Primary Methods
- **call-1**: Identifies variants against a reference sequence for a single condition.
- **call-2**: Identifies variants by comparing two different conditions.
- **rt-arrest**: Models base call counts of arrest and read-through using a Beta-Binomial distribution to find differences between conditions.
- **pileup**: Generates a SAMtools-like mpileup for two conditions.

### Common Command Patterns

**Variant Calling (Two Conditions)**
To compare a control group against a treatment group:
```bash
java -jar jacusa2.jar call-2 -r results.out condition1.bam condition2.bam
```

**Handling Replicates**
Multiple BAM files for a single condition should be separated by commas (no spaces):
```bash
java -jar jacusa2.jar call-2 -r results.out cond1_rep1.bam,cond1_rep2.bam cond2_rep1.bam,cond2_rep2.bam
```

**Detecting RT-Arrest Events**
When identifying arrest events, specifying the library type is mandatory:
```bash
java -jar jacusa2.jar rt-arrest -P FR-SECONDSTRAND -r arrest_results.out cond1.bam cond2.bam
```

## Expert Tips and Best Practices

### Input Requirements
- **Indexed BAMs**: All input BAM files must be indexed (`samtools index`).
- **MD Tags**: The `call-1` method and several filtering options require the "MD" field to be correctly populated in the BAM file. If missing, use `samtools calmd` to regenerate them using the reference FASTA.
- **Java Version**: JACUSA2 is optimized for Java 17. Ensure your environment uses this version to avoid runtime exceptions.

### Filtering and Performance
- **Feature Filters (`-a`)**: Use the `-a` flag to apply artifact filters (e.g., `-a H:1`) to reduce false positives from mapping artifacts.
- **Coverage Thresholds**: Use `-c <MIN-COVERAGE>` to filter out low-confidence sites. The default is 5.
- **Parallelization**: JACUSA2 supports multi-threading. Note that it creates temporary files for each thread in the JVM's temp directory; ensure sufficient disk space is available for large runs.

### Output Formats
- The default output is a BED6-based format with method-specific columns.
- Use `-f V` if you require VCF output (supported by specific methods like `call-1` and `call-2`).
- The output header (prefixed with `##`) contains critical metadata including the exact command line used and version info.

## Reference documentation
- [JACUSA2 GitHub Repository](./references/github_com_dieterich-lab_JACUSA2.md)
- [JACUSA2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_jacusa2_overview.md)