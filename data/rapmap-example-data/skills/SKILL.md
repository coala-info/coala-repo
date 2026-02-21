---
name: rapmap-example-data
description: RapMap is a high-performance tool designed for the rapid mapping of sequencing reads, primarily optimized for transcriptomes rather than large mammalian genomes.
homepage: https://github.com/COMBINE-lab/RapMap
---

# rapmap-example-data

## Overview

RapMap is a high-performance tool designed for the rapid mapping of sequencing reads, primarily optimized for transcriptomes rather than large mammalian genomes. It utilizes a "quasi-mapping" approach that provides high speed and sensitivity. This skill covers the two-phase workflow required by the tool: building a reference index and performing the actual mapping. It also includes guidance on using selective alignment for improved accuracy and managing large output files through BAM compression.

## Command Line Usage

### 1. Indexing the Reference
Before mapping, you must create an index from your reference transcriptome (e.g., `ref.fa`).

**Basic Indexing:**
```bash
rapmap quasiindex -t ref.fa -i ref_index
```

**Memory-Optimized Indexing:**
To reduce memory requirements during the mapping phase, use a minimum perfect hash.
```bash
rapmap quasiindex -t ref.fa -i ref_index -p -x 4
```
*   `-p`: Enables minimum perfect hash.
*   `-x [threads]`: Sets the number of threads used to build the hash.

### 2. Mapping Reads
Once the index is created, you can map paired-end or single-end reads.

**Standard Mapping (Paired-End):**
```bash
rapmap quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 -o mapped_reads.sam
```
*   `-i`: Path to the index created in step 1.
*   `-1`, `-2`: Paths to the first and second mate files.
*   `-s`: **Highly Recommended.** Enables selective alignment to validate hits and improve mapping quality.
*   `-t`: Number of threads.

### 3. Efficient Output Handling
SAM files are large and slow to write. It is best practice to pipe output directly to `samtools` for BAM compression.

**Streaming to BAM:**
```bash
rapmap quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 | samtools view -Sb -@ 4 - > mapped_reads.bam
```

**Using the Wrapper Script:**
RapMap includes a wrapper script `RunRapMap.sh` that simplifies the BAM conversion process.
```bash
RunRapMap.sh quasimap -i ref_index -1 r1.fq.gz -2 r2.fq.gz -s -t 8 --bamOut mapped_reads.bam --bamThreads 4
```

## Best Practices and Tips

*   **Selective Alignment:** Always use the `-s` flag during the `quasimap` step. This validates the alignment score of hits and significantly improves the accuracy of the results.
*   **Transcriptome Focus:** RapMap is specifically geared toward transcriptomes. While it can map to small genomes (viral or bacterial), it will consume excessive memory if applied to mammalian-sized genomes.
*   **Thread Allocation:** When piping to `samtools` or using `RunRapMap.sh`, ensure you balance threads between the mapper and the compressor to avoid bottlenecks.
*   **Index Persistence:** The index records whether it was built with a perfect hash (`-p`); you do not need to specify this again during the mapping phase.

## Reference documentation
- [RapMap GitHub Repository](./references/github_com_COMBINE-lab_RapMap.md)
- [Bioconda RapMap Package Overview](./references/anaconda_org_channels_bioconda_packages_rapmap_overview.md)