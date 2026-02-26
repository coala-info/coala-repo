# epigrass CWL Generation Report

## epigrass

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/epigrass:v2.4.7-1-deb_cv1
- **Homepage**: https://github.com/fccoelho/epigrass
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/epigrass/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/fccoelho/epigrass
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/bin/epigrass", line 6, in <module>
    from pkg_resources import load_entry_point
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 3019, in <module>
    @_call_aside
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 3003, in _call_aside
    f(*args, **kwargs)
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 3032, in _initialize_master_working_set
    working_set = WorkingSet._build_master()
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 655, in _build_master
    ws.require(__requires__)
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 963, in require
    needed = self.resolve(parse_requirements(requirements))
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 849, in resolve
    raise DistributionNotFound(req, requirers)
pkg_resources.DistributionNotFound: The 'dbfread' distribution was not found and is required by epigrass
```

