# hardklor CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| hardklor | PASS |  |
| hardklor_cmd | Failed | tool bug: -xml 1 with -algorithm Version2 writes only a spectrum header and no features |

## hardklor

### Tool Description
Hardklor is a tool for processing mass spectrometry data.

### Metadata
- **Docker Image**: quay.io/biocontainers/hardklor:2.3.2--h503566f_6
- **Homepage**: https://github.com/mhoopmann/hardklor
- **Package**: https://anaconda.org/channels/bioconda/packages/hardklor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hardklor/overview
- **Total Downloads**: 14.8K
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/mhoopmann/hardklor
- **Stars**: N/A
### Original Help Text
```text
Hardklor v2.3.2, November 11 2019
Mike Hoopmann, Mike MacCoss
Copyright 2007-2019
University of Washington
Usage:		hardklor <config file>
		hardklor -cmd [options] <input file> <output file>

See documentation for instructions to modify and use config files.
```


## hardklor_cmd

### Tool Description
Hardklor command-line mode (`hardklor -cmd [options] <input file> <output file>`): finds isotope-distribution features in high-resolution mass spectra without a config file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hardklor:2.3.2--h503566f_6
- **Homepage**: https://github.com/mhoopmann/hardklor
- **Package**: https://anaconda.org/channels/bioconda/packages/hardklor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:		hardklor <config file>
		hardklor -cmd [options] <input file> <output file>

Options are the config-file parameters written as "-name value" (for example -instrument Orbitrap -resolution 70000).
```
