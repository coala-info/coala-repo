---
name: fiji-omero_ij
description: This tool integrates Fiji/ImageJ with OMERO servers to enable the visualization, manipulation, and import of multidimensional image data and metadata. Use when user asks to launch the OMERO.insight client, import image data into an OMERO server, or configure the OMERO metadata extension.
homepage: https://github.com/ome/omero-insight
metadata:
  docker_image: "quay.io/biocontainers/fiji:20250206--h9ee0642_1"
---

# fiji-omero_ij

## Overview
The fiji-omero_ij tool provides a critical link between the Fiji/ImageJ image analysis environment and OMERO server instances. It enables researchers to visualize, manipulate, and import complex multidimensional image data and associated metadata. The package includes the OMERO.insight desktop client and a dedicated importer tool, allowing for both interactive GUI-based work and scripted data ingestion.

## Installation and Setup
The most efficient way to deploy the tool in a managed environment is via Conda:

```bash
conda install bioconda::fiji-omero_ij
```

For development or building from source, the project requires JDK 1.8 or later and uses Gradle:

```bash
gradle build
```

## Command Line Usage Patterns

### Launching the Client
To start the standard OMERO.insight GUI client from a distribution bundle:

```bash
bin/omero-insight
```

### Command Line Importing
The OMERO.importer can be executed directly to handle data ingestion. This is often used in automated pipelines where an XML configuration file defines the import parameters:

```bash
bin/omero-insight containerImporter.xml
```

Alternatively, using Gradle during development:

```bash
gradle runImporter
```

## Configuration and Best Practices

### Enabling the Metadata Extension (OMERO.mde)
To use the advanced metadata extension for structured data handling, you must modify the configuration files (`container.xml` or `containerImporter.xml`). Locate the `omero.client.import.mde.enabled` entry and set it to true:

```xml
<entry name="omero.client.import.mde.enabled" type="boolean">true</entry>
```

### Memory Management
When dealing with large image datasets or high-throughput imports, ensure the JVM heap size is sufficient. If the application fails with memory errors, adjust the memory settings in the launch scripts or via environment variables before execution.

### Platform-Specific Packaging
If you need to create a standalone installer for a specific environment:
- **Windows**: Use `gradle packageApplicationExe` (requires Inno Setup and WiX).
- **macOS**: Use `gradle packageApplicationDmg` (requires OpenJFX).

## Reference documentation
- [fiji-omero_ij Overview](./references/anaconda_org_channels_bioconda_packages_fiji-omero_ij_overview.md)
- [OMERO.insight GitHub Repository](./references/github_com_ome_omero-insight.md)