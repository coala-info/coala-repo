# perl-perldoc CWL Generation Report

## perl-perldoc

### Tool Description
FAIL to generate CWL: perl-perldoc not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-perldoc:0.20--pl5321hdfd78af_0
- **Homepage**: http://metacpan.org/pod/Perldoc
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-perldoc/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-perldoc/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: perl-perldoc not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: perl-perldoc not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## perl-perldoc_perldoc

### Tool Description
Look up Perl documentation in Pod format.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-perldoc:0.20--pl5321hdfd78af_0
- **Homepage**: http://metacpan.org/pod/Perldoc
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-perldoc/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
perldoc [options] PageName|ModuleName|ProgramName|URL...
perldoc [options] -f BuiltinFunction
perldoc [options] -q FAQRegex
perldoc [options] -v PerlVariable

Options:
    -h   Display this help message
    -V   Report version
    -r   Recursive search (slow)
    -i   Ignore case
    -t   Display pod using pod2text instead of Pod::Man and groff
             (-t is the default on win32 unless -n is specified)
    -u   Display unformatted pod text
    -m   Display module's file in its entirety
    -n   Specify replacement for groff
    -l   Display the module's file name
    -U   Don't attempt to drop privs for security
    -F   Arguments are file names, not modules (implies -U)
    -D   Verbosely describe what's going on
    -T   Send output to STDOUT without any pager
    -d output_filename_to_send_to
    -o output_format_name
    -M FormatterModuleNameToUse
    -w formatter_option:option_value
    -L translation_code   Choose doc translation (if any)
    -X   Use index if present (looks for pod.idx at .../../lib/perl5/5.32/core_perl)
    -q   Search the text of questions (not answers) in perlfaq[1-9]
    -f   Search Perl built-in functions
    -a   Search Perl API
    -v   Search predefined Perl variables

PageName|ModuleName|ProgramName|URL...
         is the name of a piece of documentation that you want to look at. You
         may either give a descriptive name of the page (as in the case of
         `perlfunc') the name of a module, either like `Term::Info' or like
         `Term/Info', or the name of a program, like `perldoc', or a URL
         starting with http(s).

BuiltinFunction
         is the name of a perl function.  Will extract documentation from
         `perlfunc' or `perlop'.

FAQRegex
         is a regex. Will search perlfaq[1-9] for and extract any
         questions that match.

Any switches in the PERLDOC environment variable will be used before the
command line arguments.  The optional pod index file contains a list of
filenames, one per line.
                                                       [Perldoc v3.2801]
```

