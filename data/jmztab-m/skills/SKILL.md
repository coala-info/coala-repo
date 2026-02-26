---
name: jmztab-m
description: jmztab-m reads, writes, and validates metabolomics data files according to the mzTab-M 2.0 reporting standard. Use when user asks to validate mzTab-M files, convert between TSV and JSON formats, or ensure metabolomics datasets are compliant with community standards.
homepage: https://github.com/lifs-tools/jmztab-m
---


# jmztab-m

## Overview
The `jmztab-m` tool is the reference implementation for the mzTab-M 2.0 reporting standard. It is designed to facilitate the sharing of quantitative metabolomics results by providing a robust framework for reading, writing, and validating data files. Use this skill to ensure that metabolomics datasets are compliant with community standards before submitting to repositories or integrating with LIMS and downstream statistical software like R or Excel.

## Installation and Setup
The tool is primarily distributed via Bioconda and Maven.
- **Conda**: `conda install bioconda::jmztab-m`
- **Manual Build**: Run `./mvnw install` in the source directory to generate the CLI JAR file located in `cli/target/`.

## Command Line Usage
The core functionality is accessed via the executable JAR file: `java -jar jmztabm-cli-<VERSION>.jar`.

### Validation
Validation ensures the file follows the mzTab-M 2.0 specification.
- **Basic Validation**:
  `java -jar jmztabm-cli.jar -c <file.mztab> -level Info`
  Levels include `Info`, `Warn`, and `Error`. `Info` provides the most comprehensive feedback.
- **Semantic Validation**:
  To check against controlled vocabularies (CV), you must provide a mapping file:
  `java -jar jmztabm-cli.jar -c <file.mztab> -level Info -s cv-mapping/mzTab-M-mapping.xml`

### Format Conversion
The tool can transcode between the standard TSV format and JSON.
- **TSV to JSON**:
  `java -jar jmztabm-cli.jar -c <input.mztab> -toJson -s cv-mapping/mzTab-M-mapping.xml`
  *Note: Comments are retained but their original line positions are lost in JSON.*
- **JSON to TSV**:
  `java -jar jmztabm-cli.jar -c <input.json> -fromJson -s cv-mapping/mzTab-M-mapping.xml`
  *Note: Comment objects are currently discarded when converting from JSON back to TSV.*

## Best Practices
- **Always use CV Mapping**: Structural validation alone is often insufficient for repository submission. Always include the `-s` flag with the official `mzTab-M-mapping.xml` to ensure metadata and terms are correct.
- **Check Versioning**: Ensure you are using the `jmztab-m` implementation for mzTab 2.0+; for older mzTab 1.0 files, the original `jmztab` project should be used instead.
- **Memory Management**: For very large metabolomics files, you may need to increase the Java heap size using the `-Xmx` flag (e.g., `java -Xmx4g -jar ...`).

## Reference documentation
- [jmzTab-m GitHub Repository](./references/github_com_lifs-tools_jmzTab-m.md)
- [jmztab-m Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_jmztab-m_overview.md)