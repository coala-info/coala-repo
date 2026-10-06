# perl-module-util CWL Generation Report

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

