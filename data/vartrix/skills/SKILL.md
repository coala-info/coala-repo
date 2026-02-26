---
name: vartrix
description: VarTrix quantifies the presence of predefined alleles at the single-cell level. Use when user asks to genotype single cells, quantify allele presence per cell, or generate a sparse matrix of variant counts for single-cell data.
homepage: https://github.com/10XGenomics/vartrix
---


# vartrix

## Overview

VarTrix is a high-performance genotyping tool designed to quantify the presence of specific alleles at the single-cell level. Rather than performing de novo variant calling, it takes a set of pre-defined variants and evaluates the supporting reads for each variant across all identified cell barcodes. This allows researchers to overlay mutational data onto expression-based or copy-number-based clusters, providing insights into the genetic architecture of complex cell populations.

## Command Line Usage

The basic syntax for running VarTrix requires four primary inputs and an output path:

```bash
vartrix \
  --vcf <input_variants.vcf> \
  --bam <cellranger_alignments.bam> \
  --fasta <reference_genome.fa> \
  --cell-barcodes <barcodes.tsv> \
  --out-matrix <output_matrix.mtx>
```

### Required Arguments

- `-v, --vcf`: The input VCF file containing the variants to be assigned.
- `-b, --bam`: The indexed BAM or CRAM file from Cell Ranger. It must contain the `CB` tag for cell barcodes.
- `-f, --fasta`: The indexed reference genome FASTA file used for the original alignment.
- `-c, --cell-barcodes`: A plain text file containing one cell barcode per line (typically the `barcodes.tsv` from Cell Ranger's filtered output).
- `-o, --out-matrix`: The destination path for the generated sparse matrix in Market Exchange format.

### High-Utility Options

- `--umi`: **Critical for scRNA-seq.** Use this flag to count unique molecules rather than raw reads to account for PCR duplication.
- `--out-variants`: Generates a text file containing the names of the variants (rows) in the format `chromosome_position`.
- `--mapq`: Sets a minimum mapping quality threshold (default is 0). Increasing this (e.g., to 30 or 40) helps reduce noise from multi-mapping reads.
- `--padding`: Defines the number of bases to pad around the variant for Smith-Waterman alignment.

## Best Practices and Expert Tips

- **Coordinate Consistency**: Ensure that the chromosome names in your VCF, BAM, and FASTA files match exactly (e.g., "chr1" vs "1"). VarTrix will fail or produce empty results if there is a mismatch.
- **Input VCF Quality**: Since VarTrix does not call variants, the quality of your output depends entirely on the input VCF. For scRNA-seq, it is highly recommended to use variants called from matched bulk WGS or WES data to minimize false positives caused by RNA-seq noise.
- **Barcode Selection**: Always use the "filtered" barcodes file from Cell Ranger (found in `outs/filtered_feature_bc_matrix/barcodes.tsv`) to ensure you are only genotyping high-quality cells and not empty droplets.
- **Multi-allelic Sites**: Note that VarTrix currently ignores multi-allelic sites. These will appear as empty rows in the output matrix to maintain the index ordering of the input VCF.
- **Memory Management**: For very large datasets, ensure your environment has sufficient RAM for the Smith-Waterman alignment process, especially if using a high `--padding` value.
- **Downstream Analysis**: The output `.mtx` file is compatible with standard single-cell analysis packages like Seurat or Scanpy. Use the `--out-variants` file to provide the row names for your data objects.

## Reference documentation
- [VarTrix GitHub Repository](./references/github_com_10XGenomics_vartrix.md)
- [VarTrix Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vartrix_overview.md)