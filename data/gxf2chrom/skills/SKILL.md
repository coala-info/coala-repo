---
name: gxf2chrom
description: gxf2chrom is a high-performance utility that transforms GTF or GFF genomic annotation files into a simplified, tab-delimited .chrom format. Use when user asks to convert GTF or GFF files to .chrom format, extract specific genomic features like transcript IDs, or process large-scale annotation datasets quickly.
homepage: https://github.com/alejandrogzi/gxf2chrom
metadata:
  docker_image: "quay.io/biocontainers/gxf2chrom:0.1.0--h9948957_1"
---

# gxf2chrom

## Overview

gxf2chrom is a high-performance Rust-based utility designed to transform standard genomic annotation formats (GTF/GFF) into a simplified, tab-delimited .chrom format. It is optimized for speed and can process large-scale datasets, such as human or mouse GENCODE annotations, in seconds. The tool is a modern, faster alternative to legacy Python scripts used for coordinate extraction, supporting both uncompressed and gzipped input files.

## Command Line Usage

The basic syntax for gxf2chrom requires an input file and a designated output path.

### Basic Conversion
To convert a standard GTF or GFF file:
```bash
gxf2chrom --input input.gtf --output output.chrom
```

### Working with Compressed Files
The tool natively handles gzipped files without requiring prior decompression:
```bash
gxf2chrom -i genes.gff3.gz -o genes.chrom
```

### Customizing Feature Extraction
By default, the tool extracts the `protein_id`. You can specify different attributes (e.g., `transcript_id`, `gene_id`) using the `--feature` flag:
```bash
gxf2chrom -i input.gtf -o output.chrom --feature transcript_id
```

### Performance Tuning
gxf2chrom uses all available CPU cores by default. In shared computing environments or HPC clusters, limit the thread count to be a "good citizen":
```bash
gxf2chrom -i input.gtf -o output.chrom -t 4
```

## Expert Tips and Best Practices

- **Input Versatility**: You do not need to specify whether the input is GTF or GFF; the tool detects the format automatically.
- **Output Format**: The resulting .chrom file follows a specific structure: `[Feature_ID] [Chromosome] [Strand] [Start] [End]`. Ensure your downstream tools expect this 5-column format.
- **Attribute Matching**: When using the `-f` or `--feature` flag, ensure the attribute exists in the 9th column of your input file. If the specified feature is missing for a record, that record may be skipped or result in empty identifiers.
- **Speed Advantage**: Use this tool instead of custom AWK or Python scripts when processing full-genome annotations (like GENCODE or Ensembl) to reduce processing time from minutes to seconds.

## Reference documentation
- [gxf2chrom GitHub Repository](./references/github_com_alejandrogzi_gxf2chrom.md)
- [gxf2chrom Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gxf2chrom_overview.md)