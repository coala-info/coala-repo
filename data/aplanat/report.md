# aplanat CWL Generation Report

## aplanat_demo

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/aplanat:0.5.6--pyhfa5458b_0
- **Homepage**: https://github.com/epi2me-labs/aplanat
- **Package**: https://anaconda.org/channels/bioconda/packages/aplanat/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/aplanat/overview
- **Total Downloads**: 56.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/epi2me-labs/aplanat
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/aplanat", line 10, in <module>
    sys.exit(cli())
  File "/usr/local/lib/python3.10/site-packages/aplanat/__init__.py", line 200, in cli
    mod = importlib.import_module('aplanat.components.{}'.format(module))
  File "/usr/local/lib/python3.10/importlib/__init__.py", line 126, in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
  File "<frozen importlib._bootstrap>", line 1050, in _gcd_import
  File "<frozen importlib._bootstrap>", line 1027, in _find_and_load
  File "<frozen importlib._bootstrap>", line 1006, in _find_and_load_unlocked
  File "<frozen importlib._bootstrap>", line 688, in _load_unlocked
  File "<frozen importlib._bootstrap_external>", line 883, in exec_module
  File "<frozen importlib._bootstrap>", line 241, in _call_with_frames_removed
  File "/usr/local/lib/python3.10/site-packages/aplanat/components/demo.py", line 11, in <module>
    from aplanat import \
  File "/usr/local/lib/python3.10/site-packages/aplanat/graphics.py", line 15, in <module>
    import sigfig
ModuleNotFoundError: No module named 'sigfig'
```

