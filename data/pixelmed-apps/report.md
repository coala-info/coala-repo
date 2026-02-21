# pixelmed-apps CWL Generation Report

## pixelmed-apps

### Tool Description
The provided text does not contain help documentation for the tool. It is an error log from a container runtime (Apptainer/Singularity) indicating a failure to build or fetch the image 'docker://biocontainers/pixelmed-apps:v20150917-1-deb_cv1' due to 'no space left on device'.

### Metadata
- **Docker Image**: biocontainers/pixelmed-apps:v20150917-1-deb_cv1
- **Homepage**: Not found
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pixelmed-apps/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 21:16:49  warn rootless{usr/local/man} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
FATAL:   Unable to handle docker://biocontainers/pixelmed-apps:v20150917-1-deb_cv1 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:b0b2717199c456fc67768ff3e46086cc520afc98521258d26b340c2e3171d4fe: unpack entry: usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/classes.jsa: unpack to regular file: short write: write /tmp/build-temp-1995929110/rootfs/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server/classes.jsa: no space left on device
```


## Metadata
- **Skill**: not generated
