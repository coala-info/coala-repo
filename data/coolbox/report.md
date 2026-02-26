# coolbox CWL Generation Report

## coolbox

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/coolbox:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/GangCaoLab/CoolBox
- **Package**: https://anaconda.org/channels/bioconda/packages/coolbox/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/coolbox/overview
- **Total Downloads**: 29.3K
- **Last updated**: 2025-11-11
- **GitHub**: https://github.com/GangCaoLab/CoolBox
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/coolbox", line 5, in <module>
    from coolbox.__main__ import main
  File "/usr/local/lib/python3.12/site-packages/coolbox/__main__.py", line 3, in <module>
    from coolbox.cli import CLI
  File "/usr/local/lib/python3.12/site-packages/coolbox/cli.py", line 13, in <module>
    from coolbox.api import *
  File "/usr/local/lib/python3.12/site-packages/coolbox/api.py", line 70, in <module>
    from coolbox.core.track import *
  File "/usr/local/lib/python3.12/site-packages/coolbox/core/track/__init__.py", line 1, in <module>
    from .bam import Track
  File "/usr/local/lib/python3.12/site-packages/coolbox/core/track/bam.py", line 8, in <module>
    from coolbox.utilities.reader.tab import get_indexed_tab_reader
  File "/usr/local/lib/python3.12/site-packages/coolbox/utilities/reader/tab.py", line 7, in <module>
    import oxbow as ox
ModuleNotFoundError: No module named 'oxbow'
```

