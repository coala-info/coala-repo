---
name: sparse-neighbors-search
description: This tool performs high-performance approximate nearest neighbor searches in high-dimensional sparse datasets using Locality Sensitive Hashing. Use when user asks to find similar items in sparse matrices, perform MinHash or WTA-Hash searches, or identify neighbors in datasets with massive feature spaces.
homepage: https://github.com/joachimwolff/sparse-neighbors-search
metadata:
  docker_image: "quay.io/biocontainers/sparse-neighbors-search:0.7--py38h8ded8fe_2"
---

# sparse-neighbors-search

## Overview
The `sparse-neighbors-search` tool provides a high-performance Python/C++ implementation for finding approximate nearest neighbors in sparse data structures. By utilizing Locality Sensitive Hashing (LSH) techniques—specifically MinHash and WTA-Hash (Winner-Take-All)—it circumvents the "curse of dimensionality" that slows down traditional exact search methods. This skill is most valuable when working with datasets where the feature space is massive (e.g., 1,000,000+) but the average number of non-zero entries per row is small (e.g., <500).

## Installation and Environment
The package is primarily distributed via Bioconda. Note that it requires hardware support for SSE4.1 and a C++11 compatible environment.

```bash
# Recommended installation via Conda
conda install -c bioconda sparse-neighbors-search

# Installation from source with OpenMP support (Linux default)
python setup.py install --user --openmp
```

**Hardware/OS Constraints:**
*   **CPU:** Requires SSE4.1 support.
*   **OS:** Officially supports Linux. macOS support is deprecated/unstable since version 0.3.
*   **GPU:** CUDA support was removed in version 0.6; use CPU-based parallelization via OpenMP instead.

## Python Usage Patterns
The tool follows a scikit-learn-like API, making it easy to integrate into existing data science pipelines.

### Basic MinHash Search
Use `MinHash` for standard sparse binary or frequency data.

```python
from sparse_neighbors_search import MinHash
import scipy.sparse

# X should be a sparse matrix (e.g., csr_matrix)
minHash = MinHash(n_neighbors=10, n_hashes=128)
minHash.fit(X)

# Retrieve neighbor indices
# return_distance=False returns only indices; True returns (distances, indices)
neighbors = minHash.kneighbors(X, return_distance=False)
```

### Performance Tuning
*   **n_hashes:** Increasing the number of hashes improves accuracy but increases memory usage and computation time.
*   **Parallelization:** On Linux, the tool uses OpenMP by default. Ensure your environment variables (like `OMP_NUM_THREADS`) are configured to utilize available cores.
*   **Memory Management:** For extremely large datasets, ensure the input `X` is already in a compressed sparse format (CSR or CSC) to avoid unnecessary dense conversions.

## Expert Tips and Troubleshooting
*   **Data Sparsity:** If your data is relatively dense (e.g., >10% non-zero features), traditional ANN libraries like Faiss or HNSWlib may perform better. This tool is specifically optimized for "very sparse" data.
*   **GCC Compatibility:** Users on modern Linux distributions (e.g., Ubuntu 22.04+) may encounter build failures with GCC 11.3.0. If installing from source, consider using an older GCC version or the pre-compiled Bioconda binaries.
*   **Similarity Measures:** The tool can be configured to use the number of hash collisions as a direct similarity measure, which is significantly faster than calculating Euclidean or Cosine distances on million-dimensional vectors.
*   **Single-Cell Genomics:** This tool is the underlying engine for specific single-cell Hi-C clustering workflows. When using it for genomic data, ensure feature IDs are consistent across the entire sparse matrix.

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sparse-neighbors-search_overview.md)
- [GitHub Repository and Documentation](./references/github_com_joachimwolff_sparse-neighbors-search.md)
- [Known Issues and Build Failures](./references/github_com_joachimwolff_sparse-neighbors-search_issues.md)