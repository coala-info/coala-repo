---
name: namfinder
description: namfinder is a high-performance sequence mapping utility that identifies shared regions between query and reference sequences using strobemer seeds.
homepage: https://github.com/ksahlin/namfinder
---

# namfinder

## Overview
namfinder is a high-performance sequence mapping utility that identifies shared regions between query and reference sequences using strobemer seeds. While traditional tools search for exact matches, namfinder identifies "Approximate Matches," allowing for biological noise and sequencing errors. It is particularly useful as a component in transcriptomic alignment pipelines (like uLTRA) and produces output compatible with the MUMmer MEM format (.tsv).

## Installation and Setup
The tool must be compiled from source using CMake and a modern C++ compiler (g++ 8+).

```bash
# Standard installation for the current CPU
cmake -B build -DCMAKE_C_FLAGS="-march=native" -DCMAKE_CXX_FLAGS="-march=native"
make -j -C build

# For broad x86-64 compatibility
cmake -B build -DCMAKE_C_FLAGS="-msse4.2" -DCMAKE_CXX_FLAGS="-msse4.2"
make -j -C build
```

## Command Line Usage
The basic syntax requires defining the strobemer parameters and specifying the reference and query files.

```bash
namfinder -k <strobe_size> -s <sub_kmer_size> -l <min_dist> -u <max_dist> -C <cutoff> -o <output.tsv> <ref.fa> <query.fq>
```

### Parameter Guidelines
*   **-k (Strobe size)**: Defines the length of the individual strobes.
*   **-s (Sub-k-mer size)**: Used for thinning via syncmers. To disable thinning and use all k-mers, set `-s` to the same value as `-k`.
*   **-l and -u (Window boundaries)**: These define the minimum and maximum relative distance for sampling the downstream strobe.
*   **-C**: Complexity/cutoff parameter for hit filtering.
*   **-o**: Specifies the output path for the MUMmer-style TSV file.

## Expert Tips and Best Practices
*   **Strobemer Order**: Currently, namfinder only supports strobemers of order 2. Do not attempt to configure higher-order strobemers.
*   **Thinning Strategy**: Use the `-s` parameter to control the density of the index. Smaller values of `s` relative to `k` will result in more aggressive thinning, reducing memory usage and increasing speed at the potential cost of sensitivity.
*   **Performance Warning**: As of the current version, the tool may encounter squared complexity issues when performing full genome-to-genome comparisons. It is best suited for transcript-to-genome mapping or smaller reference sets.
*   **Input Formats**: The tool accepts standard FASTA (.fa) and FASTQ (.fq) formats for both reference and query sequences.

## Reference documentation
- [namfinder Repository Overview](./references/github_com_ksahlin_namfinder.md)