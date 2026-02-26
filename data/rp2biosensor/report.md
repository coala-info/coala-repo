# rp2biosensor CWL Generation Report

## rp2biosensor

### Tool Description
Generate HTML outputs to explore Sensing Enabling Metabolic Pathway from RetroPath2 results.

### Metadata
- **Docker Image**: quay.io/biocontainers/rp2biosensor:3.2.1
- **Homepage**: https://github.com/conda-forge/rp2biosensor-feedstock
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/rp2biosensor/overview
- **Total Downloads**: 12.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/conda-forge/rp2biosensor-feedstock
- **Stars**: N/A
### Original Help Text
```text
usage: rp2biosensor [-h] [--opath OPATH] [--otype {dir,file}] [--ojson OJSON]
                    [--cache-dir CACHE_DIR]
                    rp2_results sink_file

Generate HTML outputs to explore Sensing Enabling Metabolic Pathway from
RetroPath2 results.

positional arguments:
  rp2_results           RetroPath2.0 results
  sink_file             Sink file used for RetroPath2.0

options:
  -h, --help            show this help message and exit
  --opath OPATH         Output path. Default: /biosensor.html.
  --otype {dir,file}    Output type. This could be either (i) "dir" which
                        means ouput files will outputted into this directory,
                        or (ii) "file" which means that all files will be
                        embedded into a single HTML page. Default: file
  --ojson OJSON         Output the graph as json file if the path is not None.
                        Default: None
  --cache-dir CACHE_DIR
                        Path to the cache directory. If not specified, None is
                        passed to rrCache.
```


## Metadata
- **Skill**: generated
