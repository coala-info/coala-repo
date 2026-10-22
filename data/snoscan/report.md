# snoscan CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| snoscan | PASS |  |
| snoscan_sort-snos | PASS |  |

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


## snoscan_sort-snos

### Tool Description
Sort snoRNA hits by overall score

### Metadata
- **Docker Image**: quay.io/biocontainers/snoscan:1.0--pl5321h031d066_5
- **Homepage**: http://lowelab.ucsc.edu/snoscan
- **Package**: https://anaconda.org/channels/bioconda/packages/snoscan/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: sort-snos [options] <snoRNA hits file>

   Sort snoRNA hits by overall score

   where -P        :  sort snos by Position of complementarity on rRNA
         -H        :  sort snos by position of hit in query sequence
         -R        :  sort snos by position & Remove lower-scoring duplicate hits
                       (both start & end bounds must match
         -r        :  same as -R, but only start bound must match to count as duplicate
         -M        :  sort snos, output only hits to Mapped sites
         -U        :  sort snos, output only hits to Unmapped sites
         -T <int>  :  sort snos, output only top <int> hits per meth site (def=50)
         -S <score>:  sort snos, require minimum score
         -m <score>:  sort snos, don't include hits _over_ max <score>
         -e <expr> :  Extract only snos with <expr> in header line
         -F        :  Don't sort -- just filter & output in same order
```

## Metadata
- **Skill**: generated
