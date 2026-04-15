---
name: maffilter
description: Maffilter processes multiple genome alignments with flexible filtering capabilities. Use when user asks to filter alignments by score, identity, length, species, or to output statistics.
homepage: https://github.com/jydu/maffilter
metadata:
  docker_image: "biocontainers/maffilter:v1.3.1dfsg-1b1-deb_cv1"
---

# maffilter

maffilter/SKILL.md
---
name: maffilter
description: Processes multiple genome alignments, offering flexible and extensible filtering capabilities. Use when dealing with multiple sequence alignments (e.g., in MAF format) and requiring advanced filtering, manipulation, or analysis of these alignments.
---
## Overview
Maffilter is a powerful command-line tool designed for processing multiple genome alignments. It provides a flexible and extensible framework for filtering, manipulating, and analyzing alignment data, particularly in formats like MAF. This skill enables users to leverage Maffilter's capabilities for complex bioinformatics workflows involving large-scale genomic alignments.

## Usage Instructions

Maffilter operates by taking an input alignment file and applying a series of filters and operations. The general command structure is:

```bash
maffilter [options] <input_alignment_file>
```

### Core Functionality and Common Options

Maffilter's strength lies in its extensive filtering options. Here are some key functionalities and how to use them:

*   **Filtering by alignment score:**
    *   `--MinAlignmentScore <score>`: Filters alignments based on a minimum alignment score.
    *   Example: `maffilter --MinAlignmentScore 100 input.maf`

*   **Filtering by sequence identity:**
    *   `--MinSeqIdentity <percentage>`: Filters alignments based on a minimum percentage of sequence identity.
    *   Example: `maffilter --MinSeqIdentity 80 input.maf`

*   **Filtering by alignment length:**
    *   `--MinAlignmentLength <length>`: Filters alignments based on a minimum alignment length.
    *   Example: `maffilter --MinAlignmentLength 500 input.maf`

*   **Filtering by number of species:**
    *   `--MinSpecies <number>`: Filters alignments to include only those with at least a specified number of species.
    *   Example: `maffilter --MinSpecies 5 input.maf`

*   **Selecting specific species:**
    *   `--Species <species1,species2,...>`: Filters alignments to include only those that contain the specified species.
    *   Example: `maffilter --Species human,mouse input.maf`

*   **Outputting statistics:**
    *   `--stats <output_file>`: Generates alignment statistics and saves them to a file.
    *   Example: `maffilter --stats alignment_stats.txt input.maf`

*   **Controlling output format:**
    *   `--OutputFormat <format>`: Specifies the output format (e.g., MAF, FASTA).
    *   Example: `maffilter --OutputFormat FASTA input.maf > output.fasta`

### Advanced Filtering and Operations

Maffilter supports more complex operations for fine-grained control:

*   **Filtering orphans:**
    *   `--SelectOrphans`: Selects alignments where only one species is present.
    *   Example: `maffilter --SelectOrphans input.maf`

*   **Handling deletions:**
    *   Maffilter can process alignments with deletions. Specific options might be available for how deletions are treated or filtered, though explicit command-line flags for this are not detailed in the provided documentation. Refer to the tool's comprehensive documentation for advanced deletion handling.

*   **VCF export:**
    *   Maffilter can export alignment data in VCF format, which is useful for variant calling.
    *   Example: `maffilter --VCFExport output.vcf input.maf`

### Best Practices and Tips

*   **Input Format:** Ensure your input alignment file is in a supported format, typically MAF.
*   **Combine Filters:** You can chain multiple filtering options together to create highly specific subsets of your alignment data.
*   **Output Redirection:** Use shell redirection (`>`) to save the filtered output to a file.
*   **Statistics:** Always consider generating statistics (`--stats`) to understand the impact of your filters and the characteristics of your data.
*   **Consult Documentation:** For a complete list of options and detailed explanations, refer to the official Maffilter documentation. The provided GitHub repository contains the source code and README, which are the primary sources of information.

## Reference documentation
- [MafFilter README](./references/github_com_jydu_maffilter.md)