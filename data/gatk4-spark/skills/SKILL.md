---
name: gatk4-spark
description: This tool provides guidance for executing Spark-enabled GATK tools to parallelize compute-intensive genomic workflows. Use when user asks to run GATK tools on Spark, optimize resource allocation for variant discovery, or manage Spark-specific arguments like spark-master and memory configurations.
homepage: https://www.broadinstitute.org/gatk/
---


# gatk4-spark

## Overview
The `gatk4-spark` skill provides specialized guidance for executing the Spark-enabled versions of the Genome Analysis Toolkit (GATK). While standard GATK tools run on single nodes, Spark-enabled tools are designed to parallelize compute-intensive genomic workflows. This skill focuses on optimizing command-line execution, managing Spark-specific arguments, and ensuring efficient resource allocation for variant discovery and data preprocessing.

## Core CLI Patterns
GATK4 Spark tools generally follow the standard GATK syntax but include specific arguments for the Spark engine.

### Local Execution
For running on a single machine using multiple cores:
```bash
gatk ToolNameSpark \
  -I input.bam \
  -O output.vcf \
  -R reference.fasta \
  -- \
  --spark-master local[N]
```
*Replace `N` with the number of available CPU cores.*

### Cluster Execution (Spark Standalone/YARN)
```bash
gatk ToolNameSpark \
  -I hdfs://path/to/input.bam \
  -O hdfs://path/to/output.vcf \
  -R hdfs://path/to/reference.fasta \
  -- \
  --spark-master spark://host:port \
  --conf 'spark.executor.memory=8g'
```

## Common Spark-Enabled Tools
- **MarkDuplicatesSpark**: A faster, parallelized version of MarkDuplicates.
- **HaplotypeCallerSpark**: Experimental Spark implementation for germline SNP and Indel calling.
- **BaseRecalibratorSpark**: Generates a recalibration table for BQSR.
- **PrintReadsSpark**: Applies BQSR or filters reads in a parallelized fashion.

## Expert Tips & Best Practices
- **The Double Dash (`--`)**: Always place Spark-specific arguments (like `--spark-master` or `--conf`) after a double dash at the end of the command. Arguments before the `--` are interpreted by GATK; arguments after are passed to the Spark engine.
- **Memory Management**: Genomic data is memory-intensive. Use `--conf 'spark.driver.memory=Xg'` and `--conf 'spark.executor.memory=Xg'` to prevent OutOfMemory (OOM) errors.
- **Validation Stringency**: When working with Spark, ensure your input BAM files are properly indexed and coordinate-sorted, as Spark tools are often less forgiving of malformed headers than their non-Spark counterparts.
- **HDFS vs. Local FS**: If running on a cluster, ensure the reference genome and input files are accessible via HDFS or a shared filesystem (like S3/GCS) to avoid data localization bottlenecks.

## Reference documentation
- [GATK4-Spark Overview](./references/anaconda_org_channels_bioconda_packages_gatk4-spark_overview.md)