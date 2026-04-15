---
name: proteomiqon-alignmentbasedquantstatistics
description: This tool scores peptide ion quantifications based on alignment properties. Use when user asks to score peptide quantifications from aligned mass spectrometry runs.
homepage: https://csbiology.github.io/ProteomIQon/
metadata:
  docker_image: "quay.io/biocontainers/proteomiqon-alignmentbasedquantstatistics:0.0.3--hdfd78af_0"
---

# proteomiqon-alignmentbasedquantstatistics

## Overview
The `proteomiqon-alignmentbasedquantstatistics` tool is designed to evaluate and score peptide ion quantifications that have been generated through alignment across different mass spectrometry runs. It leverages various peak and run properties to provide a measurement of reliability for these aligned quantifications, helping to refine the accuracy of protein abundance estimations in shotgun proteomics.

## Usage Instructions

The `proteomiqon-alignmentbasedquantstatistics` tool is part of the ProteomIQon suite. It is typically invoked via the command line using the `proteomiqon` executable followed by the specific subcommand.

### Core Functionality

The primary function of this tool is to score peptide ion quantifications based on alignment. The documentation indicates that this tool scores quantifications obtained through alignment based on peak and run properties to obtain a measurement of reliability for the alignments.

### Command Line Execution

The general command structure for ProteomIQon tools is:

```bash
proteomiqon <tool_name> [options]
```

While the provided documentation does not explicitly detail the command for `alignmentbasedquantstatistics` itself, it describes the `AlignmentbasedQuantification` tool which is closely related and likely uses a similar invocation pattern. Based on the `AlignmentbasedQuantification` tool's usage, you would typically provide input files and an output directory.

**Example (based on related tool usage):**

```bash
proteomiqon alignmentbasedquantification -i path/to/your/run.mzlite -ii path/to/your/run.align -iii path/to/your/run.alignmetric -iv path/to/your/run.quant -d path/to/your/database.sqlite -o path/to/your/outDirectory -p path/to/your/params.json
```

**Key Input Files (inferred from related tools):**

*   `-i`: Input MS run file (e.g., `.mzlite`).
*   `-ii`: Aligned data file (e.g., `.align`).
*   `-iii`: Alignment metric file (e.g., `.alignmetric`).
*   `-iv`: Quantification file (e.g., `.quant`).
*   `-d`: Peptide database file (e.g., `.sqlite`).
*   `-o`: Output directory for results.
*   `-p`: Path to a JSON parameter file for detailed configuration.

### Parallel Processing

If you have a multi-core CPU, you can process multiple runs in parallel using the `-c` flag, specifying the number of cores to use.

**Example with parallel processing:**

```bash
proteomiqon alignmentbasedquantification -i run1.mzlite run2.mzlite -ii run1.align run2.align -iii run1.alignmetric run2.alignmetric -iv run1.quant run2.quant -d database.sqlite -o outDirectory -p params.json -c 2
```

### File Matching

By default, input files are matched by their position in the list. To perform a name-based file match, use the `-mf` flag.

**Example with name-based matching:**

```bash
proteomiqon alignmentbasedquantification -i run1.mzlite run2.mzlite -ii run1.align run2.align -iii run1.alignmetric run2.alignmetric -iv run1.quant run2.quant -d database.sqlite -o outDirectory -p params.json -mf
```

### Getting Help

To obtain a detailed description of all available CLI arguments and parameters for the tool, you can use the `--help` flag:

```bash
proteomiqon alignmentbasedquantification --help
```

## Expert Tips

*   **Parameterization is Key**: The `AlignmentBasedQuantification` tool accepts parameters via a JSON file (`-p`). Refer to the documentation for default parameter files and F# scripts to generate custom ones. Tuning these parameters, especially those related to XIC extraction and baseline correction, can significantly impact the scoring accuracy.
*   **Input File Consistency**: Ensure that the input files (`.mzlite`, `.align`, `.alignmetric`, `.quant`) are correctly named and ordered, especially if not using the `-mf` flag for name-based matching. Mismatched files can lead to incorrect analysis.
*   **Database Requirement**: The tool requires a peptide database (`-d`). Ensure this database is correctly generated and accessible. The `PeptideDB` tool is used for this purpose.
*   **Output Directory**: Always specify an output directory (`-o`) to store the results of the quantification scoring.

## Reference documentation
- [AlignmentbasedQuantification](./references/csbiology_github_io_ProteomIQon_tools_AlignmentBasedQuantification.html.md)
- [PeptideDB](./references/csbiology_github_io_ProteomIQon_tools_PeptideDB.html.md)