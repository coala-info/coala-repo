# perl-file-copy-link CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-file-copy-link_copylink | Not completed | copylink needs a real symbolic link as input, but cwltool stages inputs as regular files, so it fails with 'not a link' |

## Metadata
- **Skill**: generated

## perl-file-copy-link_copylink

### Tool Description
Replace symbolic links with a copy of the linked file

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-file-copy-link:0.200--pl5321h7b50bb2_0
- **Homepage**: https://metacpan.org/pod/File::Copy::Link
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-file-copy-link/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/copylink: no links
Usage:
    copylink [link ...]
```

