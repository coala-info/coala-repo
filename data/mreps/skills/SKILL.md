---
name: mreps
description: This tool identifies serial (tandem) repeats in DNA sequences. Use when user asks to find tandem repeats in DNA sequences.
homepage: http://mreps.univ-mlv.fr/
metadata:
  docker_image: "quay.io/biocontainers/mreps:2.6.01--h7b50bb2_6"
---

# mreps

mreps/SKILL.md
```yaml
name: mreps
description: Identifies serial (tandem) repeats in DNA sequences. Use when Claude needs to analyze DNA sequences for repetitive elements, such as in genomic research, sequence annotation, or comparative genomics.
```
## Overview
The `mreps` tool is designed for the efficient identification of tandem repeats within DNA sequences. It's particularly useful for researchers and bioinformaticians who need to analyze the repetitive nature of genetic material.

## Usage Instructions

`mreps` is a command-line tool. The basic syntax is:

```bash
mreps [options] <input_fasta_file>
```

### Core Functionality and Options

*   **Input**: `mreps` takes a single FASTA file as input, containing the DNA sequence(s) to be analyzed.
*   **Output**: By default, `mreps` prints the identified repeats to standard output. The output format typically includes the repeat unit, its length, and its occurrences.

### Key Options for Analysis

*   `-l <min_len>`: Minimum length of the repeat unit.
*   `-u <max_len>`: Maximum length of the repeat unit.
*   `-o <min_occ>`: Minimum number of occurrences for a repeat to be reported.
*   `-p <min_period>`: Minimum period of the repeat.
*   `-q <max_period>`: Maximum period of the repeat.
*   `-d <max_dist>`: Maximum distance between two occurrences of a repeat.
*   `-a <alphabet>`: Specify the alphabet for the sequence (e.g., 'DNA', 'RNA', 'PROTEIN'). Defaults to 'DNA'.
*   `-f <output_format>`: Specify the output format. Common options include:
    *   `tab`: Tab-separated values.
    *   `json`: JSON format.
    *   `bed`: BED format (useful for genomic visualization).
*   `-o <output_file>`: Redirect output to a specified file instead of standard output.

### Expert Tips

*   **Iterative Refinement**: Start with broader parameters (e.g., larger `-l`, smaller `-o`) and then narrow down your search by adjusting parameters based on initial results.
*   **Understanding Output**: Pay close attention to the output format. The `tab` format is often the most straightforward for basic analysis, while `bed` is excellent for integration with genome browsers.
*   **Sequence Quality**: Ensure your input FASTA file is clean and correctly formatted. `mreps` is sensitive to sequence data quality.
*   **Parameter Combinations**: Experiment with combinations of `-l`, `-u`, `-o`, and `-p` to find the most relevant repeats for your specific research question. For instance, to find short, highly repeated sequences, you might use a small `-l` and a high `-o`.

## Reference documentation
- [Overview of mreps package on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mreps_overview.md)