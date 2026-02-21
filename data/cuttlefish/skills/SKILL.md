---
name: cuttlefish
description: Cuttlefish is a specialized bioinformatics tool that efficiently builds compacted de Bruijn graphs, a fundamental structure in modern genomics.
homepage: https://github.com/COMBINE-lab/cuttlefish
---

# cuttlefish

## Overview

Cuttlefish is a specialized bioinformatics tool that efficiently builds compacted de Bruijn graphs, a fundamental structure in modern genomics. By identifying maximal unitigs—sequences that represent non-branching paths in the graph—it reduces the complexity of genomic data without losing information. This skill enables the processing of massive datasets, such as whole human genomes or large populations of bacterial reads, using a highly scalable and parallelized approach that balances RAM usage and execution speed.

## Core CLI Usage

The primary command for Cuttlefish is `cuttlefish build`.

### Basic Command Patterns

**For Reference Sequences (FASTA):**
Use the `--ref` flag. The default frequency cutoff is 1.
```bash
cuttlefish build --ref -s input.fa -k 31 -t 16 -o output_prefix
```

**For Sequencing Reads (FASTQ):**
Use the `--read` flag. The default frequency cutoff is 2.
```bash
cuttlefish build --read -s reads.fastq -k 31 -m 8 -o output_prefix
```

### Input Management
Cuttlefish offers flexible ways to specify input files:
- **Single/Multiple files**: `-s file1.fa,file2.fa` or `-s file1.fa -s file2.fa`
- **File lists**: `-l list_of_files.txt` (where the text file contains one path per line)
- **Directories**: `-d /path/to/data/` (processes all files in the directory)

## Parameters and Optimization

### K-mer Length (`-k`)
- Must be an **odd** integer.
- Default is 27.
- Bioconda installations typically support $k$ up to 127. Source builds default to 63 unless modified during compilation.

### Memory and Performance
- **Memory Limit (`-m`)**: Sets a soft maximum RAM limit in GB. Cuttlefish will attempt to stay within this limit while maintaining speed.
- **Unrestricted Memory (`--unrestrict-memory`)**: Use this to prioritize speed over RAM conservation if the system has abundant resources.
- **Threads (`-t`)**: Defaults to 1/4 of available logical cores. For large datasets, manually increasing this to near-maximum capacity is recommended.
- **Working Directory (`-w`)**: Specify a directory for temporary files. **Note**: This directory must exist before running the command.

### Output Formats (`-f`)
Cuttlefish 1 specific output formats (Cuttlefish 2 primarily outputs FASTA unitigs):
- `0`: FASTA (Maximal unitig fragments)
- `1`: GFA 1.0 (Unitigs + connectivity + tilings)
- `2`: GFA 2.0
- `3`: GFA-reduced

## Expert Tips

1. **Frequency Cutoffs**: When working with noisy long reads or high-coverage short reads, adjust the cutoff (`-c`) to filter out erroneous k-mers. For references, `-c 1` is standard; for reads, `-c 2` or higher helps remove sequencing errors.
2. **Disk Space**: Ensure the working directory (`-w`) has sufficient space, as Cuttlefish generates intermediate KMC (k-mer counter) databases which can be large.
3. **Gzipped Inputs**: Cuttlefish natively supports `.gz` files, so there is no need to decompress genomic data before processing.
4. **Validation**: Always check the generated `.json` metadata file. It contains structural characteristics of the graph, such as the number of vertices and edges, which can be used to verify the success of the build.

## Reference documentation
- [Cuttlefish Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cuttlefish_overview.md)
- [Cuttlefish GitHub Documentation](./references/github_com_COMBINE-lab_cuttlefish.md)