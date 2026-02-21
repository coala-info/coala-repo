# danpos CWL Generation Report

## danpos

### Tool Description
The provided text does not contain the help documentation for the tool. It is a log of a failed container build process (Singularity/Apptainer) due to 'no space left on device'. As a result, no functional arguments or descriptions could be extracted from this specific input.

### Metadata
- **Docker Image**: biocontainers/danpos:v2.2.2_cv3
- **Homepage**: https://sites.google.com/site/danposdoc/
- **Package**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Total Downloads**: 3.6K
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
2026/02/11 17:23:03  warn rootless{dev/agpgart} creating empty file in place of device 10:175
2026/02/11 17:23:03  warn rootless{dev/audio} creating empty file in place of device 14:4
2026/02/11 17:23:03  warn rootless{dev/audio1} creating empty file in place of device 14:20
2026/02/11 17:23:03  warn rootless{dev/audio2} creating empty file in place of device 14:36
2026/02/11 17:23:03  warn rootless{dev/audio3} creating empty file in place of device 14:52
2026/02/11 17:23:03  warn rootless{dev/audioctl} creating empty file in place of device 14:7
2026/02/11 17:23:03  warn rootless{dev/console} creating empty file in place of device 5:1
2026/02/11 17:23:03  warn rootless{dev/dsp} creating empty file in place of device 14:3
2026/02/11 17:23:03  warn rootless{dev/dsp1} creating empty file in place of device 14:19
2026/02/11 17:23:03  warn rootless{dev/dsp2} creating empty file in place of device 14:35
2026/02/11 17:23:03  warn rootless{dev/dsp3} creating empty file in place of device 14:51
2026/02/11 17:23:03  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/11 17:23:03  warn rootless{dev/kmem} creating empty file in place of device 1:2
2026/02/11 17:23:03  warn rootless{dev/loop0} creating empty file in place of device 7:0
2026/02/11 17:23:03  warn rootless{dev/loop1} creating empty file in place of device 7:1
2026/02/11 17:23:03  warn rootless{dev/loop2} creating empty file in place of device 7:2
2026/02/11 17:23:03  warn rootless{dev/loop3} creating empty file in place of device 7:3
2026/02/11 17:23:03  warn rootless{dev/loop4} creating empty file in place of device 7:4
2026/02/11 17:23:03  warn rootless{dev/loop5} creating empty file in place of device 7:5
2026/02/11 17:23:03  warn rootless{dev/loop6} creating empty file in place of device 7:6
2026/02/11 17:23:03  warn rootless{dev/loop7} creating empty file in place of device 7:7
2026/02/11 17:23:03  warn rootless{dev/mem} creating empty file in place of device 1:1
2026/02/11 17:23:03  warn rootless{dev/midi0} creating empty file in place of device 35:0
2026/02/11 17:23:03  warn rootless{dev/midi00} creating empty file in place of device 14:2
2026/02/11 17:23:03  warn rootless{dev/midi01} creating empty file in place of device 14:18
2026/02/11 17:23:03  warn rootless{dev/midi02} creating empty file in place of device 14:34
2026/02/11 17:23:03  warn rootless{dev/midi03} creating empty file in place of device 14:50
2026/02/11 17:23:03  warn rootless{dev/midi1} creating empty file in place of device 35:1
2026/02/11 17:23:03  warn rootless{dev/midi2} creating empty file in place of device 35:2
2026/02/11 17:23:03  warn rootless{dev/midi3} creating empty file in place of device 35:3
2026/02/11 17:23:03  warn rootless{dev/mixer} creating empty file in place of device 14:0
2026/02/11 17:23:03  warn rootless{dev/mixer1} creating empty file in place of device 14:16
2026/02/11 17:23:03  warn rootless{dev/mixer2} creating empty file in place of device 14:32
2026/02/11 17:23:03  warn rootless{dev/mixer3} creating empty file in place of device 14:48
2026/02/11 17:23:03  warn rootless{dev/mpu401data} creating empty file in place of device 31:0
2026/02/11 17:23:03  warn rootless{dev/mpu401stat} creating empty file in place of device 31:1
2026/02/11 17:23:03  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/11 17:23:03  warn rootless{dev/port} creating empty file in place of device 1:4
2026/02/11 17:23:03  warn rootless{dev/ram0} creating empty file in place of device 1:0
2026/02/11 17:23:03  warn rootless{dev/ram1} creating empty file in place of device 1:1
2026/02/11 17:23:03  warn rootless{dev/ram10} creating empty file in place of device 1:10
2026/02/11 17:23:03  warn rootless{dev/ram11} creating empty file in place of device 1:11
2026/02/11 17:23:03  warn rootless{dev/ram12} creating empty file in place of device 1:12
2026/02/11 17:23:03  warn rootless{dev/ram13} creating empty file in place of device 1:13
2026/02/11 17:23:03  warn rootless{dev/ram14} creating empty file in place of device 1:14
2026/02/11 17:23:03  warn rootless{dev/ram15} creating empty file in place of device 1:15
2026/02/11 17:23:03  warn rootless{dev/ram16} creating empty file in place of device 1:16
2026/02/11 17:23:03  warn rootless{dev/ram2} creating empty file in place of device 1:2
2026/02/11 17:23:03  warn rootless{dev/ram3} creating empty file in place of device 1:3
2026/02/11 17:23:03  warn rootless{dev/ram4} creating empty file in place of device 1:4
2026/02/11 17:23:03  warn rootless{dev/ram5} creating empty file in place of device 1:5
2026/02/11 17:23:03  warn rootless{dev/ram6} creating empty file in place of device 1:6
2026/02/11 17:23:03  warn rootless{dev/ram7} creating empty file in place of device 1:7
2026/02/11 17:23:03  warn rootless{dev/ram8} creating empty file in place of device 1:8
2026/02/11 17:23:03  warn rootless{dev/ram9} creating empty file in place of device 1:9
2026/02/11 17:23:03  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/11 17:23:03  warn rootless{dev/rmidi0} creating empty file in place of device 35:64
2026/02/11 17:23:03  warn rootless{dev/rmidi1} creating empty file in place of device 35:65
2026/02/11 17:23:03  warn rootless{dev/rmidi2} creating empty file in place of device 35:66
2026/02/11 17:23:03  warn rootless{dev/rmidi3} creating empty file in place of device 35:67
2026/02/11 17:23:03  warn rootless{dev/sequencer} creating empty file in place of device 14:1
2026/02/11 17:23:03  warn rootless{dev/smpte0} creating empty file in place of device 35:128
2026/02/11 17:23:03  warn rootless{dev/smpte1} creating empty file in place of device 35:129
2026/02/11 17:23:03  warn rootless{dev/smpte2} creating empty file in place of device 35:130
2026/02/11 17:23:03  warn rootless{dev/smpte3} creating empty file in place of device 35:131
2026/02/11 17:23:03  warn rootless{dev/sndstat} creating empty file in place of device 14:6
2026/02/11 17:23:03  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/11 17:23:03  warn rootless{dev/tty0} creating empty file in place of device 4:0
2026/02/11 17:23:03  warn rootless{dev/tty1} creating empty file in place of device 4:1
2026/02/11 17:23:03  warn rootless{dev/tty2} creating empty file in place of device 4:2
2026/02/11 17:23:03  warn rootless{dev/tty3} creating empty file in place of device 4:3
2026/02/11 17:23:03  warn rootless{dev/tty4} creating empty file in place of device 4:4
2026/02/11 17:23:03  warn rootless{dev/tty5} creating empty file in place of device 4:5
2026/02/11 17:23:03  warn rootless{dev/tty6} creating empty file in place of device 4:6
2026/02/11 17:23:03  warn rootless{dev/tty7} creating empty file in place of device 4:7
2026/02/11 17:23:03  warn rootless{dev/tty8} creating empty file in place of device 4:8
2026/02/11 17:23:03  warn rootless{dev/tty9} creating empty file in place of device 4:9
2026/02/11 17:23:03  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/11 17:23:03  warn rootless{dev/zero} creating empty file in place of device 1:5
FATAL:   Unable to handle docker://biocontainers/danpos:v2.2.2_cv3 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:9ff7e2e5f967fb9c4e8099e63508ab0dddebe3f820d08ca7fd568431b0d10c0e: unpack entry: etc/dpkg/dpkg.cfg.d: mkdirall: unpriv.mkdirall: mkdir /tmp/build-temp-1980881927/rootfs/etc/dpkg/dpkg.cfg.d: no space left on device
```


## Metadata
- **Skill**: generated

## danpos_danpos.py

### Tool Description
The provided text contains system logs and a fatal error message regarding a lack of disk space during a container build; it does not contain the help text or usage information for danpos_danpos.py. As a result, no arguments could be extracted from the input.

### Metadata
- **Docker Image**: biocontainers/danpos:v2.2.2_cv3
- **Homepage**: https://sites.google.com/site/danposdoc/
- **Package**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 17:24:02  warn rootless{dev/agpgart} creating empty file in place of device 10:175
2026/02/11 17:24:02  warn rootless{dev/audio} creating empty file in place of device 14:4
2026/02/11 17:24:02  warn rootless{dev/audio1} creating empty file in place of device 14:20
2026/02/11 17:24:02  warn rootless{dev/audio2} creating empty file in place of device 14:36
2026/02/11 17:24:02  warn rootless{dev/audio3} creating empty file in place of device 14:52
2026/02/11 17:24:02  warn rootless{dev/audioctl} creating empty file in place of device 14:7
2026/02/11 17:24:02  warn rootless{dev/console} creating empty file in place of device 5:1
2026/02/11 17:24:02  warn rootless{dev/dsp} creating empty file in place of device 14:3
2026/02/11 17:24:02  warn rootless{dev/dsp1} creating empty file in place of device 14:19
2026/02/11 17:24:02  warn rootless{dev/dsp2} creating empty file in place of device 14:35
2026/02/11 17:24:02  warn rootless{dev/dsp3} creating empty file in place of device 14:51
2026/02/11 17:24:02  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/11 17:24:02  warn rootless{dev/kmem} creating empty file in place of device 1:2
2026/02/11 17:24:02  warn rootless{dev/loop0} creating empty file in place of device 7:0
2026/02/11 17:24:02  warn rootless{dev/loop1} creating empty file in place of device 7:1
2026/02/11 17:24:02  warn rootless{dev/loop2} creating empty file in place of device 7:2
2026/02/11 17:24:02  warn rootless{dev/loop3} creating empty file in place of device 7:3
2026/02/11 17:24:02  warn rootless{dev/loop4} creating empty file in place of device 7:4
2026/02/11 17:24:02  warn rootless{dev/loop5} creating empty file in place of device 7:5
2026/02/11 17:24:02  warn rootless{dev/loop6} creating empty file in place of device 7:6
2026/02/11 17:24:02  warn rootless{dev/loop7} creating empty file in place of device 7:7
2026/02/11 17:24:02  warn rootless{dev/mem} creating empty file in place of device 1:1
2026/02/11 17:24:02  warn rootless{dev/midi0} creating empty file in place of device 35:0
2026/02/11 17:24:02  warn rootless{dev/midi00} creating empty file in place of device 14:2
2026/02/11 17:24:02  warn rootless{dev/midi01} creating empty file in place of device 14:18
2026/02/11 17:24:02  warn rootless{dev/midi02} creating empty file in place of device 14:34
2026/02/11 17:24:02  warn rootless{dev/midi03} creating empty file in place of device 14:50
2026/02/11 17:24:02  warn rootless{dev/midi1} creating empty file in place of device 35:1
2026/02/11 17:24:02  warn rootless{dev/midi2} creating empty file in place of device 35:2
2026/02/11 17:24:02  warn rootless{dev/midi3} creating empty file in place of device 35:3
2026/02/11 17:24:02  warn rootless{dev/mixer} creating empty file in place of device 14:0
2026/02/11 17:24:02  warn rootless{dev/mixer1} creating empty file in place of device 14:16
2026/02/11 17:24:02  warn rootless{dev/mixer2} creating empty file in place of device 14:32
2026/02/11 17:24:02  warn rootless{dev/mixer3} creating empty file in place of device 14:48
2026/02/11 17:24:02  warn rootless{dev/mpu401data} creating empty file in place of device 31:0
2026/02/11 17:24:02  warn rootless{dev/mpu401stat} creating empty file in place of device 31:1
2026/02/11 17:24:02  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/11 17:24:02  warn rootless{dev/port} creating empty file in place of device 1:4
2026/02/11 17:24:02  warn rootless{dev/ram0} creating empty file in place of device 1:0
2026/02/11 17:24:02  warn rootless{dev/ram1} creating empty file in place of device 1:1
2026/02/11 17:24:02  warn rootless{dev/ram10} creating empty file in place of device 1:10
2026/02/11 17:24:02  warn rootless{dev/ram11} creating empty file in place of device 1:11
2026/02/11 17:24:02  warn rootless{dev/ram12} creating empty file in place of device 1:12
2026/02/11 17:24:02  warn rootless{dev/ram13} creating empty file in place of device 1:13
2026/02/11 17:24:02  warn rootless{dev/ram14} creating empty file in place of device 1:14
2026/02/11 17:24:02  warn rootless{dev/ram15} creating empty file in place of device 1:15
2026/02/11 17:24:02  warn rootless{dev/ram16} creating empty file in place of device 1:16
2026/02/11 17:24:02  warn rootless{dev/ram2} creating empty file in place of device 1:2
2026/02/11 17:24:02  warn rootless{dev/ram3} creating empty file in place of device 1:3
2026/02/11 17:24:02  warn rootless{dev/ram4} creating empty file in place of device 1:4
2026/02/11 17:24:02  warn rootless{dev/ram5} creating empty file in place of device 1:5
2026/02/11 17:24:02  warn rootless{dev/ram6} creating empty file in place of device 1:6
2026/02/11 17:24:02  warn rootless{dev/ram7} creating empty file in place of device 1:7
2026/02/11 17:24:02  warn rootless{dev/ram8} creating empty file in place of device 1:8
2026/02/11 17:24:02  warn rootless{dev/ram9} creating empty file in place of device 1:9
2026/02/11 17:24:02  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/11 17:24:02  warn rootless{dev/rmidi0} creating empty file in place of device 35:64
2026/02/11 17:24:02  warn rootless{dev/rmidi1} creating empty file in place of device 35:65
2026/02/11 17:24:02  warn rootless{dev/rmidi2} creating empty file in place of device 35:66
2026/02/11 17:24:02  warn rootless{dev/rmidi3} creating empty file in place of device 35:67
2026/02/11 17:24:02  warn rootless{dev/sequencer} creating empty file in place of device 14:1
2026/02/11 17:24:02  warn rootless{dev/smpte0} creating empty file in place of device 35:128
2026/02/11 17:24:02  warn rootless{dev/smpte1} creating empty file in place of device 35:129
2026/02/11 17:24:02  warn rootless{dev/smpte2} creating empty file in place of device 35:130
2026/02/11 17:24:02  warn rootless{dev/smpte3} creating empty file in place of device 35:131
2026/02/11 17:24:02  warn rootless{dev/sndstat} creating empty file in place of device 14:6
2026/02/11 17:24:02  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/11 17:24:02  warn rootless{dev/tty0} creating empty file in place of device 4:0
2026/02/11 17:24:02  warn rootless{dev/tty1} creating empty file in place of device 4:1
2026/02/11 17:24:02  warn rootless{dev/tty2} creating empty file in place of device 4:2
2026/02/11 17:24:02  warn rootless{dev/tty3} creating empty file in place of device 4:3
2026/02/11 17:24:02  warn rootless{dev/tty4} creating empty file in place of device 4:4
2026/02/11 17:24:02  warn rootless{dev/tty5} creating empty file in place of device 4:5
2026/02/11 17:24:02  warn rootless{dev/tty6} creating empty file in place of device 4:6
2026/02/11 17:24:02  warn rootless{dev/tty7} creating empty file in place of device 4:7
2026/02/11 17:24:02  warn rootless{dev/tty8} creating empty file in place of device 4:8
2026/02/11 17:24:02  warn rootless{dev/tty9} creating empty file in place of device 4:9
2026/02/11 17:24:02  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/11 17:24:02  warn rootless{dev/zero} creating empty file in place of device 1:5
FATAL:   Unable to handle docker://biocontainers/danpos:v2.2.2_cv3 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:9ff7e2e5f967fb9c4e8099e63508ab0dddebe3f820d08ca7fd568431b0d10c0e: unpack entry: etc/dpkg/dpkg.cfg.d: mkdirall: unpriv.mkdirall: mkdir /tmp/build-temp-2420749685/rootfs/etc/dpkg/dpkg.cfg.d: no space left on device
```

