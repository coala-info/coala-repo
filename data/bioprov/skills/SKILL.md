---
name: bioprov
description: BioProv is a framework that integrates bioinformatics tool execution with formal provenance tracking to ensure reproducibility and auditability. Use when user asks to track execution metadata, wrap command-line tools into Pythonic structures, manage genomic samples, or export workflows as W3C-PROV documents.
homepage: https://github.com/vinisalazar/BioProv
metadata:
  docker_image: "quay.io/biocontainers/bioprov:0.1.23--pyh5e36f6f_0"
---

# bioprov

## Overview

BioProv is a specialized framework that bridges bioinformatics execution with formal provenance standards. It allows you to wrap command-line tools into a Pythonic structure that automatically tracks inputs, outputs, and execution metadata. Use this skill to transition from simple script execution to a structured environment where every file and program run is recorded as part of a W3C-PROV document, ensuring full reproducibility and auditability of genomic analyses.

## Core Workflow Patterns

### 1. Initializing Samples and Files
Always start by defining a `Sample` and associating `File` objects with specific tags. Tags are critical as they are used by programs to identify inputs and outputs.

```python
import bioprov as bp

# Initialize sample
sample = bp.Sample("sample_01")

# Add files with descriptive tags
sample.add_files(bp.File("data/raw_genome.fasta", "genome"))
```

### 2. Executing Programs with Provenance
To run a tool, create a `Program` object. Map the `params` dictionary to the file tags defined in your sample.

```python
# Define output file and add to sample
output_file = bp.File("results/blast_out.tsv", "blast_out")
sample.add_files(output_file)

# Configure and run the program
blastn = bp.Program("blastn", params={
    "-query": sample.files["genome"],
    "-db": "ref_database.fasta",
    "-out": sample.files["blast_out"]
})
sample.add_programs(blastn)
sample.run_programs()
```

### 3. Batch Processing from DataFrames
For large-scale studies, import sample metadata directly from CSV/TSV files using Pandas integration.

```python
# sequencefile_cols maps a column in the CSV to a BioProv File object
project = bp.read_csv("metadata.tsv", sep="\t", sequencefile_cols="assembly_path")

# Access specific samples
first_sample = project['sample_id_001']
```

### 4. Generating Provenance Exports
Once execution is complete, wrap the `Project` in a `BioProvDocument` to export the trace.

```python
# Create the provenance document
prov = bp.BioProvDocument(project)

# Export to human-readable PROV-N
prov.write_provn("workflow_trace.provn")

# Export to PDF visualization (requires pydot)
prov.dot.write_pdf("workflow_graph.pdf")
```

## CLI Usage Best Practices

The `bioprov` command-line tool is used for managing the internal database and running preset workflows.

- **Database Management**: BioProv stores project history in a local TinyDB.
  - `bioprov -l`: List all projects in the database.
  - `bioprov --show_db`: Locate the database file.
  - `bioprov --clear_db`: Reset the environment.
- **Preset Workflows**: Use built-in workflows for common tasks to ensure standard provenance.
  - `bioprov genome_annotation -i input_folder/`: Runs a standard annotation pipeline.
  - `bioprov blastn -i query.fasta -d db.fasta`: Runs BLASTN with automatic tracking.

## Expert Tips

- **Preset Programs**: Instead of defining `bp.Program` from scratch, check `bioprov.programs` for pre-configured tools like `prodigal`, `prokka`, `mafft`, and `muscle`. These have pre-defined parameter mappings.
- **JSON Persistence**: Use `project.to_json()` to save the entire state of your analysis. This can be reloaded later with `bp.from_json()` to resume work or inspect results without re-running.
- **Attribute Tracking**: You can add arbitrary metadata to samples using `sample.attributes["key"] = "value"`. These attributes are included in the final provenance document.



## Subcommands

| Command | Description |
|---------|-------------|
| bioprov_blastn | Align nucleotide data to a reference database with BLASTN. |
| genome_annotation | Genome annotation with Prodigal, Prokka and the COG database. |
| kaiju | Run Kaiju on metagenomic data and create reports for taxonomic ranks. |

## Reference documentation
- [BioProv - W3C-PROV provenance documents for bioinformatics](./references/bioprov_readthedocs_io_en_latest_readme.html.md)
- [Source API Overview](./references/bioprov_readthedocs_io_en_latest_modules.html.md)
- [bioprov.programs package](./references/bioprov_readthedocs_io_en_latest_bioprov.programs.html.md)
- [bioprov.src package (Core Classes)](./references/bioprov_readthedocs_io_en_latest_bioprov.src.html.md)