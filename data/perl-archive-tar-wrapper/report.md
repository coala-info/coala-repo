# perl-archive-tar-wrapper CWL Generation Report

## Metadata
- **Skill**: generated

## perl-archive-tar-wrapper_tar

### Tool Description
Create, extract, or list files from a tar file

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-archive-tar-wrapper:0.33--pl526_0
- **Homepage**: http://metacpan.org/pod/Archive::Tar::Wrapper
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-archive-tar-wrapper/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
BusyBox v1.22.1 (2014-05-23 01:24:27 UTC) multi-call binary.

Usage: tar -[cxthvO] [-X FILE] [-T FILE] [-f TARFILE] [-C DIR] [FILE]...

Create, extract, or list files from a tar file

Operation:
	c	Create
	x	Extract
	t	List
	f	Name of TARFILE ('-' for stdin/out)
	C	Change to DIR before operation
	v	Verbose
	O	Extract to stdout
	h	Follow symlinks
	exclude	File to exclude
	X	File with names to exclude
	T	File with names to include
```

