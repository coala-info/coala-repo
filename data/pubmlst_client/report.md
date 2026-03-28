# pubmlst_client CWL Generation Report

## pubmlst_client_pubmlst_list

### Tool Description
List schemes from the PubMLST database with optional filtering

### Metadata
- **Docker Image**: quay.io/biocontainers/pubmlst_client:0.2.0--py_0
- **Homepage**: https://github.com/Public-Health-Bioinformatics/pubmlst_client
- **Package**: https://anaconda.org/channels/bioconda/packages/pubmlst_client/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pubmlst_client/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Public-Health-Bioinformatics/pubmlst_client
- **Stars**: N/A
### Original Help Text
```text
usage: pubmlst_list [-h] [--pattern PATTERN]
                    [--exclude_pattern EXCLUDE_PATTERN] [--names_only]
                    [--base-url BASE_URL]

optional arguments:
  -h, --help            show this help message and exit
  --pattern PATTERN, -p PATTERN
                        regex pattern to filter scheme names
  --exclude_pattern EXCLUDE_PATTERN, -e EXCLUDE_PATTERN
                        regex pattern to filter scheme names
  --names_only, -n      Only show scheme names
  --base-url BASE_URL, -b BASE_URL
                        Base URL for the API. Suggested values are:
                        http://rest.pubmlst.org/db (default),
                        https://bigsdb.pasteur.fr/api/db
```


## pubmlst_client_pubmlst_download

### Tool Description
Download schemes from PubMLST API

### Metadata
- **Docker Image**: quay.io/biocontainers/pubmlst_client:0.2.0--py_0
- **Homepage**: https://github.com/Public-Health-Bioinformatics/pubmlst_client
- **Package**: https://anaconda.org/channels/bioconda/packages/pubmlst_client/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pubmlst_download [-h] --scheme_name SCHEME_NAME [--scheme_id SCHEME_ID]
                        [--outdir OUTDIR] [--base-url BASE_URL]

optional arguments:
  -h, --help            show this help message and exit
  --scheme_name SCHEME_NAME, -s SCHEME_NAME
                        scheme name
  --scheme_id SCHEME_ID, -i SCHEME_ID
                        scheme id
  --outdir OUTDIR, -o OUTDIR
                        output directory
  --base-url BASE_URL, -b BASE_URL
                        Base URL for the API. Suggested values are:
                        http://rest.pubmlst.org/db (default),
                        https://bigsdb.pasteur.fr/api/db
```


## Metadata
- **Skill**: generated
