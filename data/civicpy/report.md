# civicpy CWL Generation Report

## civicpy

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/civicpy:5.2.0--pyhdfd78af_0
- **Homepage**: http://civicpy.org
- **Package**: https://anaconda.org/channels/bioconda/packages/civicpy/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/civicpy/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/griffithlab/civicpy
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/civicpy", line 6, in <module>
    from civicpy.cli import cli
  File "/usr/local/lib/python3.13/site-packages/civicpy/cli.py", line 4, in <module>
    from civicpy import LOCAL_CACHE_PATH, civic
  File "/usr/local/lib/python3.13/site-packages/civicpy/civic.py", line 11, in <module>
    from backports.datetime_fromisoformat import MonkeyPatch
ModuleNotFoundError: No module named 'backports.datetime_fromisoformat'
```

