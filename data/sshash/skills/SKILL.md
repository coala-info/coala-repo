---
name: sshash
description: SSHash is a high-performance C++ data structure designed to store and query large sets of DNA k-mers using a compressed dictionary. Use when user asks to build a k-mer index, query k-mer membership, retrieve k-mer weights, or perform navigational queries for genome analysis.
homepage: https://github.com/jermp/sshash
---

# sshash

## Overview

SSHash (Sparse and Skew Hashing) is a high-performance C++ data structure designed to store and query large sets of DNA k-mers efficiently. It functions as a compressed dictionary that maps k-mers to unique identifiers or frequency counts (weights). By utilizing sparse and skew hashing techniques, it achieves a significantly lower memory footprint than traditional hash tables while maintaining high query throughput. This tool is particularly useful for bioinformatics applications such as genome assembly verification, sequence search, and k-mer counting.

## Usage Instructions

### Installation and Setup

SSHash can be installed via Bioconda or built from source using CMake.

**Bioconda:**
```bash
conda install -c bioconda sshash
```

**Build from Source:**
```bash
git clone --recursive https://github.com/jermp/sshash.git
cd sshash
mkdir build && cd build
cmake ..
make -j
```
*Note: To support k-mers longer than 31 (up to 63), use `cmake .. -D SSHASH_USE_MAX_KMER_LENGTH_63=On`.*

### Building an Index

To use SSHash, you must first build an index from a FASTA or FASTQ file.

```bash
# Basic build
./sshash build -i input.fasta -k 31 -m 13 -o index.sshash

# Weighted build (to store k-mer frequencies)
./sshash build -i input.fasta -k 31 -m 13 --weighted -o index.weighted.sshash
```

**Key Parameters:**
- `-k`: The length of the k-mers (default is 31).
- `-m`: The minimizer length (must be less than $k$). A common choice is $m \approx \log_4(N)$ where $N$ is the number of k-mers.
- `-l`: The sparse index step (default is 1). Increasing this reduces memory but slows down queries.
- `--weighted`: Required if you need to perform `Weight(i)` queries to retrieve k-mer counts.

### Querying the Index

Once the index is built, you can perform various lookups.

**Membership and Lookup:**
```bash
./sshash query -i index.sshash -q queries.fasta
```

**Supported Query Types:**
- **Lookup(x)**: Returns the unique identifier $i \in [0, n)$ for k-mer $x$, or -1 if not found.
- **Access(i)**: Returns the k-mer string associated with identifier $i$.
- **Weight(i)**: Returns the frequency count of the k-mer (requires a weighted index).
- **Membership**: Checks if a k-mer exists in the dictionary.

### Advanced CLI Patterns

**Streaming Queries:**
Process all k-mers in a DNA file to determine their presence in the dictionary:
```bash
./sshash query -i index.sshash -q input.fastq --stream
```

**Navigational Queries:**
Determine the forward or backward neighborhood of a k-mer (useful for graph traversal):
```bash
# Check for x[2..k] + {A,C,G,T} and {A,C,G,T} + x[1..k-1]
./sshash navigate -i index.sshash -q queries.fasta
```

### Expert Tips

1. **Memory Optimization**: If memory is tight, increase the `-l` parameter during the build phase. This increases the "sparseness" of the index.
2. **Canonical K-mers**: SSHash assumes that a k-mer and its reverse complement are identical. Ensure your input data follows this convention or use the tool's default behavior which handles canonical representation.
3. **Minimizer Selection**: The choice of $m$ significantly impacts performance. If queries are slow, try adjusting $m$ relative to your dataset size.
4. **Architecture Native**: For maximum performance on your specific CPU, compile with `-D SSHASH_USE_ARCH_NATIVE=On`.



## Subcommands

| Command | Description |
|---------|-------------|
| sshash permute | Permute the order of sequences in a FASTA file. |
| sshash_build | Build a shash index from a FASTA file. |

## Reference documentation
- [SSHash GitHub Repository](./references/github_com_jermp_sshash_blob_master_README.md)
- [SSHash Build Configuration](./references/github_com_jermp_sshash_blob_master_CMakeLists.txt.md)