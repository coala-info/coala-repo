---
name: eido
description: Eido is the PEP (Portable Encapsulated Project) validation and conversion tool from pepkit. It checks sample metadata against a JSON Schema-based PEP schema, prints a summary of a project or its samples, and converts a PEP into other formats with filters. Use when user asks to validate a PEP or sample sheet against a schema, inspect the samples of a PEP, convert a PEP to CSV or YAML, or write a schema that states the sample attributes a pipeline needs.
homepage: https://github.com/pepkit/eido
metadata:
  docker_image: "biocontainers/eido:0.1.9_cv2"
---

# eido

## Overview

Eido works on sample metadata stored in the PEP format. A PEP is a YAML project configuration file plus a sample table (CSV) and optional subsample tables. Eido does two jobs. First, it validates a PEP against a schema. The schema uses the JSON Schema vocabulary with a few extra keys for bioinformatics projects. Second, it converts a PEP into another output format with "filters". Pipeline authors write a schema that lists the sample attributes their tool needs. Users then run `eido validate` to check their sample sheet before they start the pipeline. Eido reads PEPs with the `peppy` Python package.

## Installation and Setup

Install with pip or conda:

```bash
pip install eido
conda install -c conda-forge eido
```

Check the install with `eido -h`. The Docker image `biocontainers/eido:0.1.9_cv2` holds eido 0.1.9.

## The PEP format in brief

A minimal PEP has a configuration file and a sample table:

```yaml
# project_config.yaml
pep_version: 2.0.0
sample_table: sample_table.csv
subsample_table: subsample_table.csv   # optional
```

```text
sample_name,protocol,file
frog_1,anySampleType,data/frog1_data.txt
frog_2,anySampleType,data/frog2_data.txt
```

- Paths in the configuration file are relative to the configuration file. Keep the sample and subsample tables in the same folder as the configuration (the CWL wrappers stage them there through the `pep_files` input).
- Samples are identified by the `sample_name` column. Use `--st-index` to pick a different column.
- A subsample table adds several values for one attribute (for example several FASTQ files for one sample).

## Command Line Usage

Eido 0.1.9 has three subcommands: `validate`, `inspect` and `convert`. Each takes the PEP configuration file as its positional argument. Global options are `--verbosity {0,1,2,3}`, `--logging-level` and `--dbg`.

### Validate a PEP against a schema

```bash
eido validate project_config.yaml -s schema.yaml
eido validate project_config.yaml -s http://schema.databio.org/pep/2.0.0.yaml -e
```

- `-s`, `--schema`: the schema file (local path or URL). Required.
- `-e`, `--exclude-case`: print only the short error message, not the failing object. Use it for large PEPs.
- `-n`, `--sample-name`: validate only one sample, given by name or index.
- `-c`, `--just-config`: validate only the project configuration, not the samples.
- `--st-index`: sample table column that holds the sample names.

On success eido logs `Validation successful` on standard error and exits with 0. On failure it raises `EidoValidationError` ("Validation unsuccessful. N errors found.") and exits with a non-zero code.

### Inspect a PEP

```bash
eido inspect project_config.yaml
eido inspect project_config.yaml -n frog_1 frog_2 -l 5
```

- Without options it prints the project name, the number of samples, the first sample names and the configuration sections.
- `-n`, `--sample-name`: print the attributes of the named samples.
- `-l`, `--attr-limit`: number of sample attributes to show (default 10).

### Convert a PEP with filters

```bash
eido convert --list                                 # list the available filters
eido convert -f yaml-samples -d                     # describe one filter
eido convert project_config.yaml -f csv             # processed sample table to stdout
eido convert project_config.yaml -f yaml-samples -p samples=samples.yaml
```

- `-f`, `--format`: name of the filter.
- `-l`, `--list`: list the installed filters. Eido 0.1.9 ships `basic`, `csv`, `yaml` and `yaml-samples`.
- `-d`, `--describe`: print the documentation of the filter given with `-f`.
- `-a`, `--args`: pass `key=value` arguments to the filter function.
- `-p`, `--paths`: write results to files as `key=path` pairs. The key is the name of a result returned by the filter: `project` for `basic` and `yaml`, `samples` for `csv` and `yaml-samples`.
- `-n`, `--sample-name`: listed in the help, but the 0.1.9 convert code ignores it; all samples are converted.

The filter output always goes to standard output too. Newer eido releases also have an `eido filters` command that lists the filters; in 0.1.9 use `eido convert --list`.

## Writing a schema

An eido schema is a JSON Schema document written in YAML. It has a `config` section for project attributes and a `samples` section for sample attributes:

```yaml
description: Schema for an example pipeline
imports:
  - http://schema.databio.org/pep/2.0.0.yaml
properties:
  samples:
    type: array
    items:
      type: object
      properties:
        sample_name:
          type: string
        read1:
          type: string
          description: "FASTQ file for read 1"
        read_type:
          type: string
          enum: ["SINGLE", "PAIRED"]
      required:
        - sample_name
        - read1
      required_files:
        - read1
      files:
        - read1
        - read2
required:
  - samples
```

- `imports`: schemas to validate first. Start from the generic PEP schema `http://schema.databio.org/pep/2.0.0.yaml`.
- `required`: attributes that must be present.
- `required_files` and `files`: attributes that point to input files (required and optional). Eido 0.1.9 reads these key names; newer documentation calls the required list `tangible` and the optional list `sizing`. The CLI `eido validate` checks the JSON Schema rules only. The file-existence check runs from the Python function `eido.validate_inputs`, which `looper` uses.
- String, number and boolean sample attributes also accept a list of values. This lets subsample tables pass validation.

## Expert Tips and Best Practices

- Validate every PEP against the generic schema `http://schema.databio.org/pep/2.0.0.yaml` first. Then validate against the pipeline schema.
- Use `-e` on large projects. Without it each error prints the whole failing sample or project.
- Use `-c` to check only the configuration while you are still filling in the sample table.
- Schema URLs need network access. In a container without network, pass a local copy of the schema and of every schema in its `imports` list.
- Custom filters are Python functions that take a `peppy.Project` and `**kwargs` and return a dict of strings. Register them under the `pep.filters` entry point in `setup.py`. Filters are an experimental feature.
- Example schemas live at https://schema.databio.org (generic PEP 2.0.0, PEPPRO, PEPATAC, refgenie build).

## Reference documentation
- [eido GitHub Repository and Introduction](./references/github_com_pepkit_eido.md)
- [eido Command Line Usage](./references/pep_databio_org_eido_cli.md)
- [eido Filters and Custom Filters](./references/pep_databio_org_eido_filters.md)
- [How to Write a PEP Schema](./references/pep_databio_org_eido_writing_a_schema.md)
