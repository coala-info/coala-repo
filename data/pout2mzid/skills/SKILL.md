---
name: pout2mzid
description: The pout2mzid tool merges Percolator output files with mzIdentML files using a memory-efficient stream parser. Use when user asks to merge Percolator results with mzIdentML files, process large proteomics datasets without exceeding RAM, or integrate statistical metrics into identification results.
homepage: https://github.com/percolator/pout2mzid
---


# pout2mzid

## Overview
The `pout2mzid` tool is a specialized utility designed to merge Percolator output (`.pout`) with existing mzIdentML files. Unlike many XML processors that load entire files into memory, `pout2mzid` utilizes a stream parser, making it suitable for processing very large datasets that would otherwise exceed system RAM. It is primarily used in proteomics workflows to finalize identification results with high-confidence statistical metrics.

## Usage Instructions

### Basic Command Structure
The tool typically requires an input Percolator file and a target mzIdentML file. It can output to a specific file or stream directly to standard output for piping into other tools.

### Common Patterns
- **File-to-File Processing**: Specify the input Percolator results and the base mzIdentML file to generate an enriched version.
- **Standard Output**: Use the tool's ability to write to `stdout` when building automated pipelines where the resulting `.mzid` is immediately consumed by another process or compressed.
- **Decoy Filtering**: Utilize the decoy status flags to filter out or specifically handle decoy hits during the integration process.

### Expert Tips
- **Memory Management**: Because the tool uses a stream parser, you do not need to provision massive amounts of RAM even for files containing hundreds of thousands of PSMs.
- **Directory Processing**: The tool supports processing multiple files via input and output directory specifications, which is more efficient than manual loops for large batches.
- **Metadata Preservation**: The tool is designed to adhere to the mzIdentML standard, ensuring that the resulting files remain compatible with downstream analysis software and repositories.
- **Parameter Mapping**: Note that Percolator parameters are often mapped as `userParam` elements within the mzIdentML structure to ensure all scoring metadata is preserved.

## Reference documentation
- [Main Repository and README](./references/github_com_percolator_pout2mzid.md)
- [Project Wiki Overview](./references/github_com_percolator_pout2mzid_wiki.md)