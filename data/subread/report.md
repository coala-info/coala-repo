# subread CWL Generation Report

## subread

### Tool Description
The provided text does not contain help information or usage instructions for the subread tool. It appears to be a log of a failed container build process (Apptainer/Singularity).

### Metadata
- **Docker Image**: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
- **Homepage**: https://subread.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/subread/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/subread/overview
- **Total Downloads**: 350.7K
- **Last updated**: 2025-05-03
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/subread:2.1.1--h577a1d6_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```


## Metadata
- **Skill**: generated

## subread_subread-buildindex

### Tool Description
Build an index for the reference genome for Subread aligners.

### Metadata
- **Docker Image**: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
- **Homepage**: https://subread.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/subread/overview
- **Validation**: PASS

### Original Help Text
```text
Version 2.1.1

Usage:

 ./subread-buildindex [options] -o <basename> {FASTA[.gz] file1}\
      [FASTA[.gz] file2] ...

Required arguments:

    -o <basename>   base name of the index to be created

Optional arguments:

    -F              build a full index for the reference genome. 16bp subreads
                    will be extracted from every position of the reference
                    genome. Size of the index is typically 3 times the size of
                    index built from using the default setting.

    -B              create one block of index. The built index will not be split
                    into multiple pieces. This makes the largest amount of
                    memory be requested when running alignments, but it enables
                    the maximum mapping speed to be achieved. This option
                    overrides -M when it is provided as well.

    -M <int>        size of requested memory(RAM) in megabytes, 8000 by default.

    -f <int>        specify the threshold for removing uninformative subreads
                    (highly repetitive 16mers in the reference). 100 by default.

    -c              build a color-space index.

    -v              output version of the program.

For more information about these arguments, please refer to the User Manual.
```
## subread_subread-align

### Tool Description
The provided text does not contain help information for the tool. It appears to be a container execution error log.

### Metadata
- **Docker Image**: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
- **Homepage**: https://subread.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/subread/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/subread:2.1.1--h577a1d6_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

## subread_subjunc

### Tool Description
The provided text does not contain help information or usage instructions for subread_subjunc. It appears to be an error log from a container runtime (Apptainer/Singularity) failing to fetch the OCI image.

### Metadata
- **Docker Image**: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
- **Homepage**: https://subread.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/subread/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/subread:2.1.1--h577a1d6_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

## subread_featureCounts

### Tool Description
The provided text does not contain help information for the tool, but appears to be a set of system logs and a fatal error message regarding a container image build failure.

### Metadata
- **Docker Image**: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
- **Homepage**: https://subread.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/subread/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/subread:2.1.1--h577a1d6_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

## subread_exactSNP

### Tool Description
The provided text does not contain help information for subread_exactSNP. It contains error logs from a container runtime (Apptainer/Singularity) indicating a failure to fetch or build the container image.

### Metadata
- **Docker Image**: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
- **Homepage**: https://subread.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/subread/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/subread:2.1.1--h577a1d6_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

## subread_sublong

### Tool Description
The provided text does not contain help information or a description of the tool; it contains container runtime log messages and a fatal error regarding an OCI image build failure.

### Metadata
- **Docker Image**: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
- **Homepage**: https://subread.sourceforge.net
- **Package**: https://anaconda.org/channels/bioconda/packages/subread/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/subread:2.1.1--h577a1d6_0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

