---
name: get_mnv
description: The `get_mnv` tool is designed to improve the accuracy of genomic variant annotation by detecting MNVs—instances where two or more SNVs fall within the same codon.
homepage: https://github.com/PathoGenOmics-Lab/get_mnv
---

# get_mnv

## Overview

The `get_mnv` tool is designed to improve the accuracy of genomic variant annotation by detecting MNVs—instances where two or more SNVs fall within the same codon. Standard annotation pipelines often process variants individually, which can lead to incorrect amino acid predictions if the combined effect of multiple changes is ignored. This tool reclassifies these clusters and computes the true resulting protein-level change. It is particularly effective when paired with BAM files to verify that the variants exist on the same physical reads.

## Command Line Usage

The basic syntax requires a VCF of variants, a reference FASTA, and a specific gene definition file.

### Basic Execution
```bash
get_mnv --vcf variants.vcf --fasta reference.fasta --genes genes.txt
```

### Enhanced Analysis with Read Support
Providing a BAM file allows the tool to calculate the number of reads supporting the MNV versus individual SNPs, providing higher confidence in the variant call.
```bash
get_mnv -v variants.vcf -b aligned_reads.bam -f reference.fasta -g genes.txt
```

### Filtering by Quality
Use the `-q` or `--quality` flag to set a minimum Phred quality threshold for reads (default is 20).
```bash
get_mnv -v variants.vcf -b aligned_reads.bam -f reference.fasta -g genes.txt -q 30
```

## Input Requirements

### Gene File Format
The `--genes` file must be a tab-delimited text file with four columns. Ensure there are no headers.
*   **Format**: `GeneName` [tab] `Start` [tab] `End` [tab] `Strand`
*   **Example**:
    ```text
    Rv0007_Rv0007    9914    10828    +
    Rv0010c_Rv0010c  13133   13558    -
    ```

### Reference FASTA
The FASTA file must match the reference used to generate the VCF and BAM files.

## Expert Tips and Best Practices

*   **Verify Co-occurrence**: Always provide a BAM file when possible. Without it, the tool identifies potential MNVs based on genomic position, but cannot confirm if the mutations occur on the same haplotype/read.
*   **Handle SNVs Only**: Remember that `get_mnv` is strictly for SNVs. If your VCF contains insertions or deletions (indels) that shift the reading frame, they will be ignored or may cause unexpected behavior in the surrounding codons.
*   **Output Interpretation**: The tool generates a TSV file named `<vcf_filename>.MNV.tsv`. Pay close attention to the `Variant Type` column, which distinguishes between standard `SNP` and reclassified `MNV`.
*   **Strand Awareness**: Ensure the strand (+/-) in your genes file is accurate, as this dictates how the tool reconstructs the codon sequence from the reference FASTA.

## Reference documentation
- [get_MNV GitHub Repository](./references/github_com_PathoGenOmics-Lab_get_mnv.md)
- [get_MNV Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_get_mnv_overview.md)