---
name: crimson
description: "Crimson converts legacy bioinformatics text outputs from tools like FastQC, Picard, and samtools into structured JSON or YAML formats. Use when user asks to parse bioinformatics log files, convert tool outputs to machine-readable formats, or aggregate quality control data into JSON."
homepage: https://github.com/bow/crimson
---

# crimson

## Overview

Crimson is a specialized utility designed to bridge the gap between legacy bioinformatics text outputs and modern data formats. It eliminates the need for writing custom regex-heavy parsers for every project by providing a unified interface to extract data from tools like FastQC, Picard, and samtools. This skill enables the transformation of "human-readable" logs into machine-readable JSON or YAML, facilitating easier data visualization and quality control aggregation.

## Command Line Usage

The basic syntax for crimson follows a sub-command structure based on the tool output being parsed.

### Basic Conversion
By default, crimson writes JSON to `stdout`.
```bash
crimson picard input.metrics
```

### Saving to File
To save the structured output directly to a file, provide a second argument:
```bash
crimson star-fusion STAR-Fusion.fusion_predictions.abridged.tsv output.json
```

### Tool-Specific Patterns

- **FastQC**: Supports directories, zipped results, or the raw `fastqc_data.txt` file.
  ```bash
  crimson fastqc path/to/fastqc_results.zip
  ```
- **Samtools**: Specifically handles the `flagstat` output.
  ```bash
  samtools flagstat input.bam | crimson flagstat -
  ```
- **Picard/STAR/VEP**: Supports custom line separators if the input file uses non-POSIX endings.
  ```bash
  crimson picard input.metrics --input-linesep '\r\n'
  ```

## Python Library Integration

For complex workflows, use crimson as a library to get a Python dictionary directly.

```python
from crimson import fastqc, picard

# Parse FastQC
fqc_data = fastqc.parse("sample_fastqc.zip")

# Parse Picard metrics
with open("sample.metrics") as f:
    picard_data = picard.parse(f)
```

## Supported Tools and Parsers

| Sub-command | Source Tool | Supported Formats / Notes |
| :--- | :--- | :--- |
| `fastqc` | FastQC | `.zip`, directories, or `fastqc_data.txt` |
| `flagstat` | samtools | Standard `flagstat` text output |
| `picard` | Picard | Various metrics files (Alignment, InsertSize, etc.) |
| `star` | STAR | `Log.final.out` files |
| `star-fusion` | STAR-Fusion | Hits table (supports v1.6.0 and v1.10) |
| `fusioncatcher` | FusionCatcher | `final-list_candidate_fusion_genes.txt` |
| `vep` | Ensembl VEP | Plain text output (handles empty results) |



## Subcommands

| Command | Description |
|---------|-------------|
| crimson fastqc | Convert FastQC output to JSON |
| crimson flagstat | Crimson flagstat parses samtools flagstat output into structured data. |
| crimson fusioncatcher | Convert FusionCatcher output to a structured format using Crimson. |
| crimson picard | Converts Picard metrics output. |
| crimson star | Converts STAR Log.final.out file. |
| crimson star-fusion | Convert STAR-Fusion output to Crimson format |
| crimson vep | Converts plain text output of Variant Effect Predictor. |

## Reference documentation
- [Crimson README](./references/github_com_bow_crimson_blob_master_README.md)
- [Changelog and Version History](./references/github_com_bow_crimson_blob_master_CHANGELOG.rst.md)