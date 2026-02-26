# stellarscope CWL Generation Report

## stellarscope

### Tool Description
Stellarscope is a tool for the quantification of transposable elements (TEs) at the single-cell level.

### Metadata
- **Docker Image**: quay.io/biocontainers/stellarscope:1.5--py312h0fa9677_1
- **Homepage**: https://github.com/nixonlab/stellarscope
- **Package**: https://anaconda.org/channels/bioconda/packages/stellarscope/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stellarscope/overview
- **Total Downloads**: 5.4K
- **Last updated**: 2025-11-28
- **GitHub**: https://github.com/nixonlab/stellarscope
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/stellarscope:1.5--py312h0fa9677_1 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```


## Metadata
- **Skill**: generated

## stellarscope

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/stellarscope:1.5--py312h0fa9677_1
- **Homepage**: https://github.com/nixonlab/stellarscope
- **Package**: https://anaconda.org/channels/bioconda/packages/stellarscope/overview
- **Validation**: FAIL (generation failed)
### Generation Failed

No inputs — do not generate CWL.

### Validation Errors
- No inputs — do not generate CWL.

### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/stellarscope:1.5--py312h0fa9677_1' locally
1.5--py312h0fa9677_1: Pulling from biocontainers/stellarscope
544d4fd7c48a: Pulling fs layer
docker: failed to extract layer (application/vnd.docker.image.rootfs.diff.tar.gzip sha256:544d4fd7c48aa1c71eb8ebefbf8f351e8dc1f4ad8c89c4c616c4442420cc0126) to overlayfs as "extract-844317065-69uA sha256:a452fc048f7ae2501c5de482c56a84e7f565bf770de55052919597240b20e4ef": failed to Lchown "/var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/106394/fs/usr/local/lib/libpython3.12.so.1.0" for UID 0, GID 0: lchown /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/snapshots/106394/fs/usr/local/lib/libpython3.12.so.1.0: no such file or directory

Run 'docker run --help' for more information
```

