---
name: bellerophon
description: Bellerophon filters mapped sequencing reads to retain those spanning a mapping junction, keeping the 5'-side. Use when user asks to filter reads spanning a junction.
homepage: https://github.com/davebx/bellerophon/
metadata:
  docker_image: "quay.io/biocontainers/bellerophon:1.0--pyh5e36f6f_0"
---

# bellerophon

---
## Overview
Bellerophon is a bioinformatics tool designed to process mapped sequencing reads. Its primary function is to filter these reads, specifically identifying and retaining those that span a mapping junction. This is particularly useful for detecting structural variations or complex genomic events where a single read might map across a known or novel junction point. The tool focuses on keeping the 5'-side of such reads for further analysis.

## Usage Instructions

Bellerophon is a command-line tool. The core functionality involves specifying an input BAM file and an output file.

### Basic Usage

To filter mapped reads and retain those spanning a junction (keeping the 5'-side), use the following command structure:

```bash
bellerophon -i <input.bam> -o <output.bam>
```

- `-i <input.bam>`: Specifies the input BAM file containing mapped sequencing reads.
- `-o <output.bam>`: Specifies the output BAM file where the filtered reads will be written.

### Key Functionality and Options

The primary purpose of Bellerophon is to filter reads based on their mapping characteristics, specifically focusing on reads that span a junction. The tool is designed to retain the 5'-side of these reads.

While the provided documentation does not detail extensive command-line options beyond input and output files, the core utility lies in its specific filtering capability. For advanced usage or specific parameter tuning, refer to the tool's source code or dedicated documentation if available.

### Expert Tips

*   **Input File Format**: Ensure your input file is a valid, sorted, and indexed BAM file. Bellerophon's effectiveness relies on correctly formatted input.
*   **Output File**: The output BAM file will contain only the reads that meet Bellerophon's filtering criteria (spanning a junction, retaining 5'-side).
*   **Junction Definition**: Bellerophon implicitly defines what constitutes a "junction" based on its internal algorithms. If you require custom junction definitions or specific types of junctions, Bellerophon might not be the direct tool for that, and you may need to explore other bioinformatics tools or pre-processing steps.
*   **Performance**: For large BAM files, ensure your system has sufficient memory and processing power. The filtering process can be computationally intensive.

## Reference documentation
- [Overview](./references/anaconda_org_channels_bioconda_packages_bellerophon_overview.md)
- [GitHub Repository](./references/github_com_davebx_bellerophon.md)