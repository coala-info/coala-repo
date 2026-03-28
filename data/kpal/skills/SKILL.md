---
name: kpal
description: kpal is a toolkit for generating, manipulating, and comparing k-mer frequency profiles for alignment-free sequence analysis. Use when user asks to count k-mers, calculate distances between sequencing datasets, generate distance matrices, or shrink and balance k-mer profiles.
homepage: https://github.com/LUMC/kPAL
---

# kpal

## Overview

kpal (k-mer Profile Analysis Library) is a specialized toolkit designed for the generation, manipulation, and comparison of k-mer frequency profiles. By focusing on alignment-free analysis, kpal allows for the rapid assessment of Next-Generation Sequencing (NGS) data quality. It is particularly effective at identifying technical biases, such as high duplication rates or contamination, and can be used to study microbial community shifts in metagenomic datasets where reference genomes may be unavailable.

## Core CLI Operations

### Counting k-mers
The primary entry point is generating a profile from sequence data.
- **Basic count**: `kpal count -k <length> <input.fasta> <output.h5>`
- **Per-record counting**: Use `--by-record` (or `-r`) to create individual profiles for every sequence in a multi-FASTA file instead of one aggregate profile.
- **Naming**: Use `-n <name>` to label the profile within the HDF5 container.

### Comparing Profiles
kpal provides tools to measure the similarity or distance between sequencing datasets.
- **Pairwise distance**: `kpal distance <profile1.h5> <profile2.h5>`
- **Distance Matrix**: Generate a full matrix for multiple profiles:
  `kpal matrix <p1.h5> <p2.h5> <p3.h5> -o matrix.txt`
- **Metrics**: Supports `euclidean` (default) and `cosine` similarity. Use `-m cosine` to switch metrics.

### Profile Manipulation
- **Shrinking**: Reduce the k-mer length of an existing profile without re-counting from the source FASTA:
  `kpal shrink -f <factor> <input.h5> <output.h5>` (where new $k = old\_k - factor$).
- **Balancing**: Enforce strand balance (averaging counts of k-mers and their reverse complements), which is essential for double-stranded DNA analysis:
  `kpal balance <input.h5> <output.h5>`
- **Concatenation**: Merge multiple HDF5 profile files into a single file:
  `kpal cat <input1.h5> <input2.h5> <output.h5>`

## Python Library Usage

For advanced workflows, use the `kpal.klib` and `kpal.kdistlib` modules.

```python
from kpal.klib import Profile
import h5py

# Load a profile
with h5py.File('data.h5', 'r') as h:
    p = Profile.from_file(h, name='sample1')

# Basic stats
print(p.total, p.mean, p.median)

# Manipulation
p.balance()
p.shrink(factor=2)

# Calculate distance
from kpal.kdistlib import ProfileDistance
pd = ProfileDistance(distance_function='euclidean')
dist = pd.distance(profile_a, profile_b)
```

## Expert Tips & Best Practices

- **Choosing K**: For most QC tasks, $k=9$ to $k=11$ provides a good balance between sensitivity and computational overhead. Larger $k$ values exponentially increase memory and storage requirements ($4^k$).
- **HDF5 Management**: Since kpal uses HDF5, you can store hundreds of profiles in a single `.h5` file. Use the `cat` command to organize your library.
- **Alignment-Free QC**: To detect contamination, compare your sample profile against a "clean" reference profile of the same species. A high Euclidean distance often indicates technical artifacts or foreign DNA.
- **Vectorization**: When using the Python API for custom merge functions, ensure your functions are NumPy-vectorized for performance.



## Subcommands

| Command | Description |
|---------|-------------|
| kpal balance | Balance k-mer profiles. |
| kpal matrix | Make a distance matrix between any number of k-mer profiles. |
| kpal scale | Scale two profiles such that the total number of k-mers is equal. If the files contain more than one profile, they are linked by name and processed pairwise. |
| kpal shrink | Shrink k-mer profiles, effectively reducing k. |
| kpal shuffle | Randomise k-mer profiles. |
| kpal_cat | Save k-mer profiles from several files to one k-mer profile file. |
| kpal_convert | Save k-mer profiles from files in the old plaintext format (used by kPAL versions < 1.0.0) to a k-mer profile file in the current HDF5 format. |
| kpal_count | Make k-mer profiles from FASTA files. |
| kpal_distance | Calculate the distance between two k-mer profiles. If the files contain more than one profile, they are linked by name and processed pairwise. |
| kpal_distr | Calculate the distribution of the values in k-mer profiles. Every output line has the name of the profile, the count and the number of k-mers with this count. |
| kpal_getcount | Retrieve the counts in k-mer profiles for a particular word. |
| kpal_info | Print some information about k-mer profiles. |
| kpal_merge | Merge k-mer profiles. If the files contain more than one profile, they are linked by name and merged pairwise. The resulting profile name is set to that of the original profiles if they match, or to their concatenation otherwise. |
| kpal_positive | Only keep counts that are positive in both k-mer profiles. If the files contain more than one profile, they are linked by name and processed pairwise. |
| kpal_showbalance | Show the balance of k-mer profiles. |
| kpal_smooth | Smooth two profiles by collapsing sub-profiles. If the files contain more than one profile, they are linked by name and processed pairwise. |
| kpal_stats | Show the mean and standard deviation of k-mer profiles. |

## Reference documentation
- [kPAL Tutorial](./references/kpal_readthedocs_io_en_latest_tutorial.html.md)
- [API Reference](./references/kpal_readthedocs_io_en_latest_api.html.md)
- [k-mer Profile File Format](./references/kpal_readthedocs_io_en_latest_fileformat.html.md)
- [Methodology Overview](./references/kpal_readthedocs_io_en_latest_method.html.md)