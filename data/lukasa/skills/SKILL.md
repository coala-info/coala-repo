---
name: lukasa
description: Lukasa is a bioinformatics utility designed to streamline the process of mapping protein evidence to eukaryotic genomes.
homepage: https://github.com/pvanheus/lukasa
---

# lukasa

## Overview

Lukasa is a bioinformatics utility designed to streamline the process of mapping protein evidence to eukaryotic genomes. It functions as a wrapper that orchestrates a two-stage workflow: first, it utilizes MetaEUK to rapidly scan genomic contigs for potential protein matches; second, it employs spaln to perform fine-grained, splice-aware alignments on those specific regions. This hybrid approach significantly reduces the computational overhead of whole-genome protein alignment while maintaining high accuracy for gene model prediction. The primary output is a GFF3 file, making it directly compatible with standard genome annotation pipelines.

## Installation and Setup

Lukasa is most easily managed via the Bioconda channel. Ensure your environment is configured to access Bioconda before installation.

```bash
conda install bioconda::lukasa
```

The tool relies on `metaeuk`, `spaln`, and `samtools` being available in the system path.

## Command Line Usage

The core functionality is accessed through the `lukasa.py` script. While specific flags may vary by version, the tool generally requires a genomic fasta file and a protein database.

### Basic Execution Pattern
```bash
python lukasa.py --genome <genome.fasta> --proteins <proteins.fasta> [options]
```

### Key Parameters and Tuning
Based on the tool's development history, several parameters are critical for controlling the sensitivity and specificity of the mapping:

- **Coverage Control**: Use `--min_coverage` to filter out short or fragmentary alignments that do not meet a specific percentage of the query protein length.
- **Intron Modeling**: Use `--max_intron` to define the maximum allowable intron length. This is crucial for eukaryotic species with varying genomic architectures (e.g., fungi vs. mammals).
- **Search Sensitivity**: The `--eval` parameter controls the E-value threshold for the initial MetaEUK search phase. Lowering this value increases the stringency of the initial match detection.
- **Debugging**: Use the `--leave_outputs` flag to prevent the script from deleting intermediate files. This is helpful for inspecting the raw MetaEUK results or individual spaln alignments before they are merged into the final GFF3.

## Best Practices

- **Input Preparation**: Ensure your genomic contig headers are simple and do not contain spaces or special characters that might confuse the underlying alignment tools.
- **Parallelization**: When running on large datasets, utilize the parallel processing capabilities of the underlying tools if the wrapper supports thread allocation.
- **Output Handling**: The resulting GFF3 file contains protein-to-genome mappings. If using this for automated annotation (like MAKER or Braker), ensure the source tags in the GFF3 are correctly identified as protein evidence.

## Reference documentation
- [lukasa - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_lukasa_overview.md)
- [pvanheus/lukasa GitHub Repository](./references/github_com_pvanheus_lukasa.md)
- [lukasa Commit History](./references/github_com_pvanheus_lukasa_commits_main.md)