# ucsc-ixixx CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ucsc-ixixx | PASS |  |

## ucsc-ixixx

### Tool Description
Create indices for word searches. The input is a text file where each line starts with an identifier, followed by the text to be indexed. The output is a pair of files: a main index (.ix) and a secondary index (.ixx) used for fast lookups.

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-ixixx:482--h0b57e2e_0
- **Homepage**: http://hgdownload.cse.ucsc.edu/admin/exe/
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-ixixx/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-ixixx/overview
- **Total Downloads**: 46.6K
- **Last updated**: 2025-06-26
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
ixIxx - Create indices for simple line-oriented file of format 
<symbol> <free text>
usage:
   ixIxx in.text out.ix out.ixx
Where out.ix is a word index, and out.ixx is an index into the index.
options:
   -prefixSize=N Size of prefix to index on in ixx.  Default is 5.
   -binSize=N Size of bins in ixx.  Default is 64k.
   -maxWordLength=N Maximum allowed word length. 
     Words with more characters than this limit are ignored and will not appear in index or be searchable.  Default is 31.
```


## Metadata
- **Skill**: generated
