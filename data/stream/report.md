# stream CWL Generation Report

## stream

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/stream:0.4.0--py37r36hc99cbb1_0
- **Homepage**: https://github.com/pinellolab/stream
- **Package**: https://anaconda.org/channels/bioconda/packages/stream/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/stream/overview
- **Total Downloads**: 123.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pinellolab/stream
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/stream", line 11, in <module>
    load_entry_point('stream==0.4.0', 'console_scripts', 'stream')()
  File "/usr/local/lib/python3.7/site-packages/pkg_resources/__init__.py", line 489, in load_entry_point
    return get_distribution(dist).load_entry_point(group, name)
  File "/usr/local/lib/python3.7/site-packages/pkg_resources/__init__.py", line 2852, in load_entry_point
    return ep.load()
  File "/usr/local/lib/python3.7/site-packages/pkg_resources/__init__.py", line 2443, in load
    return self.resolve()
  File "/usr/local/lib/python3.7/site-packages/pkg_resources/__init__.py", line 2449, in resolve
    module = __import__(self.module_name, fromlist=['__name__'], level=0)
  File "/usr/local/lib/python3.7/site-packages/stream/__init__.py", line 1, in <module>
    from .core import *
  File "/usr/local/lib/python3.7/site-packages/stream/core.py", line 10, in <module>
    import shapely.geometry as geom
  File "/usr/local/lib/python3.7/site-packages/shapely/geometry/__init__.py", line 4, in <module>
    from .base import CAP_STYLE, JOIN_STYLE
  File "/usr/local/lib/python3.7/site-packages/shapely/geometry/base.py", line 17, in <module>
    from shapely.coords import CoordinateSequence
  File "/usr/local/lib/python3.7/site-packages/shapely/coords.py", line 8, in <module>
    from shapely.geos import lgeos
  File "/usr/local/lib/python3.7/site-packages/shapely/geos.py", line 76, in <module>
    free = load_dll('c').free
  File "/usr/local/lib/python3.7/site-packages/shapely/geos.py", line 56, in load_dll
    libname, fallbacks or []))
OSError: Could not find lib c or load any of its variants [].
```

