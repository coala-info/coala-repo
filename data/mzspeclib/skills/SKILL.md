---
name: mzspeclib
description: "This tool handles the creation, validation, and manipulation of mzSpecLib spectral library files. Use when user asks to create mzSpecLib spectral libraries, validate mzSpecLib spectral libraries, or convert spectral libraries to the mzSpecLib format."
homepage: https://github.com/HUPO-PSI/mzSpecLib
---

# mzspeclib

yaml
name: mzspeclib
description: |
  Handles the creation, validation, and manipulation of mzSpecLib spectral library files.
  Use this skill when you need to work with spectral libraries in the mzSpecLib format,
  such as creating new libraries, validating existing ones, or converting between formats
  (if supported by the tool). This skill is specifically for the mzSpecLib command-line tool.
```
## Overview
The mzspeclib tool is designed for managing spectral libraries in the HUPO-PSI mzSpecLib format. It allows users to create, validate, and potentially convert spectral library data. This skill is useful when you need to interact with spectral libraries for mass spectrometry data analysis, particularly in proteomics research, and require the use of the mzSpecLib command-line interface.

## Usage Instructions

The `mzspeclib` tool is primarily used via its command-line interface. The core functionalities revolve around creating, validating, and potentially converting spectral library files.

### Installation

Install mzspeclib via conda:
```bash
conda install bioconda::mzspeclib
```

### Core Commands and Patterns

The `mzspeclib` tool's functionality is accessed through subcommands. While the exact commands and their options may evolve, common patterns involve specifying input files, output files, and validation or conversion targets.

**General Command Structure:**

```bash
mzspeclib <command> [options] <input_file> [output_file]
```

**Key Operations:**

*   **Creating a spectral library:** This typically involves providing raw spectral data or a source that can be converted into the mzSpecLib format.
    *   *Example (hypothetical, based on common tool patterns):*
        ```bash
        mzspeclib create --input my_spectra.mzML --output my_library.mzspec
        ```
        This command would take an input file (e.g., in mzML format) and convert it into the mzSpecLib format.

*   **Validating a spectral library:** Ensure that an existing mzSpecLib file conforms to the standard.
    *   *Example:*
        ```bash
        mzspeclib validate --file my_library.mzspec
        ```
        This command checks the integrity and format compliance of the specified mzSpecLib file.

*   **Converting between formats:** If the tool supports conversion from other common spectral library formats (e.g., MSP, MGF) to mzSpecLib, or vice-versa.
    *   *Example (hypothetical):*
        ```bash
        mzspeclib convert --from msp --to mzspec --input old_library.msp --output new_library.mzspec
        ```

### Expert Tips

*   **Consult the documentation:** For the most up-to-date command-line options and specific subcommand usage, always refer to the official `mzspeclib` documentation or use the `--help` flag for the tool and its subcommands.
*   **Input/Output Formats:** Be mindful of the supported input and output file formats for creation and conversion operations. The tool's primary focus is the mzSpecLib format itself.
*   **Validation is Crucial:** Always validate your mzSpecLib files after creation or modification to ensure data integrity and compatibility with downstream tools.



## Subcommands

| Command | Description |
|---------|-------------|
| mzspeclib convert | Convert a spectral library from one format to another. If `outpath` is `-`, instead of writing to file, data will instead be sent to STDOUT. |
| mzspeclib describe | Produce a minimal textual description of a spectral library. |
| mzspeclib index | Build an external on-disk SQL-based index for the spectral library |
| mzspeclib validate | Semantically and structurally validate a spectral library. |

## Reference documentation
- [Overview of mzspeclib](https://anaconda.org/bioconda/mzspeclib)
- [mzSpecLib GitHub Repository](https://github.com/HUPO-PSI/mzSpecLib)