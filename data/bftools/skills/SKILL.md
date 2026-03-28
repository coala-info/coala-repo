---
name: bftools
description: bftools provides command-line utilities for inspecting, converting, and validating over 150 proprietary microscopy image formats. Use when user asks to convert image formats, extract metadata, validate OME-XML files, or inspect image file structures.
homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html
---

# bftools

## Overview

This skill provides guidance for using the Bio-Formats command-line utilities (bftools) to handle over 150 proprietary microscopy image formats. It enables automated image processing workflows, metadata extraction, and format standardization without requiring a graphical user interface like ImageJ or OMERO.

## Core Tools and Usage

### Metadata Inspection (`showinf`)
Use `showinf` to probe file structures and metadata without loading full pixel data.
- **Basic Metadata**: `showinf image.czi`
- **No Pixels (Fast)**: `showinf -nopix image.nd2` (Use this to quickly check dimensions/metadata).
- **OME-XML Output**: `showinf -omexml image.lif` (Dumps the full OME-XML metadata block).
- **Version Check**: `showinf -version`

### Image Conversion (`bfconvert`)
The primary tool for converting proprietary formats to open standards like OME-TIFF.
- **Standard Conversion**: `bfconvert input.czi output.ome.tif`
- **Compression**: `bfconvert -compression LZW input.nd2 output.ome.tif`
- **BigTIFF Support**: `bfconvert -bigtiff input.lif output.ome.tif` (Required for files >4GB).
- **Crop/Subset**: `bfconvert -x 0 -y 0 -w 512 -h 512 input.czi crop.ome.tif`

### XML and TIFF Utilities
- **tiffcomment**: Extract the OME-XML header from an OME-TIFF file.
  - `tiffcomment image.ome.tif > metadata.xml`
- **xmlvalid**: Validate an OME-XML file against the official schema.
  - `xmlvalid metadata.xml`
- **xmlindent**: Clean up and format messy or minified XML.
  - `xmlindent input.xml > formatted.xml`

## Expert Tips and Best Practices

- **Avoid Update Checks**: In firewalled or HPC environments, use the `-no-upgrade` flag to prevent the tool from hanging while trying to check for updates.
  - Example: `bfconvert -no-upgrade input.czi output.ome.tif`
- **Memory Management**: If you encounter `java.lang.OutOfMemoryError`, increase the JVM heap size by setting the `BF_MAX_MEM` environment variable (e.g., `export BF_MAX_MEM=4g`).
- **Batch Processing**: Use `formatlist` to check if a specific format is supported for writing before starting a large batch job.
- **Testing Metadata**: Use `mkfake` to generate mock High-Content Screening (HCS) datasets to test your analysis pipelines without using large raw data files.



## Subcommands

| Command | Description |
|---------|-------------|
| bfconvert | To convert a file between formats, run: |
| bftools_formatlist | List supported image formats |
| bftools_xmlvalid | Validates an XML file against a schema. |
| showinf | To test read a file in any format, run: |
| tiffcomment | This tool requires an ImageDescription tag to be present in the TIFF file. |

## Reference documentation

- [Command line tools introduction](./references/docs_openmicroscopy_org_bio-formats_5.7.1_users_comlinetools_index.html.md)