---
name: svist4get
description: svist4get is a command-line utility that generates publication-quality visualizations of genomic regions by overlaying sequencing data tracks onto a reference genome. Use when user asks to visualize genomic regions, create snapshots of read alignments, display coverage profiles from BigWig files, or generate figures for gene annotations and variant calls.
homepage: https://bitbucket.org/artegorov/svist4get/
---


# svist4get

## Overview
svist4get is a Python-based CLI utility designed to bridge the gap between raw sequencing data and visual interpretation. It excels at creating "snapshot" visualizations of genomic regions, allowing users to overlay multiple data types—such as read alignments, coverage profiles, and variant calls—onto a reference genome coordinate system. It is particularly useful for researchers who need to quickly inspect specific loci or generate figures for multiple regions programmatically without the overhead of a full genome browser.

## Usage Patterns

### Basic Visualization
To generate a plot for a specific genomic region, use the primary command structure:
```bash
svist4get -g reference.gtf -f reference.fasta -r chr1:1000-2000 [data_files]
```

### Common Input Types
- **Genomic Annotations**: Use `-g` for GTF/GFF3 files to display gene structures.
- **Reference Sequence**: Use `-f` for FASTA files to show nucleotide sequences (at appropriate zoom levels).
- **Signal Data**: Provide BigWig (.bw) files to display continuous tracks like RNA-seq coverage or ChIP-seq peaks.
- **Alignment Data**: Provide BAM (.bam) files to visualize individual read mappings and depth.
- **Variant Data**: Provide VCF (.vcf) files to mark SNPs and Indels.

### Configuration and Styling
svist4get uses a configuration file to manage visual parameters (colors, track heights, fonts).
- **Generate default config**: `svist4get --create-config my_style.conf`
- **Apply custom config**: `svist4get -c my_style.conf ...`

### Expert Tips
- **Batch Processing**: For visualizing multiple regions, create a simple text file with coordinates and wrap the command in a bash loop to generate a series of PNG/PDF outputs.
- **Output Formats**: Specify the output filename with `-o`. Use `.pdf` or `.svg` for publication-quality vector graphics, or `.png` for quick web previews.
- **Track Ordering**: The order in which data files are listed in the command line typically dictates the vertical order of tracks in the resulting image.

## Reference documentation
- [svist4get Overview](./references/anaconda_org_channels_bioconda_packages_svist4get_overview.md)
- [svist4get Repository and Documentation](./references/bitbucket_org_artegorov_svist4get.md)