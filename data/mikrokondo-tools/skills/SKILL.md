---
name: mikrokondo-tools
description: This tool provides utilities to manage sample sheets and download databases for the mikrokondo pipeline. Use when user asks to download databases, generate sample sheets, or manage mikrokondo pipeline data preparation.
homepage: https://pypi.org/project/mikrokondo-tools
metadata:
  docker_image: "quay.io/biocontainers/mikrokondo-tools:0.0.1rc0--pyhdfd78af_0"
---

# mikrokondo-tools

A collection of utilities to simplify the use of the mikrokondo pipeline.
  Use this skill when you need to manage sample sheets, download necessary databases, or interact with the mikrokondo pipeline's data preparation steps.
  This skill is particularly useful for bioinformatics workflows involving microbial genomics.
---
## Overview

The `mikrokondo-tools` skill provides a command-line interface for managing data and sample sheets required for the mikrokondo pipeline. It allows users to download essential databases and generate or validate sample sheets from raw sequencing data, streamlining the initial setup for microbial genomics analyses.

## Usage

The `mikrokondo-tools` command-line interface offers two primary commands: `download` and `samplesheet`.

### Downloading Databases

The `download` command allows you to fetch necessary external files for mikrokondo.

**Available files to download:**
*   `gtdb-sketch`
*   `gtdb-shigella`
*   `dehost`
*   `kraken-std`
*   `bakta-light`
*   `bakta-full`

**Command structure:**

```bash
mikrokondo-tools download --file <file_name> --output <output_directory>
```

**Example:** To download the `bakta-light` database to a directory named `databases`:

```bash
mikrokondo-tools download --file bakta-light --output databases
```

**Note:** This command only downloads the files; it does not perform any extraction or unzipping.

### Generating Sample Sheets

The `samplesheet` command helps create and validate sample sheets from a directory containing Next-Generation Sequencing (NGS) data.

**Command structure:**

```bash
mikrokondo-tools samplesheet <sample_directory> --output-sheet <output_sheet_path> --read-1-suffix <suffix_r1> --read-2-suffix <suffix_r2> --schema-input <schema_json_path>
```

**Key Options:**

*   `<sample_directory>`: The directory containing your NGS data files.
*   `--output-sheet` (`-o`): The path to the file where the generated sample sheet will be saved. This directory must exist.
*   `--read-1-suffix` (`-1`): A suffix used to identify read 1 files (default: `_R1_`).
*   `--read-2-suffix` (`-2`): A suffix used to identify read 2 files (default: `_R2_`).
*   `--schema-input` (`-s`): An optional path to a `schema_input.json` file. If not provided, the tool will attempt to download the latest schema from the main mikrokondo repository. This is useful for offline usage or when using older pipeline versions.

**Example:** To generate a sample sheet from the directory `~/ngs_data` and save it as `~/sample_sheet.csv`, assuming read files have suffixes `_r1.fastq.gz` and `_r2.fastq.gz`:

```bash
mikrokondo-tools samplesheet ~/ngs_data -o ~/sample_sheet.csv -1 _r1.fastq.gz -2 _r2.fastq.gz
```

### Expert Tips

*   **Always specify an output directory** for downloads to keep your project organized.
*   **Verify read suffixes** carefully to ensure accurate sample sheet generation. Mismatched suffixes are a common source of errors.
*   **Consider downloading the `schema_input.json`** beforehand if you anticipate network issues or need to ensure reproducibility with a specific schema version.
*   The `samplesheet` command is designed to be robust and will update with the latest pipeline schema by default, ensuring compatibility.

## Reference documentation
- [mikrokondo-tools Usage](https://github.com/DOED-DAAD/mikrokondo-tools#usage)
- [mikrokondo-tools Download Command](https://github.com/DOED-DAAD/mikrokondo-tools#download)
- [mikrokondo-tools Samplesheet Command](https://github.com/DOED-DAAD/mikrokondo-tools#samplesheet)