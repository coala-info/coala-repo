# pyclone CWL Generation Report

## pyclone_PyClone

### Tool Description
PyClone is a tool for inferring clonal structure from tumor sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyclone:0.13.1--py_0
- **Homepage**: https://github.com/Roth-Lab/pyclone/
- **Package**: https://anaconda.org/channels/bioconda/packages/pyclone/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyclone/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Roth-Lab/pyclone
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/PyClone", line 6, in <module>
    from pyclone.cli import main
  File "/usr/local/lib/python2.7/site-packages/pyclone/cli.py", line 7, in <module>
    import pyclone.run as run
  File "/usr/local/lib/python2.7/site-packages/pyclone/run.py", line 27, in <module>
    import pyclone.post_process.plot as plot
  File "/usr/local/lib/python2.7/site-packages/pyclone/post_process/plot/__init__.py", line 1, in <module>
    import clusters
  File "/usr/local/lib/python2.7/site-packages/pyclone/post_process/plot/clusters.py", line 7, in <module>
    import matplotlib.pyplot as pp
  File "/usr/local/lib/python2.7/site-packages/matplotlib/pyplot.py", line 115, in <module>
    _backend_mod, new_figure_manager, draw_if_interactive, _show = pylab_setup()
  File "/usr/local/lib/python2.7/site-packages/matplotlib/backends/__init__.py", line 63, in pylab_setup
    [backend_name], 0)
  File "/usr/local/lib/python2.7/site-packages/matplotlib/backends/backend_tkagg.py", line 4, in <module>
    from . import tkagg  # Paint image to Tk photo blitter extension.
  File "/usr/local/lib/python2.7/site-packages/matplotlib/backends/tkagg.py", line 5, in <module>
    from six.moves import tkinter as Tk
  File "/usr/local/lib/python2.7/site-packages/six.py", line 203, in load_module
    mod = mod._resolve()
  File "/usr/local/lib/python2.7/site-packages/six.py", line 115, in _resolve
    return _import_module(self.mod)
  File "/usr/local/lib/python2.7/site-packages/six.py", line 82, in _import_module
    __import__(name)
  File "/usr/local/lib/python2.7/lib-tk/Tkinter.py", line 39, in <module>
    import _tkinter # If this fails your Python may not be configured for Tk
ImportError: libX11.so.6: cannot open shared object file: No such file or directory
```

