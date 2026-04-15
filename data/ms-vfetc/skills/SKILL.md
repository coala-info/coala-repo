---
name: ms-vfetc
description: The ms-vfetc tool standardizes and converts proprietary mass spectrometry feature export files into a unified format for downstream analysis. Use when user asks to convert vendor-specific mass spectrometry data, merge multiple experimental batches, or normalize sample naming conventions across different software platforms.
homepage: https://github.com/leidenuniv-lacdr-abs/ms-vfetc
metadata:
  docker_image: "biocontainers/ms-vfetc:phenomenal-v0.6_cv1.1.27"
---

# ms-vfetc

## Overview
The `ms-vfetc` (Mass Spectrometry Vendor Feature Export Tool Converter) is a utility designed to standardize the output from various proprietary mass spectrometry software packages. It resolves the common issue of inconsistent data formats between vendors by providing a unified conversion layer. This tool is particularly effective when you need to aggregate data from multiple experimental batches or ensure that sample naming conventions (including aliquots, replicates, and internal standards) remain consistent for downstream statistical analysis.

## Command Line Usage

The tool is primarily executed via PHP or Docker. The core logic requires two main parameters: `files` (input) and `outputfile` (destination).

### Native PHP Execution
If running in an environment with PHP installed, use the following pattern:

```bash
php -f src/vfetc.php files=<input_path_1>,<input_path_2> outputfile=<output_path>
```

### Docker Execution
For containerized environments, mount your data directory to access local files:

```bash
docker run -it --rm -v /path/to/local/data:/data vfetc files=/data/vendor_export.txt outputfile=/data/converted_results.txt
```

## Best Practices and Patterns

### Handling Multiple Batches
To merge multiple export files into a single standardized output, provide a comma-separated list to the `files` argument.
*   **Example**: `files=batch1.txt,batch2.txt,batch3.txt`

### Working with Compressed Data
The tool supports processing batches provided as a zipped archive. This is particularly useful when dealing with large datasets or when integrated into platforms like Galaxy where `.dat` files may represent zip archives.

### Sample Identification Logic
*   **Unique Naming**: The tool automatically appends sample types (e.g., QC, Blank, Cal) to the sample name to ensure uniqueness across batches.
*   **Internal Standards (ISTD)**: If an internal standard name is not explicitly provided in the source, the tool will attempt to generate one using the pattern `samplename_ISTD`.
*   **Replicates**: The converter extracts injection and replicate information to populate specific columns, moving away from generic sample numbering.

### Vendor-Specific Notes
The tool includes detection logic for:
*   **Agilent**: Processes standard batch exports.
*   **Sciex**: Includes specific detection and parsing for Sciex-formatted text exports.
*   **Shimadzu**: Supports multi-batch aggregation.
*   **Waters**: Normalizes Waters-specific feature exports.

## Reference documentation
- [Main Repository and Usage Guide](./references/github_com_leidenuniv-lacdr-abs_ms-vfetc.md)
- [Version History and Feature Updates](./references/github_com_leidenuniv-lacdr-abs_ms-vfetc_tags.md)