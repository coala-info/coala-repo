# galaxy-ie-helpers CWL Generation Report

## galaxy-ie-helpers_get

### Tool Description
Get datasets from Galaxy.

### Metadata
- **Docker Image**: quay.io/biocontainers/galaxy-ie-helpers:0.2.7--pyh7cba7a3_0
- **Homepage**: https://github.com/bgruening/galaxy_ie_helpers
- **Package**: https://anaconda.org/channels/bioconda/packages/galaxy-ie-helpers/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/galaxy-ie-helpers/overview
- **Total Downloads**: 19.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bgruening/galaxy_ie_helpers
- **Stars**: N/A
### Original Help Text
```text
usage: get [-h] -i ID [ID ...] [-t {hid,name,regex}] [--history-id HISTORY_ID]

Get datasets from Galaxy.

options:
  -h, --help            show this help message and exit
  -i ID [ID ...], --id ID [ID ...]
                        The dataset ID/name from your Galaxy history, or a
                        regex pattern to search all files in the history
  -t {hid,name,regex}, --identifier_type {hid,name,regex}
                        Type of the argument File/ID Number. Per default,
                        integer ID number. If a pattern is specified in the -i
                        argument, then this argument should be set to "regex"
  --history-id HISTORY_ID
                        History ID. The history ID and the dataset ID uniquly
                        identify a dataset. Per default this is set to the
                        current Galaxy history.
```


## galaxy-ie-helpers_put

### Tool Description
Put datasets back into Galaxy.

### Metadata
- **Docker Image**: quay.io/biocontainers/galaxy-ie-helpers:0.2.7--pyh7cba7a3_0
- **Homepage**: https://github.com/bgruening/galaxy_ie_helpers
- **Package**: https://anaconda.org/channels/bioconda/packages/galaxy-ie-helpers/overview
- **Validation**: PASS

### Original Help Text
```text
usage: put [-h] -p FILEPATH [FILEPATH ...] [-t FILETYPE]
           [--history-id HISTORY_ID]

Put datasets back into Galaxy.

options:
  -h, --help            show this help message and exit
  -p FILEPATH [FILEPATH ...], --filepath FILEPATH [FILEPATH ...]
                        Specify the path to the files that should be uploaded
                        to Galaxy.
  -t FILETYPE, --filetype FILETYPE
                        Galaxy file format. If not specified Galaxy will try
                        to guess the filetype automatically.
  --history-id HISTORY_ID
                        History ID. The history ID and the dataset ID uniquly
                        identify a dataset. Per default this is set to the
                        current Galaxy history.
```

