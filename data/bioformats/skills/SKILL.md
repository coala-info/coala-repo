---
name: bioformats
description: Bio-Formats is a software toolset for reading, writing, and converting biological image file formats and their associated metadata. Use when user asks to convert proprietary microscopy files to standardized formats, extract image metadata, or perform batch image processing.
homepage: https://github.com/gtamazian/bioformats
---


# bioformats

## Overview
Bio-Formats is a software toolset designed for reading and writing biological image file formats. It acts as a translation layer that converts proprietary microscopy formats (like .czi, .nd2, .lif, or .ims) into standardized formats such as OME-TIFF. Use this skill to automate image data ingestion, extract embedded metadata, and perform batch conversions in high-performance computing or pipeline environments.

## Core Command-Line Tools

### showinf (Metadata Inspection)
Use `showinf` to display image dimensions, pixel types, and metadata without opening the full image.

- **Basic Inspection**: `showinf image.czi`
- **Display Metadata Only**: `showinf -nopix image.nd2`
- **Detailed OME-XML**: `showinf -omexml image.lif`
- **Check Format Support**: `showinf -version`

### bfconvert (Image Conversion)
Use `bfconvert` to transform proprietary files into open standards.

- **Standard Conversion**: `bfconvert input.czi output.ome.tif`
- **Compression**: Use `-compression` to reduce file size (e.g., `LZW`, `JPEG-2000`, `zlib`).
  - `bfconvert -compression LZW input.nd2 output.ome.tif`
- **Channel/Series Selection**:
  - Convert a specific series: `bfconvert -series 0 input.lif output_s0.ome.tif`
  - Convert a range of timepoints: `bfconvert -timepoint 0-10 input.czi output_t.ome.tif`
- **BigTIFF Support**: For files exceeding 4GB, force BigTIFF:
  - `bfconvert -bigtiff input.ims output.ome.tif`
- **Tiling**: For extremely large images, use `-tilex` and `-tiley` to process in chunks:
  - `bfconvert -tilex 512 -tiley 512 input.svs output.ome.tif`

## Expert Tips & Best Practices

- **Memory Management**: Bio-Formats is Java-based. If encountering `OutOfMemoryError`, set the `BF_MAX_MEM` environment variable (e.g., `export BF_MAX_MEM=4g`) before running commands.
- **Headless Environments**: When running on servers without a display, ensure you use the `-nogui` flag if the tool attempts to launch a window.
- **Metadata Preservation**: Always convert to `.ome.tif` rather than plain `.tif` to ensure that spatial scales (microns per pixel) and timestamps are preserved in the OME-XML header.
- **Batch Processing**: Use simple shell loops for directory-wide conversion:
  ```bash
  for f in *.czi; do bfconvert "$f" "${f%.czi}.ome.tif"; done
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| bedautosql | Get an autoSql table structure for the specified BED file |
| bedcolumns | A command within the bioformats toolset to process or display columns of a BED file. |
| fastagaps | Identify gaps in a FASTA file and output their coordinates in BED format. |
| fastareorder | Reorder sequences in a FASTA file. |
| flanknfilter | Given features from a BED or VCF file, check if they contain N's in their flanking regions of the specified length. |
| gff2bed | Convert a GFF3 file to the BED format. |
| gff2to3 | Convert GFF2 files to GFF3 format using the bioformats toolset. |
| gfftagstat | Extract tag statistics from a GFF file. |
| interval2bed | Convert interval files to BED format. |
| ncbirenameseq | Change NCBI-style sequence names in a FASTA file or plain text tabular file |
| randomfasta | Generate a random FASTA file with specified sequence length and number of sequences. |
| renameseq | Change sequence names in a FASTA or plain text tabular file. |
| rmout2bed | Convert a RepeatMasker out file to the BED format. |
| snpeff2bed | Convert SnpEff VCF files to BED format. |
| snpeff2pph | Convert SnpEff annotated VCF files to PolyPhen-2 format. |
| vcf2bed | Convert VCF files to BED format using the bioformats toolset. |
| vcfeffect2bed | Given an snpEff-annotated VCF file, extract its sample genotype effects. |
| vcfgeno2bed | Given a VCF file, extract genotype counts from it and write them to the specified file in the BED3+ format. |

## Reference documentation
- [Bio-Formats Overview](./references/anaconda_org_channels_bioconda_packages_bioformats_overview.md)