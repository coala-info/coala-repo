# mcl CWL Generation Report

## mcl

### Tool Description
Performs Markov Cluster Algorithm (MCL) for graph clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/mcl:22.282--pl5321h7b50bb2_4
- **Homepage**: https://micans.org/mcl/
- **Package**: https://anaconda.org/channels/bioconda/packages/mcl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mcl/overview
- **Total Downloads**: 137.6K
- **Last updated**: 2025-05-28
- **GitHub**: https://github.com/micans/mcl
- **Stars**: N/A
### Original Help Text
```text
-o <fname>      !  write output to file <fname>

--version       i  show version
-h              i  output description of most important options
--help          i  output description of options
-z              i  show some of the default settings
--jury-charter  i  show the meaning of the jury pruning synopsis
-how-much-ram <int> i  show estimated RAM usage for graphs with <int> nodes
--show-schemes  i  show the preset -scheme options

-overlap <split|cut|keep>    what to do with overlap (default cut)
-force-connected y/n    analyze clustering, make sure it induces cocos
-check-connected y/n    analyze clustering, see whether it induces cocos
--write-limit      output the limit matrix
-show-log y/n      send log to stdout
-discard-loops y/n    remove loops in input graphs if any
-c <num>           increase loop-weights <num>-fold
-q log-spec        quiet level of logging
-analyze y/n       append performance/characteristics measures
-sort <mode>       order clustering by one of lex|size|revsize|none
-digits <int>      precision in interchange (intermediate matrices) output
--i3               use three digits to encode inflation
--write-binary     write binary output

--abc              expect abc-format (label input), write label output
--sif              expect sif-format (label input), write label output
--etc              expect etc-format (label input), write label output
--expect-values    accept extended SIF or ETC format (label:weight fields)
-use-tab fname     expect native network format, write label output using dictionary
-abc-tf tf-spec    transform label values

--abc-neg-log      log-transform label value, negate sign
--abc-neg-log10    log10-transform label value, negate sign
-write-graph fname    write input matrix to file
-write-graphx fname    write transformed matrix to file
-write-expanded <fname>    file name to write expanded graph to

-annot <description>    string describing the experiment
-aa <suffix>       append <suffix> to mcl-created output file name
-odir <directory> !  use this directory for output
-az             i  show output file name mcl would construct
-ax             i  show the suffix mcl constructs from parameters
-ap <prefix>       prepend <prefix> to mcl-created output file name
--d                use automatic naming and use input directory for output

-tf tf-spec        transform matrix values
-icl fname         subcluster this clustering
-pi <num>          preprocess by applying inflation with parameter <num>
-if <num>          assume expanded input, inflate with parameter <num>
-I <num>        !  main inflation value (default 2.0)
-scheme <int>   !  use a preset resource scheme (cf --show-schemes)
-resource <int> !  allow <int> neighbours throughout computation
-sparse <num>      estimated sparse matrix-vector overhead per summand (default 10)
-te <int>       !  expansion thread number, use with multiple CPUs

--show             (small graphs only [#<20]) dump iterands to *screen*
-v {pruning|explain|clusters|all}    mode verbose
-V {pruning|explain|clusters|all}    mode silent

-p <num>           the rigid pruning threshold
-P <int>           (inverted) rigid pruning threshold (cf -z)
-R <int>           recover to maximally <int> entries if needed
-S <int>           select down to <int> entries if needed
-pct <pct>         try recovery if mass is less than <pct>

-warn-factor <int>    warn if pruning reduces entry count by <int>
-warn-pct <pct>    warn if pruning reduces mass to <pct> weight

-dump-stem <str>    use <str> to construct dump (file) names
-dump <mode>       <mode> in chr|ite|cls|dag (cf manual page)
-dump-interval <int>:<int>    only dump for iterand indices in this interval
-dump-modulo <int>    only dump if the iterand index modulo <int> vanishes

Legend:
  (i)   for informative options that exit after usage
  (!)   for important options that you should be aware of
Consult the manual page for more information
```