## danpos_dpos

### Tool Description
Analyze dynamics of nucleosome positions, including occupancy, position, and fuzziness changes.

### Metadata
- **Docker Image**: biocontainers/danpos:v2.2.2_cv3
- **Homepage**: https://sites.google.com/site/danposdoc/
- **Package**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 17:24:15  warn rootless{dev/agpgart} creating empty file in place of device 10:175
2026/02/11 17:24:15  warn rootless{dev/audio} creating empty file in place of device 14:4
2026/02/11 17:24:15  warn rootless{dev/audio1} creating empty file in place of device 14:20
2026/02/11 17:24:15  warn rootless{dev/audio2} creating empty file in place of device 14:36
2026/02/11 17:24:15  warn rootless{dev/audio3} creating empty file in place of device 14:52
2026/02/11 17:24:15  warn rootless{dev/audioctl} creating empty file in place of device 14:7
2026/02/11 17:24:15  warn rootless{dev/console} creating empty file in place of device 5:1
2026/02/11 17:24:15  warn rootless{dev/dsp} creating empty file in place of device 14:3
2026/02/11 17:24:15  warn rootless{dev/dsp1} creating empty file in place of device 14:19
2026/02/11 17:24:15  warn rootless{dev/dsp2} creating empty file in place of device 14:35
2026/02/11 17:24:15  warn rootless{dev/dsp3} creating empty file in place of device 14:51
2026/02/11 17:24:15  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/11 17:24:15  warn rootless{dev/kmem} creating empty file in place of device 1:2
2026/02/11 17:24:15  warn rootless{dev/loop0} creating empty file in place of device 7:0
2026/02/11 17:24:15  warn rootless{dev/loop1} creating empty file in place of device 7:1
2026/02/11 17:24:15  warn rootless{dev/loop2} creating empty file in place of device 7:2
2026/02/11 17:24:15  warn rootless{dev/loop3} creating empty file in place of device 7:3
2026/02/11 17:24:15  warn rootless{dev/loop4} creating empty file in place of device 7:4
2026/02/11 17:24:15  warn rootless{dev/loop5} creating empty file in place of device 7:5
2026/02/11 17:24:15  warn rootless{dev/loop6} creating empty file in place of device 7:6
2026/02/11 17:24:15  warn rootless{dev/loop7} creating empty file in place of device 7:7
2026/02/11 17:24:15  warn rootless{dev/mem} creating empty file in place of device 1:1
2026/02/11 17:24:15  warn rootless{dev/midi0} creating empty file in place of device 35:0
2026/02/11 17:24:15  warn rootless{dev/midi00} creating empty file in place of device 14:2
2026/02/11 17:24:15  warn rootless{dev/midi01} creating empty file in place of device 14:18
2026/02/11 17:24:15  warn rootless{dev/midi02} creating empty file in place of device 14:34
2026/02/11 17:24:15  warn rootless{dev/midi03} creating empty file in place of device 14:50
2026/02/11 17:24:15  warn rootless{dev/midi1} creating empty file in place of device 35:1
2026/02/11 17:24:15  warn rootless{dev/midi2} creating empty file in place of device 35:2
2026/02/11 17:24:15  warn rootless{dev/midi3} creating empty file in place of device 35:3
2026/02/11 17:24:15  warn rootless{dev/mixer} creating empty file in place of device 14:0
2026/02/11 17:24:15  warn rootless{dev/mixer1} creating empty file in place of device 14:16
2026/02/11 17:24:15  warn rootless{dev/mixer2} creating empty file in place of device 14:32
2026/02/11 17:24:15  warn rootless{dev/mixer3} creating empty file in place of device 14:48
2026/02/11 17:24:15  warn rootless{dev/mpu401data} creating empty file in place of device 31:0
2026/02/11 17:24:15  warn rootless{dev/mpu401stat} creating empty file in place of device 31:1
2026/02/11 17:24:15  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/11 17:24:15  warn rootless{dev/port} creating empty file in place of device 1:4
2026/02/11 17:24:15  warn rootless{dev/ram0} creating empty file in place of device 1:0
2026/02/11 17:24:15  warn rootless{dev/ram1} creating empty file in place of device 1:1
2026/02/11 17:24:15  warn rootless{dev/ram10} creating empty file in place of device 1:10
2026/02/11 17:24:15  warn rootless{dev/ram11} creating empty file in place of device 1:11
2026/02/11 17:24:15  warn rootless{dev/ram12} creating empty file in place of device 1:12
2026/02/11 17:24:15  warn rootless{dev/ram13} creating empty file in place of device 1:13
2026/02/11 17:24:15  warn rootless{dev/ram14} creating empty file in place of device 1:14
2026/02/11 17:24:15  warn rootless{dev/ram15} creating empty file in place of device 1:15
2026/02/11 17:24:15  warn rootless{dev/ram16} creating empty file in place of device 1:16
2026/02/11 17:24:15  warn rootless{dev/ram2} creating empty file in place of device 1:2
2026/02/11 17:24:15  warn rootless{dev/ram3} creating empty file in place of device 1:3
2026/02/11 17:24:15  warn rootless{dev/ram4} creating empty file in place of device 1:4
2026/02/11 17:24:15  warn rootless{dev/ram5} creating empty file in place of device 1:5
2026/02/11 17:24:15  warn rootless{dev/ram6} creating empty file in place of device 1:6
2026/02/11 17:24:15  warn rootless{dev/ram7} creating empty file in place of device 1:7
2026/02/11 17:24:15  warn rootless{dev/ram8} creating empty file in place of device 1:8
2026/02/11 17:24:15  warn rootless{dev/ram9} creating empty file in place of device 1:9
2026/02/11 17:24:15  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/11 17:24:15  warn rootless{dev/rmidi0} creating empty file in place of device 35:64
2026/02/11 17:24:15  warn rootless{dev/rmidi1} creating empty file in place of device 35:65
2026/02/11 17:24:15  warn rootless{dev/rmidi2} creating empty file in place of device 35:66
2026/02/11 17:24:15  warn rootless{dev/rmidi3} creating empty file in place of device 35:67
2026/02/11 17:24:15  warn rootless{dev/sequencer} creating empty file in place of device 14:1
2026/02/11 17:24:15  warn rootless{dev/smpte0} creating empty file in place of device 35:128
2026/02/11 17:24:15  warn rootless{dev/smpte1} creating empty file in place of device 35:129
2026/02/11 17:24:15  warn rootless{dev/smpte2} creating empty file in place of device 35:130
2026/02/11 17:24:15  warn rootless{dev/smpte3} creating empty file in place of device 35:131
2026/02/11 17:24:15  warn rootless{dev/sndstat} creating empty file in place of device 14:6
2026/02/11 17:24:15  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/11 17:24:15  warn rootless{dev/tty0} creating empty file in place of device 4:0
2026/02/11 17:24:15  warn rootless{dev/tty1} creating empty file in place of device 4:1
2026/02/11 17:24:15  warn rootless{dev/tty2} creating empty file in place of device 4:2
2026/02/11 17:24:15  warn rootless{dev/tty3} creating empty file in place of device 4:3
2026/02/11 17:24:15  warn rootless{dev/tty4} creating empty file in place of device 4:4
2026/02/11 17:24:15  warn rootless{dev/tty5} creating empty file in place of device 4:5
2026/02/11 17:24:15  warn rootless{dev/tty6} creating empty file in place of device 4:6
2026/02/11 17:24:15  warn rootless{dev/tty7} creating empty file in place of device 4:7
2026/02/11 17:24:15  warn rootless{dev/tty8} creating empty file in place of device 4:8
2026/02/11 17:24:15  warn rootless{dev/tty9} creating empty file in place of device 4:9
2026/02/11 17:24:15  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/11 17:24:15  warn rootless{dev/zero} creating empty file in place of device 1:5
FATAL:   Unable to handle docker://biocontainers/danpos:v2.2.2_cv3 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:9ff7e2e5f967fb9c4e8099e63508ab0dddebe3f820d08ca7fd568431b0d10c0e: unpack entry: etc/dpkg/dpkg.cfg.d: mkdirall: unpriv.mkdirall: mkdir /tmp/build-temp-1081647916/rootfs/etc/dpkg/dpkg.cfg.d: no space left on device
```

## danpos_dpeak

### Tool Description
The dpeak function in DANPOS is used for calling peaks (nucleosomes) from sequencing data, typically after preprocessing or for specific enrichment analysis.

### Metadata
- **Docker Image**: biocontainers/danpos:v2.2.2_cv3
- **Homepage**: https://sites.google.com/site/danposdoc/
- **Package**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 17:24:37  warn rootless{dev/agpgart} creating empty file in place of device 10:175
2026/02/11 17:24:37  warn rootless{dev/audio} creating empty file in place of device 14:4
2026/02/11 17:24:37  warn rootless{dev/audio1} creating empty file in place of device 14:20
2026/02/11 17:24:37  warn rootless{dev/audio2} creating empty file in place of device 14:36
2026/02/11 17:24:37  warn rootless{dev/audio3} creating empty file in place of device 14:52
2026/02/11 17:24:37  warn rootless{dev/audioctl} creating empty file in place of device 14:7
2026/02/11 17:24:37  warn rootless{dev/console} creating empty file in place of device 5:1
2026/02/11 17:24:37  warn rootless{dev/dsp} creating empty file in place of device 14:3
2026/02/11 17:24:37  warn rootless{dev/dsp1} creating empty file in place of device 14:19
2026/02/11 17:24:37  warn rootless{dev/dsp2} creating empty file in place of device 14:35
2026/02/11 17:24:37  warn rootless{dev/dsp3} creating empty file in place of device 14:51
2026/02/11 17:24:37  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/11 17:24:37  warn rootless{dev/kmem} creating empty file in place of device 1:2
2026/02/11 17:24:37  warn rootless{dev/loop0} creating empty file in place of device 7:0
2026/02/11 17:24:37  warn rootless{dev/loop1} creating empty file in place of device 7:1
2026/02/11 17:24:37  warn rootless{dev/loop2} creating empty file in place of device 7:2
2026/02/11 17:24:37  warn rootless{dev/loop3} creating empty file in place of device 7:3
2026/02/11 17:24:37  warn rootless{dev/loop4} creating empty file in place of device 7:4
2026/02/11 17:24:37  warn rootless{dev/loop5} creating empty file in place of device 7:5
2026/02/11 17:24:37  warn rootless{dev/loop6} creating empty file in place of device 7:6
2026/02/11 17:24:37  warn rootless{dev/loop7} creating empty file in place of device 7:7
2026/02/11 17:24:37  warn rootless{dev/mem} creating empty file in place of device 1:1
2026/02/11 17:24:37  warn rootless{dev/midi0} creating empty file in place of device 35:0
2026/02/11 17:24:37  warn rootless{dev/midi00} creating empty file in place of device 14:2
2026/02/11 17:24:37  warn rootless{dev/midi01} creating empty file in place of device 14:18
2026/02/11 17:24:37  warn rootless{dev/midi02} creating empty file in place of device 14:34
2026/02/11 17:24:37  warn rootless{dev/midi03} creating empty file in place of device 14:50
2026/02/11 17:24:37  warn rootless{dev/midi1} creating empty file in place of device 35:1
2026/02/11 17:24:37  warn rootless{dev/midi2} creating empty file in place of device 35:2
2026/02/11 17:24:37  warn rootless{dev/midi3} creating empty file in place of device 35:3
2026/02/11 17:24:37  warn rootless{dev/mixer} creating empty file in place of device 14:0
2026/02/11 17:24:37  warn rootless{dev/mixer1} creating empty file in place of device 14:16
2026/02/11 17:24:37  warn rootless{dev/mixer2} creating empty file in place of device 14:32
2026/02/11 17:24:37  warn rootless{dev/mixer3} creating empty file in place of device 14:48
2026/02/11 17:24:37  warn rootless{dev/mpu401data} creating empty file in place of device 31:0
2026/02/11 17:24:37  warn rootless{dev/mpu401stat} creating empty file in place of device 31:1
2026/02/11 17:24:37  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/11 17:24:37  warn rootless{dev/port} creating empty file in place of device 1:4
2026/02/11 17:24:37  warn rootless{dev/ram0} creating empty file in place of device 1:0
2026/02/11 17:24:37  warn rootless{dev/ram1} creating empty file in place of device 1:1
2026/02/11 17:24:37  warn rootless{dev/ram10} creating empty file in place of device 1:10
2026/02/11 17:24:37  warn rootless{dev/ram11} creating empty file in place of device 1:11
2026/02/11 17:24:37  warn rootless{dev/ram12} creating empty file in place of device 1:12
2026/02/11 17:24:37  warn rootless{dev/ram13} creating empty file in place of device 1:13
2026/02/11 17:24:37  warn rootless{dev/ram14} creating empty file in place of device 1:14
2026/02/11 17:24:37  warn rootless{dev/ram15} creating empty file in place of device 1:15
2026/02/11 17:24:37  warn rootless{dev/ram16} creating empty file in place of device 1:16
2026/02/11 17:24:37  warn rootless{dev/ram2} creating empty file in place of device 1:2
2026/02/11 17:24:37  warn rootless{dev/ram3} creating empty file in place of device 1:3
2026/02/11 17:24:37  warn rootless{dev/ram4} creating empty file in place of device 1:4
2026/02/11 17:24:37  warn rootless{dev/ram5} creating empty file in place of device 1:5
2026/02/11 17:24:37  warn rootless{dev/ram6} creating empty file in place of device 1:6
2026/02/11 17:24:37  warn rootless{dev/ram7} creating empty file in place of device 1:7
2026/02/11 17:24:37  warn rootless{dev/ram8} creating empty file in place of device 1:8
2026/02/11 17:24:37  warn rootless{dev/ram9} creating empty file in place of device 1:9
2026/02/11 17:24:37  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/11 17:24:37  warn rootless{dev/rmidi0} creating empty file in place of device 35:64
2026/02/11 17:24:37  warn rootless{dev/rmidi1} creating empty file in place of device 35:65
2026/02/11 17:24:37  warn rootless{dev/rmidi2} creating empty file in place of device 35:66
2026/02/11 17:24:37  warn rootless{dev/rmidi3} creating empty file in place of device 35:67
2026/02/11 17:24:37  warn rootless{dev/sequencer} creating empty file in place of device 14:1
2026/02/11 17:24:37  warn rootless{dev/smpte0} creating empty file in place of device 35:128
2026/02/11 17:24:37  warn rootless{dev/smpte1} creating empty file in place of device 35:129
2026/02/11 17:24:37  warn rootless{dev/smpte2} creating empty file in place of device 35:130
2026/02/11 17:24:37  warn rootless{dev/smpte3} creating empty file in place of device 35:131
2026/02/11 17:24:37  warn rootless{dev/sndstat} creating empty file in place of device 14:6
2026/02/11 17:24:37  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/11 17:24:37  warn rootless{dev/tty0} creating empty file in place of device 4:0
2026/02/11 17:24:37  warn rootless{dev/tty1} creating empty file in place of device 4:1
2026/02/11 17:24:37  warn rootless{dev/tty2} creating empty file in place of device 4:2
2026/02/11 17:24:37  warn rootless{dev/tty3} creating empty file in place of device 4:3
2026/02/11 17:24:37  warn rootless{dev/tty4} creating empty file in place of device 4:4
2026/02/11 17:24:37  warn rootless{dev/tty5} creating empty file in place of device 4:5
2026/02/11 17:24:37  warn rootless{dev/tty6} creating empty file in place of device 4:6
2026/02/11 17:24:37  warn rootless{dev/tty7} creating empty file in place of device 4:7
2026/02/11 17:24:37  warn rootless{dev/tty8} creating empty file in place of device 4:8
2026/02/11 17:24:37  warn rootless{dev/tty9} creating empty file in place of device 4:9
2026/02/11 17:24:37  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/11 17:24:37  warn rootless{dev/zero} creating empty file in place of device 1:5
FATAL:   Unable to handle docker://biocontainers/danpos:v2.2.2_cv3 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:9ff7e2e5f967fb9c4e8099e63508ab0dddebe3f820d08ca7fd568431b0d10c0e: unpack entry: etc/dpkg/dpkg.cfg.d: mkdirall: unpriv.mkdirall: mkdir /tmp/build-temp-1658898796/rootfs/etc/dpkg/dpkg.cfg.d: no space left on device
```

