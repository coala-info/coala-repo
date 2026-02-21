# perl-module-util CWL Generation Report

## perl-module-util

### Tool Description
The provided text does not contain help information for the tool; it contains an execution error log indicating the executable was not found in the environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-module-util:1.09--pl526_0
- **Homepage**: http://metacpan.org/pod/Module::Util
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-module-util/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-module-util/overview
- **Total Downloads**: 5.6K
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
2026/02/14 15:12:17  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "perl-module-util": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## perl-module-util_pm_which

### Tool Description
Returns the path to the given module(s)

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-module-util:1.09--pl526_0
- **Homepage**: http://metacpan.org/pod/Module::Util
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-module-util/overview
- **Validation**: PASS
### Original Help Text
```text
No modules selected
Usage:
        pm_which [ options ] module(s)

        Returns the path to the given module(s)

  Options:
        -q, --quiet     Just print paths
        -p, --paths     Just convert the module name into a relative path
        -a, --all       Print all paths, not just the first one found
        -n, --namespace Print all modules in the given namespace
        -m              Only print module names, not paths
        -V              Show module version
        -I libpath      Add a path to search (like perl -I)
        -d, --dump      Dump paths that would be searched (@INC by default)
        -h, --help      Print this message
        -v, --version   Print version information
        -               Read modules from stdin, one per line
```

