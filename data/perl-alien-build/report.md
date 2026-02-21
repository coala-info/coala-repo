# perl-alien-build CWL Generation Report

## perl-alien-build

### Tool Description
FAIL to generate CWL: perl-alien-build not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-alien-build:2.84--pl5321h7b50bb2_1
- **Homepage**: https://metacpan.org/pod/Alien::Build
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-alien-build/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-alien-build/overview
- **Total Downloads**: 255.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: perl-alien-build not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: perl-alien-build not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## perl-alien-build_wget

### Tool Description
Retrieve files via HTTP or FTP

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-alien-build:2.84--pl5321h7b50bb2_1
- **Homepage**: https://metacpan.org/pod/Alien::Build
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-alien-build/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/bin/wget: option '--header' requires an argument
BusyBox v1.36.1 (2024-06-02 11:42:27 UTC) multi-call binary.

Usage: wget [-cqS] [--spider] [-O FILE] [-o LOGFILE] [--header STR]
	[--post-data STR | --post-file FILE] [-Y on/off]
	[--no-check-certificate] [-P DIR] [-U AGENT] [-T SEC] URL...

Retrieve files via HTTP or FTP

	--spider	Only check URL existence: $? is 0 if exists
	--header STR	Add STR (of form 'header: value') to headers
	--post-data STR	Send STR using POST method
	--post-file FILE	Send FILE using POST method
	--no-check-certificate	Don't validate the server's certificate
	-c		Continue retrieval of aborted transfer
	-q		Quiet
	-P DIR		Save to DIR (default .)
	-S    		Show server response
	-T SEC		Network read timeout is SEC seconds
	-O FILE		Save to FILE ('-' for stdout)
	-o LOGFILE	Log messages to FILE
	-U STR		Use STR for User-Agent header
	-Y on/off	Use proxy
```

