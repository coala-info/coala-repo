---
name: dirseq
description: dirseq evaluates the directional consistency of RNA-seq mappings against genomic features to validate strand-specific library preparations. Use when user asks to check read directionality, perform gene-level quantification, or calculate coverage for specific GFF feature types.
homepage: https://github.com/wwood/dirseq
---


# dirseq

## Overview
dirseq is a specialized bioinformatics tool used to evaluate the directional consistency of RNA-seq mappings against genomic features. By comparing BAM alignment files with GFF3 annotations, it determines whether reads are generally in the same direction as predicted genes. This is essential for validating strand-specific library preparations and generating gene-level quantification metrics.

## Installation and Dependencies
The tool requires Ruby, samtools, and bedtools (version 2.24.0 or higher). It is most easily installed via Conda:
```bash
conda install -c bioconda dirseq
```

## Common CLI Patterns

### Basic Directionality Check
To calculate the default coverage and check directionality for CDS features:
```bash
dirseq --bam mapping.bam --gff annotation.gff
```

### Gene-wise Read Counting
To output raw read counts instead of coverage depth:
```bash
dirseq --bam mapping.bam --gff annotation.gff --measure-type count
```

### Handling Non-Standard GFF Features
By default, dirseq looks for `CDS` features. To target other feature types (e.g., 'gene' or 'exon'):
```bash
dirseq --bam mapping.bam --gff annotation.gff --accepted-feature-types gene
```

### Customizing Output Metadata
To include specific attributes from the GFF "attributes" column (column 9) in the output:
```bash
dirseq --bam mapping.bam --gff annotation.gff --comment-fields ID,Name,locus_tag
```

### Processing EnrichM or Prokka Outputs
When working with EnrichM-generated GFF files, use specific comment fields to ensure correct identification:
```bash
dirseq --bam mapping.bam --gff enrichm_output.gff --measure-type count --comment-fields seq_id,annotations
```

## Expert Tips and Best Practices

- **Strand-Specific Validation**: If you expect your library to be strand-specific but see low agreement, run the tool with `--ignore-directions` to compare total coverage against directional coverage. This helps distinguish between low mapping quality and incorrect strand assumptions.
- **SAM Flag Filtering**: The default filter is `-F0x100 -F0x800` (excluding secondary and supplementary alignments). If you need to include these or filter specifically for proper pairs, modify the `--sam-filter-flags`.
- **Forward Read Only**: For certain library types where only the first read (R1) defines the strand, use the `--forward-read-only` flag to avoid noise from R2.
- **Bedtools Version**: Ensure `bedtools` is version 2.24.0 or later. Older versions use different command-line arguments for coverage calculation that are incompatible with dirseq.
- **Performance**: For large BAM files, ensure the BAM is sorted and indexed (`samtools index`) before running dirseq to improve processing speed.

## Reference documentation
- [github_com_wwood_dirseq.md](./references/github_com_wwood_dirseq.md)
- [anaconda_org_channels_bioconda_packages_dirseq_overview.md](./references/anaconda_org_channels_bioconda_packages_dirseq_overview.md)