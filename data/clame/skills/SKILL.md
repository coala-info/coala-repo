---
name: clame
description: CLAME is a metagenomic binning tool that classifies nucleotide sequences into distinct genomic groups using sequence alignment and DNA composition analysis. Use when user asks to bin metagenomic reads, classify sequences into genomic groups, or perform sequence alignment for binning.
homepage: https://github.com/andvides/CLAME
metadata:
  docker_image: "quay.io/biocontainers/clame:1.0--h503566f_3"
---

# clame

## Overview
CLAME (Clasificador Metagenomico) is a binning software designed for metagenomic reads. It utilizes a two-step process: first, it performs nucleotide sequence alignment using an FM-index search algorithm; second, it applies a strongly connected component strategy to bin sequences that exhibit similar DNA composition. This approach allows for the efficient classification of reads into distinct genomic groups.

## CLI Usage and Best Practices

### Basic Command Structure
The primary way to run CLAME is by providing a multi-FASTA input file and specifying an output prefix.

```bash
clame -multiFasta <input.fna> -output <prefix> -nt <threads> -b <threshold> -print
```

### Key Parameters
- `-multiFasta`: Path to the input nucleotide sequence file in FASTA format.
- `-output`: The prefix used for all generated output files.
- `-nt`: Number of threads to use for parallel processing. Increasing this significantly speeds up the FM-index search.
- `-b`: The binning parameter (e.g., `70`). This influences the sensitivity of the strongly connected component clustering.
- `-print`: A critical flag if you require the actual sequences to be written to separate FASTA files for each bin.
- `-h`: Displays the help menu with all available options.

### Output Files
CLAME generates several files based on the provided prefix:
- `<prefix>_*.fasta`: Individual FASTA files containing the reads for each identified bin (requires `-print`).
- `<prefix>.binning`: A summary file listing all reported bins.
- `<prefix>.fm9`: The generated FM-index used for the alignment phase.
- `<prefix>.index`: A mapping file where the first column is the original read name and the second is the internal index used by CLAME.
- `<prefix>.links`: A histogram of links based on the number of reads.
- `<prefix>.result`: An adjacency list representing the detected overlaps between reads.

### Expert Tips
- **Resource Management**: The FM-index (`.fm9`) can be large depending on the input size. Ensure the working directory has sufficient disk space before starting.
- **Workflow Integration**: Since CLAME outputs standard FASTA files for each bin, these can be piped directly into downstream tools like CheckM for bin quality assessment or Prokka for functional annotation.
- **Compilation**: If not using the Bioconda package, ensure the SDSL (Succinct Data Structure Library) is installed before running `make` in the source directory.

## Reference documentation
- [Bioconda clame overview](./references/anaconda_org_channels_bioconda_packages_clame_overview.md)
- [CLAME GitHub Repository](./references/github_com_andvides_CLAME.md)