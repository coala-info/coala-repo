# perl-ipc-run CWL Generation Report

## perl-ipc-run_run

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-ipc-run:20250809.0--pl5321hdfd78af_0
- **Homepage**: https://metacpan.org/pod/IPC::Run
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-ipc-run/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-ipc-run/overview
- **Total Downloads**: 332.7K
- **Last updated**: 2025-08-15
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/env-execute: line 3: exec: run: cannot execute: Is a directory
```


## perl-ipc-run_timeout

### Tool Description
Run PROG. Send SIG to it if it is not gone in SECS seconds. Default SIG: TERM.If it still exists in KILL_SECS seconds, send KILL.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-ipc-run:20250809.0--pl5321hdfd78af_0
- **Homepage**: https://metacpan.org/pod/IPC::Run
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-ipc-run/overview
- **Validation**: PASS

### Original Help Text
```text
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: timeout [-s SIG] [-k KILL_SECS] SECS PROG ARGS

Run PROG. Send SIG to it if it is not gone in SECS seconds.
Default SIG: TERM.If it still exists in KILL_SECS seconds, send KILL.
```

