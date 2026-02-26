---
name: bed2gtf
description: "bed2gtf converts BED files into GTF annotations while preserving gene-level metadata and attribute fields. Use when user asks to convert BED to GTF, map genes to transcripts, or generate GTF files for downstream tools like STAR."
homepage: https://github.com/alejandrogzi/bed2gtf
---


# bed2gtf

## Overview

`bed2gtf` is a specialized Rust-based utility designed to bridge the gap between BED files and GTF annotations. While standard tools like UCSC's KentUtils often lose gene-level metadata or produce incomplete attribute fields during conversion, `bed2gtf` is optimized to generate fully functional GTF files compatible with downstream tools like STAR or arriba. It supports multi-threading, native GZIP compression, and gene-to-transcript mapping to ensure the resulting 9th column attributes are biologically accurate.

## Command Line Usage

### Basic Conversion (UCSC Style)
To perform a standard conversion without gene-level metadata (similar to `bedToGtf`), use the `--no-gene` flag.
```bash
bed2gtf -b input.bed -o output.gtf --no-gene
```

### Full Conversion with Gene Mapping
To include proper `gene_id` attributes, provide a tab-delimited isoforms file mapping genes to transcripts.
```bash
bed2gtf -b input.bed -i isoforms.txt -o output.gtf
```

### Working with Compressed Files
The tool natively handles `.gz` input and can produce compressed output to save disk space.
```bash
bed2gtf -b input.bed.gz -i isoforms.txt -o output.gtf.gz --gz
```

### Performance Optimization
For large genomic datasets, specify the number of threads to utilize parallel processing.
```bash
bed2gtf -b input.bed -i isoforms.txt -o output.gtf -t 8
```

## Expert Tips and Best Practices

- **Isoform File Format**: The isoforms file should be a simple tab-delimited file where the first column is the Gene ID and the second column is the Transcript ID. Ensure that every transcript name in your BED file exists in this mapping file to avoid errors.
- **Attribute Preservation**: Use this tool specifically when your downstream analysis requires a complete 9th column in the GTF. `bed2gtf` calculates start/stop codons and UTR positions based on the BED block coordinates.
- **Memory Efficiency**: Because it is written in Rust, `bed2gtf` is significantly more memory-efficient than Python or Perl-based conversion scripts, making it the preferred choice for high-throughput pipelines.
- **Input Validation**: Ensure your BED file contains the standard 12 fields if you require exon-level detail in the resulting GTF. Files with fewer than 12 fields may result in single-exon transcript entries.

## Reference documentation

- [bed2gtf GitHub Repository](./references/github_com_alejandrogzi_bed2gtf.md)
- [bed2gtf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bed2gtf_overview.md)