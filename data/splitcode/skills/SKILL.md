---
name: splitcode
description: This tool parses, interprets, and edits technical sequences like DNA and RNA. Use when user asks to extract subsequences, trim sequences, filter reads, work with FASTQ or BAM files, or perform reverse complement operations.
homepage: https://github.com/pachterlab/splitcode
metadata:
  docker_image: "quay.io/biocontainers/splitcode:0.31.6--h077b44d_0"
---

# splitcode

Flexible parsing, interpretation, and editing of technical sequences, particularly DNA and RNA sequences.
  Use when Claude needs to manipulate or extract specific patterns from sequencing reads, such as:
  - Extracting subsequences based on defined patterns.
  - Trimming or modifying sequences.
  - Filtering reads based on sequence content or quality.
  - Working with FASTQ or BAM files for sequence manipulation.
  - Performing reverse complement operations on sequences.
body: |
  ## Overview
  `splitcode` is a powerful command-line tool designed for flexible and efficient parsing, interpretation, and editing of technical sequences, commonly used in bioinformatics for DNA and RNA sequencing data. It allows users to extract, trim, filter, and modify sequences based on user-defined specifications, making it invaluable for tasks involving sequence manipulation and analysis.

  ## Core Usage and Best Practices

  `splitcode` operates by taking input sequences (typically from FASTQ or BAM files) and applying a series of directives to parse, interpret, and edit them. The general command structure involves specifying input files, output options, and the directives themselves.

  ### Basic Command Structure

  ```bash
  splitcode --input <input_file(s)> --output <output_file> [directives] [options]
  ```

  ### Key Directives and Patterns

  `splitcode` uses a directive-based syntax for sequence manipulation. These directives are often chained together to perform complex operations.

  *   **Extraction (`--extract` or `-x`)**: Extract subsequences based on patterns.
      *   **Simple pattern extraction**: `splitcode -x "pattern"`
      *   **Reverse complement extraction**: `splitcode -x "~c~pattern"`
      *   **Reverse extraction**: `splitcode -x "~r~pattern"`
      *   **Extraction with quality score preservation**: Ensure quality scores are maintained for extracted reads.
      *   **Multiple extractions**: Use `--extract` multiple times or with comma-separated patterns for complex scenarios.

  *   **Trimming (`--trim`)**: Trim sequences from the beginning or end.
      *   **Trim after a pattern**: `splitcode --trim "pattern"` (trims the sequence *after* the pattern).
      *   **Trim before a pattern**: `splitcode --trim "pattern" --trim-before` (trims the sequence *before* the pattern).

  *   **Filtering (`--select`, `--filter`)**: Select or filter reads based on criteria.
      *   **Select reads containing a pattern**: `splitcode --select "pattern"`
      *   **Filter based on quality**: Use quality score thresholds.

  *   **Keeping sequences (`--keep`)**: Specify how to handle sequences that match criteria.
      *   **Outputting to BAM**: `--keep --output-bam` can be used to output matching sequences into a BAM file.

  *   **Substitutions (`--subs`)**: Make substitutions within sequences.
      *   **Deleting a sequence**: `--subs "pattern" ""` can be used to delete an entire matched pattern.

  ### Advanced Tips and Considerations

  *   **Input Formats**: `splitcode` supports various input formats, including FASTQ and BAM. Ensure your input files are correctly formatted.
  *   **Output Formats**: The tool can output to FASTQ, FASTA, and BAM formats.
  *   **Configuration Files**: For complex workflows, consider using a configuration file to specify directives, which can improve readability and reusability.
  *   **Error Handling**: Pay attention to error messages, especially regarding incompatible directives or file issues.
  *   **Performance**: For large datasets, consider the efficiency of your directive chains. The documentation mentions optimizations for thread race conditions and zlib-ng.
  *   **Reverse Complement and Reverse Operations**: The `~c~` and `~r~` prefixes are crucial for handling reverse complement and reverse operations, respectively.
  *   **Tag and Barcode Handling**: `splitcode` has features for extracting barcodes (sample and UMI) from read names and handling tag combinations.

  ### Example CLI Patterns

  *   **Extracting all sequences containing "AGCT" and their reverse complements, preserving quality scores:**
      ```bash
      splitcode -x "AGCT" -x "~c~AGCT" --output output.fastq input.fastq
      ```

  *   **Trimming sequences after the pattern "XYZ" and outputting to a new FASTQ file:**
      ```bash
      splitcode --trim "XYZ" --output trimmed.fastq input.fastq
      ```

  *   **Extracting barcodes from read names (assuming a format like `read_name:barcode1:barcode2`):**
      ```bash
      # This would require specific directives for parsing read names,
      # refer to the documentation for detailed read name parsing.
      # Example conceptual usage:
      # splitcode --extract-readname-barcode "(\w+):(\w+):(\w+)" --output output.fastq input.fastq
      ```

  *   **Using a configuration file for complex operations:**
      ```bash
      splitcode --config config.txt --output output.fastq input.fastq
      ```
      (Where `config.txt` contains directives like `extract: AGCT`, `trim: XYZ`, etc.)

  ## Reference documentation
  - [splitcode README](./references/github_com_pachterlab_splitcode.md)
  - [splitcode GitHub Actions Workflows](./references/github_com_pachterlab_splitcode_actions.md)
  - [splitcode Activity Log](./references/github_com_pachterlab_splitcode_activity.md)
  - [splitcode Branches](./references/github_com_pachterlab_splitcode_branches.md)
  - [splitcode Commits](./references/github_com_pachterlab_splitcode_commits_main.md)
  - [splitcode Forks](./references/github_com_pachterlab_splitcode_forks.md)
  - [splitcode Issues](./references/github_com_pachterlab_splitcode_issues.md)
  - [splitcode Projects](./references/github_com_pachterlab_splitcode_projects.md)
  - [splitcode Pull Requests](./references/github_com_pachterlab_splitcode_pulls.md)
  - [splitcode Pulse](./references/github_com_pachterlab_splitcode_pulse.md)
  - [splitcode Security Overview](./references/github_com_pachterlab_splitcode_security.md)
  - [splitcode Stargazers](./references/github_com_pachterlab_splitcode_stargazers.md)
  - [splitcode Tags](./references/github_com_pachterlab_splitcode_tags.md)
  - [splitcode License](./references/github_com_pachterlab_splitcode_blob_main_LICENSE.md)
  - [splitcode .github/workflows](./references/github_com_pachterlab_splitcode_tree_main_.github_workflows.md)
  - [splitcode Anaconda Overview](./references/anaconda_org_channels_bioconda_packages_splitcode_overview.md)