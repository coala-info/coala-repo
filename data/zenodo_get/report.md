# zenodo_get CWL Generation Report

## zenodo_get

### Tool Description
Command-line interface for downloading files from Zenodo records.

### Metadata
- **Docker Image**: hubentu/zenodo-get
- **Homepage**: https://github.com/dvolgyes/zenodo_get
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/zenodo_get/overview
- **Total Downloads**: 48.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dvolgyes/zenodo_get
- **Stars**: N/A
### Original Help Text
```text
Usage: zenodo_get [OPTIONS] [RECORD_OR_DOI]

  Command-line interface for downloading files from Zenodo records.

  CLI mode - uses signal handling and can exit directly.

Options:
  --version                      Show the version and exit.
  -c, --cite                     print citation information
  -r, --record TEXT              Zenodo record ID
  -d, --doi TEXT                 Zenodo DOI
  -m, --md5                      Create md5sums.txt for verification.
  -w, --wget TEXT                Create URL list for download managers. (Files
                                 will not be downloaded.)
  -e, --continue-on-error        Continue with next file if error happens.
  -k, --keep                     Keep files with invalid checksum. (Default:
                                 delete them.)
  -n, --do-not-continue          Do not continue previous download attempt,
                                 start fresh.
  -R, --retry INTEGER            Application-level retries for checksum
                                 failures and non-HTTP errors. Separate from
                                 --max-http-retries.  [default: 1]
  -p, --pause FLOAT              Wait N second before retry attempt, e.g. 0.5
                                 [default: 3]
  -t, --time-out FLOAT           Set connection time-out. Default: 25 [sec].
                                 [default: 25.0]
  -o, --output-dir DIRECTORY     Output directory, created if necessary.
                                 Default: current directory.  [default: .]
  -s, --sandbox                  Use Zenodo Sandbox URL.
  -a, --access-token TEXT        Optional access token for the requests query.
  -g, --glob TEXT                Glob expressions for files, it can be used
                                 multiple times. (e.g., -g '*.txt'  -g
                                 '*.pdf'). Default: all files.
  -v, --verbosity INTEGER RANGE  Verbosity level (0-4). 0=silent, 1=minimal,
                                 2=normal, 3=nested progress, 4=full
                                 [default: 2; 0<=x<=4]
  --max-http-retries INTEGER     HTTP transport-level retries for network
                                 errors and 429/5xx responses. Uses
                                 exponential backoff.  [default: 5]
  --backoff-factor FLOAT         Exponential backoff factor for HTTP retries
                                 (e.g., 0.5 means 0.5s, 1s, 2s...).  [default:
                                 0.5]
  --overwrite                    Re-download and overwrite existing files with
                                 mismatched checksums. (Default behavior)
  --no-overwrite                 Do not overwrite existing files with
                                 mismatched checksums. Exit with error at end.
  --ignore-existing-files        Ignore existing files with mismatched
                                 checksums. Do not overwrite, no error.
  -h, --help                     Show this message and exit.
```


## Metadata
- **Skill**: generated
