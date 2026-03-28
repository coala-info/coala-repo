---
name: paragraph
description: Paragraph is a graph-based structural variant genotyper that realigns short reads to local directed acyclic graphs to determine genotypes. Use when user asks to genotype structural variants using a graph-based approach, realign reads to variant graphs, or perform population-scale genotyping of deletions, insertions, and duplications.
homepage: https://github.com/Illumina/paragraph
---


# paragraph

## Overview
Paragraph is a graph-based structural variant genotyper developed by Illumina. Unlike traditional linear aligners that often struggle with complex genomic regions or large insertions, Paragraph constructs local directed acyclic graphs (DAGs) for each variant. It then realigns short reads to these graphs to determine the most likely genotype. This approach provides higher accuracy for SVs, especially in population-scale studies where consistent genotyping across many samples is required.

## Instructions

### 1. Prepare the Sample Manifest
Paragraph requires a tab-delimited manifest file describing the input samples.
*   **Required Columns**:
    *   `id`: Unique sample identifier.
    *   `path`: Full path to the BAM or CRAM file.
    *   `depth`: Average genomic depth (use `bin/idxdepth` for a fast estimate).
    *   `read length`: Average read length in base pairs.
*   **Optional Columns**:
    *   `sex`: "male"/"M" or "female"/"F" (affects sex chromosome genotyping).
    *   `depth sd`: Standard deviation of depth (defaults to `sqrt(5 * depth)`).

### 2. Standard Genotyping Workflow
Use the `multigrmpy.py` script to genotype a VCF against a set of samples. This is the standard entry point for most users.

```bash
python3 bin/multigrmpy.py \
    -i candidates.vcf \
    -m samples.txt \
    -r reference.fa \
    -o output_directory \
    -t 8 \
    -M 600
```

### 3. Expert Tips and Best Practices
*   **Filter High-Depth Regions**: Use the `-M` option to set the maximum allowed read count for a variant. A good rule of thumb is to set this to **20 times the mean sample depth**. This prevents the tool from stalling on low-complexity or repetitive regions with abnormal pileups.
*   **VCF Formatting**:
    *   **Deletions/Duplications/Inversions**: Ensure the `END` tag is present in the INFO field.
    *   **Insertions**: Paragraph looks for the insertion sequence in the INFO field. By default, it looks for the `SEQ` key. If using Manta output, specify `--ins-info-key SVINSSEQ`.
*   **Imprecise Breakpoints**: Paragraph can handle variants where the VCF breakpoint is slightly off, but accuracy decreases as the deviation increases.
*   **Population Genotyping**: For large cohorts, run Paragraph in single-sample mode (one manifest per sample) and merge the resulting VCFs using `bcftools merge`.

### 4. Troubleshooting Common Errors
*   **REF Allele Mismatch**: If you see `REF != END - POS + 1`, your VCF coordinates do not match the reference sequence length. Verify your VCF records.
*   **Padding Bases**: Ensure the padding base (the nucleotide at the `POS` position) is identical between the `REF` and `ALT` columns.
*   **BAM/Reference Mismatch**: Ensure the chromosome names in your BAM header exactly match those in the reference FASTA.



## Subcommands

| Command | Description |
|---------|-------------|
| Multigrmpy.py | A tool for graph-based genotyping of variants using a manifest of samples and a reference genome. |
| grmpy | Graph-based read mapping and genotyping for structural variants. |
| paragraph_idxdepth | Estimate coverage depth from BAM/CRAM files using index information. |

## Reference documentation
- [Paragraph README](./references/github_com_Illumina_paragraph.md)
- [Common Usage Questions](./references/github_com_Illumina_paragraph_wiki_Common-usage-question.md)
- [Frequently Asked Errors](./references/github_com_Illumina_paragraph_wiki_Frequently-asked-errors.md)