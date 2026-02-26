# nii2dcm CWL Generation Report

## nii2dcm

### Tool Description
Convert NIfTI files to DICOM series.

### Metadata
- **Docker Image**: quay.io/biocontainers/nii2dcm:0.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/tomaroberts/nii2dcm
- **Package**: https://anaconda.org/channels/bioconda/packages/nii2dcm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nii2dcm/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tomaroberts/nii2dcm
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/nii2dcm", line 7, in <module>
    from nii2dcm.__main__ import cli
  File "/usr/local/lib/python3.10/site-packages/nii2dcm/__main__.py", line 9, in <module>
    from nii2dcm._version import __version__
  File "/usr/local/lib/python3.10/site-packages/nii2dcm/_version.py", line 2, in <module>
    __version__ = Version.from_git().serialize(metadata=False, style=Style.SemVer)
  File "/usr/local/lib/python3.10/site-packages/dunamai/__init__.py", line 1058, in from_git
    _detect_vcs(vcs)
  File "/usr/local/lib/python3.10/site-packages/dunamai/__init__.py", line 350, in _detect_vcs
    raise RuntimeError("Unable to find '{}' program".format(program))
RuntimeError: Unable to find 'git' program
```

