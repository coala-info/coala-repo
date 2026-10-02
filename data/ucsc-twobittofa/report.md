# ucsc-twobittofa CWL Generation Report

## ucsc-twobittofa

### Tool Description
Convert all or part of .2bit file to fasta

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-twobittofa:482--hdc0a859_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-twobittofa/overview
- **Validation**: PASS

### Original Help Text
```text
twoBitToFa - Convert all or part of .2bit file to fasta
usage:
   twoBitToFa input.2bit output.fa
options:
   -seq=name       Restrict this to just one sequence.
   -start=X        Start at given position in sequence (zero-based).
   -end=X          End at given position in sequence (non-inclusive).
   -seqList=file   File containing list of the desired sequence names 
                   in the format seqSpec[:start-end], e.g. chr1 or chr1:0-189
                   where coordinates are half-open zero-based, i.e. [start,end).
   -noMask         Convert sequence to all upper case.
   -bpt=index.bpt  Use bpt index instead of built-in one.
   -bed=input.bed  Grab sequences specified by input.bed. Will exclude introns.
   -bedPos         With -bed, use chrom:start-end as the fasta ID in output.fa.
   -udcDir=/dir/to/cache  Place to put cache for remote bigBed/bigWigs.

Input file can be a URL
Sequence and range may also be specified as part of the input
file name using the syntax:
      /path/input.2bit:name
   or
      /path/input.2bit:name:start-end
examples:
  wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/latest/hg38.2bit
  twoBitToFa hg38.2bit -seq=chr1 -start=1000000 -end=20000000 out.fa
  echo 'chr1 1 1000 testRegion' > test.bed
  twoBitToFa https://hgdownload.soe.ucsc.edu/goldenPath/hg38/bigZips/latest/hg38.2bit -bed=test.bed out.fa
```
## Metadata
- **Skill**: not generated
