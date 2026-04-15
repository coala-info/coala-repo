---
name: biom-format
description: The biom-format tool manages large-scale biological observation data by storing and manipulating sparse matrices of species or genomic counts. Use when user asks to convert between TSV and BIOM formats, add sample or observation metadata to tables, or summarize and validate biological observation matrices.
homepage: http://www.biom-format.org
metadata:
  docker_image: "quay.io/biocontainers/biom-format:2.1.15"
---

# biom-format

## Overview
The `biom-format` tool is essential for managing large-scale biological observation data, such as OTU tables or functional genomic counts. It allows for efficient storage and manipulation of sparse matrices where observations (e.g., species) are mapped against samples. Use this skill to execute command-line operations for data transformation and metadata integration, ensuring compatibility between different bioinformatics pipelines like QIIME, MG-RAST, and phyloseq.

## Installation and Setup
To work with modern BIOM files (Version 2.0+), ensure the HDF5 support is installed:
- **Conda**: `conda install bioconda::biom-format`
- **Pip**: `pip install numpy h5py biom-format`

## Common CLI Patterns

### Converting Between Formats
The `biom convert` command is the primary way to move between human-readable TSV files and high-performance BIOM files.

- **TSV to BIOM (HDF5)**:
  `biom convert -i table.txt -o table.biom --table-type="OTU table" --to-hdf5`
- **BIOM to TSV**:
  `biom convert -i table.biom -o table.tsv --to-tsv`
- **JSON to HDF5**:
  `biom convert -i legacy_table.biom -o new_table.biom --to-hdf5`

### Adding Metadata
Metadata is critical for downstream statistical analysis. You can add sample or observation (taxonomy) data to an existing BIOM file.

- **Add Sample Metadata**:
  `biom add-metadata -i table.biom -o table_with_metadata.biom -m sample_metadata.txt`
- **Add Taxonomy (Observation Metadata)**:
  `biom add-metadata -i table.biom -o table_with_taxonomy.biom -m taxonomy.txt --observation-header OTUID,Taxonomy,Confidence --sc-separated Taxonomy`

### Summarizing Tables
Use the summarize command to validate the contents of a BIOM file and check sequencing depth.

- **General Summary**:
  `biom summarize-table -i table.biom -o summary.txt`
- **Detailed Sample Counts**:
  `biom summarize-table -i table.biom --qualitative -o qualitative_summary.txt`

## Expert Tips
- **TSV Formatting**: When converting from TSV, the input file must start with `#OTU ID` (or the specific observation ID header) in the first column.
- **Validation**: Always run `biom validate-table -i table.biom` after manual creation or conversion to ensure the file adheres to the official specification.
- **Version Choice**: Use `--to-hdf5` (Version 2.1) for large datasets to improve performance and reduce file size. Use JSON only if a legacy tool specifically requires Version 1.0.
- **Bash Completion**: Enable faster CLI usage by adding `eval "$(_BIOM_COMPLETE=source biom)"` to your shell profile.

## Reference documentation
- [The Biological Observation Matrix (BIOM) format](./references/biom-format_org_index.md)
- [biom-format - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_biom-format_overview.md)