## danpos_dregion

### Tool Description
The provided text contains system logs and error messages related to a container build failure and does not contain the help text for the tool. Based on the tool name hint, this is part of the DANPOS (Dynamic Analysis of Nucleosome Positioning and Occupancy by Sequencing) suite, specifically the 'dregion' subcommand for detecting differential regions.

### Metadata
- **Docker Image**: biocontainers/danpos:v2.2.2_cv3
- **Homepage**: https://sites.google.com/site/danposdoc/
- **Package**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 17:24:57  warn rootless{dev/agpgart} creating empty file in place of device 10:175
2026/02/11 17:24:57  warn rootless{dev/audio} creating empty file in place of device 14:4
2026/02/11 17:24:57  warn rootless{dev/audio1} creating empty file in place of device 14:20
2026/02/11 17:24:57  warn rootless{dev/audio2} creating empty file in place of device 14:36
2026/02/11 17:24:57  warn rootless{dev/audio3} creating empty file in place of device 14:52
2026/02/11 17:24:57  warn rootless{dev/audioctl} creating empty file in place of device 14:7
2026/02/11 17:24:57  warn rootless{dev/console} creating empty file in place of device 5:1
2026/02/11 17:24:57  warn rootless{dev/dsp} creating empty file in place of device 14:3
2026/02/11 17:24:57  warn rootless{dev/dsp1} creating empty file in place of device 14:19
2026/02/11 17:24:57  warn rootless{dev/dsp2} creating empty file in place of device 14:35
2026/02/11 17:24:57  warn rootless{dev/dsp3} creating empty file in place of device 14:51
2026/02/11 17:24:57  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/11 17:24:57  warn rootless{dev/kmem} creating empty file in place of device 1:2
2026/02/11 17:24:57  warn rootless{dev/loop0} creating empty file in place of device 7:0
2026/02/11 17:24:57  warn rootless{dev/loop1} creating empty file in place of device 7:1
2026/02/11 17:24:57  warn rootless{dev/loop2} creating empty file in place of device 7:2
2026/02/11 17:24:57  warn rootless{dev/loop3} creating empty file in place of device 7:3
2026/02/11 17:24:57  warn rootless{dev/loop4} creating empty file in place of device 7:4
2026/02/11 17:24:57  warn rootless{dev/loop5} creating empty file in place of device 7:5
2026/02/11 17:24:57  warn rootless{dev/loop6} creating empty file in place of device 7:6
2026/02/11 17:24:57  warn rootless{dev/loop7} creating empty file in place of device 7:7
2026/02/11 17:24:57  warn rootless{dev/mem} creating empty file in place of device 1:1
2026/02/11 17:24:57  warn rootless{dev/midi0} creating empty file in place of device 35:0
2026/02/11 17:24:57  warn rootless{dev/midi00} creating empty file in place of device 14:2
2026/02/11 17:24:57  warn rootless{dev/midi01} creating empty file in place of device 14:18
2026/02/11 17:24:57  warn rootless{dev/midi02} creating empty file in place of device 14:34
2026/02/11 17:24:57  warn rootless{dev/midi03} creating empty file in place of device 14:50
2026/02/11 17:24:57  warn rootless{dev/midi1} creating empty file in place of device 35:1
2026/02/11 17:24:57  warn rootless{dev/midi2} creating empty file in place of device 35:2
2026/02/11 17:24:57  warn rootless{dev/midi3} creating empty file in place of device 35:3
2026/02/11 17:24:57  warn rootless{dev/mixer} creating empty file in place of device 14:0
2026/02/11 17:24:57  warn rootless{dev/mixer1} creating empty file in place of device 14:16
2026/02/11 17:24:57  warn rootless{dev/mixer2} creating empty file in place of device 14:32
2026/02/11 17:24:57  warn rootless{dev/mixer3} creating empty file in place of device 14:48
2026/02/11 17:24:57  warn rootless{dev/mpu401data} creating empty file in place of device 31:0
2026/02/11 17:24:57  warn rootless{dev/mpu401stat} creating empty file in place of device 31:1
2026/02/11 17:24:57  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/11 17:24:57  warn rootless{dev/port} creating empty file in place of device 1:4
2026/02/11 17:24:57  warn rootless{dev/ram0} creating empty file in place of device 1:0
2026/02/11 17:24:57  warn rootless{dev/ram1} creating empty file in place of device 1:1
2026/02/11 17:24:57  warn rootless{dev/ram10} creating empty file in place of device 1:10
2026/02/11 17:24:57  warn rootless{dev/ram11} creating empty file in place of device 1:11
2026/02/11 17:24:57  warn rootless{dev/ram12} creating empty file in place of device 1:12
2026/02/11 17:24:57  warn rootless{dev/ram13} creating empty file in place of device 1:13
2026/02/11 17:24:57  warn rootless{dev/ram14} creating empty file in place of device 1:14
2026/02/11 17:24:57  warn rootless{dev/ram15} creating empty file in place of device 1:15
2026/02/11 17:24:57  warn rootless{dev/ram16} creating empty file in place of device 1:16
2026/02/11 17:24:57  warn rootless{dev/ram2} creating empty file in place of device 1:2
2026/02/11 17:24:57  warn rootless{dev/ram3} creating empty file in place of device 1:3
2026/02/11 17:24:57  warn rootless{dev/ram4} creating empty file in place of device 1:4
2026/02/11 17:24:57  warn rootless{dev/ram5} creating empty file in place of device 1:5
2026/02/11 17:24:57  warn rootless{dev/ram6} creating empty file in place of device 1:6
2026/02/11 17:24:57  warn rootless{dev/ram7} creating empty file in place of device 1:7
2026/02/11 17:24:57  warn rootless{dev/ram8} creating empty file in place of device 1:8
2026/02/11 17:24:57  warn rootless{dev/ram9} creating empty file in place of device 1:9
2026/02/11 17:24:57  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/11 17:24:57  warn rootless{dev/rmidi0} creating empty file in place of device 35:64
2026/02/11 17:24:57  warn rootless{dev/rmidi1} creating empty file in place of device 35:65
2026/02/11 17:24:57  warn rootless{dev/rmidi2} creating empty file in place of device 35:66
2026/02/11 17:24:57  warn rootless{dev/rmidi3} creating empty file in place of device 35:67
2026/02/11 17:24:57  warn rootless{dev/sequencer} creating empty file in place of device 14:1
2026/02/11 17:24:57  warn rootless{dev/smpte0} creating empty file in place of device 35:128
2026/02/11 17:24:57  warn rootless{dev/smpte1} creating empty file in place of device 35:129
2026/02/11 17:24:57  warn rootless{dev/smpte2} creating empty file in place of device 35:130
2026/02/11 17:24:57  warn rootless{dev/smpte3} creating empty file in place of device 35:131
2026/02/11 17:24:57  warn rootless{dev/sndstat} creating empty file in place of device 14:6
2026/02/11 17:24:57  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/11 17:24:57  warn rootless{dev/tty0} creating empty file in place of device 4:0
2026/02/11 17:24:57  warn rootless{dev/tty1} creating empty file in place of device 4:1
2026/02/11 17:24:57  warn rootless{dev/tty2} creating empty file in place of device 4:2
2026/02/11 17:24:57  warn rootless{dev/tty3} creating empty file in place of device 4:3
2026/02/11 17:24:57  warn rootless{dev/tty4} creating empty file in place of device 4:4
2026/02/11 17:24:57  warn rootless{dev/tty5} creating empty file in place of device 4:5
2026/02/11 17:24:57  warn rootless{dev/tty6} creating empty file in place of device 4:6
2026/02/11 17:24:57  warn rootless{dev/tty7} creating empty file in place of device 4:7
2026/02/11 17:24:57  warn rootless{dev/tty8} creating empty file in place of device 4:8
2026/02/11 17:24:57  warn rootless{dev/tty9} creating empty file in place of device 4:9
2026/02/11 17:24:57  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/11 17:24:57  warn rootless{dev/zero} creating empty file in place of device 1:5
FATAL:   Unable to handle docker://biocontainers/danpos:v2.2.2_cv3 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:9ff7e2e5f967fb9c4e8099e63508ab0dddebe3f820d08ca7fd568431b0d10c0e: unpack entry: etc/dhcp/dhclient-exit-hooks.d/timesyncd: unpack to regular file: short write: write /tmp/build-temp-2977635230/rootfs/etc/dhcp/dhclient-exit-hooks.d/timesyncd: no space left on device
```

## danpos_dtriple

### Tool Description
The provided text does not contain the help documentation for danpos_dtriple; it contains system logs and a fatal error indicating a failure to build or run the container due to lack of disk space. No arguments could be extracted from the provided text.

### Metadata
- **Docker Image**: biocontainers/danpos:v2.2.2_cv3
- **Homepage**: https://sites.google.com/site/danposdoc/
- **Package**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 17:25:12  warn rootless{dev/agpgart} creating empty file in place of device 10:175
2026/02/11 17:25:12  warn rootless{dev/audio} creating empty file in place of device 14:4
2026/02/11 17:25:12  warn rootless{dev/audio1} creating empty file in place of device 14:20
2026/02/11 17:25:12  warn rootless{dev/audio2} creating empty file in place of device 14:36
2026/02/11 17:25:12  warn rootless{dev/audio3} creating empty file in place of device 14:52
2026/02/11 17:25:12  warn rootless{dev/audioctl} creating empty file in place of device 14:7
2026/02/11 17:25:12  warn rootless{dev/console} creating empty file in place of device 5:1
2026/02/11 17:25:12  warn rootless{dev/dsp} creating empty file in place of device 14:3
2026/02/11 17:25:12  warn rootless{dev/dsp1} creating empty file in place of device 14:19
2026/02/11 17:25:12  warn rootless{dev/dsp2} creating empty file in place of device 14:35
2026/02/11 17:25:12  warn rootless{dev/dsp3} creating empty file in place of device 14:51
2026/02/11 17:25:12  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/11 17:25:12  warn rootless{dev/kmem} creating empty file in place of device 1:2
2026/02/11 17:25:12  warn rootless{dev/loop0} creating empty file in place of device 7:0
2026/02/11 17:25:12  warn rootless{dev/loop1} creating empty file in place of device 7:1
2026/02/11 17:25:12  warn rootless{dev/loop2} creating empty file in place of device 7:2
2026/02/11 17:25:12  warn rootless{dev/loop3} creating empty file in place of device 7:3
2026/02/11 17:25:12  warn rootless{dev/loop4} creating empty file in place of device 7:4
2026/02/11 17:25:12  warn rootless{dev/loop5} creating empty file in place of device 7:5
2026/02/11 17:25:12  warn rootless{dev/loop6} creating empty file in place of device 7:6
2026/02/11 17:25:12  warn rootless{dev/loop7} creating empty file in place of device 7:7
2026/02/11 17:25:12  warn rootless{dev/mem} creating empty file in place of device 1:1
2026/02/11 17:25:12  warn rootless{dev/midi0} creating empty file in place of device 35:0
2026/02/11 17:25:12  warn rootless{dev/midi00} creating empty file in place of device 14:2
2026/02/11 17:25:12  warn rootless{dev/midi01} creating empty file in place of device 14:18
2026/02/11 17:25:12  warn rootless{dev/midi02} creating empty file in place of device 14:34
2026/02/11 17:25:12  warn rootless{dev/midi03} creating empty file in place of device 14:50
2026/02/11 17:25:12  warn rootless{dev/midi1} creating empty file in place of device 35:1
2026/02/11 17:25:12  warn rootless{dev/midi2} creating empty file in place of device 35:2
2026/02/11 17:25:12  warn rootless{dev/midi3} creating empty file in place of device 35:3
2026/02/11 17:25:12  warn rootless{dev/mixer} creating empty file in place of device 14:0
2026/02/11 17:25:12  warn rootless{dev/mixer1} creating empty file in place of device 14:16
2026/02/11 17:25:12  warn rootless{dev/mixer2} creating empty file in place of device 14:32
2026/02/11 17:25:12  warn rootless{dev/mixer3} creating empty file in place of device 14:48
2026/02/11 17:25:12  warn rootless{dev/mpu401data} creating empty file in place of device 31:0
2026/02/11 17:25:12  warn rootless{dev/mpu401stat} creating empty file in place of device 31:1
2026/02/11 17:25:12  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/11 17:25:12  warn rootless{dev/port} creating empty file in place of device 1:4
2026/02/11 17:25:12  warn rootless{dev/ram0} creating empty file in place of device 1:0
2026/02/11 17:25:12  warn rootless{dev/ram1} creating empty file in place of device 1:1
2026/02/11 17:25:12  warn rootless{dev/ram10} creating empty file in place of device 1:10
2026/02/11 17:25:12  warn rootless{dev/ram11} creating empty file in place of device 1:11
2026/02/11 17:25:12  warn rootless{dev/ram12} creating empty file in place of device 1:12
2026/02/11 17:25:12  warn rootless{dev/ram13} creating empty file in place of device 1:13
2026/02/11 17:25:12  warn rootless{dev/ram14} creating empty file in place of device 1:14
2026/02/11 17:25:12  warn rootless{dev/ram15} creating empty file in place of device 1:15
2026/02/11 17:25:12  warn rootless{dev/ram16} creating empty file in place of device 1:16
2026/02/11 17:25:12  warn rootless{dev/ram2} creating empty file in place of device 1:2
2026/02/11 17:25:12  warn rootless{dev/ram3} creating empty file in place of device 1:3
2026/02/11 17:25:12  warn rootless{dev/ram4} creating empty file in place of device 1:4
2026/02/11 17:25:12  warn rootless{dev/ram5} creating empty file in place of device 1:5
2026/02/11 17:25:12  warn rootless{dev/ram6} creating empty file in place of device 1:6
2026/02/11 17:25:12  warn rootless{dev/ram7} creating empty file in place of device 1:7
2026/02/11 17:25:12  warn rootless{dev/ram8} creating empty file in place of device 1:8
2026/02/11 17:25:12  warn rootless{dev/ram9} creating empty file in place of device 1:9
2026/02/11 17:25:12  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/11 17:25:12  warn rootless{dev/rmidi0} creating empty file in place of device 35:64
2026/02/11 17:25:12  warn rootless{dev/rmidi1} creating empty file in place of device 35:65
2026/02/11 17:25:12  warn rootless{dev/rmidi2} creating empty file in place of device 35:66
2026/02/11 17:25:12  warn rootless{dev/rmidi3} creating empty file in place of device 35:67
2026/02/11 17:25:12  warn rootless{dev/sequencer} creating empty file in place of device 14:1
2026/02/11 17:25:12  warn rootless{dev/smpte0} creating empty file in place of device 35:128
2026/02/11 17:25:12  warn rootless{dev/smpte1} creating empty file in place of device 35:129
2026/02/11 17:25:12  warn rootless{dev/smpte2} creating empty file in place of device 35:130
2026/02/11 17:25:12  warn rootless{dev/smpte3} creating empty file in place of device 35:131
2026/02/11 17:25:12  warn rootless{dev/sndstat} creating empty file in place of device 14:6
2026/02/11 17:25:12  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/11 17:25:12  warn rootless{dev/tty0} creating empty file in place of device 4:0
2026/02/11 17:25:12  warn rootless{dev/tty1} creating empty file in place of device 4:1
2026/02/11 17:25:12  warn rootless{dev/tty2} creating empty file in place of device 4:2
2026/02/11 17:25:12  warn rootless{dev/tty3} creating empty file in place of device 4:3
2026/02/11 17:25:12  warn rootless{dev/tty4} creating empty file in place of device 4:4
2026/02/11 17:25:12  warn rootless{dev/tty5} creating empty file in place of device 4:5
2026/02/11 17:25:12  warn rootless{dev/tty6} creating empty file in place of device 4:6
2026/02/11 17:25:12  warn rootless{dev/tty7} creating empty file in place of device 4:7
2026/02/11 17:25:12  warn rootless{dev/tty8} creating empty file in place of device 4:8
2026/02/11 17:25:12  warn rootless{dev/tty9} creating empty file in place of device 4:9
2026/02/11 17:25:12  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/11 17:25:12  warn rootless{dev/zero} creating empty file in place of device 1:5
FATAL:   Unable to handle docker://biocontainers/danpos:v2.2.2_cv3 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:9ff7e2e5f967fb9c4e8099e63508ab0dddebe3f820d08ca7fd568431b0d10c0e: unpack entry: etc/dhcp/dhclient-exit-hooks.d/timesyncd: unpack to regular file: short write: write /tmp/build-temp-2011678163/rootfs/etc/dhcp/dhclient-exit-hooks.d/timesyncd: no space left on device
```

