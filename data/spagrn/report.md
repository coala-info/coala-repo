# spagrn CWL Generation Report

## spagrn

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/spagrn:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/iprada/Circle-Map
- **Package**: https://anaconda.org/channels/bioconda/packages/spagrn/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/spagrn/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/iprada/Circle-Map
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.8/site-packages/libpysal/cg/alpha_shapes.py:39: NumbaDeprecationWarning: [1mThe 'nopython' keyword argument was not supplied to the 'numba.jit' decorator. The implicit default value for this argument is currently False, but it will be changed to True in Numba 0.59.0. See https://numba.readthedocs.io/en/stable/reference/deprecation.html#deprecation-of-object-mode-fall-back-behaviour-when-using-jit for details.[0m
  def nb_dist(x, y):
/usr/local/lib/python3.8/site-packages/libpysal/cg/alpha_shapes.py:165: NumbaDeprecationWarning: [1mThe 'nopython' keyword argument was not supplied to the 'numba.jit' decorator. The implicit default value for this argument is currently False, but it will be changed to True in Numba 0.59.0. See https://numba.readthedocs.io/en/stable/reference/deprecation.html#deprecation-of-object-mode-fall-back-behaviour-when-using-jit for details.[0m
  def get_faces(triangle):
/usr/local/lib/python3.8/site-packages/libpysal/cg/alpha_shapes.py:199: NumbaDeprecationWarning: [1mThe 'nopython' keyword argument was not supplied to the 'numba.jit' decorator. The implicit default value for this argument is currently False, but it will be changed to True in Numba 0.59.0. See https://numba.readthedocs.io/en/stable/reference/deprecation.html#deprecation-of-object-mode-fall-back-behaviour-when-using-jit for details.[0m
  def build_faces(faces, triangles_is, num_triangles, num_faces_single):
/usr/local/lib/python3.8/site-packages/libpysal/cg/alpha_shapes.py:261: NumbaDeprecationWarning: [1mThe 'nopython' keyword argument was not supplied to the 'numba.jit' decorator. The implicit default value for this argument is currently False, but it will be changed to True in Numba 0.59.0. See https://numba.readthedocs.io/en/stable/reference/deprecation.html#deprecation-of-object-mode-fall-back-behaviour-when-using-jit for details.[0m
  def nb_mask_faces(mask, faces):
/usr/local/lib/python3.8/site-packages/libpysal/weights/util.py:23: UserWarning: geopandas not available. Some functionality will be disabled.
  warn("geopandas not available. Some functionality will be disabled.")
Traceback (most recent call last):
  File "/usr/local/bin/spagrn", line 7, in <module>
    from spagrn.cli.spagrn_parser import main
ModuleNotFoundError: No module named 'spagrn.cli'
```

