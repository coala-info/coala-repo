---
name: mudskipper
description: "Mudskipper projects genomic read alignments onto transcriptomic coordinates using a GTF annotation file. Use when user asks to convert genomic BAM files to transcriptomic alignments, project genomic reads to transcripts for quantification, or generate RAD files for single-cell RNA-seq workflows."
homepage: https://github.com/OceanGenomics/mudskipper
---


# mudskipper

## Overview
`mudskipper` is a specialized bioinformatics tool designed to project genomic read alignments onto transcriptomic coordinates. By utilizing a GTF annotation file, it identifies which transcripts a genomic alignment overlaps and generates corresponding transcriptomic alignment records. This allows researchers to perform transcript-level quantification without the computationally expensive step of re-mapping raw reads directly to the transcriptome.

## Core Workflows

### Bulk RNA-Seq Conversion
To convert a standard genomic BAM file to a transcriptomic BAM for tools like Salmon:
```bash
mudskipper bulk --gtf annotation.gtf --alignment genomic.bam --out transcriptomic.bam
```

### Single-Cell RNA-Seq Conversion
To convert single-cell genomic alignments to RAD format for use with alevin-fry:
```bash
mudskipper sc --gtf annotation.gtf --alignment genomic.sam --out transcriptomic_dir --rad
```

### Efficient Processing with Indexing
If processing multiple samples using the same annotation, first build a GTF index to avoid redundant parsing:
1. **Build the index**:
   ```bash
   mudskipper index --gtf annotation.gtf --dir-index gtf_index
   ```
2. **Run conversion using the index**:
   ```bash
   mudskipper bulk --index gtf_index --alignment genomic.bam --out transcriptomic.bam
   ```

## Command Line Options and Best Practices

### Key Parameters
- `--alignment (-a)`: Input SAM/BAM file containing genomic alignments.
- `--gtf (-g)`: Input GTF/GFF file for on-the-fly index building.
- `--index (-i)`: Path to a pre-built index directory (mutually exclusive with `--gtf`).
- `--out (-o)`: Output file path (BAM) or directory (RAD).
- `--threads (-t)`: Number of threads for BAM processing (default: 1).
- `--max-softclip (-s)`: Maximum allowed soft-clipped bases (default: 50). Alignments exceeding this are dropped.
- `--rad (-r)`: Output in RAD format instead of BAM (required for single-cell alevin-fry workflows).

### Expert Tips
- **Version Matching**: Always ensure the GTF file matches the exact reference genome version used during the initial genomic alignment. Discrepancies in chromosome names or coordinates will result in dropped alignments.
- **Soft-clip Filtering**: If your genomic aligner was permissive with soft-clipping, consider tightening the `--max-softclip` parameter to ensure only high-quality transcriptomic projections are retained.
- **Spliced Alignments**: `mudskipper` natively handles spliced genomic alignments (records with 'N' in the CIGAR string) by matching them against the exon structures defined in the GTF.
- **Limitations**: Note that `mudskipper` currently does not project alignments to intergenic or intronic regions, nor does it support "overhanging" alignments that extend beyond transcript boundaries.

## Reference documentation
- [mudskipper GitHub Repository](./references/github_com_OceanGenomics_mudskipper.md)
- [bioconda mudskipper Overview](./references/anaconda_org_channels_bioconda_packages_mudskipper_overview.md)