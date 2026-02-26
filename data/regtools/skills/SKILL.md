---
name: regtools
description: RegTools is a suite of tools designed to integrate DNA-seq and RNA-seq data to identify genomic variants that influence RNA splicing patterns. Use when user asks to extract exon-exon junctions from RNA-seq alignments, identify cis-splice effects of variants, or annotate junctions and variants with respect to a reference transcriptome.
homepage: https://github.com/griffithlab/regtools/
---


# regtools

## Overview
RegTools is a specialized suite of tools designed to bridge the gap between DNA-seq and RNA-seq data. It allows researchers to identify how specific genomic variants influence splicing patterns, such as exon skipping, intron retention, or the creation of cryptic splice sites. By extracting exon-exon junctions directly from RNA-seq alignments and cross-referencing them with variant calls and reference transcriptomes, RegTools provides a streamlined workflow for discovering regulatory mutations that might otherwise be overlooked in standard pipelines.

## Common CLI Patterns

### 1. Extracting Junctions from RNA-seq
The first step in most workflows is extracting exon-exon junctions from a BAM file.
```bash
regtools junctions extract -a 8 -m 50 -M 500000 -s 1 input.bam -o junctions.bed
```
*   `-a`: Minimum anchor length (number of bases that must overlap an exon).
*   `-m`: Minimum intron length.
*   `-M`: Maximum intron length.
*   `-s`: Strand specificity (0 for unstranded, 1 for RF/fr-firststrand, 2 for FR/fr-secondstrand).

### 2. Identifying Cis-Splice Effects
This is the primary command for integrating variants and RNA-seq data to find mutations associated with splicing changes.
```bash
regtools cis-splice-effects identify \
    -s 1 \
    -e 10 \
    -i 10 \
    variants.vcf.gz \
    alignments.bam \
    ref_genome.fa \
    annotations.gtf
```
*   **Inputs**: Requires a BGZIP-compressed and indexed VCF, a coordinate-sorted and indexed BAM, a FASTA genome, and a GTF annotation file.
*   **Logic**: It looks for junctions in the BAM file that are within a specific window (defined by `-e` and `-i`) of the variants in the VCF.

### 3. Annotating Junctions
To determine if junctions are known or novel compared to a reference:
```bash
regtools junctions annotate junctions.bed ref_genome.fa annotations.gtf -o annotated_junctions.txt
```

### 4. Annotating Variants
To specifically annotate variants with their proximity to splice regions:
```bash
regtools variants annotate variants.vcf -g annotations.gtf -r 20 -o annotated_variants.vcf
```
*   `-r`: Defines the "splice region" distance from the exon-intron boundary.

## Expert Tips and Best Practices

*   **Strand Awareness**: Incorrectly specifying the `-s` (strand) parameter is the most common cause of empty or misleading results. Verify your library preparation (e.g., dUTP/fr-firststrand usually requires `-s 1`).
*   **Indexing Requirements**: Ensure all large genomic files are indexed. Use `samtools index` for BAMs, `tabix` for VCFs, and `samtools faidx` for FASTA files.
*   **Anchor Length**: For short-read data (e.g., 50-75bp), a smaller anchor length (e.g., 6) may increase sensitivity but also noise. For 100bp+ reads, an anchor of 8-10 is standard.
*   **Filtering**: The output of `cis-splice-effects identify` can be large. Focus on the `variant_info` and `junction_info` columns to prioritize junctions that have high read support (`score` column) and are not present in the "known" annotation.
*   **Memory Management**: RegTools is generally efficient, but processing very high-depth BAM files or large VCFs may require significant RAM. Ensure your environment has at least 8GB-16GB for standard human samples.

## Reference documentation
- [RegTools GitHub Repository](./references/github_com_griffithlab_regtools.md)
- [Bioconda RegTools Overview](./references/anaconda_org_channels_bioconda_packages_regtools_overview.md)