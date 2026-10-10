# moreutils CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| moreutils_chronic | Failed | image problem: chronic is a perl script and the image has no /usr/bin/perl (exec: no such file) |
| moreutils_combine | Failed | image problem: combine is a perl script and the image has no /usr/bin/perl (exec: no such file) |
| moreutils_errno | PASS |  |
| moreutils_ifdata | PASS |  |
| moreutils_ifne | PASS |  |
| moreutils_isutf8 | PASS | synthetic data: one planted Latin-1 file next to a real UTF-8 BED; the bad file was reported |
| moreutils_lckdo | PASS |  |
| moreutils_mispipe | PASS |  |
| moreutils_pee | PASS |  |
| moreutils_sponge | PASS |  |
| moreutils_ts | Failed | image problem: ts is a perl script and the image has no /usr/bin/perl (exec: no such file) |
| moreutils_zrun | Failed | image problem: zrun is a perl script and the image has no /usr/bin/perl (exec: no such file) |

## moreutils_isutf8

### Tool Description
Usage: isutf8 [-hq] [--help] [--quiet] [file ...]

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: https://anaconda.org/channels/bioconda/packages/moreutils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: isutf8 [-hq] [--help] [--quiet] [file ...]
Check whether input files are valid UTF-8.
This is version 1.1.
```

## moreutils_errno

### Tool Description
Usage: errno [-lsS] [--list] [--search] [--search-all-locales] [keyword]

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: https://anaconda.org/channels/bioconda/packages/moreutils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: errno [-lsS] [--list] [--search] [--search-all-locales] [keyword]
```

## moreutils_ifdata

### Tool Description
Usage: ifdata [options] iface

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: https://anaconda.org/channels/bioconda/packages/moreutils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ifdata [options] iface
     -e   Reports interface existence via return code
     -p   Print out the whole config of iface
    -pe   Print out yes or no according to existence
    -pa   Print out the address
    -pn   Print netmask
    -pN   Print network address
    -pb   Print broadcast
    -pm   Print mtu
    -ph   Print out the hardware address
    -pf   Print flags
    -si   Print all statistics on input
   -sip   Print # of in packets
   -sib   Print # of in bytes
   -sie   Print # of in errors
   -sid   Print # of in drops
   -sif   Print # of in fifo overruns
   -sic   Print # of in compress
   -sim   Print # of in multicast
    -so   Print all statistics on output
   -sop   Print # of out packets
   -sob   Print # of out bytes
   -soe   Print # of out errors
   -sod   Print # of out drops
   -sof   Print # of out fifo overruns
   -sox   Print # of out collisions
   -soc   Print # of out carrier loss
   -som   Print # of out multicast
  -bips   Print # of incoming bytes per second
  -bops   Print # of outgoing bytes per second
```

## moreutils_lckdo

### Tool Description
lckdo: execute a program with a lock set.

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: https://anaconda.org/channels/bioconda/packages/moreutils/overview
- **Validation**: PASS

### Original Help Text
```text
lckdo: execute a program with a lock set.
Usage: lckdo [options] lockfile program [arguments]
where options are:
 -w - if the lock is already held by another process,
   wait for it to complete instead of failing immediately
 -W sec - the same as -w but wait not more than sec seconds
 -e - execute the program directly, no fork/wait
   (keeps extra open file descriptor)
 -E nnn - set the fd# to keep open in -e case (implies -e)
 -n - do not create the lock file if it does not exist
 -q - produce no output if lock is already held
 -s - lock in shared (read) mode
 -x - lock in exclusive (write) mode (default)
 -t - test for lock existence (just prints pid if any with -q)
   (implies -n)
```

## moreutils_ts

### Tool Description
Usage: ts [-r] [-i | -s] [-m] [format]

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: https://anaconda.org/channels/bioconda/packages/moreutils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ts [-r] [-i | -s] [-m] [format]
Timestamp standard input.
(help text from the moreutils man page; the image cannot run ts, perl is missing)
```

## moreutils_zrun

### Tool Description
Usage: zrun program [arg ...] file.gz ...

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: https://anaconda.org/channels/bioconda/packages/moreutils/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: zrun program [arg ...] file.gz ...
Automatically uncompress arguments to command.
(help text from the moreutils man page; the image cannot run zrun, perl is missing)
```

## Metadata
- **Skill**: generated

## moreutils_sponge

### Tool Description
Soak up standard input and write to a file. Unlike a shell redirect, sponge soaks up all its input before opening the output file, allowing for reading from and writing to the same file in a pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/moreutils:0.5.7--1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1788024220: no space left on device
```

## moreutils_ifne

### Tool Description
Run a command if the standard input is not empty (or empty with -n).

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/moreutils:0.5.7--1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-4197413047: no space left on device
```

## moreutils_chronic

### Tool Description
Runs a command and hides its standard output and standard error unless the command fails (exits non-zero or crashes).

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/moreutils:0.5.7--1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3606059966: no space left on device
```

## moreutils_pee

### Tool Description
Pipes standard input to the specified commands. It is similar to tee, but for pipes.

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/moreutils:0.5.7--1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1857817263: no space left on device
```

## moreutils_mispipe

### Tool Description
Pipe two commands together and return the exit status of the first command.

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/moreutils:0.5.7--1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-3348743743: no space left on device
```

## moreutils_combine

### Tool Description
Combine the lines in two files using boolean operations (and, or, not, xor).

### Metadata
- **Docker Image**: quay.io/biocontainers/moreutils:0.5.7--1
- **Homepage**: https://github.com/madx/moreutils
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
FATAL:   Unable to handle docker://quay.io/biocontainers/moreutils:0.5.7--1 uri: while building SIF from layers: unable to create new build: failed to create build parent dir: mkdir /tmp/build-temp-1821908281: no space left on device
```