## danpos_wiq

### Tool Description
Wig data normalization and comparison (part of the DANPOS suite for nucleosome positioning analysis). Note: The provided text is a container build log and does not contain CLI help information.

### Metadata
- **Docker Image**: biocontainers/danpos:v2.2.2_cv3
- **Homepage**: https://sites.google.com/site/danposdoc/
- **Package**: https://anaconda.org/channels/bioconda/packages/danpos/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/11 17:25:27  warn rootless{dev/agpgart} creating empty file in place of device 10:175
2026/02/11 17:25:27  warn rootless{dev/audio} creating empty file in place of device 14:4
2026/02/11 17:25:27  warn rootless{dev/audio1} creating empty file in place of device 14:20
2026/02/11 17:25:27  warn rootless{dev/audio2} creating empty file in place of device 14:36
2026/02/11 17:25:27  warn rootless{dev/audio3} creating empty file in place of device 14:52
2026/02/11 17:25:27  warn rootless{dev/audioctl} creating empty file in place of device 14:7
2026/02/11 17:25:27  warn rootless{dev/console} creating empty file in place of device 5:1
2026/02/11 17:25:27  warn rootless{dev/dsp} creating empty file in place of device 14:3
2026/02/11 17:25:27  warn rootless{dev/dsp1} creating empty file in place of device 14:19
2026/02/11 17:25:27  warn rootless{dev/dsp2} creating empty file in place of device 14:35
2026/02/11 17:25:27  warn rootless{dev/dsp3} creating empty file in place of device 14:51
2026/02/11 17:25:27  warn rootless{dev/full} creating empty file in place of device 1:7
2026/02/11 17:25:27  warn rootless{dev/kmem} creating empty file in place of device 1:2
2026/02/11 17:25:27  warn rootless{dev/loop0} creating empty file in place of device 7:0
2026/02/11 17:25:27  warn rootless{dev/loop1} creating empty file in place of device 7:1
2026/02/11 17:25:27  warn rootless{dev/loop2} creating empty file in place of device 7:2
2026/02/11 17:25:27  warn rootless{dev/loop3} creating empty file in place of device 7:3
2026/02/11 17:25:27  warn rootless{dev/loop4} creating empty file in place of device 7:4
2026/02/11 17:25:27  warn rootless{dev/loop5} creating empty file in place of device 7:5
2026/02/11 17:25:27  warn rootless{dev/loop6} creating empty file in place of device 7:6
2026/02/11 17:25:27  warn rootless{dev/loop7} creating empty file in place of device 7:7
2026/02/11 17:25:27  warn rootless{dev/mem} creating empty file in place of device 1:1
2026/02/11 17:25:27  warn rootless{dev/midi0} creating empty file in place of device 35:0
2026/02/11 17:25:27  warn rootless{dev/midi00} creating empty file in place of device 14:2
2026/02/11 17:25:27  warn rootless{dev/midi01} creating empty file in place of device 14:18
2026/02/11 17:25:27  warn rootless{dev/midi02} creating empty file in place of device 14:34
2026/02/11 17:25:27  warn rootless{dev/midi03} creating empty file in place of device 14:50
2026/02/11 17:25:27  warn rootless{dev/midi1} creating empty file in place of device 35:1
2026/02/11 17:25:27  warn rootless{dev/midi2} creating empty file in place of device 35:2
2026/02/11 17:25:27  warn rootless{dev/midi3} creating empty file in place of device 35:3
2026/02/11 17:25:27  warn rootless{dev/mixer} creating empty file in place of device 14:0
2026/02/11 17:25:27  warn rootless{dev/mixer1} creating empty file in place of device 14:16
2026/02/11 17:25:27  warn rootless{dev/mixer2} creating empty file in place of device 14:32
2026/02/11 17:25:27  warn rootless{dev/mixer3} creating empty file in place of device 14:48
2026/02/11 17:25:27  warn rootless{dev/mpu401data} creating empty file in place of device 31:0
2026/02/11 17:25:27  warn rootless{dev/mpu401stat} creating empty file in place of device 31:1
2026/02/11 17:25:27  warn rootless{dev/null} creating empty file in place of device 1:3
2026/02/11 17:25:27  warn rootless{dev/port} creating empty file in place of device 1:4
2026/02/11 17:25:27  warn rootless{dev/ram0} creating empty file in place of device 1:0
2026/02/11 17:25:27  warn rootless{dev/ram1} creating empty file in place of device 1:1
2026/02/11 17:25:27  warn rootless{dev/ram10} creating empty file in place of device 1:10
2026/02/11 17:25:27  warn rootless{dev/ram11} creating empty file in place of device 1:11
2026/02/11 17:25:27  warn rootless{dev/ram12} creating empty file in place of device 1:12
2026/02/11 17:25:27  warn rootless{dev/ram13} creating empty file in place of device 1:13
2026/02/11 17:25:27  warn rootless{dev/ram14} creating empty file in place of device 1:14
2026/02/11 17:25:27  warn rootless{dev/ram15} creating empty file in place of device 1:15
2026/02/11 17:25:27  warn rootless{dev/ram16} creating empty file in place of device 1:16
2026/02/11 17:25:27  warn rootless{dev/ram2} creating empty file in place of device 1:2
2026/02/11 17:25:27  warn rootless{dev/ram3} creating empty file in place of device 1:3
2026/02/11 17:25:27  warn rootless{dev/ram4} creating empty file in place of device 1:4
2026/02/11 17:25:27  warn rootless{dev/ram5} creating empty file in place of device 1:5
2026/02/11 17:25:27  warn rootless{dev/ram6} creating empty file in place of device 1:6
2026/02/11 17:25:27  warn rootless{dev/ram7} creating empty file in place of device 1:7
2026/02/11 17:25:27  warn rootless{dev/ram8} creating empty file in place of device 1:8
2026/02/11 17:25:27  warn rootless{dev/ram9} creating empty file in place of device 1:9
2026/02/11 17:25:27  warn rootless{dev/random} creating empty file in place of device 1:8
2026/02/11 17:25:27  warn rootless{dev/rmidi0} creating empty file in place of device 35:64
2026/02/11 17:25:27  warn rootless{dev/rmidi1} creating empty file in place of device 35:65
2026/02/11 17:25:27  warn rootless{dev/rmidi2} creating empty file in place of device 35:66
2026/02/11 17:25:27  warn rootless{dev/rmidi3} creating empty file in place of device 35:67
2026/02/11 17:25:27  warn rootless{dev/sequencer} creating empty file in place of device 14:1
2026/02/11 17:25:27  warn rootless{dev/smpte0} creating empty file in place of device 35:128
2026/02/11 17:25:27  warn rootless{dev/smpte1} creating empty file in place of device 35:129
2026/02/11 17:25:27  warn rootless{dev/smpte2} creating empty file in place of device 35:130
2026/02/11 17:25:27  warn rootless{dev/smpte3} creating empty file in place of device 35:131
2026/02/11 17:25:27  warn rootless{dev/sndstat} creating empty file in place of device 14:6
2026/02/11 17:25:27  warn rootless{dev/tty} creating empty file in place of device 5:0
2026/02/11 17:25:27  warn rootless{dev/tty0} creating empty file in place of device 4:0
2026/02/11 17:25:27  warn rootless{dev/tty1} creating empty file in place of device 4:1
2026/02/11 17:25:27  warn rootless{dev/tty2} creating empty file in place of device 4:2
2026/02/11 17:25:27  warn rootless{dev/tty3} creating empty file in place of device 4:3
2026/02/11 17:25:27  warn rootless{dev/tty4} creating empty file in place of device 4:4
2026/02/11 17:25:27  warn rootless{dev/tty5} creating empty file in place of device 4:5
2026/02/11 17:25:27  warn rootless{dev/tty6} creating empty file in place of device 4:6
2026/02/11 17:25:27  warn rootless{dev/tty7} creating empty file in place of device 4:7
2026/02/11 17:25:27  warn rootless{dev/tty8} creating empty file in place of device 4:8
2026/02/11 17:25:27  warn rootless{dev/tty9} creating empty file in place of device 4:9
2026/02/11 17:25:27  warn rootless{dev/urandom} creating empty file in place of device 1:9
2026/02/11 17:25:27  warn rootless{dev/zero} creating empty file in place of device 1:5
FATAL:   Unable to handle docker://biocontainers/danpos:v2.2.2_cv3 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:9ff7e2e5f967fb9c4e8099e63508ab0dddebe3f820d08ca7fd568431b0d10c0e: unpack entry: etc/dhcp/dhclient-exit-hooks.d/timesyncd: unpack to regular file: short write: write /tmp/build-temp-2013480572/rootfs/etc/dhcp/dhclient-exit-hooks.d/timesyncd: no space left on device
```

