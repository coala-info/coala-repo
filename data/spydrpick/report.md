# spydrpick CWL Generation Report

## spydrpick_SpydrPick

### Tool Description
MI-ARACNE genome-wide co-evolution analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/spydrpick:1.2.0--h78a066a_0
- **Homepage**: https://github.com/santeripuranen/SpydrPick
- **Package**: https://anaconda.org/channels/bioconda/packages/spydrpick/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spydrpick/overview
- **Total Downloads**: 18.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/santeripuranen/SpydrPick
- **Stars**: N/A
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

