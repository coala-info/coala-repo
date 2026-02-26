# tissuumaps CWL Generation Report

## tissuumaps

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/tissuumaps:3.2.1.14--pyh7e72e81_0
- **Homepage**: https://tissuumaps.research.it.uu.se/
- **Package**: https://anaconda.org/channels/bioconda/packages/tissuumaps/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/tissuumaps/overview
- **Total Downloads**: 17.4K
- **Last updated**: 2025-05-18
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
INFO:root: * TissUUmaps version: 3.2.1.14
Traceback (most recent call last):
  File "/usr/local/bin/tissuumaps", line 7, in <module>
    from tissuumaps.gui import main
  File "/usr/local/lib/python3.13/site-packages/tissuumaps/__init__.py", line 112, in <module>
    from . import views  # noqa: E402
    ^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/site-packages/tissuumaps/views.py", line 6, in <module>
    import imghdr
ModuleNotFoundError: No module named 'imghdr'
```

