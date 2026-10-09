# htslib CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| htslib_annot_tsv | PASS |  |
| htslib_bgzip | PASS |  |
| htslib_htsfile | PASS |  |
| htslib_tabix | PASS |  |

## htslib_annot_tsv

### Tool Description
Annotate regions of the target file with information from overlapping regions of the source file

### Metadata
- **Docker Image**: quay.io/biocontainers/htslib:1.23--h566b1c6_0
- **Homepage**: https://github.com/samtools/htslib
- **Package**: https://anaconda.org/channels/bioconda/packages/htslib/overview
- **Validation**: PASS

### Original Help Text
```text

Version: 1.23
About: Annotate regions of the target file (TGT) with information from
       overlapping regions of the source file (SRC). Multiple columns can be
       transferred (-f) and the transfer can be conditioned on requiring
       matching values in one or more columns (-m).
       In addition to column transfer (-f) and special annotations (-a), the
       program can operate in a simple grep-like mode and print matching lines
       (when neither -f nor -a are given) or drop matching lines (-x).
       All indexes and coordinates are 1-based and inclusive.

Usage: annot-tsv [OPTIONS] -s source.txt -t target.txt > output.txt

Common options:
   -c, --core SRC:TGT      Core columns in SRC and TGT file
                             [chr,beg,end:chr,beg,end]
   -f, --transfer SRC:TGT  Columns to transfer. If SRC column does not exist,
                           interpret as the default value to use. If the TGT
                           column does not exist, a new column is created. If
                           the TGT column does exist, its values are overwritten
                           when overlap is found or left as is otherwise.
   -m, --match SRC:TGT     Require match in these columns for annotation
                           transfer
   -o, --output FILE       Output file name [STDOUT]
   -s, --source-file FILE  Source file to take annotations from
   -t, --target-file FILE  Target file to be extend with annotations from -s

Other options:
       --allow-dups        Add annotations multiple times
       --help              This help message
       --max-annots INT    Adding at most INT annotations per column to save
                           time in big regions
       --version           Print version string and exit
   -a, --annotate LIST     Add special annotations, one or more of:
                             cnt  .. number of overlapping regions
                             frac .. fraction of the target region with an
                                       overlap
                             nbp  .. number of source base pairs in the overlap
   -C, --coords SRC:TGT    Are coordinates 0 or 1-based, BED=01, TSV=11 [11]
   -d, --delim SRC:TGT     Column delimiter in SRC and TGT file
   -h, --headers SRC:TGT   Header row line number, 0:0 is equivalent to -H, negative
                             value counts from the end of comment line block [1:1]
   -H, --ignore-headers    Use numeric indices, ignore the headers completely
   -I, --no-header-idx     Suppress index numbers in the printed header. If given
                           twice, drop the entire header
   -O, --overlap FLOAT[,FLOAT]     Minimum required overlap with respect to SRC,TGT.
                           If single value, the bigger overlap is considered.
                           Identical values are equivalent to running with -r.
   -r, --reciprocal        Apply the -O requirement to both overlapping
                           intervals
   -x, --drop-overlaps     Drop overlapping regions (precludes -f)

Examples:
   # Header is present, match and transfer by column name
   annot-tsv -s src.txt.gz -t tgt.txt.gz -c chr,beg,end:CHR,POS,POS \
       -m type,sample:TYPE,SMPL -f info:INFO

   # Header is not present, match and transfer by column index (1-based)
   annot-tsv -s src.txt.gz -t tgt.txt.gz -c 1,2,3:1,2,3 -m 4,5:4,5 -f 6:6

   # If the TGT part is not given, the program assumes that the SRC:TGT columns
   # are identical
   annot-tsv -s src.txt.gz -t tgt.txt.gz -c chr,beg,end -m type,sample -f info

   # One of the SRC or TGT file can be streamed from stdin
   gunzip -c src.txt.gz | \
       annot-tsv -t tgt.txt.gz -c chr,beg,end -m type,sample -f info
   gunzip -c tgt.txt.gz | \
       annot-tsv -s src.txt.gz -c chr,beg,end -m type,sample -f info

   # Print matching regions as above but without modifying the records
   gunzip -c src.txt.gz | annot-tsv -t tgt.txt.gz -c chr,beg,end -m type,sample
```

