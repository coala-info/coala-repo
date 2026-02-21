---
name: crimson
description: Crimson is a specialized utility designed to bridge the gap between legacy bioinformatics text reports and modern data pipelines.
homepage: https://github.com/bow/crimson
---

# crimson

## Overview

Crimson is a specialized utility designed to bridge the gap between legacy bioinformatics text reports and modern data pipelines. It parses the often idiosyncratic and inconsistent text outputs of common genomic tools, transforming them into machine-readable JSON or YAML. This is particularly useful when you need to aggregate quality control metrics, summarize alignment statistics, or feed tool results into web dashboards and databases without writing custom regex parsers from scratch.

## Supported Tools

Crimson provides dedicated parsers for the following bioinformatics tools:
- **FastQC**: `fastqc`
- **FusionCatcher**: `fusioncatcher`
- **Samtools flagstat**: `flagstat`
- **Picard metrics**: `picard`
- **STAR log**: `star`
- **STAR-Fusion**: `star-fusion`
- **Variant Effect Predictor (VEP)**: `vep` (plain text output)

## CLI Usage Patterns

### Basic Conversion
By default, crimson writes the converted output to `stdout`.
```bash
crimson {tool_name} /path/to/input_file
```

### Writing to File
To save the output directly to a file, provide a second path argument.
```bash
crimson {tool_name} /path/to/input_file output.json
```

### Tool-Specific Inputs
Some parsers support directory-level or compressed inputs:
- **FastQC**: Accepts a path to the FastQC output directory or the zipped result file.
  ```bash
  crimson fastqc /path/to/fastqc_results/
  crimson fastqc /path/to/fastqc_results.zip
  ```

## Expert Tips

- **Discovery**: Use `crimson --help` to see the full list of supported subcommands and `crimson {tool_name} --help` to see specific options for a particular parser.
- **Piping to JQ**: Since crimson defaults to `stdout`, it is highly effective when piped into `jq` for immediate filtering of bioinformatics metrics.
  ```bash
  crimson flagstat alignment.flagstat | jq '.total'
  ```
- **Python Integration**: For complex workflows, use crimson as a library rather than a CLI tool to avoid shell overhead.
  ```python
  from crimson import picard
  parsed_data = picard.parse("/path/to/picard.metrics")
  ```
- **Input Flexibility**: The Python API accepts both file paths (strings/path-like objects) and open file handles, making it compatible with various stream-processing patterns.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_bow_crimson.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_crimson_overview.md)