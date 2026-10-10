# nanopack CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nanopack_NanoStat | PASS | fastq and bam modes give correct counts on real nanopore data (100 reads, 17 reads); the nf-core sequencing summary file is malformed so summary mode was not judged |

## Metadata
- **Skill**: generated

## nanopack_NanoStat

### Tool Description
NanoStat: Calculate statistics of long read sequencing data and generate plots.

### Metadata
- **Docker Image**: quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0
- **Homepage**: https://github.com/wdecoster/nanopack
- **Package**: https://anaconda.org/channels/bioconda/packages/nanopack/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/nanopack:1.1.1--hdfd78af_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-4030505092: no space left on device
```

