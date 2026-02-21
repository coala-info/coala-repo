# perl-xml-xpath CWL Generation Report

## perl-xml-xpath

### Tool Description
FAIL to generate CWL: perl-xml-xpath not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-xml-xpath:1.47--pl5321hdfd78af_0
- **Homepage**: https://metacpan.org/pod/XML::XPath
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-xml-xpath/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-xml-xpath/overview
- **Total Downloads**: 186.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: perl-xml-xpath not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: perl-xml-xpath not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


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

