---
name: emboss-lib
description: EMBOSS is a comprehensive bioinformatics toolkit that integrates over 200 applications for sequence analysis and data management under a unified interface. Use when user asks to execute bioinformatics workflows, manage sequence data using Uniform Sequence Addresses, handle diverse biological data formats, or perform high-throughput sequence analysis.
homepage: http://emboss.open-bio.org/
metadata:
  docker_image: "biocontainers/emboss-lib:v6.6.0dfsg-6-deb_cv1"
---

# emboss-lib

## Overview

EMBOSS (European Molecular Biology Open Software Suite) is a comprehensive, open-source toolkit designed for the bioinformatics community. It integrates over 200 specialized applications for sequence analysis under a unified command-line interface. This skill should be used to execute bioinformatics workflows, handle diverse biological data formats without manual conversion, and manage sequence data through the powerful Uniform Sequence Address (USA) mechanism. It is particularly effective for high-throughput analysis where consistency across different tools is required.

## Command Line Best Practices

### The Uniform Sequence Address (USA)
The most powerful feature of EMBOSS is the USA, which allows you to specify sequence inputs without worrying about file paths or formats.
- **Standard Format**: `database:entry` (e.g., `swissprot:ins_human`)
- **File-based**: `format::filename` (e.g., `fasta::myseq.fa`)
- **Wildcards**: Use `database:*` to process entire sets.
- **Sequence Ranges**: Append ranges to the address, such as `swissprot:ins_human[10:50]`.

### Common Global Qualifiers
Every EMBOSS tool supports a set of global qualifiers that modify behavior:
- `-help`: Displays all available options for the specific tool, including mandatory and optional parameters.
- `-auto`: Disables interactive prompting. Use this in scripts to ensure the tool fails or uses defaults rather than waiting for user input.
- `-stdout`: Forces the primary output to the standard output stream.
- `-filter`: Allows the tool to act as a Unix pipe (reading from stdin, writing to stdout).
- `-ossdirectory`: Specifies a custom directory for output files.

### Application Execution Patterns
EMBOSS applications use the AJAX Command Definition (ACD) system to validate input before the algorithm begins.
1. **Interactive Mode**: Simply type the command (e.g., `needle`). The system will prompt you for missing mandatory information.
2. **Command Line Mode**: Provide all mandatory arguments as flags to bypass prompts.
3. **Format Specification**: While EMBOSS auto-detects formats, you can force an output format using `-osformat`, such as `-osformat fasta` or `-osformat gcg`.

## Configuration and Environment

### User Customization (`.embossrc`)
To define personal databases or default behavior, create a `.embossrc` file in your home directory.
- Use `SET` commands to define environment variables.
- Use `DB` definitions to point to local flatfiles or remote servers (like SRS or Entrez).

### Data Extraction Tools
Before using specific analysis tools, you may need to prepare data using the "extract" suite:
- `rebaseextract`: For restriction enzyme data.
- `aaindexextract`: For amino acid indices.
- `prosextract`: For PROSITE patterns.

## Expert Tips
- **Memory Management**: EMBOSS has no arbitrary sequence length limits; it allocates memory dynamically based on the input. If a process fails on a large genome, ensure the system has sufficient swap/RAM.
- **Pipe Integration**: Combine EMBOSS tools with standard Unix utilities (grep, awk, sed) by using the `-filter` qualifier to build complex discovery pipelines.
- **Version Checking**: Use `embossversion` to verify the current installation and ensure compatibility with specific EMBASSY (extension) packages.

## Reference documentation
- [Key Features and USA](./references/emboss_open-bio_org_html_use_ch01s03.html.md)
- [Post-installation and Configuration](./references/emboss_open-bio_org_html_adm_ch01s06.html.md)
- [Introduction to EMBOSS](./references/emboss_open-bio_org_html_use_pr02s01.html.md)