# pycorrfit CWL Generation Report

## pycorrfit

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/pycorrfit:v1.1.5dfsg-1-deb_cv1
- **Homepage**: https://github.com/FCS-analysis/PyCorrFit
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pycorrfit/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/FCS-analysis/PyCorrFit
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/bin/pycorrfit", line 11, in <module>
    load_entry_point('pycorrfit==2018.11.27.dev22', 'gui_scripts', 'pycorrfit')()
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 489, in load_entry_point
    return get_distribution(dist).load_entry_point(group, name)
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2793, in load_entry_point
    return ep.load()
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2411, in load
    return self.resolve()
  File "/usr/lib/python3/dist-packages/pkg_resources/__init__.py", line 2417, in resolve
    module = __import__(self.module_name, fromlist=['__name__'], level=0)
  File "/usr/lib/pycorrfit/pycorrfit/gui/main.py", line 27, in <module>
    matplotlib.use('WXAgg') # Tells matplotlib to use WxWidgets for dialogs
  File "/usr/lib/python3/dist-packages/matplotlib/__init__.py", line 1393, in use
    switch_backend(name)
  File "/usr/lib/python3/dist-packages/matplotlib/pyplot.py", line 222, in switch_backend
    newbackend, required_framework, current_framework))
ImportError: Cannot load backend 'WXAgg' which requires the 'wx' interactive framework, as 'headless' is currently running
```

