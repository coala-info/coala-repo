---
name: regtools
description: RegTools integrates genomic variants with transcriptomic data to identify variants that cause non-canonical splicing and allele-specific expression. Use when user asks to identify cis-splice-effects, extract or annotate exon-exon junctions from BAM files, and analyze allele-specific expression.
homepage: https://github.com/griffithlab/regtools/
---


# regtools

## Overview

RegTools is a specialized suite designed to bridge the gap between genomic variants (DNA-seq) and transcriptomic outcomes (RNA-seq). It is primarily used in cancer genomics and rare disease research to identify "cis-splice-effects"—variants that cause non-canonical splicing—and allele-specific expression (ASE). The tool is highly efficient for processing large BAM files to extract exon-exon junctions and provides automated workflows to associate these junctions with specific mutations.

## Core Workflows and Commands

### 1. Identifying Splicing Effects (The Primary Use Case)
To identify variants that cause aberrant splicing, use the `cis-splice-effects` modules.

*   **From BAM files (Direct):**
    ```bash
    regtools cis-splice-effects identify [options] variants.vcf alignments.bam ref.fa annotations.gtf
    ```
*   **From BED files (Association):** Use this if you have already extracted junctions and want to save time on re-processing BAMs.
    ```bash
    regtools cis-splice-effects associate [options] variants.vcf junctions.bed ref.fa annotations.gtf
    ```

### 2. Junction Extraction and Annotation
If you only need to characterize the splicing landscape of an RNA-seq sample:

*   **Extract:** Pulls all exon-exon junctions from a BAM.
    ```bash
    regtools junctions extract -s [STRAND] -a [MIN_ANCHOR] alignments.bam -o junctions.bed
    ```
*   **Annotate:** Compares extracted junctions against a known transcriptome (GTF).
    ```bash
    regtools junctions annotate junctions.bed ref.fa annotations.gtf -o annotated_junctions.txt
    ```

### 3. Allele-Specific Expression (ASE)
To find polymorphisms showing unbalanced expression near somatic variants:
```bash
regtools cis-ase identify [options] somatic.vcf poly.vcf dna.bam rna.bam ref.fa annotations.gtf
```

## Expert Tips and Best Practices

*   **Strand Specificity (`-s`):** This is the most common source of error. Ensure you know your library preparation:
    *   `0`: Unstranded (Default)
    *   `1`: RF (first-strand / stranded-reverse)
    *   `2`: FR (second-strand / stranded-forward)
*   **Window Size (`-w`):** By default, the tool looks for junctions in a window between the previous and next exons. If you are looking for deep intronic mutations that might create cryptic splice sites, increase the window size (e.g., `-w 1000`).
*   **Anchor Length (`-a`):** The default anchor length is 8bp. For short-read data with low complexity, increasing this to 10 or 12 can reduce false-positive junction calls at the expense of sensitivity.
*   **Input Sorting:** Ensure your BAM files are coordinate-sorted and indexed (`samtools index`). VCF files should also be sorted by coordinate.
*   **GTF Compatibility:** Always ensure the chromosome naming convention in your GTF (e.g., "chr1" vs "1") matches your reference FASTA and BAM headers.

## Common CLI Patterns

**Filtering for Novel Junctions:**
After running `junctions annotate`, novel junctions are those where the `known_junction` column is `0`. You can quickly filter these using `awk`:
```bash
awk '$14 == 0' annotated_junctions.txt > novel_junctions.txt
```

**Annotating Variants for Splice-Site Proximity:**
If you just want to know which variants in a VCF fall within the splice region (default 2bp intronic, 3bp exonic):
```bash
regtools variants annotate variants.vcf -o annotated_variants.vcf
```



## Subcommands

| Command | Description |
|---------|-------------|
| cis-ase | Identify cis ase. |
| regtools junctions | Identify exon-exon junctions from alignments or annotate junctions. |
| variants | Annotate variants with splicing information. |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_griffithlab_regtools.md)
- [cis-splice-effects identify Command](./references/regtools_readthedocs_io_en_latest_commands_cis-splice-effects-identify.md)
- [junctions extract Command](./references/regtools_readthedocs_io_en_latest_commands_junctions-extract.md)
- [cis-ase identify Command](./references/regtools_readthedocs_io_en_latest_commands_cis-ase-identify.md)