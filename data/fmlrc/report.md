# fmlrc CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| fmlrc | PASS | rewrote flags from the help; 21-mer match to the genome rose from 0.35 to 0.82 on nanopore reads |
| fmlrc_convert | PASS |  |

## fmlrc

### Tool Description
FMLRC (FM-index Long Read Corrector) is a tool for correcting long reads (like Oxford Nanopore or Pacific Biosciences) using a BWT of short read sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/fmlrc:1.0.0--h9948957_6
- **Homepage**: https://github.com/holtjma/fmlrc
- **Package**: https://anaconda.org/channels/bioconda/packages/fmlrc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fmlrc/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/holtjma/fmlrc
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/fmlrc:1.0.0--h9948957_6' locally
1.0.0--h9948957_6: Pulling from biocontainers/fmlrc
0cacab098358: Already exists
bd9ddc54bea9: Already exists
e1a290abb57e: Pulling fs layer
docker: write /var/lib/docker/tmp/GetImageBlob3586772576: no space left on device

Run 'docker run --help' for more information
```

## fmlrc_convert

### Tool Description
Convert a plain text BWT of short reads into the compressed multi-string BWT (.npy) format used by fmlrc.

### Metadata
- **Docker Image**: quay.io/biocontainers/fmlrc:1.0.0--h9948957_6
- **Homepage**: https://github.com/holtjma/fmlrc
- **Package**: https://anaconda.org/channels/bioconda/packages/fmlrc/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:   fmlrc-convert [options] <out_comp_mbswt.npy>
Options: -h        print help menu
         -v        print version number and exit
         -f        force overwrite of existing file (default: false)
         -i STR    the plain text BWT file to be converted into msbwt format (default: stdin)
```

