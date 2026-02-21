# pangwes CWL Generation Report

## pangwes

### Tool Description
FAIL to generate CWL: pangwes not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
- **Homepage**: https://github.com/jurikuronen/PANGWES
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwes/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/pangwes/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jurikuronen/PANGWES
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: pangwes not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: pangwes not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## pangwes_cuttlefish

### Tool Description
Cuttlefish is a tool for building the compacted de Bruijn graph from sequencing reads or genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
- **Homepage**: https://github.com/jurikuronen/PANGWES
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwes/overview
- **Validation**: PASS
### Original Help Text
```text
cuttlefish 2.2.0
Supported commands: `build`, `help`, `version`.
Usage:
	cuttlefish build [options]
```

## pangwes_gfa1_parser

### Tool Description
Parser for GFA1 files

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
- **Homepage**: https://github.com/jurikuronen/PANGWES
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwes/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: /usr/local/bin/gfa1_parser [../../input.gfa1] [../../output]
```

## pangwes_SpydrPick

### Tool Description
MI-ARACNE genome-wide co-evolution analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
- **Homepage**: https://github.com/jurikuronen/PANGWES
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwes/overview
- **Validation**: PASS
### Original Help Text
```text
SpydrPick: MI-ARACNE genome-wide co-evolution analysis.

Usage: SpydrPick [options] <alignmentfile> [-o <outputfile>]
Option '--help' will print a list of available options.

  -h [ --help ]                         Print this help message.
  --version                             Print version information.
  -v [ --verbose ]                      Be verbose.
  --mi-threshold arg (=-1)              The MI threshold value. Experience 
                                        suggests that a value of 0.11 is often 
                                        reasonable. Zero indicates no threshold
                                        and negative values will trigger 
                                        auto-define heuristics.
  --mi-values arg (=0)                  Approximate number of MI values to 
                                        calculate from data (default=#samples*1
                                        00).
  --mi-pseudocount arg (=0.5)           The MI pseudocount value.
  --mi-threshold-iterations arg (=10)   Number of iterations for estimating 
                                        saving threshold.
  --mi-threshold-pairs arg (=0)         Number of sampled pairs for estimating 
                                        saving threshold (0=determine 
                                        automatically).
  --ld-threshold arg (=0)               Threshold distance for linkage 
                                        disequilibrium (LD).
  --no-aracne                           Skip ARACNE, only calculate MI.

  -t [ --threads ] arg (=-1)            Number of threads per MPI/shared memory
                                        node (-1=use all hardware threads that 
                                        the OS/environment exposes).

  --alignmentfile arg                   The input alignment filename(s). When 
                                        two filenames are specified, only 
                                        inter-alignment links will be probed 
                                        for.
  --include-list arg                    Name of file containing list of loci to
                                        include in analysis.
  --exclude-list arg                    Name of file containing list of loci to
                                        exclude from analysis.
  --mapping-list arg                    Name of file containing loci mappings.
  --sample-list arg                     The sample filter list input filename.
  --sample-weights arg                  Name of file containing sample weights.
  --input-indexing-base arg (=1)        Base index for input.
  --no-filter-alignment                 Do not filter alignment columns by 
                                        applying MAF and GAP thresholds.
  --maf-threshold arg (=0.01)           Minor state frequency threshold. Loci 
                                        with less than 2 states above threshold
                                        are removed from alignment.
  --gap-threshold arg (=0.14999999999999999)
                                        Gap frequency threshold. Positions with
                                        a gap frequency above the threshold are
                                        excluded from the pair-analysis.
  --no-sample-reweighting               Turn sample reweighting off, i.e. do 
                                        not try to correct for population 
                                        structure.
  --sample-reweighting-threshold arg (=0.90000000000000002)
                                        Fraction of identical positions 
                                        required for two samples to be 
                                        considered identical.
  --rescale-sample-weights              Rescale sample weights so that 
                                        n(effective) == n.
  --output-state-frequencies            Write column-wise state frequencies to 
                                        file.
  --output-sample-weights               Output sample weights.
  --output-sample-distance-matrix       Output triangular sample-sample Hamming
                                        distance matrix.
  --output-indexing-base arg (=1)       Base index for output.
  --output-alignment                    Write alignment to file.
  --output-filtered-alignment           Write filtered alignment to file.
  --genome-size arg                     Genome size, if different from input. 
                                        Default = 0: detect size from input.
  --linear-genome                       Assume linear genome in distance 
                                        calculations.

  --begin arg (=1)                      The first locus index to work on. Used 
                                        to define a range.
  --end arg (=-1)                       The last locus index to work on (-1=end
                                        of input). Used to define a range.

  -o [ --aracne-outputfile ] arg (=aracne.out)
                                        The ARACNE output filename. This is a 
                                        binary file for "plot.r".
  --aracne-edge-threshold arg (=2.2204460492503131e-16)
                                        Equality tolerance threshold. Edges 
                                        differing by less than this value are 
                                        considered equal in strength.
  --aracne-block-size arg (=16384)      Block size for graph processing.
  --aracne-node-grouping-size arg (=16) Grouping size for node processing.
