# setuptools_cython CWL Generation Report

## setuptools_cython

### Tool Description
Cython is a compiler for code written in the Cython language. Cython is based on Pyrex by Greg Ewing.

### Metadata
- **Docker Image**: quay.io/biocontainers/setuptools_cython:0.2.1--py27_1
- **Homepage**: https://github.com/Technologicat/setup-template-cython
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/setuptools_cython/overview
- **Total Downloads**: 10.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Technologicat/setup-template-cython
- **Stars**: N/A
### Original Help Text
```text
Cython (http://cython.org) is a compiler for code written in the
Cython language.  Cython is based on Pyrex by Greg Ewing.

Usage: cython [options] sourcefile.{pyx,py} ...

Options:
  -V, --version                  Display version number of cython compiler
  -l, --create-listing           Write error messages to a listing file
  -I, --include-dir <directory>  Search for include files in named directory
                                 (multiple include directories are allowed).
  -o, --output-file <filename>   Specify name of generated C file
  -t, --timestamps               Only compile newer source files
  -f, --force                    Compile all source files (overrides implied -t)
  -v, --verbose                  Be verbose, print file names on multiple compilation
  -p, --embed-positions          If specified, the positions in Cython files of each
                                 function definition is embedded in its docstring.
  --cleanup <level>              Release interned objects on python exit, for memory debugging.
                                 Level indicates aggressiveness, default 0 releases nothing.
  -w, --working <directory>      Sets the working directory for Cython (the directory modules
                                 are searched from)
  --gdb                          Output debug information for cygdb
  --gdb-outdir <directory>       Specify gdb debug information output directory. Implies --gdb.

  -D, --no-docstrings            Strip docstrings from the compiled module.
  -a, --annotate                 Produce a colorized HTML version of the source.
  --annotate-coverage <cov.xml>  Annotate and include coverage information from cov.xml.
  --line-directives              Produce #line directives pointing to the .pyx source
  --cplus                        Output a C++ rather than C file.
  --embed[=<method_name>]        Generate a main() function that embeds the Python interpreter.
  -2                             Compile based on Python-2 syntax and code semantics.
  -3                             Compile based on Python-3 syntax and code semantics.
  --lenient                      Change some compile time errors to runtime errors to
                                 improve Python compatibility
  --capi-reexport-cincludes      Add cincluded headers to any auto-generated header files.
  --fast-fail                    Abort the compilation on the first error
  --warning-errors, -Werror      Make all warnings into errors
  --warning-extra, -Wextra       Enable extra warnings
  -X, --directive <name>=<value>[,<name=value,...] Overrides a compiler directive
```

