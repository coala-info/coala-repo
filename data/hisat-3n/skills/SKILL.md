---
name: hisat-3n
description: HISAT-3N (Hierarchical Indexing for Spliced Alignment of Transcripts - 3 Nucleotides) is an extension of the HISAT2 aligner tailored for base-conversion sequencing.
homepage: https://github.com/fulcrumgenomics/hisat-3n
---

# hisat-3n

## Overview
HISAT-3N (Hierarchical Indexing for Spliced Alignment of Transcripts - 3 Nucleotides) is an extension of the HISAT2 aligner tailored for base-conversion sequencing. It utilizes a specialized indexing strategy that accounts for the reduced complexity of converted genomes, allowing for high-speed and memory-efficient mapping of both RNA and DNA reads. It supports strand-specific and non-strand-specific data and can integrate SNP and splice-site information to improve alignment accuracy.

## Core Workflow

### 1. Index Generation
Use `hisat-3n-build` to create the reference index. This process generates two HISAT2 indexes.

*   **Standard Index**: Requires ~16GB RAM for the human genome.
*   **Repeat Index**: Optimized for reads mapping to thousands of positions; requires ~256GB RAM to build.

**Common Patterns:**
```bash
# Build standard index for Bisulfite-seq (C to T conversion)
hisat-3n-build --base-change C,T reference.fa genome_index

# Build index with splice sites and exons for RNA-seq
hisat-3n-build --base-change T,C --ss genome.ss --exon genome.exon reference.fa genome_index

# Build repeat index for high-frequency mapping
hisat-3n-build --base-change C,T --repeat-index reference.fa genome_index
```

### 2. Read Alignment
Use `hisat-3n` to align reads against the generated index. The `--base-change` argument must match the conversion type of your library.

**Common Patterns:**
```bash
# Align single-end SLAM-seq reads (T to C)
hisat-3n -x genome_index --base-change T,C -U reads.fastq -S aligned.sam

# Align paired-end Bisulfite-seq reads (C to T)
hisat-3n -x genome_index --base-change C,T -1 reads_R1.fastq -2 reads_R2.fastq -S aligned.sam
```

### 3. Table Generation
Use `hisat-3n-table` to produce a summary table of conversions. This requires SAMtools to sort the input SAM/BAM file first.

```bash
# Sort the alignment
samtools sort -o aligned.sorted.bam aligned.sam

# Generate the conversion table
hisat-3n-table -p 8 --base-change C,T --ref reference.fa --input aligned.sorted.bam --output conversion_stats.txt
```

## Expert Tips and Best Practices

*   **Index Compatibility**: A HISAT-3N index built for C-to-T conversion (e.g., BS-seq) can also be used to align T-to-C conversion reads (e.g., SLAM-seq). You do not need to rebuild the index for the reciprocal conversion.
*   **Memory Management**: While building a repeat index requires 256GB RAM, the actual alignment process using that index typically requires less than 16GB RAM.
*   **Directional Mapping**: For libraries where the conversion only occurs on a specific strand, use the `--directional-mapping` or `--directional-mapping-reverse` flags to reduce false positives and improve speed.
*   **Handling Multi-mappers**: If your research involves repetitive elements, prioritize the `--repeat-index` during the build phase; it is approximately 3x faster than the standard index for reads with thousands of potential hits.
*   **SNP Integration**: To increase accuracy in populations with known variants, provide a SNP file using the `--snp` flag during the build process.

## Reference documentation
- [HISAT-3N GitHub Repository](./references/github_com_fulcrumgenomics_hisat-3n.md)
- [HISAT-3N Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hisat-3n_overview.md)