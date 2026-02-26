---
name: ngsderive
description: ngsderive infers experimental parameters and technical attributes from sequencing files by analyzing raw data. Use when user asks to infer sequencing instrument, determine RNA-Seq strandedness, compute read length distributions, identify PHRED quality encoding, or annotate splice junctions.
homepage: https://github.com/claymcleod/ngsderive
---


# ngsderive

## Overview

`ngsderive` is a specialized bioinformatics utility designed for "backwards" derivation of experimental parameters from sequencing files. It is particularly useful for forensic analysis of legacy datasets, verifying metadata consistency, or filling in missing information in NGS pipelines. The tool analyzes the raw data (BAM, SAM, or FASTQ) to provide "best guess" estimates for technical attributes that are often not explicitly labeled in the data files themselves.

## Tool Usage and Subcommands

The tool follows a standard subcommand-based CLI structure: `ngsderive <subcommand> [options] <input_file>`.

### Core Subcommands

*   **`instrument`**: Infers the Illumina instrument used by matching read headers and flowcell naming patterns against a known database. It provides a confidence score for each guess.
*   **`strandedness`**: Analyzes RNA-Seq data to determine if the library protocol was Stranded-Forward, Stranded-Reverse, or Unstranded.
*   **`read-length`**: Computes the distribution of read lengths and attempts to identify the original (pre-trimmed) read length of the experiment.
*   **`encoding`**: Identifies the PHRED quality score encoding scheme (e.g., Sanger/Illumina 1.8+ vs. older Illumina formats) used to store ASCII quality characters.
*   **`junction-annotation`**: The most deterministic tool in the suite. It compares splice junctions found in the data against a reference gene model to classify them as known, novel, or partially novel.

### Installation

The tool can be installed via Python Package Index or Bioconda:

```bash
# Via pip
pip install ngsderive

# Via conda
conda install -c bioconda ngsderive
```

## Best Practices and Expert Tips

*   **Interpretive Caution**: Most `ngsderive` outputs (except for junction annotation) are probabilistic "best guesses." Always review the confidence scores provided in the output before making downstream pipeline decisions.
*   **Reference Requirements**: For `junction-annotation`, ensure you provide a high-quality reference gene model (GTF/GFF) that matches the organism and assembly version of your input data.
*   **Forensic Verification**: Use `ngsderive` as a validation step in automated workflows to ensure that the claimed metadata (e.g., "this is a stranded-reverse library") matches the actual evidence in the sequencing files.
*   **Development and Testing**: If modifying the tool or running custom checks, the project uses `poetry` for environment management and `pytest` for testing.

## Reference documentation

- [ngsderive GitHub Repository](./references/github_com_stjudecloud_ngsderive.md)
- [ngsderive Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ngsderive_overview.md)