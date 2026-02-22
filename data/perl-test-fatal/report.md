# perl-test-fatal CWL Generation Report

## perl-test-fatal

### Tool Description
The provided text is an error log from a container runtime (Singularity/Apptainer) indicating a failure to pull or convert the OCI image due to insufficient disk space. It does not contain help text or command-line argument definitions.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-test-fatal:0.016--pl5321hdfd78af_0
- **Homepage**: https://github.com/rjbs/Test-Fatal
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-test-fatal/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-test-fatal/overview
- **Total Downloads**: 116.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rjbs/Test-Fatal
- **Stars**: N/A
### Original Help Text
```text
WARNING: Couldn't use cached digest for registry: open /home/qhu/.singularity/cache/blob/blobs/sha256/fe953fe96b77b8f2e3fd9a96124e4d8579943aa38848649dc21f75fabb7e94f9: no space left on device
WARNING: Falling back to direct digest.
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/perl-test-fatal:0.016--pl5321hdfd78af_0 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-4064920574: no space left on device
```

