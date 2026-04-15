---
name: bwameth
description: bwameth aligns bisulfite-treated DNA sequencing reads to a reference genome using in silico C-to-T conversion. Use when user asks to index a reference genome for bisulfite sequencing or align Bisulfite-Seq reads to produce SAM or BAM files.
homepage: https://github.com/brentp/bwa-meth
metadata:
  docker_image: "quay.io/biocontainers/bwameth:0.20--py35_0"
---

# bwameth

## Overview
bwameth is a specialized tool designed for the fast and accurate alignment of Bisulfite-Seq reads. It functions by performing an in silico C-to-T conversion of both the reference genome and the sequencing reads, allowing standard alignment algorithms like BWA-MEM to handle the reduced-alphabet complexity of bisulfite-treated DNA. This skill assists in executing the two primary phases of the workflow: building the converted index and performing the actual alignment to produce SAM/BAM files.

## Core Workflows

### 1. Indexing the Reference
Before alignment, the reference FASTA must be indexed. This process creates a C-to-T converted version of the genome and generates the necessary BWA index files.

```bash
# Default indexing using BWA-MEM
bwameth.py index reference.fasta

# Indexing using BWA-MEM2 (for improved performance on supported hardware)
bwameth.py index-mem2 reference.fasta
```

### 2. Aligning Reads
bwameth outputs SAM format to `stdout`. You must pipe the output to `samtools` to create a compressed BAM file.

**Paired-End Alignment:**
```bash
bwameth.py --threads 16 \
    --reference reference.fasta \
    read_R1.fastq.gz read_R2.fastq.gz | samtools view -bS - > aligned_reads.bam
```

**Single-End Alignment:**
```bash
bwameth.py --threads 8 \
    --reference reference.fasta \
    reads.fastq.gz | samtools view -bS - > aligned_reads.bam
```

## Expert Tips and Best Practices

### Performance Optimization
- **BWA-MEM2**: If your system supports AVX2 or AVX-512 instructions, use `index-mem2` and ensure `bwa-mem2` is in your PATH for significantly faster alignment.
- **Streaming**: bwameth streams converted reads directly to the aligner. Avoid manually decompressing FASTQ files; provide the `.gz` files directly to save disk I/O.
- **Threading**: Use the `--threads` flag to match your available CPU cores. Note that BWA-MEM is highly parallelizable.

### Downstream Compatibility
- **SAM to BAM**: Since 2016, bwameth does not create BAM files directly. Always pipe to `samtools view` and follow with `samtools sort` and `samtools index`.
- **Methylation Calling**: For extracting methylation metrics from the resulting BAM, the developer recommends using **MethylDackel** or **biscuit** rather than the legacy scripts included in the bwameth repository.
- **Tag Preservation**: bwameth stores the original read sequence in a tag (typically appended as a comment). This is critical for downstream tools to correctly tabulate methylation status.

### Troubleshooting
- **Index Mismatch**: If you receive an error regarding missing `.c2t` files, ensure you have run the `index` command on the exact FASTA file referenced in your alignment command.
- **Memory Usage**: For very large genomes, ensure your system has sufficient RAM for the BWA index, which is roughly 5-8x the size of the reference FASTA.

## Reference documentation
- [bwameth GitHub Repository](./references/github_com_brentp_bwa-meth.md)
- [Bioconda bwameth Package Overview](./references/anaconda_org_channels_bioconda_packages_bwameth_overview.md)