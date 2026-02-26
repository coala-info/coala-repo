---
name: pbipa
description: pbipa is a tool for the rapid, phased de novo assembly of PacBio HiFi reads. Use when user asks to install the software via Bioconda, perform de novo assembly of genomic data, or generate phased contigs from HiFi reads.
homepage: https://github.com/PacificBiosciences/pbbioconda
---


# pbipa

## Overview

The Improved Phased Assembly (IPA) tool is PacBio's official solution for rapid, phased de novo assembly of HiFi reads. It is designed to handle the high accuracy of HiFi data to produce assemblies that are both highly contiguous and biologically accurate, effectively separating haplotypes (phasing) during the assembly process. Use this skill to navigate the installation via Bioconda and to understand the standard execution patterns for genomic assembly projects.

## Installation and Environment

The tool is distributed via the Bioconda channel. It is recommended to use a dedicated Conda environment to avoid dependency conflicts with other PacBio tools.

```bash
# Create a new environment and install pbipa
conda create -n ipa_env
conda activate ipa_env
conda install -c bioconda pbipa
```

## Core CLI Usage

The primary command for the tool is `ipa`. The workflow typically involves taking a set of HiFi reads (in BAM or FASTQ format) and producing a phased assembly.

### Basic Assembly Command
To run a standard assembly with default parameters:
```bash
ipa local -i <input_reads.bam> -o <output_directory>
```

### Key Parameters
- `-i, --input`: Path to the input HiFi reads (BAM, FASTA, or FASTQ). Multiple inputs can be provided.
- `-o, --out-dir`: The directory where assembly results and logs will be stored.
- `--threads`: Number of CPU threads to use (default is usually all available).
- `--genome-size`: Estimated genome size (e.g., `3G` for human). Providing this helps the assembler optimize memory and runtime.

## Best Practices

1. **Input Quality**: Ensure you are using HiFi reads (CCS reads with >= QV20). The tool is specifically tuned for the error profile of HiFi data and may not perform optimally with older CLR (Continuous Long Read) data.
2. **Resource Allocation**: Assembly is computationally intensive. When running on a local machine, ensure you have sufficient RAM (typically 64GB-128GB+ depending on genome size).
3. **Phasing**: IPA automatically attempts to phase the assembly. The output will typically include primary contigs and associated (haplotig) contigs.
4. **Monitoring**: Check the `ipa.log` file within the output directory to monitor progress through the various stages (overlap, layout, consensus, and phasing).

## Reference documentation
- [pbipa - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pbipa_overview.md)
- [PacificBiosciences/pbbioconda GitHub](./references/github_com_PacificBiosciences_pbbioconda.md)