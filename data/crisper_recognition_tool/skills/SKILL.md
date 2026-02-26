---
name: crisper_recognition_tool
description: The CRISPR Recognition Tool automatically identifies CRISPR arrays within nucleotide sequences by locating clusters of short repeats and unique spacers. Use when user asks to find CRISPR arrays in FASTA files, annotate genomic sequences, or detect prokaryotic immune system components.
homepage: http://www.room220.com/crt/
---


# crisper_recognition_tool

## Overview
The CRISPR Recognition Tool (CRT) is a specialized utility designed for the rapid and automated identification of CRISPR arrays within nucleotide sequences. It analyzes FASTA-formatted data to locate clusters of short, palindromic repeats separated by unique spacer sequences. This tool is particularly effective for genomic annotation and studying prokaryotic immune systems, providing a fast alternative to manual sequence inspection.

## Installation
The most efficient way to install the tool is via Bioconda, which handles the Java dependencies:
```bash
conda install bioconda::crisper_recognition_tool
```

## Command Line Usage
The basic syntax for running the tool (using the standard bioconda wrapper) is:
```bash
crt [options] <inputFile> [outputFile]
```

If you are executing the JAR file directly in a Java environment:
```bash
java -cp CRT1.2-CLI.jar crt [options] <inputFile> [outputFile]
```

### Key Parameters
Adjust these flags to tune the sensitivity of the detection based on the target organism:
- `-minNR`: Minimum number of repeats required to identify a CRISPR (Default: 3).
- `-minRL`: Minimum length of the repeated region (Default: 19).
- `-maxRL`: Maximum length of the repeated region (Default: 38).
- `-minSL`: Minimum length of the non-repeated (spacer) region (Default: 19).
- `-maxSL`: Maximum length of the non-repeated (spacer) region (Default: 48).
- `-searchWL`: Length of the search window used to discover CRISPRs (Range: 6-9).

### Output Management
- **Default Output**: If no `outputFile` is specified, results are automatically written to a file named `a.out`.
- **Terminal Output**: To view results directly in the terminal instead of a file, use the `-screen` flag:
  ```bash
  crt -screen 1 input.fasta
  ```

## Best Practices and Tips
- **Input Format**: CRT only supports FASTA file formats. Ensure your sequence headers and line breaks conform to standard FASTA specifications before processing.
- **Sensitivity Tuning**: If you are working with highly diverged or unusual CRISPR systems, try lowering the `-minNR` to 2 or expanding the length ranges (`-minRL`/`-maxRL`) to capture non-canonical arrays.
- **Batch Processing**: When processing multiple genomes, it is recommended to specify unique output filenames to avoid the default `a.out` being overwritten.
- **Environment**: Ensure a Java Runtime Environment (JRE) is installed, as CRT is a Java-based application.

## Reference documentation
- [CRT - Command Line Interface](./references/www_room220_com_crt_cli.html.md)
- [CRISPR Recognition Tool Home](./references/www_room220_com_crt.md)