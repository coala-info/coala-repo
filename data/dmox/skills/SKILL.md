---
name: dmox
description: dmox is a Rust-based utility designed for the efficient demultiplexing of linked-read data generated via haplotagging. Use when user asks to demultiplex sequencing reads, assign reads to samples based on barcode schemas, or replace the demultiplexing component of the Harpy pipeline.
homepage: https://gitlab.mbb.cnrs.fr/ibonnici/dmox
metadata:
  docker_image: "quay.io/biocontainers/dmox:0.2.1--h3ab6199_0"
---

# dmox

## Overview
`dmox` is a specialized, Rust-based utility designed for the efficient demultiplexing of linked-read data generated via haplotagging. It serves as a standalone tool or a high-performance drop-in replacement for the demultiplexing component of the Harpy pipeline. Use this skill to process raw sequencing reads, assign them to biological samples based on barcode schemas, and manage linked-read metadata with significantly lower computational overhead than traditional Python-based implementations.

## Installation
The tool is primarily distributed via Bioconda for Linux (x86_64 and aarch64) and macOS:
```bash
conda install bioconda::dmox
```

## CLI Usage and Best Practices

### Handling Undetermined Reads
`dmox` provides granular control over reads that fail to map to the provided schema. Use these flags to debug library preparation issues:
- `--undetermined-barcodes`: Isolates reads where the barcode sequence itself is not recognized.
- `--undetermined-samples`: Isolates reads where the barcode is valid but does not map to a defined sample in your schema.

### Barcode and Sample Mapping
- **Multiple Samples per Barcode**: If your experimental design involves multiplexing several samples under a single barcode, you must explicitly opt-in using the `--multiple-samples-per-barcode` flag.
- **Schema Formatting**: The tool supports flexible whitespace in schema and reference files, allowing for cleaner, more readable mapping files without breaking the parser.

### Metadata and Tags
- **Tag Handling**: `dmox` is designed to handle RX (Sequence barcode) and QX (Quality score) tags. 
- **Default Behavior**: By default, the tool opts out of RX, QX, and ID tail modifications to ensure output compatibility. If your downstream pipeline requires these tags, ensure you check the specific version's defaults for tag preservation.

### Performance and Monitoring
- **Stats Generation**: Always review the generated stats table. Recent versions (v0.3+) provide generalized and sorted tables that prioritize the most numerous or expected samples, making it easier to spot "barcode bleeding" or low-diversity libraries.
- **Speed**: As a Rust-based tool, `dmox` is optimized for multi-threaded environments. It is significantly faster than the original Harpy demultiplexing module and should be preferred for large-scale genomic datasets.

## Expert Tips
- **Harpy Compatibility**: If you are migrating a workflow from Harpy, `dmox` is designed to be a drop-in replacement. You can swap the demultiplexing step for `dmox` to reduce wall-clock time without changing your input schema logic.
- **Platform Support**: While `dmox` supports Linux and macOS, ensure you are using version 0.2.0 or later for stable macOS builds, as earlier versions had known issues with `zlib-ng` dependencies.

## Reference documentation
- [dmox Overview](./references/anaconda_org_channels_bioconda_packages_dmox_overview.md)
- [README](./references/gitlab_mbb_cnrs_fr_ibonnici_dmox_-_blob_main_README.md)
- [Changelog](./references/gitlab_mbb_cnrs_fr_ibonnici_dmox_-_blob_main_CHANGELOG.md)