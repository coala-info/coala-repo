---
name: json2isatab
description: "This tool converts ISA-JSON data into the ISA-Tab format. Use when user asks to convert ISA-JSON to ISA-Tab."
homepage: https://github.com/phnmnl/container-json2isatab
---


# json2isatab

---
## Overview
The `json2isatab` tool is designed to convert data from the ISA-JSON format into the ISA-Tab format. This is particularly useful for researchers and data managers who need to standardize their experimental metadata into a tabular structure that is compatible with various bioinformatics tools and databases.

## Usage Instructions

The primary function of `json2isatab` is to take an ISA-JSON file as input and produce a set of ISA-Tab files.

### Basic Conversion

To convert a single ISA-JSON file to ISA-Tab format, use the `run_json2tab.py` script (or the equivalent command within a Docker container).

**Command Structure:**

```bash
python run_json2tab.py <path_to_isajson_file>
```

**Example:**

If your ISA-JSON file is named `study.json`, the command would be:

```bash
python run_json2tab.py study.json
```

This will generate multiple `.tsv` files in the current directory, representing the ISA-Tab structure (e.g., `samples.tsv`, `assays.tsv`, `investigation.tsv`, etc.).

### Using the Docker Image

If you are using the `json2isatab` Docker image, the command structure is similar:

```bash
docker run docker-registry.phenomenal-h2020.eu/phnmnl/json2isatab <path_to_isajson_file>
```

**Example:**

```bash
docker run docker-registry.phenomenal-h2020.eu/phnmnl/json2isatab study.json
```

This command will execute the conversion within the container and output the ISA-Tab files to your current directory (assuming appropriate volume mounting if needed for persistent output).

### Expert Tips

*   **Input File Validation:** Ensure your input ISA-JSON file is valid according to the ISA-JSON schema before running the conversion. Invalid JSON may lead to conversion errors.
*   **Output Directory:** By default, the generated ISA-Tab files are placed in the current working directory. If you need to direct the output to a specific directory, you may need to adjust your command or Docker volume mappings.
*   **File Naming:** The output files will be named based on the ISA-Tab conventions (e.g., `investigation.tsv`, `study.tsv`, `sample.tsv`, `assay.tsv`, etc.).
*   **Dependencies:** If running directly via Python, ensure you have the necessary ISA API library installed (`pip install isa-api`). The Docker image pre-packages these dependencies.

## Reference documentation
- [ISA-JSON to ISA-Tab Converter](./references/github_com_phnmnl_container-json2isatab.md)