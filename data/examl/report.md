# examl CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| examl_examl | PASS |  |
| examl_parse-examl | PASS |  |

## examl_examl

### Tool Description
ExaML (Exascale Maximum Likelihood) is a tool for phylogenetic inference on huge datasets using Maximum Likelihood.

### Metadata
- **Docker Image**: biocontainers/examl:v3.0.21-2-deb_cv1
- **Homepage**: https://github.com/stamatak/ExaML
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/examl/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/stamatak/ExaML
- **Stars**: N/A
### Original Help Text
```text
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://biocontainers/examl:v3.0.21-2-deb_cv1 uri: while building SIF from layers: conveyor failed to get: error writing layer: write /home/qhu/.singularity/cache/blob/blobs/sha256/7ef5d586e99740e4ab28f1fbde4e87a4f093ccbc04c82e40e23861fe49cfd0b22861501518: no space left on device
```


## examl_parse-examl

### Tool Description
parse-examl converts a PHYLIP alignment into the binary alignment file that ExaML reads.

### Metadata
- **Docker Image**: biocontainers/examl:v3.0.21-2-deb_cv1
- **Homepage**: https://github.com/stamatak/ExaML
- **Package**: https://anaconda.org/channels/bioconda/packages/examl/overview
- **Validation**: PASS

### Original Help Text
```text
This is the parse-examl version 3.0.21 released by Alexandros Stamatakis, Andre J. Aberer, and Alexey Kozlov in May 29 2018.
To report bugs use the RAxML google group
Please send us all input files, the exact invocation, details of the HW and operating system,
as well as all error messages printed to screen.
parse-examl
      -s sequenceFileName
      -n outputFileName
      -m substitutionModel
      [-c]
      [-q]
      [-h]
      -m Model of  Nucleotide or Amino Acid Substitution:
              For Binary data use: BIN
              For DNA data use:    DNA
              For AA data use:     PROT
      -c      disable site pattern compression
      -q      Specify the file name which contains the assignment of models to alignment
              partitions for multiple models of substitution. For the syntax of this file
              please consult the manual.
      -h      Display this help message.
```

## Metadata
- **Skill**: not generated
