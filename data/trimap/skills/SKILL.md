---
name: trimap
description: TriMap is a dimensionality reduction method that utilizes triplet constraints to create low-dimensional embeddings.
homepage: http://github.com/eamid/trimap
---

# trimap

## Overview
TriMap is a dimensionality reduction method that utilizes triplet constraints to create low-dimensional embeddings. By sampling triplets of points (where point $i$ is closer to $j$ than to $k$), it captures the underlying structure of complex datasets more effectively than methods like t-SNE or UMAP in terms of global layout. It is particularly useful for large-scale datasets where maintaining the semantic relationship between distant clusters is critical for interpretation.

## Installation
TriMap can be installed via pip or conda:
```bash
# Via pip
pip install trimap

# Via bioconda
conda install bioconda::trimap
```

## Core Usage Patterns
TriMap follows the scikit-learn transformer API.

### Basic Embedding
To reduce data to 2 dimensions using default parameters:
```python
import trimap
from sklearn.datasets import load_digits

data = load_digits().data
embedding = trimap.TRIMAP().fit_transform(data)
```

### Using Precomputed Distances
If you already have a pairwise distance matrix `D`:
```python
embedding = trimap.TRIMAP(use_dist_matrix=True).fit_transform(D)
```

### Evaluating Embedding Quality
TriMap provides a `global_score` to quantify how well the embedding reflects the high-dimensional global structure:
```python
trimap_obj = trimap.TRIMAP(verbose=False)
embedding = trimap_obj.fit_transform(data)
gs = trimap_obj.global_score(data, embedding)
print(f"Global Score: {gs:.2f}")
```

## Parameter Tuning and Best Practices

### Balancing Local vs. Global Structure
*   **n_inliers (default=12):** Controls the number of nearest neighbor triplets. Increasing this helps preserve local structure.
*   **n_outliers (default=4):** Controls triplets formed with distant points. This is key to TriMap's superior global view.
*   **n_random (default=3):** Random triplets per point to further stabilize the global layout.

### Optimization and Distance Metrics
*   **distance:** Supports 'euclidean' (default), 'manhattan', 'angular' (cosine), and 'hamming'.
*   **weight_temp (default=0.5):** Adjusts the "compactness" of the clusters. Higher values result in tighter, more compact cluster representations.
*   **apply_pca (default=True):** Automatically reduces data to 100 dimensions before neighbor search. Disable this if your data is already pre-processed or low-dimensional.

### Expert Tips
*   **Large Datasets:** For very large datasets, precompute the k-nearest neighbors (KNN) and pass them as a tuple `(knn_nbrs, knn_distances)` to the `knn_tuple` parameter to save computation time during iterative testing.
*   **Memory Management:** If running out of memory on massive datasets, ensure `apply_pca` is enabled or manually reduce dimensions before passing data to TriMap.
*   **Convergence:** If the embedding looks "exploded" or unformed, try reducing the learning rate (`lr`, default 0.1) or increasing the number of iterations (`n_iters`, default 400).

## Reference documentation
- [TriMap GitHub Repository](./references/github_com_eamid_trimap.md)
- [Bioconda TriMap Overview](./references/anaconda_org_channels_bioconda_packages_trimap_overview.md)