---
name: jvarkit-bam2svg
description: `jvarkit-bam2svg` is a specialized utility for rendering sequence alignment data into Scalable Vector Graphics (SVG) format.
homepage: http://lindenb.github.io/jvarkit/BamToSVG.html
---

# jvarkit-bam2svg

## Overview

`jvarkit-bam2svg` is a specialized utility for rendering sequence alignment data into Scalable Vector Graphics (SVG) format. While genome browsers provide interactive exploration, this tool is designed to produce static, high-fidelity vector representations of specific genomic regions. It excels at visualizing read-level details—such as soft-clipping, base mismatches, and mapping quality—alongside genomic features (GFF3) and variants (VCF). It is particularly useful for documenting evidence for specific variants or creating figures for biological publications.

## Core Usage Patterns

### Basic Alignment Visualization
To generate a basic visualization of a specific region, you must provide the reference genome, the target interval, and the input BAM file.

```bash
java -jar dist/jvarkit.jar bam2svg \
  -R reference.fasta \
  -i "chr1:1000-1200" \
  -o output.zip \
  input.bam
```

### Visualizing Variants and Annotations
You can overlay genomic context by including VCF files for variants and GFF3 files for gene models or other features.

```bash
java -jar dist/jvarkit.jar bam2svg \
  -R reference.fasta \
  -i "chr1:1000-1100" \
  -S variants.vcf.gz \
  --gff annotations.gff3.gz \
  -o output.zip \
  input.bam
```

### Grouping and Partitioning
If the BAM file contains multiple samples or libraries, use the `--groupby` option to partition the visualization.

*   **By Sample:** `--groupby sample`
*   **By Library:** `--groupby library`
*   **By Read Group:** `--groupby readgroup`

### Detailed Read Inspection
To see individual bases and soft-clipped sequences (useful for identifying structural variant breakpoints or alignment artifacts):

```bash
java -jar dist/jvarkit.jar bam2svg \
  -R reference.fasta \
  -i "chr1:5000-5100" \
  --bases \
  --showclipping \
  -o output.zip \
  input.bam
```

## Expert Tips and Best Practices

*   **Input Requirements:** All input files (BAM, CRAM, FASTA, VCF, GFF3) must be indexed. FASTA files require both a `.fai` index (samtools) and a `.dict` file (Picard/GATK).
*   **Interval Syntax:** The tool supports flexible interval strings:
    *   Standard: `chrom:start-end`
    *   Expansion: `chrom:start-end+extend` (adds a fixed number of bases to both sides)
    *   Center-based: `chrom:middle+extend`
*   **Output Handling:** The `-o` (output) parameter should point to a `.zip`, `.tar`, or `.tar.gz` file. The tool generates individual SVG files for different groups/samples and bundles them into this archive.
*   **Filtering:** Use the `--mapq` flag (default is 1) to filter out low-quality alignments that might clutter the visualization.
*   **Page Layout:** Adjust the `--width` parameter (default 1000) to control the horizontal scale of the SVG, which is helpful when visualizing very wide or very narrow genomic intervals.

## Reference documentation
- [BamToSVG | jvarkit](./references/lindenb_github_io_jvarkit_BamToSVG.html.md)
- [jvarkit-bam2svg - bioconda](./references/anaconda_org_channels_bioconda_packages_jvarkit-bam2svg_overview.md)