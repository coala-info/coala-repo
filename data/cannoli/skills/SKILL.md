---
name: cannoli
description: Cannoli provides a distributed execution layer for standard bioinformatics command-line tools by wrapping them for use within the Apache Spark framework.
homepage: https://github.com/bigdatagenomics/cannoli
---

# cannoli

## Overview
Cannoli provides a distributed execution layer for standard bioinformatics command-line tools by wrapping them for use within the Apache Spark framework. It allows researchers to take advantage of cluster computing to parallelize tasks that are traditionally restricted to single nodes, such as sequence alignment and variant calling. By leveraging the ADAM genomic data format, Cannoli enables high-performance, schema-aligned processing of large-scale sequencing data.

## Core CLI Usage

Cannoli provides two primary interfaces: `cannoli-submit` for batch processing and `cannoli-shell` for interactive Scala-based analysis.

### Batch Execution with cannoli-submit
The `cannoli-submit` command follows a specific syntax where Spark-specific arguments are separated from Cannoli-specific arguments by a double dash (`--`).

**Syntax:**
`cannoli-submit [<spark-args> --] <command> <input> <output> [options]`

**Example: Distributed Alignment with BWA-MEM**
```bash
cannoli-submit \
  --master spark://cluster-url:7077 \
  --executor-memory 16G \
  -- \
  bwaMem \
  input_fragments.adam \
  output_alignments.adam \
  -sample_id sample_01 \
  -index hg38.fa \
  -add_files
```

### Interactive Analysis with cannoli-shell
The `cannoli-shell` extends the ADAM and Spark shells, providing implicit methods to call bioinformatics tools directly on genomic datasets (RDDs).

**Required Imports:**
```scala
import org.bdgenomics.adam.ds.ADAMContext._
import org.bdgenomics.cannoli.Cannoli._
import org.bdgenomics.cannoli.BwaMemArgs
```

**Workflow Example:**
```scala
val reads = sc.loadPairedFastqAsFragments("reads1.fq", "reads2.fq")
val args = new BwaMemArgs()
args.indexPath = "hg38.fa"
val alignments = reads.alignWithBwaMem(args)
alignments.saveAsParquet("alignments.adam")
```

## Supported Commands

Cannoli wraps a wide array of tools categorized by function:

*   **Alignment:** `bwaMem`, `bowtie2`, `minimap2`, `star`, `gem`, `magicBlast`, `unimap`.
*   **Variant Calling:** `freebayes`, `bcftoolsCall`, `bcftoolsMpileup`, `samtoolsMpileup`.
*   **Annotation & Normalization:** `snpEff`, `vep`, `bcftoolsNorm`, `vtNormalize`.
*   **Utilities:** `bedtoolsIntersect`, `blastn`, `interleaveFastq`.

## Expert Tips and Best Practices

### Containerized Execution
To avoid manual installation of bioinformatics tools on every cluster node, use the `-use_docker` or `-use_singularity` flags. This ensures environment consistency across the Spark executors.

```bash
# Example using Singularity
cannoli-submit -- \
  bwaMem input.adam output.adam \
  -use_singularity \
  -image https://depot.galaxyproject.org/singularity/bwa:0.7.17--h5bf99c6_8
```

### Resource Distribution
When running alignments, the reference index must be available to all executors. Use the `-add_files` flag to instruct Spark to distribute the index files specified in your arguments to the working directory of every executor.

### Data Formats
While Cannoli can interleave FASTQ files, it performs best when using **ADAM (Parquet)** files. Converting your raw data to ADAM format before running Cannoli commands allows for better data partitioning and predicate pushdown, significantly improving Spark's execution efficiency.

### Memory Management
Bioinformatics tools often have high peak memory usage. When configuring `cannoli-submit`, ensure `--executor-memory` accounts for both the Spark overhead and the memory requirements of the underlying tool (e.g., the size of the genome index for BWA or STAR).

## Reference documentation
- [Cannoli GitHub Repository](./references/github_com_bigdatagenomics_cannoli.md)
- [Bioconda Cannoli Overview](./references/anaconda_org_channels_bioconda_packages_cannoli_overview.md)