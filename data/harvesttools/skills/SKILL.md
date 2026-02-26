---
name: harvesttools
description: "Converts between Gingr files and various standard text formats. Use when user asks to convert Gingr files to other text formats or vice versa."
homepage: https://github.com/marbl/harvest-tools
---


# harvesttools

yaml
name: harvesttools
description: |
  Converts between Gingr files and various standard text formats.
  Use when Claude needs to perform file format conversions for genomic data, specifically involving Gingr files and other common text-based formats.
```
## Overview
HarvestTools is a command-line utility designed for file format conversion, primarily focusing on transforming Gingr files into various standard text formats, and vice-versa. It is part of the Harvest software suite and is useful for bioinformatics workflows that require data manipulation between specialized and general text-based representations.

## Usage Instructions

HarvestTools facilitates the conversion of genomic data files. The primary function is to convert between Gingr format and other standard text formats.

### Core Functionality

The tool's main purpose is file conversion. While specific command-line arguments for conversion types are not explicitly detailed in the provided documentation, the general pattern for such tools involves specifying input file, output file, and the desired conversion type.

**General Command Structure (Inferred):**

```bash
harvesttools --input <input_file> --output <output_file> --format <output_format>
```

or

```bash
harvesttools <input_file> <output_file>
```

**Key Considerations:**

*   **Gingr Files:** HarvestTools is specifically mentioned for its ability to handle Gingr files. If you are working with Gingr files, this tool is likely the correct choice for conversion.
*   **Standard Text Formats:** The tool supports conversion to "various standard text formats." This implies common bioinformatics formats like FASTA, FASTQ, VCF, or BED, though specific support needs to be inferred or tested.
*   **Installation:** HarvestTools can be installed via Conda:
    ```bash
    conda install bioconda::harvesttools
    ```
*   **Source Code:** The source code is available on GitHub, which may be useful for understanding specific conversion capabilities or for building in unique environments.

### Expert Tips

*   **Check Documentation:** For precise command-line options and supported formats, refer to the official documentation or the tool's `--help` flag if available. The provided documentation focuses on the tool's purpose rather than exhaustive CLI arguments.
*   **Version Compatibility:** Be mindful of the version of HarvestTools you are using, as features and supported formats can change between releases. The latest version mentioned is 1.3.
*   **Error Handling:** If encountering errors, especially with specific file types or conversions, consult the GitHub issues page for `marbl/harvest-tools` for potential solutions or to report new issues. Common issues include build failures, protobuf errors, and specific format conversions.

## Reference documentation
- [GitHub Repository](https://github.com/marbl/harvest-tools)
- [Anaconda.org Overview](https://anaconda.org/bioconda/harvesttools)