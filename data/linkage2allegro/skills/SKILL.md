---
name: linkage2allegro
description: This tool converts genetic linkage files from Merlin, Simwalk, Genehunter, and Swiftlink formats into Allegro format. Use when user asks to convert genetic linkage data from one of the supported input formats to Allegro format.
homepage: https://github.com/BioTools-Tek/linkage-converter
metadata:
  docker_image: "quay.io/biocontainers/linkage2allegro:2017.3--py35_0"
---

# linkage2allegro

linkage2allegro/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_linkage2allegro_overview.md
    └── github_com_mtekman_linkage-converter.md
```

```md
name: linkage2allegro
description: Converts output linkage files from Merlin, Simwalk, Genehunter, and Swiftlink formats into Allegro format. Use when Claude needs to process genetic linkage data that is in one of the supported input formats and requires conversion to the Allegro format for downstream analysis.
---
## Overview

The `linkage2allegro` tool is designed to facilitate the conversion of genetic linkage data files between various common formats and the Allegro format. This is particularly useful in genetic analysis workflows where different software tools produce output in distinct linkage file formats. `linkage2allegro` acts as a bridge, ensuring compatibility and enabling seamless integration of data from tools like Merlin, Simwalk, Genehunter, and Swiftlink into systems that expect Allegro-formatted input.

## Usage Instructions

The `linkage2allegro` tool primarily operates via command-line arguments to specify input files, their formats, and the desired output.

### Core Functionality

The fundamental operation involves specifying the input file, its original format, and the target Allegro format.

**General Command Structure:**

```bash
linkage2allegro --input <input_file> --input_format <format> --output <output_file>
```

### Supported Input Formats

The tool supports conversion from the following linkage file formats:
*   `merlin`
*   `simwalk`
*   `genehunter`
*   `swiftlink`

### Key Command-Line Options

*   `--input <input_file>`: Path to the input linkage file.
*   `--input_format <format>`: Specifies the format of the input file. Must be one of the supported formats (e.g., `merlin`, `simwalk`, `genehunter`, `swiftlink`).
*   `--output <output_file>`: Path where the converted Allegro-formatted file will be saved.
*   `--help`: Displays a help message with all available options.

### Example Usage

**1. Converting a Merlin file to Allegro:**

```bash
linkage2allegro --input my_merlin_data.txt --input_format merlin --output my_allegro_data.txt
```

**2. Converting a Genehunter file to Allegro:**

```bash
linkage2allegro --input genehunter_output.dat --input_format genehunter --output allegro_converted.dat
```

### Expert Tips

*   **Verify Input Format:** Always double-check the exact format of your input linkage file. Incorrectly specifying `--input_format` is a common source of errors.
*   **Output File Naming:** Choose descriptive names for your output files to easily identify their content and format.
*   **Error Handling:** If the conversion fails, carefully review the error messages provided by the tool. They often indicate issues with the input file's integrity or format.
*   **File Paths:** Ensure that all file paths provided to the `--input` and `--output` arguments are correct and accessible.

## Reference documentation

- [Anaconda.org - linkage2allegro Overview](./references/anaconda_org_channels_bioconda_packages_linkage2allegro_overview.md)
- [GitHub - linkage-converter](./references/github_com_mtekman_linkage-converter.md)