# edentity CWL Generation Report

## edentity

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/edentity:1.5.5--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/edentity/
- **Package**: https://anaconda.org/channels/bioconda/packages/edentity/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/edentity/overview
- **Total Downloads**: 752
- **Last updated**: 2026-02-20
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/edentity", line 5, in <module>
    from edentity.__main__ import main
  File "/usr/local/lib/python3.12/site-packages/edentity/__main__.py", line 7, in <module>
    from edentity.workflow.scripts.custom_multiqc_module import run_qc_mode_multiqc
  File "/usr/local/lib/python3.12/site-packages/edentity/workflow/scripts/custom_multiqc_module.py", line 4, in <module>
    import polars as pl
ModuleNotFoundError: No module named 'polars'
```

