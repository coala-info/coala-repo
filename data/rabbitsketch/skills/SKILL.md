---
name: rabbitsketch
description: RabbitSketch is a highly optimized sketching library used to generate genomic sketches and calculate distances between large-scale DNA sequences. Use when user asks to compare DNA sequences, generate sketches using algorithms like MinHash or Kssd, and calculate Jaccard distances between genomic datasets.
homepage: https://github.com/RabbitBio/RabbitSketch
metadata:
  docker_image: "quay.io/biocontainers/rabbitsketch:0.1.1--py39h5ca1c30_0"
---

# rabbitsketch

## Overview

RabbitSketch is a highly optimized sketching library designed to exploit modern multi-core CPU architectures for bioinformatics tasks. It provides significant speedups (up to 49x) over traditional implementations when processing massive genomic datasets. Use this skill to guide the installation, configuration, and execution of RabbitSketch for comparing DNA sequences, generating sketches, and calculating distances between large-scale genomic files.

## Installation and Environment Setup

### Conda (Recommended)
The most reliable way to install RabbitSketch is via Bioconda. Note that Python 3.9 is specifically recommended for compatibility with certain dependencies.
```bash
conda create -n py39_env python=3.9
conda activate py39_env
conda config --add channels bioconda
conda config --add channels conda-forge
conda install rabbitsketch
```

### Python API Considerations
If installing via `pip`, you must handle a known incompatibility with the `fastx` dependency on newer Python versions (3.10+).
1. Downgrade build tools: `pip install pip==22.3 setuptools==65.0`
2. Install requirements: `pip install -r requirement.txt`
3. Install the package: `pip install . --user`

### C++ Interface Build
For maximum performance, compile the C++ API directly:
```bash
mkdir build && cd build
cmake -DCXXAPI=ON .. -DCMAKE_INSTALL_PREFIX=.
make && make install
export LD_LIBRARY_PATH=`pwd`/lib:$LD_LIBRARY_PATH
```

## Common CLI Patterns

### Calculating Distance Between Two Genomes
Use the main executable to get a direct distance comparison between two specific FASTA/FNA files.
```bash
./exe_main genome1.fna genome2.fna
```

### Large-Scale Sequence Analysis
To process a directory of sequences using a specific algorithm, use the algorithm-specific executable.
```bash
./exe_SKETCH_ALGORITHM <FILE_PATH> <threshold> <thread_num>
```
*   **Example**: `./exe_minhash /data/genomes/ 0.05 16`
*   **Algorithms supported**: MinHash, WeightedMinHash, OrderMinHash, HyperLogLog (HLL).

### Using the Kssd Algorithm
Kssd requires a pre-generated shuffled file before distance calculation.
1. Generate the shuffle file (default uses L3K10):
   ```bash
   ./exe_generate_shuf_file
   ```
2. Run the distance analysis using the generated `.shuf` file in the `shuf_file/` directory.

## Expert Tips

*   **Performance Tuning**: RabbitSketch is designed for multi-threading. Always match the `thread_num` parameter to your CPU's physical core count for optimal throughput.
*   **Memory Efficiency**: The similarity analysis of 455GB of genomic data can be completed in approximately 5 minutes; ensure your temporary storage/RAM can handle the sketch overhead for such large datasets.
*   **Fedora 39 Compatibility**: If `cmake` fails due to `uv_spawn` errors, manually compile and install the latest `libuv` from source to resolve system library conflicts.
*   **Python Testing**: Use the provided `examples/rabbitsketch_pymp.py` to verify the Python installation and Jaccard index calculations.

## Reference documentation

- [RabbitSketch GitHub Repository](./references/github_com_RabbitBio_RabbitSketch.md)
- [RabbitSketch Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rabbitsketch_overview.md)