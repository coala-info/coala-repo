# scelvis CWL Generation Report

## scelvis_convert

### Tool Description
Convert scELVIS output to .h5ad format.

### Metadata
- **Docker Image**: quay.io/biocontainers/scelvis:0.8.9--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/scelvis
- **Package**: https://anaconda.org/channels/bioconda/packages/scelvis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scelvis/overview
- **Total Downloads**: 60.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/scelvis
- **Stars**: N/A
### Original Help Text
```text
usage: scelvis convert [-h] -i INDIR [-a ABOUT_MD] [-m MARKERS] -o OUT_FILE
                       [-f {auto,text,cell-ranger,loom}] [--use-raw]
                       [--split-species] [--split-samples]
                       [--nmarkers NMARKERS] [--ncells NCELLS] [--verbose]

optional arguments:
  -h, --help            show this help message and exit
  -i INDIR, --input-dir INDIR
                        path to input/pipeline output directory
  -a ABOUT_MD, --about-md ABOUT_MD
                        Path to about.md file to embed in the resulting .h5ad
                        file
  -m MARKERS, --markers MARKERS
                        Path to markers.tsv file to embed in the resulting
                        .h5ad file
  -o OUT_FILE, --output OUT_FILE
                        Path to the .h5ad file to write to
  -f {auto,text,cell-ranger,loom}, --format {auto,text,cell-ranger,loom}
                        input format
  --use-raw             Do not normalize expression values (use raw counts)
  --split-species       Split species
  --split-samples       split samples according to summary.json file produced
                        by cellranger aggr
  --nmarkers NMARKERS   Save top n markers per cluster [10]
  --ncells NCELLS       sample ncells cells from object [take all]
  --verbose             Enable verbose output
```


## scelvis_run

### Tool Description
Run the scelvis server.

### Metadata
- **Docker Image**: quay.io/biocontainers/scelvis:0.8.9--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/scelvis
- **Package**: https://anaconda.org/channels/bioconda/packages/scelvis/overview
- **Validation**: PASS

### Original Help Text
```text
usage: scelvis run [-h] [--debug] [--host HOST] [--port PORT] [--fake-data]
                   [--data-source DATA_SOURCES]
                   [--public-url-prefix PUBLIC_URL_PREFIX]
                   [--cache-dir CACHE_DIR] [--cache-redis-url CACHE_REDIS_URL]
                   [--cache-default-timeout CACHE_DEFAULT_TIMEOUT]
                   [--cache-preload-data] [--upload-dir UPLOAD_DIR]
                   [--max-upload-data-size MAX_UPLOAD_DATA_SIZE]
                   [--disable-upload] [--disable-conversion]
                   [--custom-home-md CUSTOM_HOME_MD]
                   [--custom-static-folder CUSTOM_STATIC_FOLDER]
                   [--irods-client-server-negotiation IRODS_CLIENT_SERVER_NEGOTIATION]
                   [--irods-client-server-policy IRODS_CLIENT_SERVER_POLICY]
                   [--irods-ssl-verify-server IRODS_SSL_VERIFY_SERVER]
                   [--irods-encryption-algorithm IRODS_ENCRYPTION_ALGORITHM]
                   [--irods-encryption-key-size IRODS_ENCRYPTION_KEY_SIZE]
                   [--irods-encryption-num-hash-rounds IRODS_ENCRYPTION_NUM_HASH_ROUNDS]
                   [--irods-encryption-salt-size IRODS_ENCRYPTION_SALT_SIZE]

optional arguments:
  -h, --help            show this help message and exit
  --debug               Enable debug mode
  --host HOST           Server host
  --port PORT           Server port
  --fake-data           Enable display of fake data set (for demo purposes).
  --data-source DATA_SOURCES
                        Path to data source(s)
  --public-url-prefix PUBLIC_URL_PREFIX
                        The prefix that this app will be served under (e.g.,
                        if behind a reverse proxy.)
  --cache-dir CACHE_DIR
                        Path to cache directory, default is to autocreate one.
  --cache-redis-url CACHE_REDIS_URL
                        Redis URL to use for caching, enables Redis cache
  --cache-default-timeout CACHE_DEFAULT_TIMEOUT
                        Default timeout for cache
  --cache-preload-data  whether to preload data at startup
  --upload-dir UPLOAD_DIR
                        Directory for visualization uploads, default is to
                        create temporary directory
  --max-upload-data-size MAX_UPLOAD_DATA_SIZE
                        Maximal size for data upload in bytes
  --disable-upload      Whether or not to disable visualization uploads
  --disable-conversion  Directory for visualization uploads, default is to
                        create temporary directory
  --custom-home-md CUSTOM_HOME_MD
                        Use custom markdown file for home screen
  --custom-static-folder CUSTOM_STATIC_FOLDER
                        Use custom static folder for files included in home
                        screen markdown file
  --irods-client-server-negotiation IRODS_CLIENT_SERVER_NEGOTIATION
                        IRODS setting
  --irods-client-server-policy IRODS_CLIENT_SERVER_POLICY
                        IRODS setting
  --irods-ssl-verify-server IRODS_SSL_VERIFY_SERVER
                        IRODS setting
  --irods-encryption-algorithm IRODS_ENCRYPTION_ALGORITHM
                        IRODS setting
  --irods-encryption-key-size IRODS_ENCRYPTION_KEY_SIZE
                        IRODS setting
  --irods-encryption-num-hash-rounds IRODS_ENCRYPTION_NUM_HASH_ROUNDS
                        IRODS setting
  --irods-encryption-salt-size IRODS_ENCRYPTION_SALT_SIZE
                        IRODS setting
```


## Metadata
- **Skill**: generated
