# apollo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| apollo_arrow | Not completed | arrow is a client for a running Apollo annotation web server, which is not available in this test; group options moved before the subcommand. |

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

