# automappa CWL Generation Report

## automappa

### Tool Description
A tool for mapping and analyzing genomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/automappa:2.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/WiscEvan/Automappa
- **Package**: https://anaconda.org/channels/bioconda/packages/automappa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/automappa/overview
- **Total Downloads**: 2.7K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/WiscEvan/Automappa
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/automappa", line 6, in <module>
    from automappa.__main__ import main
  File "/usr/local/lib/python3.12/site-packages/automappa/__main__.py", line 7, in <module>
    from automappa import settings
  File "/usr/local/lib/python3.12/site-packages/automappa/settings.py", line 81, in <module>
    server = ServerSettings()
             ^^^^^^^^^^^^^^^^
  File "pydantic/env_settings.py", line 40, in pydantic.env_settings.BaseSettings.__init__
  File "pydantic/main.py", line 347, in pydantic.main.BaseModel.__init__
pydantic.error_wrappers.ValidationError: 1 validation error for ServerSettings
root_upload_folder
  field required (type=value_error.missing)
```

