# sprai CWL Generation Report

## sprai_ezez_vx1.pl

### Tool Description
Error correction and assembly tool

### Metadata
- **Docker Image**: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
- **Homepage**: http://zombie.cb.k.u-tokyo.ac.jp/sprai/
- **Package**: https://anaconda.org/channels/bioconda/packages/sprai/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sprai/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
USAGE: <this> <ec.spec> <asm.spec>
	or: <this> <ec.spec> -ec_only
	[-n: only shows parameters in ec.spec and exit.]
	[-ec_only: does error correction and does NOT assemble]
	[-now yyyymmdd_hhmmss: use a result_yyyymmdd_hhmmss directory, detect unfinished jobs and restart at the appropriate stage.]
```


## sprai_ezez4qsub_vx1.pl

### Tool Description
Error correction and assembly pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
- **Homepage**: http://zombie.cb.k.u-tokyo.ac.jp/sprai/
- **Package**: https://anaconda.org/channels/bioconda/packages/sprai/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: <this> <ec.spec> <asm.spec>
	or: <this> <ec.spec> -ec_only
	[-n: outputs qsub scripts and does NOT qsub]
	[-now yyyymmdd_hhmmss: use a XXX_yyyymmdd_hhmmss directories, detect unfinished jobs and restart at the appropriate stage.]
	[-ec_only: does error correction and does NOT assemble]
```


## sprai_runCA

### Tool Description
CA formatted fragment file

### Metadata
- **Docker Image**: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
- **Homepage**: http://zombie.cb.k.u-tokyo.ac.jp/sprai/
- **Package**: https://anaconda.org/channels/bioconda/packages/sprai/overview
- **Validation**: PASS

### Original Help Text
```text
usage: runCA -d <dir> -p <prefix> [options] <frg> ...
  -d <dir>          Use <dir> as the working directory.  Required
  -p <prefix>       Use <prefix> as the output prefix.  Required

  -s <specFile>     Read options from the specifications file <specfile>.
                      <specfile> can also be one of the following key words:
                      [no]OBT - run with[out] OBT
                      noVec   - run with OBT but without Vector

  -version          Version information
  -help             This information
  -options          Describe specFile options, and show default values

  <frg>             CA formatted fragment file

Complete documentation at http://wgs-assembler.sourceforge.net/

File not found or invalid command line option '--help'
Assembly name prefix not supplied with -p.
Directory not supplied with -d.
```


## sprai_check_circularity.pl

### Tool Description
Check for circularity in a FASTA assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
- **Homepage**: http://zombie.cb.k.u-tokyo.ac.jp/sprai/
- **Package**: https://anaconda.org/channels/bioconda/packages/sprai/overview
- **Validation**: PASS

### Original Help Text
```text
Unknown option: help
Usage: check_circurarity.pl <input FASTA (assembly)> <temporary dir>
```


## Metadata
- **Skill**: generated
