# apollo CWL Generation Report

## apollo

### Tool Description
FAIL to generate CWL: apollo not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/apollo:4.2.13--pyh5e36f6f_0
- **Homepage**: https://github.com/galaxy-genome-annotation/python-apollo
- **Package**: https://anaconda.org/channels/bioconda/packages/apollo/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/apollo/overview
- **Total Downloads**: 42.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/galaxy-genome-annotation/python-apollo
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: apollo not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: apollo not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## apollo_arrow

### Tool Description
Command line wrappers around Apollo functions. While this sounds unexciting, with arrow and jq you can easily build powerful command line scripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/apollo:4.2.13--pyh5e36f6f_0
- **Homepage**: https://github.com/galaxy-genome-annotation/python-apollo
- **Package**: https://anaconda.org/channels/bioconda/packages/apollo/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: arrow [OPTIONS] COMMAND [ARGS]...

  Command line wrappers around Apollo functions. While this sounds unexciting,
  with arrow and jq you can easily build powerful command line scripts.

Options:
  --version                       Show the version and exit.
  -v, --verbose                   Enables verbose mode.
  -a, --apollo_instance TEXT      name of apollo instance from
                                  /user/qianghu/.apollo-arrow.yml  [default:
                                  __default;required]
  -l, --log-level [debug|info|warn|error|critical]
                                  Logging level  [default: warn]
  -h, --help                      Show this message and exit.

Commands:
  init            Help initialize global configuration (in home directory)
  annotations
  cannedcomments
  cannedkeys
  cannedvalues
  groups
  io
  metrics
  organisms
  status
  users
  remote
```

