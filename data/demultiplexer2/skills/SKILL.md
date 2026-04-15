---
name: demultiplexer2
description: This tool sorts raw Illumina sequencing data into individual sample files by identifying inline barcode sequences using Excel-based configuration files. Use when user asks to create a primer set, define a tagging scheme, or demultiplex sequencing reads based on tags.
homepage: https://github.com/DominikBuchner/demultiplexer2
metadata:
  docker_image: "quay.io/biocontainers/demultiplexer2:1.1.6--pyhdfd78af_0"
---

# demultiplexer2

## Overview

The demultiplexer2 skill enables the efficient sorting of raw Illumina sequencing data into individual sample files based on inline barcode sequences. Unlike tools that rely solely on header-based demultiplexing, this tool identifies tags within the reads themselves. The workflow is uniquely centered around Excel-based configuration files, allowing researchers to manage complex primer and tagging metadata in a familiar spreadsheet format before running the high-performance Python-based demultiplexing engine.

## Core Workflow

### 1. Initialize the Primer Set
The first step generates an Excel template to define your laboratory setup.

```bash
demultiplexer2 create_primerset --name [PrimersetName] --n_primers [Count]
```

**Expert Tips:**
* **Excel Structure:** The generated file contains three sheets: *General Information*, *Forward Tags*, and *Reverse Tags*.
* **Data Entry:** You must manually fill in the tag names and sequences in the Excel file before proceeding.
* **Storage:** The tool automatically saves a copy in its internal data directory for future reference.

### 2. Define the Tagging Scheme
This step links your raw sequencing files to the specific samples defined in your primer set.

```bash
demultiplexer2 create_tagging_scheme --name [SchemeName] --data_dir [InputPath] --primerset_path [PathToExcel]
```

**Expert Tips:**
* **Input Directory:** Ensure the `data_dir` contains all the gzipped FASTQ files (`.fastq.gz`) you intend to process.
* **Sample Mapping:** Open the resulting Excel file and map the input file pairs to your desired sample names. This mapping is critical for the final output filenames.

### 3. Execute Demultiplexing
Run the final algorithm to sort the reads.

```bash
demultiplexer2 demultiplex --primerset_path [PathToExcel] --tagging_scheme_path [PathToSchemeExcel] --output_dir [OutputPath]
```

**Expert Tips:**
* **Output Format:** The tool produces gzipped FASTQ files for each sample identified in the tagging scheme.
* **Read Filtering:** Reads that do not match the provided tag sequences are automatically discarded.
* **Monitoring:** The CLI provides real-time statistics showing the percentage of reads successfully assigned to tags (e.g., "16.86 % sequences matched").

## Best Practices
* **Sequence Accuracy:** Double-check tag sequences in the Excel sheets for typos or orientation issues (Forward vs. Reverse) as the tool relies on exact matches.
* **File Naming:** Ensure your raw FASTQ files follow standard Illumina naming conventions (e.g., `_r1` and `_r2`) to help the tagging scheme generator pair them correctly.
* **Updates:** If the tool behavior seems inconsistent, ensure you are on the latest version using `pip install --upgrade demultiplexer2`.



## Subcommands

| Command | Description |
|---------|-------------|
| demultiplexer2 create_primerset | Create a primerset |
| demultiplexer2 create_tagging_scheme | Create a tagging scheme for demultiplexing. |
| demultiplexer2 demultiplex | Demultiplexes sequencing reads based on primer and tagging schemes. |

## Reference documentation
- [Demultiplexer2 README](./references/github_com_DominikBuchner_demultiplexer2_blob_main_README.md)
- [Tool Metadata and Dependencies](./references/github_com_DominikBuchner_demultiplexer2_blob_main_setup.py.md)