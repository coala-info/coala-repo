# perl-pod-usage CWL Generation Report

## perl-pod-usage

### Tool Description
FAIL to generate CWL: perl-pod-usage not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pod-usage:2.05--pl5321hdfd78af_0
- **Homepage**: http://search.cpan.org/~marekr/Pod-Usage-1.69/
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pod-usage/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-pod-usage/overview
- **Total Downloads**: 163.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: perl-pod-usage not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: perl-pod-usage not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## perl-pod-usage_pod2usage

### Tool Description
Print usage messages from a file's pod documentation

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-pod-usage:2.05--pl5321hdfd78af_0
- **Homepage**: http://search.cpan.org/~marekr/Pod-Usage-1.69/
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-pod-usage/overview
- **Validation**: PASS
### Original Help Text
```text
Usage:
    pod2usage   [-help] [-man] [-exit exitval] [-output outfile] [-verbose
                level] [-pathlist dirlist] [-formatter module] [-utf8] file

Options and Arguments:
    -help   Print a brief help message and exit.

    -man    Print this command's manual page and exit.

    -exit exitval
            The exit status value to return.

    -output outfile
            The output file to print to. If the special names "-" or ">&1"
            or ">&STDOUT" are used then standard output is used. If ">&2" or
            ">&STDERR" is used then standard error is used.

    -verbose level
            The desired level of verbosity to use:

                1 : print SYNOPSIS only
                2 : print SYNOPSIS sections and any OPTIONS/ARGUMENTS sections
                3 : print the entire manpage (similar to running pod2text)

    -pathlist dirlist
            Specifies one or more directories to search for the input file
            if it was not supplied with an absolute path. Each directory
            path in the given list should be separated by a ':' on Unix (';'
            on MSWin32 and DOS).

    -formatter module
            Which text formatter to use. Default is Pod::Text, or for very
            old Perl versions Pod::PlainText. An alternative would be e.g.
            Pod::Text::Termcap.

    -utf8   This option assumes that the formatter (see above) understands
            the option "utf8". It turns on generation of utf8 output.

    file    The pathname of a file containing pod documentation to be output
            in usage message format (defaults to standard input).
```

