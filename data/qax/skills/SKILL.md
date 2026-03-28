---
name: qax
description: qax is a high-performance utility for inspecting, extracting, and managing Qiime2 artifacts and visualizations without requiring the full Qiime2 framework. Use when user asks to list artifact metadata, extract raw data files, view internal content, generate provenance graphs, collect BibTeX citations, or create visualization artifacts from HTML directories.
homepage: https://github.com/telatin/qax
---

# qax

## Overview

qax (Qiime Artifact eXtractor) is a high-performance, standalone utility designed to interface with Qiime2 data formats. It treats artifacts as structured archives, allowing for rapid metadata inspection and data retrieval. It is significantly faster than the native Qiime2 CLI for metadata tasks and is ideal for integrating Qiime2 outputs into general-purpose bioinformatics pipelines that do not support the .qza format natively.

## Core Workflows

### Inspecting Artifacts
Use the `list` command (default) to view the ID, Type, and Format of one or multiple artifacts.
- List all artifacts in a directory: `qax list input/*.qza`
- Show UUIDs and clean formatting: `qax list -b -u *.qza`
- Find a specific artifact by its internal ID: `qax list --find [UUID] .`

### Extracting Data
Use `extract` (or `x`) to retrieve the raw data files stored inside an artifact.
- Extract to a specific directory: `qax extract -o ./output_folder/ data.qza`
- If an artifact contains multiple files, qax automatically creates a subdirectory to prevent file clutter.

### Viewing Content Directly
Use `view` to stream the content of internal files to the terminal without manual extraction.
- Count sequences in a FASTA artifact: `qax view rep-seqs.qza | grep -c '>'`
- Inspect the first few lines of a feature table: `qax view table.qza | head`

### Managing Provenance and Citations
- **Generate Provenance Graphs**: Create a Graphviz DOT file for publication-grade visualization: `qax provenance -o workflow.dot artifact.qza`
- **Summarize History**: View a text summary of how an artifact was created: `qax provenance artifact.qzv`
- **Collect Bibliography**: Aggregate all software citations from multiple artifacts into a single BibTeX file: `qax citations project_files/*.qza > bibliography.bib`

### Creating Visualizations
Convert a directory containing an `index.html` and associated assets into a Qiime2 visualization artifact:
- `qax make -o custom_report.qzv ./html_report_dir/`

## Expert Tips
- **Performance**: Use qax for metadata listing in loops; it is roughly 100x faster than `qiime tools inspect`.
- **Automation**: Since qax does not require a Conda environment or the Qiime2 framework, use it in lightweight Docker containers or CI/CD runners for data validation.
- **File Selection**: When using `view` on artifacts with multiple files, run `qax view artifact.qza` without arguments to see a list of available internal paths, then specify the desired file.



## Subcommands

| Command | Description |
|---------|-------------|
| citations | Retrieve BibTeX citations from input files. |
| extract | Extract the artifact data. If multiple files are present, a new directory will be created (artifact name), otherwise the artifact name will be used to rename the single file (unless -k is specified). |
| list | List artifacts |
| make | Create a Qiime Visualization Artifact from a directory with files. By default, will create a "Visualization", thus requiring an "index.html" file in the root of the input directory. |
| provenance | Print ancestry of an artifact |
| view | View (a la `cat`) the content of data files in one artifact. |

## Reference documentation
- [Qiime Artifact eXtractor Overview](./references/github_com_telatin_qax_blob_main_README.md)
- [General Usage Guide](./references/telatin_github_io_qax_usage.md)
- [List Command Details](./references/github_com_telatin_qax_blob_main_pages_list.md)
- [Extract Command Details](./references/github_com_telatin_qax_blob_main_pages_extract.md)
- [Provenance and Graphing](./references/github_com_telatin_qax_blob_main_pages_provenance.md)