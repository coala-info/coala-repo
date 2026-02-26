# scepia CWL Generation Report

## scepia

### Tool Description
SCEPIA: Single-cell RNA sequencing data analysis pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/scepia:0.5.1--pyhdfd78af_1
- **Homepage**: https://github.com/vanheeringen-lab/scepia
- **Package**: https://anaconda.org/channels/bioconda/packages/scepia/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scepia/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vanheeringen-lab/scepia
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/scepia", line 7, in <module>
    from scepia.cli import cli
  File "/usr/local/lib/python3.9/site-packages/scepia/cli.py", line 5, in <module>
    from scepia.sc import full_analysis
  File "/usr/local/lib/python3.9/site-packages/scepia/sc.py", line 20, in <module>
    import scanpy as sc
  File "/usr/local/lib/python3.9/site-packages/scanpy/__init__.py", line 6, in <module>
    from ._utils import check_versions
  File "/usr/local/lib/python3.9/site-packages/scanpy/_utils/__init__.py", line 29, in <module>
    from .compute.is_constant import is_constant
  File "/usr/local/lib/python3.9/site-packages/scanpy/_utils/compute/is_constant.py", line 5, in <module>
    from numba import njit
  File "/usr/local/lib/python3.9/site-packages/numba/__init__.py", line 43, in <module>
    from numba.np.ufunc import (vectorize, guvectorize, threading_layer,
  File "/usr/local/lib/python3.9/site-packages/numba/np/ufunc/__init__.py", line 3, in <module>
    from numba.np.ufunc.decorators import Vectorize, GUVectorize, vectorize, guvectorize
  File "/usr/local/lib/python3.9/site-packages/numba/np/ufunc/decorators.py", line 3, in <module>
    from numba.np.ufunc import _internal
SystemError: initialization of _internal failed without raising an exception
```

