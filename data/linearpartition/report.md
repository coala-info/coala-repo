# linearpartition CWL Generation Report

## linearpartition

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/linearpartition:1.0.1.dev20240123--h9948957_1
- **Homepage**: https://github.com/LinearFold/LinearPartition
- **Package**: https://anaconda.org/channels/bioconda/packages/linearpartition/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/linearpartition/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LinearFold/LinearPartition
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/linearpartition", line 88, in <module>
    setgflags()
    ~~~~~~~~~^^
  File "/usr/local/bin/linearpartition", line 31, in setgflags
    argv = FLAGS(sys.argv)
  File "/usr/local/lib/python3.13/site-packages/gflags/flagvalues.py", line 707, in __call__
    raise exceptions.UnrecognizedFlagError(
        name, value, suggestions=suggestions)
gflags.exceptions.UnrecognizedFlagError: Unknown command line flag 'help'
```

