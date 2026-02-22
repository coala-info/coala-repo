# pbgzip CWL Generation Report

## pbgzip

### Tool Description
Parallel block gzip compression and decompression tool

### Metadata
- **Docker Image**: quay.io/biocontainers/pbgzip:2016.08.04--hb1d24b7_6
- **Homepage**: https://github.com/nh13/pbgzip
- **Package**: https://anaconda.org/channels/bioconda/packages/pbgzip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbgzip/overview
- **Total Downloads**: 92.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nh13/pbgzip
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...

Usage:   pbgzip [options] [file] ...

Options: -c        write on standard output, keep original files unchanged
         -d        decompress
         -f        overwrite files without asking
         -n INT    number of threads [40]
         -t INT    the compress type (0 - gz, 1 - bz2) [0]
         -1 .. -9  the compression level [-1]
         -S        the block size when reading uncompressed data (must be less than or equal to 65536; -1 is auto) [-1]
         -h        give this help
```


## Metadata
- **Skill**: generated
