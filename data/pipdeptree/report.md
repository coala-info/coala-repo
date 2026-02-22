# pipdeptree CWL Generation Report

## pipdeptree

### Tool Description
Dependency tree of the installed python packages

### Metadata
- **Docker Image**: biocontainers/pipdeptree:v0.13.2-1-deb-py3_cv1
- **Homepage**: https://github.com/tox-dev/pipdeptree
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/pipdeptree/overview
- **Total Downloads**: 102.2K
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/tox-dev/pipdeptree
- **Stars**: N/A
### Original Help Text
```text
usage: pipdeptree [-h] [-v] [-f] [-a] [-l] [-u] [-w [{silence,suppress,fail}]]
                  [-r] [-p PACKAGES] [-e PACKAGES] [-j] [--json-tree]
                  [--graph-output OUTPUT_FORMAT]

Dependency tree of the installed python packages

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -f, --freeze          Print names so as to write freeze files
  -a, --all             list all deps at top level
  -l, --local-only      If in a virtualenv that has global access do not show
                        globally installed packages
  -u, --user-only       Only show installations in the user site dir
  -w [{silence,suppress,fail}], --warn [{silence,suppress,fail}]
                        Warning control. "suppress" will show warnings but
                        return 0 whether or not they are present. "silence"
                        will not show warnings at all and always return 0.
                        "fail" will show warnings and return 1 if any are
                        present. The default is "suppress".
  -r, --reverse         Shows the dependency tree in the reverse fashion ie.
                        the sub-dependencies are listed with the list of
                        packages that need them under them.
  -p PACKAGES, --packages PACKAGES
                        Comma separated list of select packages to show in the
                        output. If set, --all will be ignored.
  -e PACKAGES, --exclude PACKAGES
                        Comma separated list of select packages to exclude
                        from the output. If set, --all will be ignored.
  -j, --json            Display dependency tree as json. This will yield "raw"
                        output that may be used by external tools. This option
                        overrides all other options.
  --json-tree           Display dependency tree as json which is nested the
                        same way as the plain text output printed by default.
                        This option overrides all other options (except
                        --json).
  --graph-output OUTPUT_FORMAT
                        Print a dependency graph in the specified output
                        format. Available are all formats supported by
                        GraphViz, e.g.: dot, jpeg, pdf, png, svg
```


## Metadata
- **Skill**: generated
