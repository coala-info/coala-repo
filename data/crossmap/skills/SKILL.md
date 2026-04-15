---
name: crossmap
description: CrossMap translates genomic coordinates between different assembly versions for various high-throughput sequencing data formats. Use when user asks to liftover BED files, convert VCF variants between assemblies, update BAM or SAM alignments, or transform GFF, GTF, and BigWig files to a new reference genome.
homepage: https://crossmap.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0"
---

# crossmap

## Overview
CrossMap is a specialized utility designed to translate genomic coordinates from one assembly version to another. Unlike simple coordinate offsets, it utilizes alignment chain files to handle complex genomic rearrangements, insertions, and deletions between assembly versions. This skill enables the precise conversion of various high-throughput sequencing data formats while maintaining the integrity of the underlying biological information, such as updating reference alleles in VCFs or adjusting insert sizes in BAM files.

## Core CLI Patterns

The general syntax for CrossMap follows a sub-command structure:
`CrossMap <format> <chain_file> <input_file> [target_ref_fasta] [output_file]`

### 1. BED and Region Conversion
*   **Standard BED**: Use `bed` for typical genomic features.
    ```bash
    CrossMap bed hg19ToHg38.over.chain.gz input.hg19.bed output.hg38.bed
    ```
*   **Large Regions (CNVs)**: Use `region` for large genomic blocks to prevent the tool from splitting a single large region into multiple smaller ones if the alignment is fragmented.
    ```bash
    CrossMap region hg19ToHg38.over.chain.gz input.hg19.bed output.hg38.bed
    ```

### 2. VCF Liftover (Variants)
VCF conversion is sensitive because reference alleles must be updated to match the target assembly.
*   **Requirement**: You **must** provide the reference FASTA of the **target** assembly.
    ```bash
    CrossMap vcf hg19ToHg38.over.chain.gz input.hg19.vcf hg38.fa output.hg38.vcf
    ```
*   **Expert Tip**: Use the `--no-comp-alleles` flag if you want to skip the check that ensures the reference allele is different from the alternative allele.

### 3. Sequence Alignment (BAM/CRAM/SAM)
CrossMap updates coordinates, header sections, SAM flags, and insert sizes.
```bash
CrossMap bam hg19ToHg38.over.chain.gz input.hg19.bam output.hg38
```
*   **Note**: For BAM/CRAM, the output argument is typically a prefix.
*   **CRAM Support**: Requires `pysam >= 0.8.2`.

### 4. Annotation Files (GFF/GTF)
```bash
CrossMap gff hg19ToHg38.over.chain.gz input.hg19.gtf output.hg38.gtf
```

### 5. Transformation of Continuous Data (Wiggle/BigWig)
*   **Wiggle to BigWig**: CrossMap converts Wiggle/bedGraph input directly into BigWig output for the target assembly.
    ```bash
    CrossMap wig hg19ToHg38.over.chain.gz input.hg19.wig output.hg38
    ```
*   **BigWig to BigWig**:
    ```bash
    CrossMap bigwig hg19ToHg38.over.chain.gz input.hg19.bw output.hg38
    ```

## Expert Tips and Best Practices

*   **Chain File Sources**: 
    *   UCSC chain files often use the "chr" prefix (e.g., `chr1`).
    *   Ensembl chain files often use bare numbers (e.g., `1`).
    *   Ensure your input file's chromosome naming convention matches the source assembly in the chain file.
*   **Handling Unmapped Features**: CrossMap writes entries that failed to liftover to a file ending in `.unmap`. Always check this file to quantify data loss during conversion.
*   **Reference FASTA Indexing**: When performing VCF or BAM liftover, ensure the target reference FASTA is indexed (`samtools faidx`). CrossMap checks the timestamps of the FASTA and its index.
*   **Interpreting Chain Files**: If you are unsure about the contents of a chain file, use the `viewchain` command to convert the binary/complex format into a human-readable block-to-block format:
    ```bash
    CrossMap viewchain hg19ToHg38.over.chain.gz
    ```
*   **Memory Management**: For very large BAM files, ensure sufficient disk space for temporary files, as CrossMap may perform sorting operations during the update of SAM flags and coordinates.

## Reference documentation
- [CrossMap Documentation Index](./references/crossmap_sourceforge_net_index.md)
- [CrossMap SourceForge Index](./references/crossmap_sourceforge_net__sources_index.rst.txt.md)
- [Bioconda CrossMap Overview](./references/anaconda_org_channels_bioconda_packages_crossmap_overview.md)