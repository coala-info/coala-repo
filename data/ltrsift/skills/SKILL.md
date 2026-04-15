---
name: ltrsift
description: ltrsift is a postprocessing tool for the classification, refinement, and visualization of LTR retrotransposon candidates in genomic sequences. Use when user asks to filter LTR retrotransposon candidates, visualize genomic features, or classify retrotransposons using rule-based analysis.
homepage: https://github.com/satta/ltrsift
metadata:
  docker_image: "biocontainers/ltrsift:v1.0.2-8-deb_cv1"
---

# ltrsift

## Overview

ltrsift is a specialized tool designed for the downstream analysis of LTR (Long Terminal Repeat) retrotransposons. It acts as a postprocessing suite that helps researchers classify and refine LTR candidates identified in genomic sequences. By integrating with the GenomeTools library and utilizing external aligners like LAST or BLAST, it provides a semi-automatic environment for feature visualization and rule-based filtering.

## Usage and Best Practices

### Environment Configuration
ltrsift relies on external sequence alignment tools. If these are not in your system's standard PATH, you must define them using environment variables before execution:

- **LAST**: Set `GT_LAST_PATH` to the directory containing `lastal` and `lastdb`.
- **BLAST**: Set `GT_BLAST_PATH` to the full path of the `blastall` executable.
- **Visualization**: Use `LTRSIFT_STYLE_FILE` to point to a custom style file if you need to change the appearance of the linear feature diagrams.

### Execution Modes
Depending on your environment setup, you can run ltrsift in several ways:

1. **Standard Run**: Use the `./run_ltrsift` script in the root directory for a default configuration.
2. **Binary Execution**: Run `bin/ltrsift`. This requires the GenomeTools library to be installed on the system.
3. **Static Execution**: If GenomeTools is not installed or you lack permissions, use `bin/ltrsift_static`. This version has the necessary libraries bundled.

### Filtering and Classification
The tool uses specific rules to classify retrotransposons. 
- Refer to the `filters/` directory in the source tree for example filtering rules.
- These rules are essential for the "semi-automatic" aspect of the tool, allowing for consistent postprocessing of candidates based on the criteria described in the LTRsift literature.

### Compilation Tips
If building from source:
- Ensure **GTK+ version 2** is installed (required for the graphical components).
- Use `make 64bit=yes` for 64-bit systems.
- Use `make static=yes` to generate the standalone `ltrsift_static` binary.
- If GenomeTools is in a non-standard location, set the `gt_prefix` variable: `make gt_prefix=/path/to/genometools`.

## Reference documentation
- [Main README and Tool Overview](./references/github_com_satta_ltrsift.md)