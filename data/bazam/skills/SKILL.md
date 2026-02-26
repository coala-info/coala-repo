---
name: bazam
description: "Bazam extracts paired reads from coordinate-sorted BAM files and streams them into interleaved FASTQ format for efficient re-alignment. Use when user asks to extract read pairs from a BAM file, pipe reads directly into an aligner like BWA, or filter reads by genomic region or custom criteria."
homepage: https://github.com/ssadedin/bazam
---


# bazam

## Overview
Bazam is a specialized tool designed to efficiently extract paired reads from coordinate-sorted BAM files—a task that is traditionally difficult because mate pairs are often stored far apart in the file. Instead of performing slow random lookups or requiring massive memory to buffer the entire file, bazam uses an optimized buffering strategy to pair reads as it streams through the file. It is primarily used for "re-alignment" pipelines where reads from an existing BAM need to be mapped to a new reference genome.

## Installation and Setup
Bazam can be run as a standalone JAR file or installed via package managers:
- **Conda**: `conda install -c bioconda bazam`
- **Executable**: Download `bazam.jar` from GitHub releases and run via `java -jar bazam.jar`.

## Common CLI Patterns

### Basic FASTQ Extraction
Extract all read pairs into an interleaved FASTQ format:
```bash
java -jar bazam.jar -bam input.bam > output.fastq
```

### Direct Realignment Stream (BWA)
The most efficient way to use bazam is by piping its output directly into an aligner. This avoids the disk I/O overhead of intermediate FASTQ files:
```bash
java -jar bazam.jar -bam original.bam | \
bwa mem -p reference.fa - | \
samtools view -bSu - | \
samtools sort -o realigned.bam
```
*Note: The `-p` flag in BWA tells it to expect interleaved paired-end input.*

### Extracting Specific Regions
Use the `-L` flag to target a specific genomic region. Bazam will emit the full pair if either read overlaps the region:
```bash
java -jar bazam.jar -bam input.bam -L chr1:1000000-2000000 > region.fastq
```

### Custom Groovy Filtering
Bazam allows complex filtering using Groovy expressions via the `-f` flag. The variable `pair` provides access to `r1` and `r2` (Picard SAMRecord objects).

**Example: Extract only chimeric reads (mates on different chromosomes):**
```bash
java -jar bazam.jar -bam input.bam -f "pair.r1.referenceIndex != pair.r2.referenceIndex" > chimeric.fastq
```

### Parallelization via Sharding
For very large genomes, you can shard the processing to reduce memory requirements or increase speed through parallel instances. Use `-s n,N` where `n` is the shard number and `N` is the total shards:
```bash
# Process the 1st of 4 shards
java -jar bazam.jar -bam input.bam -s 1,4 > shard1.fastq
```

## Expert Tips and Best Practices

### Memory Management
Bazam buffers reads in memory to find their mates. For whole-genome sequencing (WGS) data, you may need to increase the JVM heap size:
```bash
java -Xmx16g -jar bazam.jar -bam input.bam ...
```

### Working with CRAM Files
Since CRAM is reference-based, you must provide the reference fasta to the HTSJDK library used by bazam:
```bash
java -Dsamjdk.reference_fasta=ref.fa -jar bazam.jar -bam input.cram > output.fastq
```

### Tracking Original Positions
If you need to know where the reads originally mapped after they have been realigned, use the `-namepos` flag. This appends the original coordinates to the read name in the FASTQ output.

### Performance Tuning
If bazam is running slower than your aligner, consider sharding the input. If the aligner is the bottleneck, bazam's efficient buffering ensures it won't add significant overhead to the pipeline.

## Reference documentation
- [Bazam GitHub Repository](./references/github_com_ssadedin_bazam.md)
- [Bioconda Bazam Overview](./references/anaconda_org_channels_bioconda_packages_bazam_overview.md)