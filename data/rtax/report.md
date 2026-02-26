# rtax CWL Generation Report

## rtax

### Tool Description
Rapid and accurate taxonomic classification of short paired-end sequence reads from the 16S ribosomal RNA gene.

### Metadata
- **Docker Image**: biocontainers/rtax:v0.984-6-deb_cv1
- **Homepage**: https://github.com/SWRT-dev/rtax89x
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rtax/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/SWRT-dev/rtax89x
- **Stars**: N/A
### Original Help Text
```text
RTAX: Rapid and accurate taxonomic classification of short paired-end
      sequence reads from the 16S ribosomal RNA gene.

David A. W. Soergel (1), Rob Knight (2), and Steven E. Brenner (1)

1 Department of Plant and Microbial Biology,
  University of California, Berkeley 
2 Howard Hughes Medical Institute and Department of Chemistry 
  and Biochemistry, University of Colorado at Boulder
* Corresponding author (current address): soergel@cs.umass.edu

Version 0.984  (August 7, 2013)

http://dev.davidsoergel.com/rtax

Please cite:
Soergel D.A.W., Dey N., Knight R., and Brenner S.E.  2012.
Selection of primers for optimal taxonomic classification of
environmental 16S rRNA gene sequences.  ISME J (6), 1440–1444

-------------------------------------------------------------
ERROR : -r, -t, -a, and -o options are required
-------------------------------------------------------------

Usage: rtax -r <refdb> -t <taxonomy> -a <queryA> -b <queryB> -d <delimiter> -i <regex> -o <classifications.out>
-r  reference database in FASTA format
-t  taxonomy file with sequence IDs matching the reference database
-a  FASTA file containing query sequences (single-ended or read 1)
-b  FASTA file containing query sequences (read b, with matching IDs)
-x  Reverse-complement query A sequences (required if they are provided in the reverse sense)
-y  Reverse-complement query B sequences (required if they are provided in the reverse sense)
-i  regular expression used to select part of the fasta header to use as the sequence id.  Default: "(\\S+)"
-l  text file containing sequence IDs to process, one per line
-d  delimiter separating the two reads when provided in a single file
-m  temporary directory.  Will be removed on successful completion, but likely not if there is an error.
-f  for sequences where only one read is available, fall back to single-ended classification.  Default: drop these sequences.
-g  for sequences where one read is overly generic, do not fall back to single-ended classification.  Default: classify these sequences based on only the more specific read.
-o  output path
```

