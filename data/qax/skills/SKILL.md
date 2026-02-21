---
name: qax
description: The Qiime2 Artifact eXtractor (`qax`) is a high-performance utility designed to provide fast, lightweight access to the contents of Qiime2 artifacts.
homepage: https://github.com/telatin/qax
---

# qax

## Overview
The Qiime2 Artifact eXtractor (`qax`) is a high-performance utility designed to provide fast, lightweight access to the contents of Qiime2 artifacts. While Qiime2 typically requires a large environment and specific versions to read its data, `qax` allows you to list properties, extract raw data (like FASTA or BIOM files), and view provenance information directly from the command line. It is significantly faster than the native Qiime2 CLI for metadata operations and is compatible across different Qiime2 release versions.

## Core Command Patterns

### Listing Artifact Properties
The `list` command is the default behavior. Use it to quickly identify the UUID, type, and format of one or more artifacts.
- **Basic list**: `qax input_file.qza`
- **Batch list**: `qax input/*.qza`
- **Clean output for scripts**: Use `-b` (brief) or `-u` (unformatted) to make the output easier to parse with `awk` or `cut`.

### Data Extraction
Use `extract` (or the alias `x`) to retrieve the underlying data files from the compressed artifact.
- **Extract to current directory**: `qax extract -o ./ feature_table.qza`
- **Extract visualization**: `qax x -o ./ taxonomy_plot.qzv` (This creates a directory containing the HTML/JS assets).

### Terminal Inspection
The `view` command prints the content of the data file within the artifact directly to STDOUT. This is powerful for piping into other CLI tools.
- **Count sequences**: `qax view rep-seqs.qza | grep -c '>'`
- **Peek at a table**: `qax view table.qza | head`

### Provenance and Citations
`qax` can reconstruct the history of an artifact or gather all necessary citations for publication.
- **View provenance summary**: `qax provenance artifact.qza`
- **Generate Graphviz dot file**: `qax p -o workflow_graph.dot artifact.qza`
- **Consolidate bibliography**: `qax citations project_files/*.qza > references.bib` (This automatically removes duplicates across multiple artifacts).

### Creating Visualizations
If you have a directory containing a web-based report (with an `index.html`), you can wrap it into a Qiime2 visualization artifact.
- **Create .qzv**: `qax make -o my_report.qzv ./path/to/report_dir/`

## Expert Tips
- **Speed Advantage**: Use `qax` instead of `qiime tools inspect` when working with large numbers of files; it is optimized for speed and does not need to load the Qiime2 framework.
- **Version Independence**: `qax` can often read artifacts created by different Qiime2 versions that might otherwise be incompatible with your current environment.
- **Pipeline Integration**: Use `qax view` to feed sequences directly into aligners or search tools (e.g., `qax view seqs.qza | blastn -db ...`) to avoid creating intermediate temporary files.

## Reference documentation
- [Qiime2 Artifact eXtractor Overview](./references/github_com_telatin_qax.md)
- [qax on Bioconda](./references/anaconda_org_channels_bioconda_packages_qax_overview.md)