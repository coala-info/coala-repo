---
name: bftools
description: This skill provides guidance on using the Bio-Formats command-line utilities to bridge the gap between proprietary imaging formats and open standards.
homepage: https://docs.openmicroscopy.org/bio-formats/5.7.1/users/comlinetools/index.html
---

# bftools

## Overview
This skill provides guidance on using the Bio-Formats command-line utilities to bridge the gap between proprietary imaging formats and open standards. It enables automated metadata extraction, format conversion, and validation of biological imaging data without requiring a full GUI environment like ImageJ or OMERO.

## Core Tools and Usage Patterns

### Metadata Inspection (`showinf`)
Use `showinf` to probe image files for dimensions, pixel types, and metadata.
- **Basic metadata**: `showinf image.czi`
- **Metadata only (no pixels)**: `showinf -nopix image.nd2`
- **Full OME-XML output**: `showinf -omexml image.lif`
- **Suppress version check**: Always use `-no-upgrade` to prevent network-related hangs in restricted environments.

### Format Conversion (`bfconvert`)
Use `bfconvert` to transform images between formats, most commonly to OME-TIFF.
- **Standard conversion**: `bfconvert input.vsi output.ome.tif`
- **Compression**: `bfconvert -compression LZW input.czi output.ome.tif`
- **Specify series**: For multi-series files (e.g., slide scans), use `-series X` (where X is the index).
- **BigTIFF support**: For files >4GB, use `-bigtiff`.

### XML and Validation
- **Extract OME-XML**: `tiffcomment image.ome.tif` dumps the XML block from a TIFF.
- **Validate Schema**: `xmlvalid metadata.xml` checks for compliance with OME-XML schemas.
- **Prettify XML**: `xmlindent broken.xml` fixes indentation even if the XML has minor syntax errors.

### Utility Commands
- **List formats**: `formatlist` shows all supported file extensions and their capabilities (read/write).
- **Domain search**: `domainlist` groups formats by imaging modality (e.g., "Medical-Imaging", "High-Content-Screening").

## Expert Tips
- **Memory Management**: If processing large files, set the `JAVA_OPTS` environment variable (e.g., `export JAVA_OPTS="-Xmx4g"`) to increase the heap size.
- **Headless Execution**: When running on a server without a display, avoid tools that attempt to launch the Bio-Formats viewer (like `showinf` without `-nopix`).
- **Performance Profiling**: If a conversion is slow, use `BF_PROFILE=true bfconvert ...` to generate heap and CPU usage data for debugging.

## Reference documentation
- [Bio-Formats Command Line Tools Introduction](./references/docs_openmicroscopy_org_bio-formats_5.7.1_users_comlinetools_index.html.md)
- [Bftools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bftools_overview.md)