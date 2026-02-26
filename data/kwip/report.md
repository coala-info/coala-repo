# kwip CWL Generation Report

## kwip

### Tool Description
Calculate kernel matrices and distance matrices from oxli Countgraph files.

### Metadata
- **Docker Image**: quay.io/biocontainers/kwip:0.2.0--hd28b015_0
- **Homepage**: https://github.com/kdmurray91/kWIP
- **Package**: https://anaconda.org/channels/bioconda/packages/kwip/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kwip/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kdmurray91/kWIP
- **Stars**: N/A
### Original Help Text
```text
kwip version 

USAGE: kwip [options] hashes

OPTIONS:
-t, --threads       Number of threads to utilise. [default N_CPUS]
-k, --kernel        Output file for the kernel matrix. [default None]
-d, --distance      Output file for the distance matrix. [default stdout]
-U, --unweighted    Use the unweighted inner proudct kernel. [default off]
-w, --weights       Bin weight vector file (input, or output w/ -C).
-C, --calc-weights  Calculate only the bin weight vector, not kernel matrix.
-h, --help          Print this help message.
-V, --version       Print the version string.
-v, --verbose       Increase verbosity. May or may not acutally do anything.
-q, --quiet         Execute silently but for errors.

Each sample's oxli Countgraph should be specified after arguments:
kwip [options] sample1.ct sample2.ct ... sampleN.ct
```


## Metadata
- **Skill**: generated
