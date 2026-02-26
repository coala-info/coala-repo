# galaxy-upload CWL Generation Report

## galaxy-upload

### Tool Description
Upload files to a Galaxy instance

### Metadata
- **Docker Image**: quay.io/biocontainers/galaxy-upload:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproject/galaxy-upload
- **Package**: https://anaconda.org/channels/bioconda/packages/galaxy-upload/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/galaxy-upload/overview
- **Total Downloads**: 4.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/galaxyproject/galaxy-upload
- **Stars**: N/A
### Original Help Text
```text
Usage: galaxy-upload [OPTIONS] [PATH]...

Options:
  History Selection Options: [mutually_exclusive, required]
    --history-id TEXT             Target history ID
    --history-name TEXT           Target history name
  History Options: 
    -i, --ignore-case             Ignore case when matching history names
  Galaxy Server Options: 
    --url TEXT                    URL of Galaxy instance
    --api-key TEXT                API key for Galaxy instance  [required]
  Upload Options: 
    --file-type TEXT              Galaxy file type to use
    --dbkey TEXT                  Genome Build for dataset
    --space-to-tab / --no-space-to-tab
                                  Convert spaces to tabs
    --auto-decompress / --no-auto-decompress
                                  Automatically decompress after upload
    --file-name TEXT              Filename to use in Galaxy history, if
                                  different from path
  General Options: 
    --storage PATH                Store URLs to resume here
    --silent                      No output while uploading
    --debug                       Debug output
  --help                          Show this message and exit.
```

