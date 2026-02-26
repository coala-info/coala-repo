# ucsc-autoxml CWL Generation Report

## ucsc-autoxml_autoXml

### Tool Description
Generate structures code and parser for XML file from DTD-like spec

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-autoxml:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-autoxml/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-autoxml/overview
- **Total Downloads**: 25.4K
- **Last updated**: 2025-06-28
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
autoXml - Generate structures code and parser for XML file from DTD-like spec
usage:
   autoXml file.dtdx root
This will generate root.c, root.h
options:
   -textField=xxx what to name text between start/end tags. Default 'text'
   -comment=xxx Comment to appear at top of generated code files
   -picky  Generate parser that rejects stuff it doesn't understand
   -main   Put in a main routine that's a test harness
   -prefix=xxx Prefix to add to structure names. By default same as root
   -positive Don't write out optional attributes with negative values
```

