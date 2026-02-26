---
name: adam
description: ADAM is a distributed genomics analysis platform that parallelizes bioinformatics workflows using Apache Spark and schema-aligned Parquet data. Use when user asks to convert legacy genomic files to Parquet, mark duplicates, recalibrate base quality scores, sort reads, or perform large-scale genomic transformations.
---


# ADAM: Distributed Genomics Analysis

ADAM parallelizes genomic analysis by leveraging Apache Spark. It replaces traditional single-node bioinformatics tools with distributed workflows that use schema-aligned data.

## Environment Setup

ADAM requires a functional Spark installation.
- **Requirement**: Set `$SPARK_HOME` to your Spark installation directory.
- **Spark Version**: 3.2.0 or later is required for ADAM 0.37.0+.
- **Memory**: Genomic tasks are memory-intensive. Always configure Spark executor memory based on the dataset size.

## Common CLI Patterns

The primary entry point for the CLI is `adam-submit` (or `bin/adam-submit` when running from source).

### Data Conversion (Legacy to Parquet)
The most common first step is converting row-based legacy files into ADAM's specialized Parquet format for faster querying.

```bash
# Convert BAM to ADAM (Parquet)
adam-submit transform input.bam output.adam

# Convert VCF to Genotypes in Parquet
adam-submit vcf2adgt input.vcf output.gt.adam
```

### Genomic Transformations
ADAM provides subcommands to perform standard preprocessing at scale.

```bash
# Mark Duplicates
adam-submit transform input.adam output.mkdup.adam -mark_duplicate_reads

# Recalibrate Base Quality Scores (BQSR)
adam-submit transform input.adam output.recal.adam -recalibrate_base_qualities -known_snps known_variants.vcf

# Sort Reads
adam-submit transform input.adam output.sorted.adam -sort_reads
```

### Exporting Data
To return to legacy formats for use with non-distributed tools:

```bash
# Convert ADAM back to BAM
adam-submit transform input.adam output.bam

# Convert ADAM to SAM
adam-submit transform input.adam output.sam
```

## Expert Tips & Best Practices

### 1. Resource Allocation
When running on a cluster, use Spark-specific flags to manage resources. Genomic joins and shuffles are expensive.
- Use `--driver-memory` and `--executor-memory` (e.g., `32G`).
- Use `--conf spark.driver.maxResultSize=0` for large exports.

### 2. Predicate Pushdown
ADAM uses Parquet's columnar storage. When possible, filter data during the `transform` step to reduce the amount of data Spark needs to load into memory.

### 3. Fragment vs. Alignment
- **AlignmentDataset**: Used for mapped reads (BAM-like).
- **FragmentDataset**: Used for unaligned or paired-end reads where the relationship between pairs must be preserved before alignment. Use `toFragments()` in APIs or specific CLI flags if the downstream tool requires paired-end context.

### 4. Validation
Use the `count` or `flagstat` commands to verify data integrity after a large distributed transformation:
```bash
adam-submit flagstat input.adam
```

### 5. Storage Optimization
ADAM data is stored as a directory of Parquet files. If you have many small files, performance will degrade. Use the `-repartition` flag during a `transform` to consolidate data into a manageable number of partitions (typically 2-3x the number of available cores).