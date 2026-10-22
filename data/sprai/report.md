# sprai CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sprai_check_circularity.pl | PASS | synthetic data: real T7 phage genome with its first 2000 bases appended to make a circular contig |
| sprai_ezez4qsub_vx1.pl | Not completed | pipeline, skipped: it writes and submits qsub jobs for the whole sprai pipeline |
| sprai_ezez_vx1.pl | Not completed | pipeline, skipped: it runs the whole sprai error-correction and assembly pipeline |

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
