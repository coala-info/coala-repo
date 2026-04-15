---
name: multigps
description: This tool simulates and analyzes genomic regions. Use when user asks to simulate genomic regions, analyze positional distribution of genomic features, or generate synthetic genomic data.
homepage: https://github.com/shaunmahony/multigps-archive
metadata:
  docker_image: "quay.io/biocontainers/multigps:0.74--r3.3.1_0"
---

# multigps

yaml
name: multigps
description: |
  Tool for analyzing high-throughput sequencing data, specifically for MultiGPS (Multiple Genome Position Simulator).
  Use when Claude needs to perform simulations or analyses related to genomic regions, such as:
  - Simulating genomic regions based on specific criteria.
  - Analyzing the positional distribution of genomic features.
  - Generating synthetic genomic data for testing or validation.
```
## Overview
MultiGPS is a Java-based tool designed for the analysis of high-throughput sequencing data, with a particular focus on simulating and analyzing genomic regions. It's useful for tasks like generating synthetic genomic data, understanding the positional distribution of genomic features, and testing hypotheses related to genomic event localization.

## Usage

MultiGPS is a Java application. To use it, you will typically need to compile the Java code and then run the main analysis class.

### Installation

MultiGPS can be installed via Conda:
```bash
conda install bioconda::multigps
```

### Running MultiGPS

The primary entry point for analysis is typically `edu.psu.compbio.seqcode.projects.multigps.analysis.MultiGPS`. The exact command-line arguments will depend on the specific analysis you wish to perform.

Based on the archive's README, the main method is:
`edu.psu.compbio.seqcode.projects.multigps.analysis.MultiGPS`

While specific command-line arguments are not detailed in the provided documentation, common patterns for such tools involve specifying input files, output directories, and various simulation or analysis parameters.

**General Workflow (Conceptual):**

1.  **Compile the Java code:** If you are working with the source code, you will need to compile it first.
2.  **Execute the main class:** Run the `MultiGPS` class with appropriate arguments.

**Example (Hypothetical - actual arguments may differ):**

```bash
java -cp path/to/multigps.jar edu.psu.compbio.seqcode.projects.multigps.analysis.MultiGPS \
  --input_regions path/to/regions.bed \
  --output_dir /path/to/output \
  --simulation_type positional \
  --num_simulations 1000 \
  --genome_fasta /path/to/genome.fa
```

**Key Parameters (Likely to be present, based on tool's purpose):**

*   `--input_regions` or similar: Path to a file defining input genomic regions (e.g., BED format).
*   `--output_dir`: Directory to save the results.
*   Simulation parameters: These will vary widely depending on the type of simulation (e.g., number of simulations, region size, positional biases, background models).
*   Genome information: Path to a reference genome file (e.g., FASTA format) might be required for certain analyses.

**Expert Tips:**

*   **Consult the Source Code:** For precise command-line arguments and options, refer to the `MultiGPS.java` file within the `src/edu/psu/compbio/seqcode/projects/multigps/analysis/` directory of the source code.
*   **Understand Input Formats:** Ensure your input region files (e.g., BED) are correctly formatted and compatible with the tool.
*   **Iterative Parameter Tuning:** Genomic analysis often requires experimentation. Start with default or sensible parameters and iteratively adjust them based on your results and biological questions.
*   **Version Compatibility:** The provided documentation refers to an archived version (0.5, Mar 2014). Newer versions may exist at `https://github.com/seqcode/multigps`. Always check for the latest stable release and its documentation.

## Reference documentation
- [Overview of MultiGPS and SeqCode](https://github.com/shaunmahony/multigps-archive.md)