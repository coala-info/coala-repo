---
name: im-pipelines
description: The im-pipelines toolkit provides modular, containerized building blocks for creating cheminformatics and computational chemistry workflows. Use when user asks to build chemical data pipelines, manipulate molecular structures, calculate properties, or manage data formats like SDF and JSON.
homepage: https://github.com/InformaticsMatters/pipelines
metadata:
  docker_image: "quay.io/biocontainers/im-pipelines:1.1.6--pyh3252c3a_0"
---

# im-pipelines

## Overview

The im-pipelines toolkit provides modular, containerized building blocks for cheminformatics and computational chemistry. These components are designed to follow the Unix philosophy: small, single-purpose tools that can be piped together to form complex workflows. They primarily utilize RDKit and Open Babel for structure manipulation and are optimized for use in high-performance computing environments or the Squonk Computational Notebook. Use this skill to navigate the consistent CLI patterns and data handling principles required to build reliable chemical data pipelines.

## CLI Usage Patterns

All components follow a consistent command-line interface to ensure interoperability.

### Standard I/O and Piping
Components are designed to work with standard streams.
- **Input**: Defaults to `STDIN`. Use `-i` or `--input` for files.
- **Output**: Defaults to `STDOUT`. Use `-o` or `--output` for files.
- **Logging**: All informational messages and metrics are written to `STDERR` to keep the data stream clean.

### Format Handling
Specify formats when they cannot be inferred from file extensions (especially when using pipes).
- **Input Format**: `-if` or `--informat` (typically `sdf` or `json`).
- **Output Format**: `-of` or `--outformat` (typically `sdf` or `json`).
- **Compression**: File names ending in `.gz` are automatically handled as gzipped data.

### Data Optimization
- **Thin Output**: Use the `--thin` flag to output only new or changed data. 
    - In **SDF**, this results in an empty molecule block with only the updated properties.
    - In **JSON**, this produces a `BasicObject` containing only the properties and a UUID.
    - *Note*: This requires a unique identifier (like a UUID or specific property) to be present in the input to allow for later reassembly.
- **Metadata**: Use the `--meta` flag to include additional metadata and execution metrics in the output, which is particularly useful for JSON-based datasets.

## Best Practices

### UUID Management
- **Preservation**: If the chemical structure is not modified (e.g., calculating a property), always retain the existing UUID to maintain traceability.
- **Generation**: If new structures are created (e.g., reaction enumeration, conformer generation, or fragmentation), you must generate new UUIDs as the identity of the molecule has changed.

### Modularity
- Split complex tasks into reusable steps. Instead of one monolithic script, pipe multiple `im-pipelines` components together.
- Example logic: `[Structure Cleaning] | [Property Calculation] | [Filtering]`.

### Error Handling
- Always monitor `STDERR` for execution logs.
- When using `STDIN`, ensure the data is not gzipped unless the specific component documentation explicitly supports gzipped streams on standard input (standard behavior expects uncompressed data on `STDIN`).

## Reference documentation
- [Pipelines Main Repository](./references/github_com_InformaticsMatters_pipelines.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_im-pipelines_overview.md)