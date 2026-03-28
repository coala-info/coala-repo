# snakebids CWL Generation Report

## snakebids_create

### Tool Description
Create a new snakebids project.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakebids:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/khanlab/snakebids
- **Package**: https://anaconda.org/channels/bioconda/packages/snakebids/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snakebids/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/khanlab/snakebids
- **Stars**: N/A
### Original Help Text
```text
usage: snakebids create [-h] [--snakebids-version VERSION_SPECIFIER]
                        [output_dir]

positional arguments:
  output_dir

options:
  -h, --help            show this help message and exit
  --snakebids-version VERSION_SPECIFIER
                        Specify snakebids version requirement. Supports either
                        a valid version specifier (e.g. `>=x.x.x`, `==a.b.c`)
                        or a url prepended with `@` (e.g. `@ https://...`).
                        Paths can be specified with `@
                        file:///absolute/path/...`. Markers and extras may not
                        be specified.
```


## snakebids_boutiques

### Tool Description
Generate a Boutiques descriptor for a Snakebids app.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakebids:0.15.0--pyhdfd78af_0
- **Homepage**: https://github.com/khanlab/snakebids
- **Package**: https://anaconda.org/channels/bioconda/packages/snakebids/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakebids boutiques [-h] [--app_dir APP_DIR] out_path

positional arguments:
  out_path           Path for the output Boutiques descriptor. Should be a
                     .json file.

options:
  -h, --help         show this help message and exit
  --app_dir APP_DIR  Location of the Snakebids app. Defaults to the current
                     directory.
```


## Metadata
- **Skill**: generated
