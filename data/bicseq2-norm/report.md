# bicseq2-norm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bicseq2-norm_BICseq2-norm.pl | Failed | image problem: the R package mgcv is missing, so NBICseq-norm.pl stops before any work (CWL rewritten to the real command NBICseq-norm.pl). |

## Metadata
- **Skill**: generated

## bicseq2-norm_BICseq2-norm.pl

### Tool Description
BIC-seq2 normalization for bias correction in NGS data. (Note: The provided help text contained only system error logs; arguments are based on standard tool documentation).

### Metadata
- **Docker Image**: quay.io/biocontainers/bicseq2-norm:0.2.4--h7b50bb2_6
- **Homepage**: http://compbio.med.harvard.edu/BIC-seq/
- **Package**: https://anaconda.org/channels/bioconda/packages/bicseq2-norm/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/bicseq2-norm:0.2.4--h7b50bb2_6 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:455461ab1b5f66689cbf612b8c1d42b60c5d4bbadc83aedef7e055e1fdefc07e: unpack entry: usr/local/bin/nghttpx: unpack to regular file: short write: write /scratch/21813747/build-temp-3122333161/rootfs/usr/local/bin/nghttpx: no space left on device
```

