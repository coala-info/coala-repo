---
name: wally
description: Wally is a command-line utility for the rapid visualization and batch image generation of aligned sequencing reads, contigs, and pan-genome graphs. Use when user asks to visualize genomic regions, generate publication-quality alignment plots, perform batch processing of variants via BED files, or inspect structural variants using split-read and paired-end views.
homepage: https://github.com/tobiasrausch/wally
---


# wally

## Overview
Wally is a high-performance command-line utility designed for the rapid visualization of aligned sequencing reads, assembled contigs, and pan-genome graphs. Unlike interactive genome browsers, wally excels at batch processing and automated image generation. It allows researchers to transform raw alignment data into clear, publication-quality plots that highlight paired-end orientations, split-read alignments, and depth of coverage across one or multiple samples.

## Core CLI Usage

### Visualizing Specific Regions
The `region` subcommand is the primary interface for generating plots. It requires a reference genome and at least one indexed BAM or CRAM file.

```bash
# Basic region plot
wally region -r chr1:1000-2000 -g ref.fa input.bam

# Plot with a specific output name
wally region -r chr1:1000-2000:my_variant_plot -g ref.fa input.bam
```

### Batch Processing with BED Files
To visualize multiple variants or regions of interest simultaneously, use a BED file. The 4th column of the BED file is used as the output filename.

```bash
# Generate plots for all regions in a BED file
wally region -R regions.bed -g ref.fa input.bam
```

### Comparative and Multi-Sample Views
Wally can overlay or stack multiple alignment files, which is essential for somatic variant calling or population studies.

```bash
# Tumor/Normal comparison
wally region -r chr17:7573900-7574000 -g ref.fa tumor.bam control.bam

# Large-scale "wallpaper" (e.g., 96 samples)
wally region -y 20480 -r NC_045512.2:1-30000 -g ref.fa Plate*.bam
```

### Advanced Visualization Modes

#### Split View (Horizontal Concatenation)
Use the `--split` (or `-s`) option to view multiple distant regions side-by-side, such as the breakpoints of a translocation.

```bash
# View two different chromosomes side-by-side
wally region -s 2 -r chrA:35-80,chrB:60-80 -g ref.fa tumor.bam
```

#### Paired-End View
Enable paired-end coloring with `-p` to highlight structural variant candidates (e.g., inversions, deletions, or duplications) based on read orientation and insert size.

```bash
wally region -p -r chr1:5000-6000 -g ref.fa input.bam
```

#### Gene Annotations
Incorporate gene models or custom features using bgzipped and tabix-indexed BED files.

```bash
# Display gene annotations from a BED file
wally region -b annotations.bed.gz -r chr1:1000-5000 -g ref.fa input.bam
```

## Expert Tips
- **Coordinate Matching**: Ensure chromosome naming (e.g., "chr1" vs "1") is consistent across the reference FASTA, BAM files, and BED annotations; wally treats them as literal strings.
- **Custom Coloring**: You can specify Hex color codes in the 5th column of an annotation BED file to highlight specific genomic features in the plot.
- **VCF Integration**: Quickly generate plots for VCF calls by converting the VCF to a BED format with padding:
  `bcftools query -f "%CHROM\t%POS\n" variants.vcf.gz | awk '{print $1"\t"($2-50)"\t"($2+50)"\tid"NR;}' > regions.bed`



## Subcommands

| Command | Description |
|---------|-------------|
| dotplot | Generates dot plots for sequence alignment visualization. |
| matches | Display matches from BAM files |
| region | Display BAM alignments in a specified region. |

## Reference documentation
- [Wally GitHub README](./references/github_com_tobiasrausch_wally_blob_main_README.md)
- [Wally Main Repository](./references/github_com_tobiasrausch_wally.md)