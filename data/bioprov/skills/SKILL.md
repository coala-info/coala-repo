---
name: bioprov
description: BioProv is a specialized tool designed to automate the capture of provenance in bioinformatics.
homepage: https://github.com/vinisalazar/BioProv
---

# bioprov

## Overview
BioProv is a specialized tool designed to automate the capture of provenance in bioinformatics. It transforms standard command-line executions into structured records that describe the relationships between users, software, and biological data. Use this skill when you need to bridge the gap between running bioinformatics tools and maintaining a rigorous record of how data was processed, ensuring that every output is linked to its specific inputs and parameters.

## Command Line Interface (CLI)
The `bioprov` CLI provides access to preset workflows and database management.

### Project Management
- **List Projects**: `bioprov -l` displays all projects currently stored in the BioProv database.
- **Check Configuration**: `bioprov --show_config` reveals the path to the active configuration file.
- **Database Location**: `bioprov --show_db` shows where the provenance records are stored.
- **Maintenance**: `bioprov --clear_db` removes all records from the database.

### Running Preset Workflows
BioProv includes built-in support for common tools. Use the following syntax:
`bioprov {workflow_name} [options]`

Available presets:
- `genome_annotation`: Runs annotation pipelines (requires Prodigal).
- `blastn`: Executes nucleotide BLAST searches with provenance tracking.
- `kaiju`: Performs taxonomic classification.

## Python API Best Practices
For custom workflows, use the Python library to define granular relationships between data and processes.

### Sample and File Definition
```python
import bioprov as bp

# Initialize sample and associate files
sample = bp.Sample("sample_id")
genome = bp.File("path/to/genome.fasta", tag="genome")
sample.add_files(genome)
```

### Program Execution
Define programs by mapping parameters to sample files to ensure the library tracks the file dependency:
```python
output = bp.File("output.tsv", tag="blast_out")
blast = bp.Program("blastn", params={
    "-query": sample.files["genome"],
    "-db": "reference_db",
    "-out": output
})
sample.add_programs(blast)
sample.run_programs()
```

### Batch Loading
Import metadata directly from tabular data to create projects quickly:
- **From CSV**: `project = bp.read_csv("metadata.tsv", sep="\t", sequencefile_cols="assembly")`
- **From Pandas**: `project = bp.from_df(df, sequencefile_cols="column_name")`

## Provenance Export and Visualization
Once a project is complete, generate formal provenance documents for publication or auditing:
- **JSON Persistence**: `project.to_json()` saves the project state for later reloading.
- **Human-Readable PROV**: `prov = bp.BioProvDocument(project); prov.write_provn()`
- **Graphical Lineage**: `prov.dot.write_pdf()` creates a visual graph of the workflow steps and data flow.

## Expert Tips
- **Dependency Check**: Ensure `prodigal` is installed in your environment if you are using the `genome_annotation` preset or testing the library, as it is a core requirement for those modules.
- **DataFrames**: Use `project.to_csv()` to export your sample attributes and associated file paths back into a spreadsheet format for standard statistical analysis.
- **Tagging**: Always use descriptive tags (e.g., "raw_reads", "assembly") when adding files to a sample; this makes parameter mapping in `bp.Program` much more intuitive.

## Reference documentation
- [BioProv Overview](./references/anaconda_org_channels_bioconda_packages_bioprov_overview.md)
- [BioProv GitHub Repository](./references/github_com_vinisalazar_BioProv.md)