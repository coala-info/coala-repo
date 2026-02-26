# pyomo CWL Generation Report

## pyomo

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyomo:4.1.10527--py34_0
- **Homepage**: https://github.com/Pyomo/pyomo
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyomo/overview
- **Total Downloads**: 19.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Pyomo/pyomo
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/lib/python3.4/site-packages/pkg_resources/__init__.py", line 660, in _build_master
    ws.require(__requires__)
  File "/usr/local/lib/python3.4/site-packages/pkg_resources/__init__.py", line 968, in require
    needed = self.resolve(parse_requirements(requirements))
  File "/usr/local/lib/python3.4/site-packages/pkg_resources/__init__.py", line 859, in resolve
    raise VersionConflict(dist, req).with_context(dependent_req)
pkg_resources.ContextualVersionConflict: (PyUtilib 5.4 (/usr/local/lib/python3.4/site-packages), Requirement.parse('PyUtilib==5.1.3556'), {'Pyomo'})

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/usr/local/bin/pyomo", line 5, in <module>
    from pkg_resources import load_entry_point
  File "/usr/local/lib/python3.4/site-packages/pkg_resources/__init__.py", line 2976, in <module>
    @_call_aside
  File "/usr/local/lib/python3.4/site-packages/pkg_resources/__init__.py", line 2962, in _call_aside
    f(*args, **kwargs)
  File "/usr/local/lib/python3.4/site-packages/pkg_resources/__init__.py", line 2989, in _initialize_master_working_set
    working_set = WorkingSet._build_master()
  File "/usr/local/lib/python3.4/site-packages/pkg_resources/__init__.py", line 662, in _build_master
    return cls._build_from_requirements(__requires__)
  File "/usr/local/lib/python3.4/site-packages/pkg_resources/__init__.py", line 675, in _build_from_requirements
    dists = ws.resolve(reqs, Environment())
  File "/usr/local/lib/python3.4/site-packages/pkg_resources/__init__.py", line 854, in resolve
    raise DistributionNotFound(req, requirers)
pkg_resources.DistributionNotFound: The 'PyUtilib==5.1.3556' distribution was not found and is required by Pyomo
```

