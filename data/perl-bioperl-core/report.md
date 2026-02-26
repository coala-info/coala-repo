# perl-bioperl-core CWL Generation Report

## perl-bioperl-core_perldoc

### Tool Description
Look up Perl documentation in Pod format.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-bioperl-core:1.007002--pl526_0
- **Homepage**: http://metacpan.org/pod/BioPerl
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-bioperl-core/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-bioperl-core/overview
- **Total Downloads**: 378.6K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
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
    -X   Use index if present (looks for pod.idx at .../../lib/5.26.2/x86_64-linux-thread-multi)
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
                                                       [Perldoc v3.28]
```

