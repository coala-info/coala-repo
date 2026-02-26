---
name: gxf2bed
description: "gxf2bed is a high-speed utility that converts GTF or GFF gene annotation files into BED format. Use when user asks to convert GTF to BED, transform GFF3 files to BED12, or extract specific genomic features and attributes into a BED file."
homepage: https://github.com/alejandrogzi/gxf2bed
---


# gxf2bed

## Overview

gxf2bed is a high-speed utility written in Rust designed to bridge the gap between complex gene annotation formats (GTF/GFF) and the simpler Browser Extensible Data (BED) format. It is particularly effective for large-scale genomic workflows where processing speed and memory efficiency are critical. The tool supports multi-threaded processing and can handle various BED output types, ranging from simple coordinate sets (BED3) to complex linked structures (BED12).

## Command Line Usage

The basic syntax for gxf2bed requires an input file and an output path:

```bash
gxf2bed -i input.gtf -o output.bed
```

### Core Arguments

- `-i, --input <GXF>`: Path to the source GTF or GFF file.
- `-o, --output <BED>`: Path for the resulting BED file.
- `-t, --type <BED_TYPE>`: Specifies the BED format (3, 4, 5, 6, 9, 12). Default is **12**.
- `-T, --threads <THREADS>`: Number of threads to use. Defaults to the system CPU count.

### Advanced Feature Mapping

gxf2bed allows for granular control over which features are extracted and how attributes are mapped to the BED name field.

- **Custom Parent/Child Features**: By default, the tool looks for standard gene/transcript/exon relationships. You can override these:
  ```bash
  gxf2bed -i input.gff3 -o output.bed -F mRNA -f exon
  ```
- **Attribute Extraction**: Use `-A` to define which attribute from the GTF/GFF should be used as the name in the BED file (e.g., `gene_id`, `transcript_id`, or `gene_name`).
  ```bash
  gxf2bed -i input.gtf -o output.bed -A gene_name
  ```
- **Additional Fields**: To append specific attributes to the end of the BED record, use the `-d` flag:
  ```bash
  gxf2bed -i input.gtf -o output.bed -d "gene_biotype,source"
  ```

## Expert Tips and Best Practices

1.  **Compression Support**: The tool natively handles compressed files. You do not need to decompress `.gz`, `.zst`, or `.bz2` files before processing, which saves disk space and I/O time.
2.  **Memory Mapping**: For uncompressed files, gxf2bed utilizes memory-mapped I/O. This provides a significant speed boost but requires sufficient virtual memory address space.
3.  **Parallelization Tuning**: While the tool defaults to all available CPUs, you can tune performance using the `-c` (chunk size) parameter. The default is 15,000 records per chunk. For extremely dense files, increasing this may improve thread efficiency.
4.  **BED12 for Spliced Alignments**: When converting transcript annotations, always prefer BED12 (`-t 12`). This format correctly represents exon blocks and introns, which is essential for tools like `bedtools intersect` or genome browsers.
5.  **GFF3 vs. GTF**: GFF3 files often take longer to process than GTF files due to the hierarchical nature of the format. If speed is the absolute priority and you have a choice, GTF is generally faster to parse.

## Reference documentation
- [gxf2bed GitHub Repository](./references/github_com_alejandrogzi_gxf2bed.md)
- [Bioconda gxf2bed Package](./references/anaconda_org_channels_bioconda_packages_gxf2bed_overview.md)