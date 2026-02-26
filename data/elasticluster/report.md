# elasticluster CWL Generation Report

## elasticluster

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/elasticluster:0.1.3bcbio--py27_11
- **Homepage**: https://github.com/elasticluster/elasticluster
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/elasticluster/overview
- **Total Downloads**: 8.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/elasticluster/elasticluster
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/elasticluster", line 5, in <module>
    from pkg_resources import load_entry_point
  File "/usr/local/lib/python2.7/site-packages/pkg_resources/__init__.py", line 2976, in <module>
    @_call_aside
  File "/usr/local/lib/python2.7/site-packages/pkg_resources/__init__.py", line 2962, in _call_aside
    f(*args, **kwargs)
  File "/usr/local/lib/python2.7/site-packages/pkg_resources/__init__.py", line 2989, in _initialize_master_working_set
    working_set = WorkingSet._build_master()
  File "/usr/local/lib/python2.7/site-packages/pkg_resources/__init__.py", line 660, in _build_master
    ws.require(__requires__)
  File "/usr/local/lib/python2.7/site-packages/pkg_resources/__init__.py", line 968, in require
    needed = self.resolve(parse_requirements(requirements))
  File "/usr/local/lib/python2.7/site-packages/pkg_resources/__init__.py", line 854, in resolve
    raise DistributionNotFound(req, requirers)
pkg_resources.DistributionNotFound: The 'python-novaclient' distribution was not found and is required by elasticluster
```

