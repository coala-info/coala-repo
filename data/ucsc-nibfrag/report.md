# ucsc-nibfrag CWL Generation Report

## ucsc-nibfrag

### Tool Description
Extract part of a nib file as .fa (all bases/gaps lower case by default)

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-nibfrag:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-nibfrag/overview
- **Validation**: PASS

### Original Help Text
```text
nibFrag - Extract part of a nib file as .fa (all bases/gaps lower case by default)
usage:
   nibFrag [options] file.nib start end strand out.fa
where strand is + (plus) or m (minus)
options:
   -masked       Use lower-case characters for bases meant to be masked out.
   -hardMasked   Use upper-case for not masked-out, and 'N' characters for masked-out bases.
   -upper        Use upper-case characters for all bases.
   -name=name    Use given name after '>' in output sequence.
   -dbHeader=db  Add full database info to the header, with or without -name option.
   -tbaHeader=db Format header for compatibility with tba, takes database name as argument.
```
## Metadata
- **Skill**: generated
