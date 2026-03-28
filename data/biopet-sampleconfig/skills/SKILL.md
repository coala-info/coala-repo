---
name: biopet-sampleconfig
description: "biopet-sampleconfig manages and converts sample metadata between flat TSV files and structured JSON or YAML configurations for sequencing pipelines. Use when user asks to convert TSV files to sample sheets, extract metadata into TSV format, format configurations for WDL pipelines, or validate case-control experimental designs."
homepage: https://github.com/biopet/sampleconfig
---


# biopet-sampleconfig

## Overview
biopet-sampleconfig is a specialized utility within the BIOPET tool suite designed to handle the complexities of sample metadata management. It acts as a bridge between flat data formats like TSV and the structured JSON or YAML configurations required by high-throughput sequencing pipelines. This tool is essential for automating the preparation of sample sheets, validating experimental designs (such as case-control pairings), and ensuring metadata consistency across different workflow engines like Cromwell and Biopet Queue.

## Core Commands and Usage

The tool follows a sub-command structure: `biopet-sampleconfig <SubTool> [options]`.

### Extracting Metadata (ExtractTsv)
Use this command to pull specific hierarchical data out of an existing sample configuration file.
- **Purpose**: Extract samples, libraries, or readgroups.
- **Output**: Can generate a single-layer TSV file for easy inspection or use in downstream scripts.
- **Context**: Often used as a helper within WDL pipelines to parse configuration files on the fly.

### Creating Sample Sheets (ReadFromTsv)
Use this command to convert flat TSV files into structured pipeline configurations.
- **Purpose**: Generate full sample sheets in JSON or YAML format.
- **Compatibility**: Produces files suitable for all Biopet Queue pipelines.
- **Workflow**: This is typically the first step in a pipeline after receiving a manifest from a sequencing facility.

### WDL Integration (CromwellArrays)
Use this command to format configurations specifically for WDL-based execution.
- **Purpose**: Converts standard sample configs into the array-based format required by WDL inputs.
- **Target**: Specifically designed to support biowdl pipelines.

### Experimental Design Validation (CaseControl)
Use this command to define and verify experimental groups.
- **Purpose**: Extract case-control pairs from a configuration file.
- **Validation**: It reads the headers of associated BAM files to confirm that the samples referenced in the config actually exist on disk.

## Expert Tips and Best Practices

- **Help Access**: Each sub-tool has its own help menu. Use `biopet-sampleconfig <SubTool> --help` to see specific flags for input and output paths.
- **Pre-flight Validation**: Always run the `CaseControl` tool before launching large-scale analysis to ensure your BAM files are correctly indexed and accessible, preventing mid-pipeline failures.
- **Metadata Inspection**: If a pipeline is failing due to configuration errors, use `ExtractTsv` to flatten the JSON/YAML config into a TSV. This makes it much easier to spot typos or missing readgroup information.
- **Version Consistency**: When working in a shared environment, verify your tool version using `biopet-sampleconfig <SubTool> --version` to ensure compatibility with specific biowdl pipeline releases.



## Subcommands

| Command | Description |
|---------|-------------|
| ReadFromTsv | Converts TSV files containing sample and library information into a Biopet configuration file (YAML or JSON). |
| casecontrol | Options for CaseControl. This tool handles sample configuration for case-control studies, allowing input of BAM files and sample configurations with specific tags. |
| cromwellarrays | A tool to generate Cromwell arrays configuration from sample JSON or YAML files. |
| extracttsv | Extracts TSV information from a sample configuration JSON file. |

## Reference documentation
- [SampleConfig README](./references/github_com_biopet_sampleconfig_blob_develop_README.md)
- [Build Configuration and CLI Commands](./references/github_com_biopet_sampleconfig_blob_develop_build.sbt.md)