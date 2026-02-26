---
name: svjedi
description: SVJedi genotypes known structural variations using long-read sequencing data. Use when user asks to genotype structural variations, determine variant zygosity, or analyze long-read alignments for deletions, insertions, inversions, and translocations.
homepage: https://github.com/llecompte/SVJedi
---


# svjedi

## Overview

SVJedi is a structural variation genotyper designed specifically for long-read data. It transforms a set of known SVs into a genotyped VCF by analyzing how long reads align to representative allele sequences. The tool is particularly useful for researchers who have already identified candidate SVs and wish to determine the zygosity (e.g., 0/1, 1/1) of those variants in a specific sample. It supports four major SV types: deletions (DEL), insertions (INS), inversions (INV), and translocations (BND).

## Core Workflows

### Standard Genotyping from Raw Reads
The most common usage involves providing the variant list, the reference genome, and the long-read file. SVJedi will internally handle the mapping using Minimap2.

```bash
python3 svjedi.py -v variants.vcf -r reference.fasta -i reads.fastq.gz -o genotyped_output.vcf
```

### Genotyping from Pre-aligned Reads (PAF)
If you have already performed alignments and have a PAF file, you can skip the internal mapping step to save time.

```bash
python3 svjedi.py -v variants.vcf -p alignments.paf -o genotyped_output.vcf
```

### Specifying Sequencing Technology
Adjust the genotyping model based on the error profile of your data using the `-d` or `--data` flag.
- For PacBio (default): `-d pb`
- For Oxford Nanopore: `-d ont`

## VCF Requirements and Formatting

SVJedi is strict about VCF formatting. Ensure your input VCF contains the following:

1.  **Matching Chromosomes**: Chromosome names in the VCF must match the FASTA headers exactly.
2.  **SVTYPE Tag**: Every record must have an `SVTYPE` tag in the INFO field.
3.  **Type-Specific Fields**:
    *   **DEL**: Requires `END` or `SVLEN`.
    *   **INS**: Requires the actual inserted sequence in the `ALT` field.
    *   **INV**: Requires the `END` tag for the second breakpoint.
    *   **BND**: Requires `CHR2` and `END` tags, with the `ALT` field formatted in standard VCF breakend notation (e.g., `]chr:pos]t`).

## Expert Tips and Best Practices

*   **Minimap2 Version**: The developers recommend using Minimap2 version 2.17-r941 for the most reliable results.
*   **Threading**: Use the `-t` parameter to specify the number of threads for the mapping step, which is the most computationally intensive part of the workflow.
*   **Support Thresholds**: If you have low coverage, consider adjusting `-ms` (minimum support). The default requires a minimum number of informative alignments to assign a genotype; increasing this can improve precision at the cost of recall.
*   **Sequence Context**: The `-ladj` parameter (default 5,000 bp) controls the length of the sequence adjacent to breakpoints used for representative alleles. For very large SVs or complex regions, adjusting this can impact mapping sensitivity.
*   **Soft-clipping**: Use `-dend` to control the allowed soft-clipping length for semi-global alignments. The default is 100 bp.

## Reference documentation
- [SVJedi GitHub Repository](./references/github_com_llecompte_SVJedi.md)
- [Bioconda SVJedi Overview](./references/anaconda_org_channels_bioconda_packages_svjedi_overview.md)