```

## pangwes_unitig_distance

### Tool Description
Calculate unitig distances in graphs and single genome graphs, with tools for determining outliers.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
- **Homepage**: https://github.com/jurikuronen/PANGWES
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwes/overview
- **Validation**: PASS
### Original Help Text
```text
Graph edges:                                  
  -E  [ --edges-file ] arg                    Path to file containing graph edges.
  -1g [ --graphs-one-based ]                  Graph files use one-based numbering.
                                              
CDBG operating mode:                          
  -U  [ --unitigs-file ] arg                  Path to file containing unitigs.
  -k  [ --k-mer-length ] arg                  k-mer length.
                                              
CDBG and/or SGGS operating mode:              
  -S  [ --sgg-paths-file ] arg                Path to file containing paths to single genome graph edge files.
  -r  [ --run-sggs-only ]                     Calculate distances only in the single genome graphs.
                                              
Distance queries:                             
  -Q  [ --queries-file ] arg                  Path to queries file.
  -1q [ --queries-one-based ]                 Queries file uses one-based numbering.
  -n  [ --n-queries ] arg (=inf)              Number of queries to read from the queries file.
  -q  [ --queries-format ] arg (-1)           Set queries format manually (0..5).
  -d  [ --max-distance ] arg (=inf)           Maximum allowed graph distance (for constraining the searches).
                                              
Tools for determining outliers:               
  -x  [ --output-outliers ]                   Output a list of outliers and outlier statistics.
  -Cc [ --sgg-count-threshold ] arg (=10)     Filter low count single genome graph distances.
  -l  [ --ld-distance ] arg (=-1)             Linkage disequilibrium distance (automatically determined if negative).
  -lm [ --ld-distance-min ] arg (=1000)       Minimum ld distance for automatic ld distance determination.
  -ls [ --ld-distance-score ] arg (=0.8)      Score difference threshold for automatic ld distance determination.
  -ln [ --ld-distance-nth-score ] arg (=10)   Use nth max score for automatic ld distance determination.
  -ot [ --outlier-threshold ] arg             Set outlier threshold to a custom value.
                                              
Other arguments.                              
  -o  [ --output-stem ] arg (=out)            Path for output files (without extension).
  -1o [ --output-one-based ]                  Output files use one-based numbering.
  -1  [ --all-one-based ]                     Use one-based numbering for everything.
  -t  [ --threads ] arg (=1)                  Number of threads.
  -v  [ --verbose ]                           Be verbose.
  -h  [ --help ]                              Print this list.
```

## pangwes_Rscript

### Tool Description
A binary front-end to R, for use in scripting applications.

### Metadata
- **Docker Image**: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
- **Homepage**: https://github.com/jurikuronen/PANGWES
- **Package**: https://anaconda.org/channels/bioconda/packages/pangwes/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: Rscript [options] file [args]
   or: Rscript [options] -e expr [-e expr2 ...] [args]
A binary front-end to R, for use in scripting applications.

Options:
  --help              Print usage and exit
  --version           Print version and exit
  --verbose           Print information on progress
  --default-packages=LIST  Attach these packages on startup;
                        a comma-separated LIST of package names, or 'NULL'
and options to R (in addition to --no-echo --no-restore), for example:
  --save              Do save workspace at the end of the session
  --no-environ        Don't read the site and user environment files
  --no-site-file      Don't read the site-wide Rprofile
  --no-init-file      Don't read the user R profile
  --restore           Do restore previously saved objects at startup
  --vanilla           Combine --no-save, --no-restore, --no-site-file,
                        --no-init-file and --no-environ

Expressions (one or more '-e <expr>') may be used *instead* of 'file'.
Any additional 'args' can be accessed from R via 'commandArgs(TRUE)'.
See also  ?Rscript  from within R.
```

