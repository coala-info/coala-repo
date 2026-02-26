# ncfp CWL Generation Report

## ncfp

### Tool Description
ncfp

### Metadata
- **Docker Image**: quay.io/biocontainers/ncfp:0.2.0--py_0
- **Homepage**: http://widdowquinn.github.io/ncfp/
- **Package**: https://anaconda.org/channels/bioconda/packages/ncfp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ncfp/overview
- **Total Downloads**: 12.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/widdowquinn/ncfp
- **Stars**: N/A
### Original Help Text
```text
Creating directory /root/.config/bioservices 
usage: ncfp [-h] [-s] [-d CACHEDIR] [-c CACHESTEM] [-b BATCHSIZE] [-r RETRIES]
            [--limit LIMIT] [--filestem FILESTEM] [--keepcache]
            [--skippedfile SKIPPEDFNAME] [-l LOGFILE] [-v] [--debug]
            [--disabletqdm]
            infname outdirname email

positional arguments:
  infname               input sequence file
  outdirname            output directory for sequence files
  email                 email address for NCBI/Entrez

optional arguments:
  -h, --help            show this help message and exit
  -s, --stockholm       parse Stockholm format sequence regions (default:
                        False)
  -d CACHEDIR, --cachedir CACHEDIR
                        directory for cached data (default: .ncfp_cache)
  -c CACHESTEM, --cachestem CACHESTEM
                        suffix for cache filestems (default:
                        2026-02-26-17-02-43)
  -b BATCHSIZE, --batchsize BATCHSIZE
                        batch size for EPost submissions (default: 100)
  -r RETRIES, --retries RETRIES
                        maximum number of Entrez retries (default: 10)
  --limit LIMIT         maximum number of sequences to process (for testing)
                        (default: None)
  --filestem FILESTEM   stem for output sequence files (default: ncfp)
  --keepcache           keep download cache (for testing) (default: False)
  --skippedfile SKIPPEDFNAME
                        path to file with skipped sequences (default:
                        skipped.fasta)
  -l LOGFILE, --logfile LOGFILE
                        path to logfile (default: None)
  -v, --verbose         report verbosely (default: False)
  --debug               report debug-level information (default: False)
  --disabletqdm         disable progress bar (for testing) (default: False)
```

