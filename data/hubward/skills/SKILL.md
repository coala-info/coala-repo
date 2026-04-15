---
name: hubward
description: hubward maps DNA sequences against large reference genomes using the Burrow-Wheeler Aligner ecosystem. Use when user asks to index a reference genome, align single-end or paired-end reads, or map long-read sequencing data from PacBio or Nanopore.
homepage: https://github.com/lh3/bwa
metadata:
  docker_image: "quay.io/biocontainers/hubward:0.2.2--py27_1"
---

# hubward

## Overview
The hubward skill provides access to the Burrow-Wheeler Aligner (BWA) ecosystem, a specialized toolset for mapping DNA sequences against large reference genomes. It features three primary algorithms tailored to different read lengths and error profiles: BWA-MEM (the industry standard for reads >70bp), BWA-backtrack (optimized for short Illumina reads <100bp), and BWA-SW. This skill facilitates the entire alignment pipeline, from reference indexing to complex chimeric alignment and local mapping.

## Common CLI Patterns

### 1. Reference Indexing
Before any alignment, the reference genome must be indexed. This is a one-time operation per reference.
```bash
bwa index ref.fa
```

### 2. BWA-MEM (Recommended for >70bp)
BWA-MEM is the most robust algorithm for modern sequencing data, including high-quality Illumina reads and noisy long reads.

**Single-end reads:**
```bash
bwa mem ref.fa reads.fq > aln.sam
```

**Paired-end reads:**
```bash
bwa mem ref.fa read1.fq read2.fq > aln-pe.sam
```

**Smart pairing (interleaved):**
```bash
bwa mem -p ref.fa interleaved_reads.fq > aln.sam
```

### 3. BWA-backtrack (Short reads <70bp)
For very short reads, use the `aln` command to generate `.sai` intermediate files before converting to SAM.

**Paired-end workflow:**
```bash
bwa aln ref.fa read1.fq > read1.sai
bwa aln ref.fa read2.fq > read2.sai
bwa sampe ref.fa read1.sai read2.sai read1.fq read2.fq > aln-pe.sam
```

### 4. Long-Read Alignment (PacBio/Nanopore)
BWA-MEM includes specific presets for third-generation sequencing data.

**PacBio subreads:**
```bash
bwa mem -x pacbio ref.fa reads.fq > aln.sam
```

**Oxford Nanopore reads:**
```bash
bwa mem -x ont2d ref.fa reads.fq > aln.sam
```

## Expert Tips and Best Practices

- **Algorithm Selection**: Always prefer **BWA-MEM** for query sequences longer than 70bp. It is faster, more accurate, and supports chimeric alignments (split reads) by default.
- **Performance Tuning**: Use the `-t` flag to specify the number of threads for multi-core processing.
  ```bash
  bwa mem -t 8 ref.fa read1.fq read2.fq > aln.sam
  ```
- **Marking Split Hits**: When using BWA-MEM for downstream tools like GATK, use the `-M` flag to mark shorter split hits as secondary for compatibility.
  ```bash
  bwa mem -M ref.fa read1.fq read2.fq > aln.sam
  ```
- **Memory Management**: BWA uses significant RAM for the FM-index. For the human genome, expect to use ~3.5 GB of memory.
- **Piping to Samtools**: To save disk space and time, pipe the SAM output directly to `samtools` for BAM conversion.
  ```bash
  bwa mem ref.fa r1.fq r2.fq | samtools view -Sb - > aln.bam
  ```
- **ALT Contigs**: If working with GRCh38, use `bwakit` or ensure your reference includes `.alt` files to handle HLA and other highly polymorphic regions correctly.



## Subcommands

| Command | Description |
|---------|-------------|
| hubward liftover | Lift over coordinates from one assembly to another, in bulk. For all configured tracks in <dirname>/metadata.yaml, if the configured track genome matches <from_assembly> then perform the liftover to a temporary directory and then move the result to <newdir> when complete. |
| hubward process | Process one or many studies. Items can be directories containing metadata.yaml/metadata-builder.py or a group configuration YAML file. |
| hubward skeleton | Populate <dirname> with template files that can be customized on a per-study basis. The skeleton is actually a working example. |
| hubward upload | Creates a track hub and uploads to configured host. Track hub files include hub.txt, genomes.txt, and trackDb.txt files. If --hub-only has been specified, only these files will be uploaded to the host configured in the group config file. Otherwise, these files and all of the configured data files (bigBed, bigWig, BAM, and VCF files) from individual studies are uploaded via rsync to their respective configured locations on the remote host. |

## Reference documentation
- [BWA Main Documentation](./references/github_com_lh3_bwa.md)
- [BWA Kit and Post-processing](./references/github_com_lh3_bwa_tree_master_bwakit.md)