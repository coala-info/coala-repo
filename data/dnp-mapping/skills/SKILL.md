---
name: dnp-mapping
description: Maps nucleosome positions within a DNA sequence based on defined patterns. Use when user asks to map nucleosome positions or analyze nucleosome occupancy.
homepage: https://github.com/erinijapranckeviciene/mapping_CC
metadata:
  docker_image: "quay.io/biocontainers/dnp-mapping:1.0--h9948957_4"
---

# dnp-mapping

Maps nucleosome positions within a DNA sequence based on defined patterns.
  Use when you need to identify and analyze nucleosome occupancy or positioning in genomic sequences.
---
## Overview

The `dnp-mapping` tool is designed to map nucleosome positions within a DNA sequence by identifying specific patterns. It's particularly useful for researchers and bioinformaticians who need to analyze nucleosome occupancy and positioning in genomic data.

## Usage

The `dnp-mapping` tool can be installed via conda from the bioconda channel.

**Installation:**

```bash
conda install -c bioconda dnp-mapping
```

**Basic Usage:**

The primary function of `dnp-mapping` is to take a sequence and a pattern, and then output the mapped positions. While specific command-line arguments are not detailed in the provided documentation, the general workflow involves providing the input sequence and the pattern to be searched.

**Input Files:**

*   **Sequence File:** Typically a FASTA format file (`.fasta` or `.seq`) containing the DNA sequence.
*   **Pattern File:** A file containing the pattern(s) to search for. The documentation mentions `.mtr` files (e.g., `AATT_human.mtr`) which likely contain specific motifs or patterns.

**Example Command Structure (Inferred):**

Based on the available information, a typical command might look like this:

```bash
dnp-mapping --sequence <sequence_file.fasta> --pattern <pattern_file.mtr> --output <output_file.txt>
```

**Key Considerations:**

*   **Pattern Definition:** The effectiveness of the mapping heavily relies on the quality and specificity of the patterns defined in the `.mtr` files.
*   **Output Interpretation:** The output will indicate the positions within the sequence where the specified patterns are found, corresponding to mapped nucleosome locations.

## Reference documentation

- [Overview of dnp-mapping package on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_dnp-mapping_overview.md)
- [GitHub repository for mapping_CC (dnp-mapping)](./references/github_com_erinijapranckeviciene_mapping_CC.md)