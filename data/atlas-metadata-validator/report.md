# atlas-metadata-validator CWL Generation Report

## atlas-metadata-validator_atlas_validation.py

### Tool Description
Validates Atlas metadata files.

### Metadata
- **Docker Image**: quay.io/biocontainers/atlas-metadata-validator:1.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/atlas-metadata-validator
- **Package**: https://anaconda.org/channels/bioconda/packages/atlas-metadata-validator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/atlas-metadata-validator/overview
- **Total Downloads**: 23.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/atlas-metadata-validator
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/lib/python3.9/site-packages/git/__init__.py", line 87, in <module>
    refresh()
  File "/usr/local/lib/python3.9/site-packages/git/__init__.py", line 76, in refresh
    if not Git.refresh(path=path):
  File "/usr/local/lib/python3.9/site-packages/git/cmd.py", line 340, in refresh
    raise ImportError(err)
ImportError: Bad git executable.
The git executable must be specified in one of the following ways:
    - be included in your $PATH
    - be set via $GIT_PYTHON_GIT_EXECUTABLE
    - explicitly set via git.refresh()

All git commands will error until this is rectified.

This initial warning can be silenced or aggravated in the future by setting the
$GIT_PYTHON_REFRESH environment variable. Use one of the following values:
    - quiet|q|silence|s|none|n|0: for no warning or exception
    - warn|w|warning|1: for a printed warning
    - error|e|raise|r|2: for a raised exception

Example:
    export GIT_PYTHON_REFRESH=quiet


The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/usr/local/bin/atlas_validation.py", line 12, in <module>
    from atlas_metadata_validator.parser import get_sdrf_path, guess_submission_type_from_sdrf, guess_submission_type_from_idf, \
  File "/usr/local/lib/python3.9/site-packages/atlas_metadata_validator/parser.py", line 8, in <module>
    from atlas_metadata_validator.fetch import get_controlled_vocabulary
  File "/usr/local/lib/python3.9/site-packages/atlas_metadata_validator/fetch.py", line 10, in <module>
    import git
  File "/usr/local/lib/python3.9/site-packages/git/__init__.py", line 89, in <module>
    raise ImportError('Failed to initialize: {0}'.format(exc)) from exc
ImportError: Failed to initialize: Bad git executable.
The git executable must be specified in one of the following ways:
    - be included in your $PATH
    - be set via $GIT_PYTHON_GIT_EXECUTABLE
    - explicitly set via git.refresh()

All git commands will error until this is rectified.

This initial warning can be silenced or aggravated in the future by setting the
$GIT_PYTHON_REFRESH environment variable. Use one of the following values:
    - quiet|q|silence|s|none|n|0: for no warning or exception
    - warn|w|warning|1: for a printed warning
    - error|e|raise|r|2: for a raised exception

Example:
    export GIT_PYTHON_REFRESH=quiet
```

