# ucsc-twobitinfo CWL Generation Report

## ucsc-twobitinfo

### Tool Description
get information about sequences in a .2bit file

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-twobitinfo:482--hdc0a859_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-twobitinfo/overview
- **Validation**: PASS

### Original Help Text
```text
twoBitInfo - get information about sequences in a .2bit file
usage:
   twoBitInfo input.2bit output.tab
options:
   -maskBed instead of seq sizes, output BED records that define 
           areas with masked sequence
   -nBed   instead of seq sizes, output BED records that define 
           areas with N's in sequence
   -noNs   outputs the length of each sequence, but does not count Ns 
   -udcDir=/dir/to/cache - place to put cache for remote bigBed/bigWigs
Output file has the columns::
   seqName size

The 2bit file may be specified in the form path:seq or path:seq1,seq2,seqN...
so that information is returned only on the requested sequence(s).
If the form path:seq:start-end is used, start-end is ignored.
```
## Metadata
- **Skill**: not generated
