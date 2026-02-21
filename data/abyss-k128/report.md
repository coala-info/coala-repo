# abyss-k128 CWL Generation Report

## abyss-k128

### Tool Description
A de novo, parallel, paired-end sequence assembler (Note: The provided help text contains only system logs and an error message regarding a failed container build; no specific command-line arguments were found in the input).

### Metadata
- **Docker Image**: quay.io/biocontainers/abyss-k128:2.0.2--boost1.64_2
- **Homepage**: http://www.bcgsc.ca/platform/bioinfo/software/abyss
- **Package**: https://anaconda.org/channels/bioconda/packages/abyss-k128/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/abyss-k128/overview
- **Total Downloads**: 14.3K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/05 12:11:49  warn rootless{usr/local/man} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2026/02/05 12:11:50  warn rootless{dev/mem} creating empty file in place of device 1:1
2026/02/05 12:11:50  warn rootless{dev/ram1} creating empty file in place of device 1:1
2026/02/05 12:11:50  warn rootless{dev/ram11} creating empty file in place of device 1:11
2026/02/05 12:11:50  warn rootless{dev/ram7} creating empty file in place of device 1:7
2026/02/05 12:11:50  warn rootless{dev/loop7} creating empty file in place of device 7:7
2026/02/05 12:11:50  warn rootless{dev/port} creating empty file in place of device 1:4
2026/02/05 12:11:50  warn rootless{dev/ram10} creating empty file in place of device 1:10
2026/02/05 12:11:50  warn rootless{dev/loop0} creating empty file in place of device 7:0
2026/02/05 12:11:50  warn rootless{dev/ram8} creating empty file in place of device 1:8
2026/02/05 12:11:50  warn rootless{dev/ram4} creating empty file in place of device 1:4
2026/02/05 12:11:50  warn rootless{dev/ram2} creating empty file in place of device 1:2
2026/02/05 12:11:50  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/05 12:11:50  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/05 12:11:50  warn rootless{dev/ram6} creating empty file in place of device 1:6
2026/02/05 12:11:50  warn rootless{dev/loop6} creating empty file in place of device 7:6
2026/02/05 12:11:50  warn rootless{dev/tty0} creating empty file in place of device 4:0
2026/02/05 12:11:50  warn rootless{dev/ram0} creating empty file in place of device 1:0
2026/02/05 12:11:50  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/05 12:11:50  warn rootless{dev/ram9} creating empty file in place of device 1:9
2026/02/05 12:11:50  warn rootless{dev/ram16} creating empty file in place of device 1:16
2026/02/05 12:11:50  warn rootless{dev/ram15} creating empty file in place of device 1:15
2026/02/05 12:11:50  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/05 12:11:50  warn rootless{dev/ram3} creating empty file in place of device 1:3
2026/02/05 12:11:50  warn rootless{dev/zero} creating empty file in place of device 1:5
2026/02/05 12:11:50  warn rootless{dev/ram12} creating empty file in place of device 1:12
2026/02/05 12:11:50  warn rootless{dev/ram13} creating empty file in place of device 1:13
2026/02/05 12:11:50  warn rootless{dev/loop3} creating empty file in place of device 7:3
2026/02/05 12:11:50  warn rootless{dev/ram5} creating empty file in place of device 1:5
2026/02/05 12:11:50  warn rootless{dev/loop1} creating empty file in place of device 7:1
2026/02/05 12:11:50  warn rootless{dev/console} creating empty file in place of device 5:1
2026/02/05 12:11:50  warn rootless{dev/loop2} creating empty file in place of device 7:2
2026/02/05 12:11:50  warn rootless{dev/ptmx} creating empty file in place of device 5:2
2026/02/05 12:11:50  warn rootless{dev/loop5} creating empty file in place of device 7:5
2026/02/05 12:11:50  warn rootless{dev/ram14} creating empty file in place of device 1:14
2026/02/05 12:11:50  warn rootless{dev/loop4} creating empty file in place of device 7:4
2026/02/05 12:11:50  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/05 12:11:50  warn rootless{dev/kmem} creating empty file in place of device 1:2
FATAL:   Unable to handle docker://quay.io/biocontainers/abyss-k128:2.0.2--boost1.64_2 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:849d331fda7b7fc393ec0953bcbd7bb62af6385d4daeb296316db38ad3d969a6: unpack entry: usr/local/bin/abyss-bloom-dbg: unpack to regular file: short write: write /tmp/build-temp-3252595059/rootfs/usr/local/bin/abyss-bloom-dbg: no space left on device
```


## Metadata
- **Skill**: generated

## abyss-k128_abyss-pe

### Tool Description
ABySS is a de novo, parallel, paired-end sequence assembler. abyss-pe is the driver script for the assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/abyss-k128:2.0.2--boost1.64_2
- **Homepage**: http://www.bcgsc.ca/platform/bioinfo/software/abyss
- **Package**: https://anaconda.org/channels/bioconda/packages/abyss-k128/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/05 12:13:17  warn rootless{usr/local/man} ignoring (usually) harmless EPERM on setxattr "user.rootlesscontainers"
2026/02/05 12:13:18  warn rootless{dev/mem} creating empty file in place of device 1:1
2026/02/05 12:13:18  warn rootless{dev/ram1} creating empty file in place of device 1:1
2026/02/05 12:13:18  warn rootless{dev/ram11} creating empty file in place of device 1:11
2026/02/05 12:13:18  warn rootless{dev/ram7} creating empty file in place of device 1:7
2026/02/05 12:13:18  warn rootless{dev/loop7} creating empty file in place of device 7:7
2026/02/05 12:13:18  warn rootless{dev/port} creating empty file in place of device 1:4
2026/02/05 12:13:18  warn rootless{dev/ram10} creating empty file in place of device 1:10
2026/02/05 12:13:18  warn rootless{dev/loop0} creating empty file in place of device 7:0
2026/02/05 12:13:18  warn rootless{dev/ram8} creating empty file in place of device 1:8
2026/02/05 12:13:18  warn rootless{dev/ram4} creating empty file in place of device 1:4
2026/02/05 12:13:18  warn rootless{dev/ram2} creating empty file in place of device 1:2
2026/02/05 12:13:18  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/05 12:13:18  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/05 12:13:18  warn rootless{dev/ram6} creating empty file in place of device 1:6
2026/02/05 12:13:18  warn rootless{dev/loop6} creating empty file in place of device 7:6
2026/02/05 12:13:18  warn rootless{dev/tty0} creating empty file in place of device 4:0
2026/02/05 12:13:18  warn rootless{dev/ram0} creating empty file in place of device 1:0
2026/02/05 12:13:18  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/05 12:13:18  warn rootless{dev/ram9} creating empty file in place of device 1:9
2026/02/05 12:13:18  warn rootless{dev/ram16} creating empty file in place of device 1:16
2026/02/05 12:13:18  warn rootless{dev/ram15} creating empty file in place of device 1:15
2026/02/05 12:13:18  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/05 12:13:18  warn rootless{dev/ram3} creating empty file in place of device 1:3
2026/02/05 12:13:18  warn rootless{dev/zero} creating empty file in place of device 1:5
2026/02/05 12:13:18  warn rootless{dev/ram12} creating empty file in place of device 1:12
2026/02/05 12:13:18  warn rootless{dev/ram13} creating empty file in place of device 1:13
2026/02/05 12:13:18  warn rootless{dev/loop3} creating empty file in place of device 7:3
2026/02/05 12:13:18  warn rootless{dev/ram5} creating empty file in place of device 1:5
2026/02/05 12:13:18  warn rootless{dev/loop1} creating empty file in place of device 7:1
2026/02/05 12:13:18  warn rootless{dev/console} creating empty file in place of device 5:1
2026/02/05 12:13:18  warn rootless{dev/loop2} creating empty file in place of device 7:2
2026/02/05 12:13:18  warn rootless{dev/ptmx} creating empty file in place of device 5:2
2026/02/05 12:13:18  warn rootless{dev/loop5} creating empty file in place of device 7:5
2026/02/05 12:13:18  warn rootless{dev/ram14} creating empty file in place of device 1:14
2026/02/05 12:13:18  warn rootless{dev/loop4} creating empty file in place of device 7:4
2026/02/05 12:13:18  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/05 12:13:18  warn rootless{dev/kmem} creating empty file in place of device 1:2
FATAL:   Unable to handle docker://quay.io/biocontainers/abyss-k128:2.0.2--boost1.64_2 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:849d331fda7b7fc393ec0953bcbd7bb62af6385d4daeb296316db38ad3d969a6: unpack entry: usr/local/bin/ParseAligns: unpack to regular file: short write: write /tmp/build-temp-3994923088/rootfs/usr/local/bin/ParseAligns: no space left on device
```

