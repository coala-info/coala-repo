---
name: ena-webin-cli
description: The `ena-webin-cli` is the primary tool for programmatic data submission to the European Nucleotide Archive (ENA).
homepage: https://github.com/enasequence/webin-cli
---

# ena-webin-cli

## Overview

The `ena-webin-cli` is the primary tool for programmatic data submission to the European Nucleotide Archive (ENA). It validates, bundles, and uploads biological data and metadata to ENA servers. This skill assists in configuring the submission environment, executing the validation and submission commands, and optimizing performance for high-throughput sequencing data.

## Installation and Setup

The tool can be deployed in three primary ways:

- **Conda**: `conda install bioconda::ena-webin-cli`
- **Docker**: `docker pull enasequence/webin-cli`
- **Java JAR**: Download the latest release from GitHub and run via `java -jar webin-cli-<version>.jar`.

**Requirements**:
- A Webin submission account (username and password).
- Java 1.8 or newer (for JAR execution).

## Core Command Patterns

### Basic Execution
The tool requires a manifest file (typically defining metadata and file paths) to perform submissions.

```bash
# Using the JAR file
java -jar webin-cli.jar -username <username> -password <password> -context <context> -manifest <file> -submit

# Using Docker
docker run --rm -v $(pwd):/data enasequence/webin-cli -username <username> -password <password> -context <context> -manifest /data/<file> -submit
```

### Supported Contexts
The `-context` flag defines the type of data being submitted:
- `genome`: Genome assemblies.
- `transcriptome`: Transcriptome assemblies.
- `reads`: Raw read data (Fastq, BAM, CRAM).
- `sequence`: Annotated sequences.
- `taxonomy`: Taxonomy reference sets.

### Validation vs. Submission
- **Validation only**: Run without the `-submit` flag to check for errors without uploading.
- **Test submission**: Use the `-test` flag to submit to the ENA test server before final production submission.

## Expert Tips and Best Practices

### Memory Management
Large genomic files (especially BAM/CRAM or large assemblies) require significant RAM for validation.
- **JAR**: Use `-Xms` and `-Xmx` flags: `java -Xmx4G -jar webin-cli.jar ...`
- **Docker**: Set the `JAVA_TOOL_OPTIONS` environment variable: `-e JAVA_TOOL_OPTIONS="-Xmx4G"`.

### Updating Existing Submissions
Use the `-sampleUpdate` flag when you need to update metadata for a sample that has already been submitted. Note that this may not update all fields in existing genome submissions depending on the version.

### Troubleshooting Common Issues
- **FTP Failures**: If you encounter "Failed to upload files to FTP server" or "530 Login incorrect," verify your Webin credentials and ensure your firewall allows outbound traffic on port 21 (FTP) and passive port ranges.
- **Java Version Warnings**: When using Java 24+, you may see warnings regarding restricted methods in `java.lang.System`; these are generally non-fatal but indicate the tool is optimized for older LTS versions.
- **Center Name Spaces**: If your center name contains spaces, ensure it is properly quoted in the manifest or command line to avoid parsing errors.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_enasequence_webin-cli.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_ena-webin-cli_overview.md)
- [Known Issues and Bug Reports](./references/github_com_enasequence_webin-cli_issues.md)