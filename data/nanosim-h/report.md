# nanosim-h CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nanosim-h | PASS |  |
| nanosim-h_train | PASS | Synthetic data: trained on 50 reads simulated by nanosim-h from the SARS-CoV-2 genome; the profile directory has the expected histograms and Markov models. |

## nanosim-h

### Tool Description
A simulator for Oxford Nanopore reads (Note: The provided help text was a Docker error message; arguments below are based on standard tool usage).

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim-h:1.1.0.4--pyr341h24bf2e0_0
- **Homepage**: https://github.com/karel-brinda/NanoSim-H
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim-h/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanosim-h/overview
- **Total Downloads**: 22.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/karel-brinda/NanoSim-H
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/nanosim-h:1.1.0.4--pyr341h24bf2e0_0' locally
1.1.0.4--pyr341h24bf2e0_0: Pulling from biocontainers/nanosim-h
a3ed95caeb02: Already exists
b0dc45cd432d: Already exists
3aaade50789a: Already exists
ddd482ea7b54: Already exists
7ff999a2256f: Already exists
e7c454e5167d: Already exists
dfda3e01f2b6: Already exists
a3ed95caeb02: Already exists
10c3bb32200b: Already exists
736eb5383705: Pulling fs layer
docker: write /var/lib/docker/tmp/GetImageBlob3919673060: no space left on device

Run 'docker run --help' for more information
```

## nanosim-h_train

### Tool Description
NanoSim-H-Train - compute an error profile for NanoSim-H.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanosim-h:1.1.0.4--pyr341h24bf2e0_0
- **Homepage**: https://github.com/karel-brinda/NanoSim-H
- **Package**: https://anaconda.org/channels/bioconda/packages/nanosim-h/overview
- **Validation**: PASS

### Original Help Text
```text
usage: nanosim-h-train [-h] [-v] [-i str] [-m str] [-b int] [--no-model-fit]
                       <reference.fa> <profile.dir>

Program:  NanoSim-H-Train - compute an error profile for NanoSim-H.
Version:  1.1.0.4
Authors:  Chen Yang <cheny@bcgsc.ca> - author of the original software package (NanoSim)
          Karel Brinda <kbrinda@hsph.harvard.edu> - author of the NanoSim-H fork

positional arguments:
  <reference.fa>        reference genome of the training reads
  <profile.dir>         error profile dir

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -i str, --infile str  training ONT real reads, must be fasta files
  -m str, --maf str     user can provide their own alignment file, with maf
                        extension
  -b int, --num-bins int
                        number of bins (for development) [20]
  --no-model-fit        no model fitting
```
