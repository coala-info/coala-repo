---
name: equirep
description: EquiRep identifies tandem repeats in biological sequences and outputs the discovered repeat units in FASTA format. Use when user asks to identify tandem repeats, find repetitive regions in DNA sequences, or extract repeat units from a FASTA file.
homepage: https://github.com/Shao-Group/EquiRep
metadata:
  docker_image: "quay.io/biocontainers/equirep:1.0.0--h9948957_0"
---

# equirep

---

## Overview
EquiRep is a high-performance tool specifically designed for the identification of tandem repeats in biological sequences. It is optimized for speed and simplicity, taking a FASTA input and generating a FASTA output containing the discovered repeat units. This skill provides the necessary command-line patterns and operational knowledge to execute EquiRep effectively in a bioinformatics environment.

## Installation
The recommended way to install EquiRep is via Bioconda:

```bash
conda install bioconda::equirep
```

For source installation, the tool requires a C++11 compatible compiler. After downloading the source, run:

```bash
./configure
make
```
The executable will be located at `src/EquiRep`.

## Usage Patterns
EquiRep uses a simple positional argument structure for processing files.

### Basic Command
```bash
EquiRep <input_file> <output_file_prefix>
```

### Arguments
- `<input_file>`: Path to the input FASTA file containing the sequences to be analyzed.
- `<output_file_prefix>`: The prefix used for the resulting output file.

### Example Execution
To analyze a file named `input.fasta` and generate an output named `results.fasta`:
```bash
EquiRep input.fasta results
```

## Expert Tips and Best Practices
- **Output Extension**: EquiRep automatically appends the `.fasta` extension to the provided `<output_file_prefix>`. If you provide a prefix like `output_data`, the resulting file will be `output_data.fasta`.
- **Input Format**: Ensure the input is a standard FASTA file. The tool is optimized for DNA sequences; using non-standard characters or FASTQ files with quality scores will result in errors.
- **Workflow Integration**: Since EquiRep is a lightweight CLI tool, it is best used as a pre-processing step in larger genomic pipelines to identify repetitive regions before alignment or assembly.
- **Directory Context**: When running from source, ensure you reference the binary path correctly (e.g., `./src/EquiRep`) or add the `src` directory to your system PATH.

## Reference documentation
- [EquiRep GitHub Repository](./references/github_com_Shao-Group_EquiRep.md)
- [Bioconda EquiRep Package Overview](./references/anaconda_org_channels_bioconda_packages_equirep_overview.md)