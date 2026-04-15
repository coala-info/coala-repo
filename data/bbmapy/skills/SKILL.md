---
name: bbmapy
description: bbmapy provides a Pythonic interface for executing the BBTools suite of bioinformatics utilities. Use when user asks to align reads to a reference, perform quality trimming and filtering, or manage Java-based genomic data processing within Python pipelines.
homepage: https://github.com/urineri/bbmapy
metadata:
  docker_image: "quay.io/biocontainers/bbmapy:0.0.51--pyhdfd78af_0"
---

# bbmapy

## Overview
`bbmapy` is a Pythonic interface for the BBTools suite, a collection of high-performance bioinformatics utilities. It simplifies the execution of Java-based tools by handling environment variables, Java Virtual Machine (JVM) flags, and argument parsing. This skill enables the integration of BBTools into larger Python data science or bioinformatics pipelines while maintaining the performance of the underlying Java implementations.

## Usage Patterns

### Basic Tool Execution
Import specific tools directly from the package. Note that the Python keyword `in` is reserved; use `in_file` instead for single-end reads.

```python
from bbmapy import bbmap

bbmap(
    in_file="reads.fastq",
    ref="reference.fasta",
    out="mapped.sam",
    threads="8"
)
```

### Quality Trimming and Filtering (BBDuk)
BBDuk is commonly used for adapter removal and quality filtering. Parameters are passed as keyword arguments.

```python
from bbmapy import bbduk

bbduk(
    in_file="input.fastq",
    out="output.fastq",
    ktrim="r",
    k=23,
    mink=11,
    hdist=1,
    tbo=True,
    minlen=45,
    ref="adapters"
)
```

### Managing Java Resources
Pass JVM flags (like memory allocation) directly as keyword arguments. These are automatically recognized and handled by the wrapper.

- `Xmx`: Set maximum heap size (e.g., `Xmx="4g"`).
- `da`: Enable/disable assertions (`da=True`).
- `eoom`: Exit on out-of-memory (`eoom=True`).

### Capturing Output Streams
To programmatically process the output of a tool, use `capture_output=True`. You must also specify a filename for the `out` parameter (often `"stdout.fastq"` or similar) to direct the data stream.

```python
stdout, stderr = bbduk(
    capture_output=True,
    in_file="input.fastq",
    out="stdout.fastq",
    k=25
)
```

## Expert Tips & Best Practices

- **Boolean Logic**: Distinguish between CLI flags and tool arguments.
    - Use Python Booleans (`flag=True`) for arguments that do not take a value in the original BBTools CLI.
    - Use string literals (`argument="true"`) for BBTools parameters that explicitly require a "true" or "false" string value in the underlying tool.
- **Java Environment**: If Java is missing or the environment is restricted, run the shell command `bbmapy-ensure-java` to fetch a lightweight JRE.
- **Verification**: Use the CLI command `bbmapy-test` to verify the installation and Java connectivity before running large-scale pipelines.
- **Paired-End Reads**: Use `in1` and `in2` for paired-end input files; unlike `in`, these are not protected keywords and can be used directly in the function call.
- **Performance**: When processing large datasets, always specify `threads` and `Xmx` to ensure the tool utilizes available hardware efficiently and does not exceed container or system memory limits.

## Reference documentation
- [UriNeri/bbmapy GitHub Repository](./references/github_com_UriNeri_bbmapy.md)