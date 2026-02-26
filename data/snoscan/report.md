# snoscan CWL Generation Report

## snoscan

### Tool Description
Find snoRNA genes containing rRNA complementarity and C & D boxes

### Metadata
- **Docker Image**: quay.io/biocontainers/snoscan:1.0--pl5321h031d066_5
- **Homepage**: http://lowelab.ucsc.edu/snoscan
- **Package**: https://anaconda.org/channels/bioconda/packages/snoscan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snoscan/overview
- **Total Downloads**: 25.5K
- **Last updated**: 2025-10-06
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
FATAL: Wrong number of arguments specified on command line

Usage: snoscan [-options] <rRNA sequence file> <query sequence file>
Find snoRNA genes containing rRNA complementarity
and C & D boxes

Available options:
-h             : help - print version and usage info
-m <meth file> : specify methylation sites
-o <outfile>   : save candidates in <outfile>
-s             : save snoRNA sequences with hit info
-l <length>    : set minimim length for snoRNA-rRNA pairing (def=9bp)
-C <Score>     : set C Box score cutoff to <Score>
-D <Score>     : set D prime Box score cutoff to <Score>
-X <Score>     : set final score cutoff to <Score>
-c <score>     : set min score for complementary region match
-d <dist>      : set max distance between C & D boxes
-p <dist>      : set min distance between rRNA match & 
                 D box when D prime box is present (def=10bp)
-i <position>  : Initiate scan at <position> in sequence (def=1)

-M <integer>   : set max distance to known meth site (Def=0)
-V             : verbose output
```


## Metadata
- **Skill**: generated
