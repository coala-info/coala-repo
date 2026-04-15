---
name: isatab2json
description: Converts ISA-Tab formatted data files into JSON format. Use when user asks to convert ISA-Tab data to JSON.
homepage: https://github.com/bio-agents/isatab2json_docker
metadata:
  docker_image: "biocontainers/isatab2json:phenomenal-v0.10.0_cv0.6.1.69"
---

# isatab2json

isatab2json/
├── SKILL.md
└── references/
    └── github_com_bio-agents_isatab2json_docker.md

---
name: isatab2json
description: Converts ISA-Tab formatted data files into JSON format. Use when Claude needs to process and transform ISA-Tab datasets into a structured JSON representation for easier programmatic access and analysis.
---
## Overview
The `isatab2json` tool is designed to convert data structured in the ISA-Tab format into a more accessible JSON format. This is particularly useful for bioinformatics and other research data management workflows where ISA-Tab is used to describe experiments and their associated data files. By converting to JSON, the data becomes easier to parse, query, and integrate with other tools and databases.

## Usage Instructions

The primary function of `isatab2json` is to take ISA-Tab files as input and produce JSON output.

### Basic Conversion

The most common usage involves specifying the input ISA-Tab directory and an output JSON file.

```bash
isatab2json --input <path_to_isa_tab_directory> --output <output_json_file.json>
```

-   `--input`: This argument points to the directory containing your ISA-Tab files (e.g., `*.txt` files and associated data files).
-   `--output`: This argument specifies the path and filename for the generated JSON output.

### Handling Specific ISA-Tab Components

`isatab2json` can selectively convert specific parts of the ISA-Tab structure.

#### Converting Study Files Only

To convert only the study-level information (e.g., `i_study.txt`), use the `--study` flag.

```bash
isatab2json --input <path_to_isa_tab_directory> --output <study.json> --study
```

#### Converting Assay Files Only

To convert only the assay-level information (e.g., `a_assayname.txt`), use the `--assay` flag.

```bash
isatab2json --input <path_to_isa_tab_directory> --output <assay.json> --assay
```

#### Converting Sample Files Only

To convert only the sample-level information (e.g., `s_samples.txt`), use the `--sample` flag.

```bash
isatab2json --input <path_to_isa_tab_directory> --output <sample.json> --sample
```

### Advanced Options

#### Verbose Output

For more detailed logging during the conversion process, use the `--verbose` flag.

```bash
isatab2json --input <path_to_isa_tab_directory> --output <output.json> --verbose
```

### Expert Tips

*   **Directory Structure**: Ensure your ISA-Tab files are organized correctly within the specified input directory. This typically includes `i_study.txt`, `s_*.txt` (for samples), and `a_*.txt` (for assays), along with any associated data files.
*   **File Naming**: The tool expects standard ISA-Tab naming conventions for files.
*   **Dependencies**: Ensure `isatab2json` is installed and accessible in your environment. It is often available via bioconda.
*   **Error Handling**: If conversion fails, check the input directory for malformed ISA-Tab files or missing data files. The `--verbose` flag can provide more insight into the cause of errors.

## Reference documentation
- [isatab2json_docker](references/github_com_bio-agents_isatab2json_docker.md)