---
name: h5sparse
description: h5sparse is a specialized library designed to bridge the gap between Scipy's sparse matrix formats and the HDF5 storage standard.
homepage: https://github.com/appier/h5sparse
---

# h5sparse

## Overview
h5sparse is a specialized library designed to bridge the gap between Scipy's sparse matrix formats and the HDF5 storage standard. It allows for the efficient persistence of sparse data (primarily CSR format) while maintaining the ability to perform partial reads via slicing and dynamic data growth via appending. Use this skill to manage large-scale sparse data in bioinformatics, machine learning, or any domain where memory efficiency is critical.

## Core Usage Patterns

### Creating Sparse Datasets
To store a Scipy sparse matrix, use the `h5sparse.File` interface. You can create a dataset directly from an existing Scipy sparse matrix.

```python
import scipy.sparse as ss
import h5sparse
import numpy as np

# Create a sample Scipy CSR matrix
sparse_matrix = ss.csr_matrix([[0, 1, 0], [0, 0, 1], [1, 1, 0]], dtype=np.float64)

# Save to HDF5
with h5sparse.File("data.h5", 'w') as h5f:
    h5f.create_dataset('my_sparse_matrix', data=sparse_matrix)
```

### Reading and Slicing
h5sparse supports efficient slicing, allowing you to load only the necessary rows into memory as Scipy sparse matrices.

```python
with h5sparse.File("data.h5", 'r') as h5f:
    # Slice rows 1 through 3
    slice_sparse = h5f['my_sparse_matrix'][1:3]
    
    # Convert slice to dense numpy array if needed
    dense_array = slice_sparse.toarray()
    
    # Load the entire matrix
    full_matrix = h5f['my_sparse_matrix'][()]
```

### Appending Data
To append data to an existing sparse dataset, the dataset must be initialized with `chunks` and a `maxshape` that allows for growth.

```python
to_append = ss.csr_matrix([[0, 1, 1], [1, 0, 0]], dtype=np.float64)

with h5sparse.File("data.h5", 'a') as h5f:
    # Initialize with maxshape=(None,) to allow appending along the first axis
    h5f.create_dataset('appendable_matrix', data=sparse_matrix, chunks=(1000,), maxshape=(None,))
    
    # Append new rows
    h5f['appendable_matrix'].append(to_append)
```

### Integration with h5py
If you are already working with `h5py` objects, you can wrap them with `h5sparse` classes to access sparse functionality.

```python
import h5py

h5py_f = h5py.File("data.h5", 'r')
# Wrap an existing h5py group or dataset
sparse_group = h5sparse.Group(h5py_f['sparse_folder'].id)
sparse_ds = h5sparse.Dataset(h5py_f['sparse_folder/matrix'])

matrix = sparse_ds[()]
```

## Expert Tips
- **Format Support**: While h5sparse is primarily used for CSR (Compressed Sparse Row) matrices, it can also store standard numpy arrays and strings by forwarding the data to the underlying `h5py` implementation.
- **Chunking**: When creating appendable datasets, choose a `chunks` size that balances I/O performance with the frequency of your append operations.
- **Memory Management**: Always use the `[start:stop]` slicing syntax to avoid loading massive datasets into memory unless the full matrix is required for computation.

## Reference documentation
- [github_com_appier_h5sparse.md](./references/github_com_appier_h5sparse.md)
- [anaconda_org_channels_bioconda_packages_h5sparse_overview.md](./references/anaconda_org_channels_bioconda_packages_h5sparse_overview.md)