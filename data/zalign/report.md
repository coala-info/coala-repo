# zalign CWL Generation Report

## zalign

### Tool Description
zalign 0.9.1 (C) 2006-2009 zAlign Team

### Metadata
- **Docker Image**: biocontainers/zalign:v0.9.1-4-deb_cv1
- **Homepage**: https://github.com/Zuehlke/ZAlign
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/zalign/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/Zuehlke/ZAlign
- **Stars**: N/A
### Original Help Text
```text
zalign 0.9.1 (C) 2006-2009 zAlign Team
usage: zalign [-s scores] [-S split] [-H hblk] [-V vblk] file1 file2

General options:
 -h           display this help and exit

 -s <scores>  specify a comma-separated list of scores to be used while
              calculating aligment matrices throughout the program. The list
              must be in the format "-sMATCH,MISMATCH,GAP_OPEN,GAP_EXTENSION"
              (without quotes), and is parsed in this PRECISE order; no spaces
              are allowed between values. If there are any unspecified
              parameters, these are set to default values and a warning message
              is issued; exceeding parameters are discarded

Stage 2 options:
 -S <split>   (mpialign only) number of parts in which to split the alignment
              matrix; after this step a cyclic block model is applied,
              subdividing each part equally between all available nodes

 -H <hblk>    (mpialign only) number of horizontal subdivisions made by each
              node to its alignment submatrix; since this value defines block
              width, a good choice should allow two full matrix lines to fit
              the processor's cache pages, improving algorithm performance

 -V <vblk>    (mpialign only) number of vertical subdivisions made by each node
              to its alignment submatrix; this value directly affects the
              amount of internode communication and is used ONLY if 'split' is
              set to 1, otherwise it is set to the number of available nodes
```

