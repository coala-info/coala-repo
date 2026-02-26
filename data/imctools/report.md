# imctools CWL Generation Report

## imctools

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/imctools:2.1.8--pyhdfd78af_0
- **Homepage**: https://github.com/BodenmillerGroup/imctools
- **Package**: https://anaconda.org/channels/bioconda/packages/imctools/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/imctools/overview
- **Total Downloads**: 24.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BodenmillerGroup/imctools
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/imctools", line 7, in <module>
    from imctools.cli import main
  File "/usr/local/lib/python3.11/site-packages/imctools/cli.py", line 5, in <module>
    from imctools.converters import (
  File "/usr/local/lib/python3.11/site-packages/imctools/converters/__init__.py", line 1, in <module>
    from .exportacquisitioncsv import export_acquisition_csv
  File "/usr/local/lib/python3.11/site-packages/imctools/converters/exportacquisitioncsv.py", line 11, in <module>
    from imctools.data import Session
  File "/usr/local/lib/python3.11/site-packages/imctools/data/__init__.py", line 4, in <module>
    from .session import *
  File "/usr/local/lib/python3.11/site-packages/imctools/data/session.py", line 16, in <module>
    from imctools.io.utils import META_CSV_SUFFIX, sort_acquisition_channels
  File "/usr/local/lib/python3.11/site-packages/imctools/io/utils.py", line 7, in <module>
    import xtiff
ModuleNotFoundError: No module named 'xtiff'
```

