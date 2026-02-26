# mawk CWL Generation Report

## mawk

### Tool Description
mawk [Options] [Program] [file ...]

### Metadata
- **Docker Image**: quay.io/biocontainers/mawk:1.3.4--h7b50bb2_11
- **Homepage**: https://www.gnu.org/software/gawk/
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mawk/overview
- **Total Downloads**: 105.2K
- **Last updated**: 2025-09-04
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: mawk [Options] [Program] [file ...]

Program:
    The -f option value is the name of a file containing program text.
    If no -f option is given, a "--" ends option processing; the following
    parameters are the program text.

Options:
    -f program-file  Program  text is read from file instead of from the
                     command-line.  Multiple -f options are accepted.
    -F value         sets the field separator, FS, to value.
    -v var=value     assigns value to program variable var.
    --               unambiguous end of options.

    Implementation-specific options are prefixed with "-W".  They can be
    abbreviated:

    -W version       show version information and exit.
    -W dump          show assembler-like listing of program and exit.
    -W help          show this message and exit.
    -W interactive   set unbuffered output, line-buffered input.
    -W exec file     use file as program as well as last option.
    -W random=number set initial random seed.
    -W sprintf=number adjust size of sprintf buffer.
    -W posix_space   do not consider "\n" a space.
    -W usage         show this message and exit.
```


## Metadata
- **Skill**: generated
