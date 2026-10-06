# perl-xml-xpath CWL Generation Report

## Metadata
- **Skill**: generated

## perl-xml-xpath_xpath

### Tool Description
A tool to query XML files using XPath expressions. If no filenames are given, it reads XML from STDIN. Each supplementary query is done in order, with the previous query providing the context for the next.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-xml-xpath:1.47--pl5321hdfd78af_0
- **Homepage**: https://metacpan.org/pod/XML::XPath
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-xml-xpath/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage:
/usr/local/bin/xpath [options] -e query [-e query...] [filename...]

If no filenames are given, supply XML on STDIN. You must provide at
least one query. Each supplementary query is done in order, the
previous query giving the context of the next one.

Options:

-q quiet, only output the resulting PATH.
-s suffix, use suffix instead of linefeed.
-p postfix, use prefix instead of nothing.
-n Don't use an external DTD.
```

