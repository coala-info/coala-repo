---
name: seqspec
description: Seqspec manages and validates machine-readable genomics assay specifications. Use when user asks to create or format assay specifications, validate library geometry, visualize library structures, extract barcode onlists, or generate methods sections for publications.
homepage: https://github.com/sbooeshaghi/seqspec
---


# seqspec

## Overview
`seqspec` is a specialized tool for managing machine-readable genomics assay specifications. It provides a unified interface to describe the physical and logical arrangement of sequencing libraries, enabling reproducible and standardized data analysis. Use this skill to interact with the `seqspec` CLI for validating assay designs, visualizing library components, and preparing metadata for downstream processing.

## Core CLI Operations

### Project Initialization and Maintenance
- **Create a new specification**: Use `seqspec init` to generate a skeleton file for a new assay.
- **Update versions**: Use `seqspec upgrade` to migrate older `0.3.0` specifications to the current `0.4.0` format.
- **Format files**: Use `seqspec format` to ensure the specification file follows standard indentation and structure.

### Validation and Inspection
- **Verify library geometry**: Run `seqspec check <spec.yaml>` to validate the file against the schema. Pay close attention to warnings regarding "risky geometry," such as overlapping read regions.
- **Inspect library contents**: Use `seqspec info` for a high-level summary or `seqspec find` to locate specific objects (regions or reads) within the specification.
- **List associated files**: Use `seqspec file` to see all external resources (like onlists) referenced in the specification.

### Visualization
- **HTML Report**: Generate a self-contained, interactive view of the library using `seqspec print -f seqspec-html > report.html`.
- **ASCII Visualization**: For a quick terminal-based view of the library or sequence structure, use `seqspec print -f library-ascii` or `seqspec print -f seqspec-ascii`.

### Data Extraction and Processing
- **Retrieve onlists**: Use `seqspec onlist -s <region-id>` to get the barcode sequences for a specific region. If a region type appears in multiple reads, ensure you specify the join explicitly to avoid errors.
- **Generate Methods sections**: Use `seqspec methods` to automatically convert the machine-readable specification into a human-readable text block suitable for the "Methods" section of a scientific paper.
- **Modality Splitting**: For multi-modal assays, use `seqspec split` to create separate specification files for each modality (e.g., RNA vs. ATAC).

### Remote Resource Management
- **Authentication**: Use `seqspec auth` to manage profiles for remote resources. This is essential when the specification references onlists hosted on secure or remote servers.
- **Authenticated Checks**: When running `check` or `onlist` on specs with remote dependencies, include the `--auth-profile <profile-name>` flag.

## Expert Tips
- **Gzip Support**: `seqspec` natively handles compressed files. You can pass `.yaml.gz` files directly to any command without decompressing them first.
- **Index Identification**: Use `seqspec index` to programmatically identify the exact coordinates of elements, which is useful for building automated pipelines.
- **Attribute Modification**: Instead of manual editing, use `seqspec modify` to programmatically update attributes like region lengths or IDs to maintain file integrity.



## Subcommands

| Command | Description |
|---------|-------------|
| onlist | Get onlist file for specific region. Onlist is a list of permissible sequences for a region. |
| seqspec build | Generate a complete seqspec with natural language. |
| seqspec file | List files present in seqspec file. |
| seqspec format | Automatically fill in missing fields in the spec. |
| seqspec index | Identify the position of elements in a spec for use in downstream tools. |
| seqspec init | Generate a new *empty* seqspec draft (meta-Regions only). |
| seqspec methods | Convert seqspec file into methods section. |
| seqspec split | Split seqspec file into one file per modality. |
| seqspec upgrade | Upgrade seqspec file from older versions to the current version. |
| seqspec_check | Validate seqspec file against the specification schema. |
| seqspec_find | Find objects in the spec. |
| seqspec_info | Get information about spec. |
| seqspec_insert | Draft spec to modify |
| seqspec_modify | Modify attributes of various elements in a seqspec file using JSON objects. |
| seqspec_print | Print sequence and/or library structure as ascii, png, or html. |
| version | Get seqspec version and seqspec file version. |

## Reference documentation
- [seqspec README](./references/github_com_pachterlab_seqspec_blob_main_README.md)
- [Installation Guide](./references/github_com_pachterlab_seqspec_blob_main_docs_INSTALLATION.md)