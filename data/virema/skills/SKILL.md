---
name: virema
description: ViReMa is a specialized bioinformatic tool designed to identify non-linear genomic events in viral datasets that standard alignment algorithms often overlook.
homepage: https://sourceforge.net/projects/virema/
---

# virema

## Overview
ViReMa is a specialized bioinformatic tool designed to identify non-linear genomic events in viral datasets that standard alignment algorithms often overlook. It is particularly effective for discovering functional genomic motifs, recombination breakpoints, and fusion events. Use this skill to correctly configure the iterative alignment process, manage reference indexes, and ensure maximum sensitivity for edge-case recombinations.

## Installation and Environment
ViReMa is a Python-based tool that relies on the Bowtie short-read aligner.

- **Installation**: The most reliable method is via Bioconda:
  `conda install bioconda::virema`
- **Dependencies**: 
  - Python 3.7+ (for recent versions) or 2.7.
  - Bowtie version 0.12.9 (specifically required; newer versions of Bowtie 2 are generally not compatible).
  - `bowtie` and `bowtie-inspect` must be in your system `$PATH`.

## Reference Preparation: The Terminal Padding Rule
A critical best practice for ViReMa is the use of terminal padding. Without this, the tool often fails to detect recombination events occurring at the extreme 5' or 3' ends of the viral genome.

1. **Add Padding**: Manually append a string of 'A' nucleotides to the end of your viral reference FASTA sequence.
2. **Length**: The pad must be longer than the maximum length of the reads in your dataset.
3. **Build Index**: Generate the Bowtie index after adding the pad:
   `bowtie-build padded_genome.fasta padded_index_name`

## Command Line Usage
The core execution follows a specific positional argument structure.

### Basic Command
```bash
python ViReMa.py <Virus_Index> <Input_Data> <Output_Data> [options]
```

- **Virus_Index**: Full path to the Bowtie index (even if in the current directory).
- **Input_Data**: Single-end reads in FASTQ or FASTA format.
- **Output_Data**: The filename for the resulting recombination report.

### Common Parameters
- `--Seed <int>`: Sets the initial alignment seed (default is often 20). Increasing this speeds up processing but may reduce sensitivity for small fragments.
- `--MicroInDel_Length <int>`: Defines the threshold for what is considered a small insertion/deletion versus a recombination event.
- `--Host_Index <path>`: Optional. Provide a host genome index (e.g., Human or Vero cells) to filter out non-viral fusion events.
- `--Mismatch <int>`: Number of mismatches allowed in the seed alignment.

## Expert Tips and Best Practices
- **Pathing**: Always provide the full path to the `Virus_Index`. ViReMa is sensitive to relative paths when calling Bowtie internally.
- **Iterative Trimming**: ViReMa works by aligning the "Seed" and then iteratively trimming unaligned nucleotides to find the next junction. If performance is slow, check if your read quality is low, as excessive trimming cycles increase compute time.
- **Compiling Results**: Use the included `Compiler_Module.py` to aggregate results from multiple runs or to simplify the raw output into a more readable summary of unique recombination junctions.
- **Memory Management**: For very large datasets, ensure your temporary directory has sufficient space, as ViReMa generates intermediate files during the iterative alignment phases.

## Reference documentation
- [ViReMa Files Overview](./references/sourceforge_net_projects_virema_files.md)
- [ViReMa Project Summary](./references/sourceforge_net_projects_virema.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_virema_overview.md)