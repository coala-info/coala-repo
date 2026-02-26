---
name: ucsc-bedtopsl
description: The ucsc-bedtopsl utility converts BED records into PSL alignment records while preserving block structures. Use when user asks to convert genomic features to alignments, transform BED files to PSL format, or represent gene models as perfect alignments for the UCSC Genome Browser.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-bedtopsl

## Overview

The `ucsc-bedtopsl` utility (commonly invoked as `bedToPsl`) is a specialized tool from the UCSC Genome Browser "Kent" suite. It transforms BED records into PSL records, which are typically used to describe sequence alignments. 

This conversion is particularly useful in bioinformatics workflows where you need to represent genomic features (like gene models or peak calls) as "perfect alignments" against a reference genome. This allows these features to be used with tools that calculate alignment statistics or with Genome Browser track types that require PSL input to display features with directionality and block structures.

## Usage Patterns

### Basic Conversion
The tool requires a `chrom.sizes` file to correctly populate the sequence length fields in the PSL output.

```bash
bedToPsl chrom.sizes input.bed output.psl
```

### Generating the Required chrom.sizes File
If you do not have a `chrom.sizes` file for your assembly, you can generate one using `fetchChromSizes` (another UCSC utility) or from a FASTA index:

```bash
# Using samtools on a reference fasta
samtools faidx reference.fa
cut -f1,2 reference.fa.fai > chrom.sizes
```

### Common Pipeline Integration
It is a best practice to ensure your BED file is properly sorted before conversion to maintain consistency in downstream PSL-based indices.

```bash
bedSort input.bed sorted.bed
bedToPsl hg38.chrom.sizes sorted.bed output.psl
```

## Expert Tips

*   **Alignment Interpretation**: The resulting PSL file represents a "perfect" alignment. The match count will equal the total length of the BED blocks, and there will be no mismatches, Ns, or rep-matches.
*   **Block Structure**: `bedToPsl` preserves the block structure (exons/introns) defined in BED12 files. If your BED file only has 3 columns (chrom, start, end), the PSL will represent a single-block alignment.
*   **Validation**: Use `pslCheck` after conversion if you intend to upload the file as a track to the UCSC Genome Browser to ensure the resulting PSL is well-formed.
*   **Coordinate Systems**: Remember that BED is 0-indexed, half-open, while PSL also uses 0-indexing for coordinates. The tool handles this conversion automatically.

## Reference documentation

- [ucsc-bedtopsl Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedtopsl_overview.md)
- [UCSC Binary Utilities Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)