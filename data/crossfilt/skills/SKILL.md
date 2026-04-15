---
name: crossfilt
description: CrossFilt mitigates alignment and annotation bias in comparative genomics by implementing a reciprocal mapping and filtering workflow. Use when user asks to split BAM files for processing, lift alignments between species using chain files, or filter for reciprocal reads to ensure unbiased orthologous sequence analysis.
homepage: https://github.com/kennethabarr/CrossFilt
metadata:
  docker_image: "quay.io/biocontainers/crossfilt:0.2.1--pyhdfd78af_0"
---

# crossfilt

## Overview

CrossFilt is a specialized bioinformatics suite designed to mitigate alignment and annotation bias in comparative genomics. In cross-species studies, reads from one species may map differently to another genome simply due to evolutionary distance rather than biological variation. CrossFilt solves this by implementing a reciprocal mapping workflow: it lifts alignments from a target species to a query species, allows for realignment, and then filters for "reciprocal" reads—those that return to their original coordinates and annotations when mapped back. This ensures that only high-confidence, unbiased orthologous sequences are used in downstream differential expression or accessibility analyses.

## Core Workflow

The standard CrossFilt pipeline involves three primary stages: splitting large datasets, lifting coordinates/sequences to the query genome, and filtering for reciprocal consistency.

### 1. Preparing and Splitting Data
Because lifting alignments is computationally intensive (~2-3 minutes per 1M reads), it is highly recommended to split large BAM files.
* **Requirement**: Input BAM files must be sorted and indexed (`samtools sort` and `samtools index`).
* **Command**: `crossfilt-split -i input.bam -o split_prefix -p -f 10`
* **Tip**: Use the `-p` flag for paired-end data to ensure mates stay in the same file. Splitting also reduces RAM usage because the tool only loads chain data for chromosomes present in the specific chunk.

### 2. Lifting Alignments (crossfilt-lift)
This tool converts genome coordinates and nucleotide sequences for orthologous segments.
* **Basic Usage**:
  ```bash
  crossfilt-lift -i sorted_input.bam -o output_prefix -c speciesA_to_speciesB.over.chain -t speciesA.fasta -q speciesB.fasta
  ```
* **Performance Tuning**:
  * **`--best`**: By default, the tool tries all chains if the best one fails. Use `--best` to only attempt the highest-scoring chain. This is ~10% faster with only a ~5% reduction in successful lifts.
  * **Memory**: Expect ~3GB RAM usage for standard human/primate chain files.

### 3. Filtering for Reciprocity (crossfilt-filter)
After lifting reads to the query species and realigning them (using tools like STAR or HISAT2), use this tool to identify reads that maintained their identity.
* **Logic**: It compares two BAM files and outputs reads from the first file that have identical contigs, positions, and CIGAR strings in the second.
* **Command**: `crossfilt-filter aligned_to_A.bam realigned_to_B_lifted_back.bam -t NH -t HI`
* **Tag Comparison**: 
  * Use `-t <TAG>` to ensure specific attributes (like gene IDs or hit indexes) match.
  * Use `-x` or `--xf` as a shortcut to compare the `XF` tag (commonly used by htseq-count).
  * Use `-@ <THREADS>` to speed up compression/decompression during the filtering process.

## Expert Tips and Best Practices

* **Paired-End Consistency**: Always use the `-p` or `--paired` flag in both `crossfilt-split` and `crossfilt-lift`. If one mate fails to lift or map reciprocally, the pair should generally be discarded to maintain library integrity.
* **Realignment Step**: CrossFilt does not perform the realignment itself. After `crossfilt-lift`, you must convert the resulting BAM back to FASTQ (e.g., `samtools fastq`), map it to the query genome using your preferred aligner, and then lift those results back to the original genome before running `crossfilt-filter`.
* **Memory Optimization**: If running on a high-core cluster, split the BAM into many small files. Since memory scales with the number of chromosomes in the file, splitting by chromosome or small chunks allows for high parallelism with low memory overhead per process.



## Subcommands

| Command | Description |
|---------|-------------|
| crossfilt-filter | Outputs reads from bam1 that that have identical contig, position, CIGAR string, and tag values (optional) in bam2 |
| crossfilt-lift | Converts genome coordinates and nucleotide sequence for othologous segments in a BAM file |
| crossfilt-split | Splits a bam file into equal sized chunks, keeping paired reads together. This may return fewer files than expected if many reads are missing a pair. |

## Reference documentation
- [CrossFilt README](./references/github_com_kennethabarr_CrossFilt_blob_main_README.md)
- [Project Configuration](./references/github_com_kennethabarr_CrossFilt_blob_main_pyproject.toml.md)