# pbbarcode CWL Generation Report

## pbbarcode

### Tool Description
The provided text is a Python ImportError traceback and does not contain help text or usage information for the tool. As a result, no arguments could be extracted.

### Metadata
- **Docker Image**: biocontainers/pbbarcode:v0.8.0-5-deb_cv1
- **Homepage**: https://github.com/mlbendall/pbbarcode
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbbarcode/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/mlbendall/pbbarcode
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
Traceback (most recent call last):
  File "/usr/bin/pbbarcode", line 11, in <module>
    load_entry_point('pbbarcode==0.8.0', 'console_scripts', 'pbbarcode')()
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 489, in load_entry_point
    return get_distribution(dist).load_entry_point(group, name)
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 2793, in load_entry_point
    return ep.load()
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 2411, in load
    return self.resolve()
  File "/usr/lib/python2.7/dist-packages/pkg_resources/__init__.py", line 2417, in resolve
    module = __import__(self.module_name, fromlist=['__name__'], level=0)
  File "/usr/lib/python2.7/dist-packages/pbbarcode/main.py", line 57, in <module>
    from pbh5tools.CmpH5Utils import copyAttributes
ImportError: No module named pbh5tools.CmpH5Utils
```


## Metadata
- **Skill**: generated
