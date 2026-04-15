---
name: jvarkit-bamstats04
description: jvarkit-bamstats04 generates per-interval coverage statistics and summary metrics from BAM or CRAM files. Use when user asks to calculate median coverage per region, identify bases with zero coverage, or aggregate depth statistics across specific genomic intervals.
homepage: http://lindenb.github.io/jvarkit/BamStats04.html
metadata:
  docker_image: "quay.io/biocontainers/jvarkit-bamstats04:2025.07.28--hdfd78af_0"
---

# jvarkit-bamstats04

## Overview
jvarkit-bamstats04 is a specialized utility for generating per-interval coverage metrics. While tools like `samtools depth` provide raw per-base information, this tool aggregates data over defined regions to provide summary statistics such as median coverage and the number of bases with zero coverage. It is highly configurable, allowing for read filtering via JEXL expressions and data partitioning by sample, library, or platform.

## Usage Instructions

### Basic Command Structure
The tool is typically invoked via the bioconda wrapper or as a sub-command of the jvarkit jar:
```bash
jvarkit-bamstats04 -B regions.bed input.bam > coverage_stats.txt
```

### Key Parameters
- `-B, --bed`: **(Required)** The source of intervals. Supports BED, VCF, GTF, and GFF formats (including gzipped versions).
- `-o, --output`: Path to the output file (defaults to stdout).
- `-R, --ref`: Path to the indexed reference FASTA. Required for CRAM input and adds a GC% column to the output.
- `-cov, --cov`: Define a minimum coverage threshold. Any depth below this value is treated as zero. You can specify this multiple times to test different thresholds.
- `-partition, --partition`: Group statistics by `sample`, `library`, `platform`, etc. Useful when processing merged BAMs or multiple input files.

### Filtering Reads with JEXL
By default, the tool filters out reads with mapping quality < 1, duplicates, failing vendor quality checks, and secondary/supplementary alignments. You can override this using the `-f` or `--jexl` option:
- **Keep all reads:** `-f ""`
- **Filter by specific mapping quality:** `-f "record.getMappingQuality() < 30"`

### Common Workflow Patterns

**Processing Multiple Samples:**
The tool can accept multiple BAM files simultaneously. Use the `--partition sample` flag to keep statistics separate:
```bash
jvarkit-bamstats04 --partition sample -B targets.bed sample1.bam sample2.bam sample3.bam > multi_sample_stats.tsv
```

**Calculating GC-aware Coverage for CRAM:**
When working with CRAM files, the reference genome is mandatory:
```bash
jvarkit-bamstats04 -R human_g1k_v37.fasta -B exome_targets.bed input.cram > stats.tsv
```

## Expert Tips
- **Index Requirement:** All input BAM/CRAM files must be indexed (`.bai` or `.crai`).
- **Memory Management:** Since this is a Java-based tool, for very large BED files or high-depth regions, you may need to increase the JVM heap size if running the JAR directly (e.g., `java -Xmx4g -jar jvarkit.jar bamstats04 ...`).
- **Output Interpretation:** The `nocoveragebp` column is particularly useful for identifying "dead zones" in targeted panels where zero reads mapped.
- **Comparison with Samtools:** While the documentation notes that `samtools coverage` is a modern alternative, `jvarkit-bamstats04` remains superior for workflows requiring median coverage per BED interval and custom JEXL read filtering.

## Reference documentation
- [BamStats04 | jvarkit](./references/lindenb_github_io_jvarkit_BamStats04.html.md)
- [jvarkit-bamstats04 - bioconda](./references/anaconda_org_channels_bioconda_packages_jvarkit-bamstats04_overview.md)