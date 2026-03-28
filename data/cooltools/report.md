# cooltools CWL Generation Report

## cooltools_coverage

### Tool Description
Calculate the sums of cis and genome-wide contacts (aka coverage aka marginals) for a sparse Hi-C contact map in Cooler HDF5 format. Note that the sum(tot_cov) from this function is two times the number of reads contributing to the cooler, as each side contributes to the coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Total Downloads**: 345.2K
- **Last updated**: 2025-08-04
- **GitHub**: https://github.com/mirnylab/cooltools
- **Stars**: N/A
### Original Help Text
```text
Usage: cooltools coverage [OPTIONS] COOL_PATH

  Calculate the sums of cis and genome-wide contacts (aka coverage aka
  marginals) for a sparse Hi-C contact map in Cooler HDF5 format. Note that
  the sum(tot_cov) from this function is two times the number of reads
  contributing to the cooler, as each side contributes to the coverage.

  COOL_PATH : The paths to a .cool file with a balanced Hi-C map.

Options:
  -o, --output TEXT       Specify output file name to store the coverage in a
                          tsv format.
  --ignore-diags INTEGER  The number of diagonals to ignore. By default,
                          equals the number of diagonals ignored during IC
                          balancing.
  --store                 Append columns with coverage (cov_cis_raw,
                          cov_tot_raw), or (cov_cis_clr_weight_name,
                          cov_tot_clr_weight_name) if calculating balanced
                          coverage, to the cooler bin table. If
                          clr_weight_name=None, also stores total cis counts
                          in the cooler info
  --chunksize INTEGER     Split the contact matrix pixel records into equally
                          sized chunks to save memory and/or parallelize.
                          Default is 10^7  [default: 10000000.0]
  --bigwig                Also save output as bigWig files for cis and total
                          coverage with the names <output>.<cis/tot>.bw
  --clr_weight_name TEXT  Name of the weight column. Specify to calculate
                          coverage of balanced cooler.
  -p, --nproc INTEGER     Number of processes to split the work between.
                          [default: 1, i.e. no process pool]
  -h, --help              Show this message and exit.
```


## cooltools_dots

### Tool Description
Call dots on a Hi-C heatmap that are not larger than max_loci_separation.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools dots [OPTIONS] COOL_PATH EXPECTED_PATH

  Call dots on a Hi-C heatmap that are not larger than max_loci_separation.

  COOL_PATH : The paths to a .cool file with a balanced Hi-C map.

  EXPECTED_PATH : The paths to a tsv-like file with expected signal, including
  a header. Use the '::' syntax to specify a column name.

  Analysis will be performed for chromosomes referred to in EXPECTED_PATH, and
  therefore these chromosomes must be a subset of chromosomes referred to in
  COOL_PATH. Also chromosomes refered to in EXPECTED_PATH must be non-trivial,
  i.e., contain not-NaN signal. Thus, make sure to prune your EXPECTED_PATH
  before applying this script.

  COOL_PATH and EXPECTED_PATH must be binned at the same resolution.

  EXPECTED_PATH must contain at least the following columns for cis contacts:
  'region1/2', 'dist', 'n_valid', value_name. value_name is controlled using
  options. Header must be present in a file.

Options:
  --view, --regions FILE         Path to a BED file with the definition of
                                 viewframe (regions) used in the calculation
                                 of EXPECTED_PATH. Dot-calling will be
                                 performed for these regions independently
                                 e.g. chromosome arms. Note that '--regions'
                                 is the deprecated name of the option. Use '--
                                 view' instead.
  --clr-weight-name TEXT         Use cooler balancing weight with this name.
                                 [default: weight]
  -p, --nproc INTEGER            Number of processes to split the work
                                 between. [default: 1, i.e. no process pool]
  --max-loci-separation INTEGER  Limit loci separation for dot-calling, i.e.,
                                 do not call dots for loci that are further
                                 than max_loci_separation basepair apart.
                                 2-20MB is reasonable and would capture most
                                 of CTCF-dots.  [default: 2000000]
  --max-nans-tolerated INTEGER   Maximum number of NaNs tolerated in a
                                 footprint of every used filter. Must be
                                 controlled with caution, as large max-nans-
                                 tolerated, might lead to pixels scored in the
                                 padding area of the tiles to "penetrate" to
                                 the list of scored pixels for the statistical
                                 testing. [max-nans-tolerated <= 2*w ]
                                 [default: 1]
  --tile-size INTEGER            Tile size for the Hi-C heatmap tiling.
                                 Typically on order of several mega-bases, and
                                 <= max_loci_separation.  [default: 6000000]
  --num-lambda-bins INTEGER      Number of log-spaced bins to divide your
                                 adjusted expected between. Same as
                                 HiCCUPS_W1_MAX_INDX (40) in the original
                                 HiCCUPS.  [default: 45]
  --fdr FLOAT                    False discovery rate (FDR) to control in the
                                 multiple hypothesis testing BH-FDR procedure.
                                 [default: 0.02]
  --clustering-radius INTEGER    Radius for clustering dots that have been
                                 called too close to each other.Typically on
                                 order of 40 kilo-bases, and >= binsize.
                                 [default: 39000]
  -v, --verbose                  Enable verbose output
  -o, --output TEXT              Specify output file name to store called dots
                                 in a BEDPE-like format  [required]
  -h, --help                     Show this message and exit.
```


## cooltools_eigs-cis

### Tool Description
Perform eigen value decomposition on a cooler matrix to calculate compartment signal by finding the eigenvector that correlates best with the phasing track.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools eigs-cis [OPTIONS] COOL_PATH

  Perform eigen value decomposition on a cooler matrix to calculate
  compartment signal by finding the eigenvector that correlates best with the
  phasing track.

  COOL_PATH : the paths to a .cool file with a balanced Hi-C map. Use the '::'
  syntax to specify a group path in a multicooler file.

  TRACK_PATH : the path to a BedGraph-like file that stores phasing track as
  track-name named column.

  BedGraph-like format assumes tab-separated columns chrom, start, stop and
  track-name.

Options:
  --phasing-track TRACK_PATH  Phasing track for orienting and ranking
                              eigenvectors,provided as
                              /path/to/track::track_value_column_name.
  --view, --regions TEXT      Path to a BED file which defines which regions
                              of the chromosomes to use (only implemented for
                              cis contacts). Note that '--regions' is the
                              deprecated name of the option. Use '--view'
                              instead.
  --n-eigs INTEGER            Number of eigenvectors to compute.  [default: 3]
  --clr-weight-name TEXT      Use balancing weight with this name. Using raw
                              unbalanced data is not currently supported for
                              eigenvectors.  [default: weight]
  --ignore-diags INTEGER      The number of diagonals to ignore. By default,
                              equals the number of diagonals ignored during IC
                              balancing.
  -v, --verbose               Enable verbose output
  -o, --out-prefix TEXT       Save compartment track as a BED-like file.
                              Eigenvectors and corresponding eigenvalues are
                              stored in out_prefix.contact_type.vecs.tsv and
                              out_prefix.contact_type.lam.txt  [required]
  --bigwig                    Also save compartment track (E1) as a bigWig
                              file with the name out_prefix.contact_type.bw
  -h, --help                  Show this message and exit.
```


## cooltools_eigs-trans

### Tool Description
Perform eigen value decomposition on a cooler matrix to calculate compartment signal by finding the eigenvector that correlates best with the phasing track.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools eigs-trans [OPTIONS] COOL_PATH

  Perform eigen value decomposition on a cooler matrix to calculate
  compartment signal by finding the eigenvector that correlates best with the
  phasing track.

  COOL_PATH : the paths to a .cool file with a balanced Hi-C map. Use the '::'
  syntax to specify a group path in a multicooler file.

  TRACK_PATH : the path to a BedGraph-like file that stores phasing track as
  track-name named column.

  BedGraph-like format assumes tab-separated columns chrom, start, stop and
  track-name.

Options:
  --phasing-track TRACK_PATH  Phasing track for orienting and ranking
                              eigenvectors,provided as
                              /path/to/track::track_value_column_name.
  --view, --regions TEXT      Path to a BED file which defines which regions
                              of the chromosomes to use (only implemented for
                              cis contacts).  Note that '--regions' is the
                              deprecated name of the option. Use '--view'
                              instead.
  --n-eigs INTEGER            Number of eigenvectors to compute.  [default: 3]
  --clr-weight-name TEXT      Use balancing weight with this name. Using raw
                              unbalanced data is not supported for saddles.
                              [default: weight]
  -v, --verbose               Enable verbose output
  -o, --out-prefix TEXT       Save compartment track as a BED-like file.
                              Eigenvectors and corresponding eigenvalues are
                              stored in out_prefix.contact_type.vecs.tsv and
                              out_prefix.contact_type.lam.txt  [required]
  --bigwig                    Also save compartment track (E1) as a bigWig
                              file with the name out_prefix.contact_type.bw
  -h, --help                  Show this message and exit.
```


## cooltools_expected-cis

### Tool Description
Calculate expected Hi-C signal for cis regions of chromosomal interaction
  map: average of interactions separated by the same genomic distance, i.e.
  are on the same diagonal on the cis-heatmap.

  When balancing weights are not applied to the data, there is no masking of
  bad bins performed.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools expected-cis [OPTIONS] COOL_PATH

  Calculate expected Hi-C signal for cis regions of chromosomal interaction
  map: average of interactions separated by the same genomic distance, i.e.
  are on the same diagonal on the cis-heatmap.

  When balancing weights are not applied to the data, there is no masking of
  bad bins performed.

  COOL_PATH : The paths to a .cool file with a balanced Hi-C map.

Options:
  -p, --nproc INTEGER      Number of processes to split the work
                           between.[default: 1, i.e. no process pool]
  -c, --chunksize INTEGER  Control the number of pixels handled by each worker
                           process at a time.  [default: 10000000]
  -o, --output TEXT        Specify output file name to store the expected in a
                           tsv format.
  --view, --regions PATH   Path to a 3 or 4-column BED file with genomic
                           regions to calculated cis-expected on. When region
                           names are not provided (no 4th column), UCSC-style
                           region names are generated. Cis-expected is
                           calculated for all chromosomes, when this is not
                           specified. Note that '--regions' is the deprecated
                           name of the option. Use '--view' instead.
  --smooth                 If set, cis-expected is smoothed and result stored
                           in an additional column e.g. balanced.avg.smoothed
  --aggregate-smoothed     If set, cis-expected is averaged over all regions
                           and then smoothed. Result is stored in an
                           additional column, e.g. balanced.avg.smoothed.agg.
                           Ignored without smoothing
  --smooth-sigma FLOAT     Control smoothing with the standard deviation of
                           the smoothing Gaussian kernel, ignored without
                           smoothing.  [default: 0.1]
  --clr-weight-name TEXT   Use balancing weight with this name stored in
                           cooler.Provide empty argument to calculate cis-
                           expected on raw data  [default: weight]
  --ignore-diags INTEGER   Number of diagonals to neglect for cis contact type
                           [default: 2]
  -h, --help               Show this message and exit.
```


## cooltools_expected-trans

### Tool Description
Calculate expected Hi-C signal for trans regions of chromosomal interaction map: average of interactions in a rectangular block defined by a pair of regions, e.g. inter-chromosomal blocks.

When balancing weights are not applied to the data, there is no masking of bad bins performed.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools expected-trans [OPTIONS] COOL_PATH

  Calculate expected Hi-C signal for trans regions of chromosomal interaction
  map: average of interactions in a rectangular block defined by a pair of
  regions, e.g. inter-chromosomal blocks.

  When balancing weights are not applied to the data, there is no masking of
  bad bins performed.

  COOL_PATH : The paths to a .cool file with a balanced Hi-C map.

Options:
  -p, --nproc INTEGER      Number of processes to split the work
                           between.[default: 1, i.e. no process pool]
  -c, --chunksize INTEGER  Control the number of pixels handled by each worker
                           process at a time.  [default: 10000000]
  -o, --output TEXT        Specify output file name to store the expected in a
                           tsv format.
  --view, --regions PATH   Path to a 3 or 4-column BED file with genomic
                           regions. Trans-expected is calculated on all
                           pairwise combinations of these regions. When region
                           names are not provided (no 4th column), UCSC-style
                           region names are generated. Trans-expected is
                           calculated  for all inter-chromosomal pairs, when
                           view is not specified. Note that '--regions' is the
                           deprecated name of the option. Use '--view'
                           instead.
  --clr-weight-name TEXT   Use balancing weight with this name stored in
                           cooler.Provide empty argument to calculate cis-
                           expected on raw data  [default: weight]
  -h, --help               Show this message and exit.
```


## cooltools_genome

### Tool Description
Utilities for binned genome assemblies.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools genome [OPTIONS] COMMAND [ARGS]...

  Utilities for binned genome assemblies.

Options:
  -h, --help  Show this message and exit.

Commands:
  binnify
  digest
  fetch-chromsizes
  gc
  genecov           BINS_PATH is the path to bintable.
```


## cooltools_insulation

### Tool Description
Calculate the diamond insulation scores and call insulating boundaries.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools insulation [OPTIONS] IN_PATH WINDOW

  Calculate the diamond insulation scores and call insulating boundaries.

  IN_PATH : The path to a .cool file with a balanced Hi-C map.

  WINDOW : The window size for the insulation score calculations.
  Multiple space-separated values can be provided.          By default, the
  window size must be provided in units of bp.          When the flag
  --window-pixels is set, the window sizes must          be provided in units
  of pixels instead.

Options:
  -p, --nproc INTEGER            Number of processes to split the work
                                 between.[default: 1, i.e. no process pool]
  -o, --output TEXT              Specify output file name to store the
                                 insulation in a tsv format.
  --view, --regions PATH         Path to a BED file containing genomic regions
                                 for which insulation scores will be
                                 calculated. Region names can be provided in a
                                 4th column and should match regions and their
                                 names in expected. Note that '--regions' is
                                 the deprecated name of the option. Use '--
                                 view' instead.
  --ignore-diags INTEGER         The number of diagonals to ignore. By
                                 default, equals the number of diagonals
                                 ignored during IC balancing.
  --clr-weight-name TEXT         Use balancing weight with this name. Provide
                                 empty argument to calculate insulation on raw
                                 data (no masking bad pixels).  [default:
                                 weight]
  --min-frac-valid-pixels FLOAT  The minimal fraction of valid pixels in a
                                 sliding diamond. Used to mask bins during
                                 boundary detection.  [default: 0.66]
  --min-dist-bad-bin INTEGER     The minimal allowed distance to a bad bin.
                                 Use to mask bins after insulation calculation
                                 and during boundary detection.  [default: 0]
  --threshold TEXT               Rule used to threshold the histogram of
                                 boundary strengths to exclude weakboundaries.
                                 'Li' or 'Otsu' use corresponding methods from
                                 skimage.thresholding.Providing a float value
                                 will filter by a fixed threshold  [default:
                                 0]
  --window-pixels                If set then the window sizes are provided in
                                 units of pixels.
  --append-raw-scores            Append columns with raw scores (sum_counts,
                                 sum_balanced, n_pixels) to the output table.
  --chunksize INTEGER            [default: 20000000]
  --verbose                      Report real-time progress.
  --bigwig                       Also save insulation tracks as a bigWig files
                                 for different window sizes with the names
                                 output.<window-size>.bw
  -h, --help                     Show this message and exit.
```


## cooltools_pileup

### Tool Description
Perform retrieval of the snippets from .cool file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools pileup [OPTIONS] COOL_PATH FEATURES_PATH

  Perform retrieval of the snippets from .cool file.

  COOL_PATH : The paths to a .cool file with a balanced Hi-C map. Use the '::'
  syntax to specify a group path in a multicooler file.

  FEATURES_PATH : the path to a BED or BEDPE-like file that contains features
  for snipping windows. If BED, then the features are on-diagonal. If BEDPE,
  then the features can be off-diagonal (but not in trans or between different
  regions in the view).

Options:
  --view, --regions TEXT          Path to a BED file which defines which
                                  regions of the chromosomes to use.  Required
                                  if EXPECTED_PATH is provided Note that '--
                                  regions' is the deprecated name of the
                                  option. Use '--view' instead.
  --expected TEXT                 Path to the expected table. If provided,
                                  outputs OOE pileup.  if not provided,
                                  outputs regular pileup.
  --flank INTEGER                 Size of flanks.  [default: 100000]
  --features-format [auto|bed|bedpe]
                                  Input features format.
  --clr-weight-name TEXT          Use balancing weight with this name.
                                  [default: weight]
  -o, --out TEXT                  Save output pileup as NPZ/HDF5 file.
                                  [required]
  --out-format [npz|hdf5]         Type of output.  [default: NPZ]
  --store-snips                   Flag indicating whether snips should be
                                  stored.
  -p, --nproc INTEGER             Number of processes to split the work
                                  between. [default: 1, i.e. no process pool]
  --ignore-diags INTEGER          The number of diagonals to ignore. By
                                  default, equals the number of diagonals
                                  ignored during IC balancing.
  --aggregate [none|mean|median|std|min|max]
                                  Function for calculating aggregate signal.
                                  [default: none]
  -v, --verbose                   Enable verbose output
  -h, --help                      Show this message and exit.
```


## cooltools_random-sample

### Tool Description
Pick a random sample of contacts from a Hi-C map.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools random-sample [OPTIONS] IN_PATH OUT_PATH

  Pick a random sample of contacts from a Hi-C map.

  IN_PATH : Input cooler path or URI.

  OUT_PATH : Output cooler path or URI.

  Specify the target sample size with either --count or --frac.

Options:
  -c, --count INTEGER  The target number of contacts in the sample. The
                       resulting sample size will not match it precisely.
                       Mutually exclusive with --frac and --cis-count
  --cis-count INTEGER  The target number of cis contacts in the sample. The
                       resulting sample size will not match it precisely.
                       Mutually exclusive with --count and --frac
  -f, --frac FLOAT     The target sample size as a fraction of contacts in the
                       original dataset. Mutually exclusive with --count and
                       --cis-count
  --exact              If specified, use exact sampling that guarantees the
                       size of the output sample. Otherwise, binomial sampling
                       will be used and the sample size will be distributed
                       around the target value.
  -p, --nproc INTEGER  Number of processes to split the work between.[default:
                       1, i.e. no process pool]
  --chunksize INTEGER  The number of pixels loaded and processed per step of
                       computation.  [default: 10000000]
  -h, --help           Show this message and exit.
```


## cooltools_rearrange

### Tool Description
Rearrange data from a cooler according to a new genomic view

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools rearrange [OPTIONS] IN_PATH OUT_PATH

  Rearrange data from a cooler according to a new genomic view

  Parameters ---------- IN_PATH : str     .cool file (or URI) with data to
  rearrange. OUT_PATH : str     .cool file (or URI) to save the rearrange
  data. view : str     Path to a BED-like file which defines which regions of
  the chromosomes to use     and in what order. Has to be a valid viewframe
  (columns corresponding to region     coordinates followed by the region
  name), with potential additional columns.     Using --new-chrom-col and
  --orientation-col you can specify the new chromosome     names and whether
  to invert each region (optional).     If has no header with column names,
  assumes the `new-chrom-col` is the fifth     column and `--orientation-col`
  is the sixth, if they exist. new_chrom_col : str     Column name in the view
  with new chromosome names.     If not provided and there is no column named
  'new_chrom' in the view file, uses     original chromosome names.
  orientation_col : str     Columns name in the view with orientations of each
  region (+ or -). - means the     region will be inverted.     If not
  providedand there is no column named 'strand' in the view file, assumes
  all are forward oriented. assembly : str     The name of the assembly for
  the new cooler. If None, uses the same as in the     original cooler.
  chunksize : int     The number of pixels loaded and processed per step of
  computation. mode : str     (w)rite or (a)ppend to the output file (default:
  w)

Options:
  --view TEXT             Path to a BED-like file which defines which regions
                          of the chromosomes to use and in what order. Using
                          --new-chrom-col and --orientation-col you can
                          specify the new chromosome names and whether to
                          invert each region (optional)  [required]
  --new-chrom-col TEXT    Column name in the view with new chromosome names.
                          If not provided and there is no column named
                          'new_chrom' in the view file, uses original
                          chromosome names
  --orientation-col TEXT  Columns name in the view with orientations of each
                          region (+ or -). If not providedand there is no
                          column named 'strand' in the view file, assumes all
                          are forward oriented
  --assembly TEXT         The name of the assembly for the new cooler. If
                          None, uses the same as in the original cooler.
  --chunksize INTEGER     The number of pixels loaded and processed per step
                          of computation.  [default: 10000000]
  --mode [w|a]            (w)rite or (a)ppend to the output file (default: w)
  -h, --help              Show this message and exit.
```


## cooltools_saddle

### Tool Description
Calculate saddle statistics and generate saddle plots for an arbitrary signal track on the genomic bins of a contact matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools saddle [OPTIONS] COOL_PATH TRACK_PATH EXPECTED_PATH

  Calculate saddle statistics and generate saddle plots for an arbitrary
  signal track on the genomic bins of a contact matrix.

  COOL_PATH : The paths to a .cool file with a balanced Hi-C map. Use the '::'
  syntax to specify a group path in a multicooler file.

  TRACK_PATH : The path to bedGraph-like file with a binned compartment track
  (eigenvector), including a header. Use the '::' syntax to specify a column
  name.

  EXPECTED_PATH : The paths to a tsv-like file with expected signal, including
  a header. Use the '::' syntax to specify a column name.

  Analysis will be performed for chromosomes referred to in TRACK_PATH, and
  therefore these chromosomes must be a subset of chromosomes referred to in
  COOL_PATH and EXPECTED_PATH.

  COOL_PATH, TRACK_PATH and EXPECTED_PATH must be binned at the same
  resolution (expect for  EXPECTED_PATH in case of trans contact type).

  EXPECTED_PATH must contain at least the following columns for cis contacts:
  'chrom', 'diag', 'n_valid', value_name and the following columns for trans
  contacts: 'chrom1', 'chrom2', 'n_valid', value_name value_name is controlled
  using options. Header must be present in a file.

Options:
  -t, --contact-type [cis|trans]  Type of the contacts to aggregate  [default:
                                  cis]
  --min-dist INTEGER              Minimal distance between bins to consider,
                                  bp. If negative, removesthe first two
                                  diagonals of the data. Ignored with
                                  --contact-type trans.  [default: -1]
  --max-dist INTEGER              Maximal distance between bins to consider,
                                  bp. Ignored, if negative. Ignored with
                                  --contact-type trans.  [default: -1]
  -n, --n-bins INTEGER            Number of bins for digitizing track values.
                                  [default: 50]
  --vrange <FLOAT FLOAT>...       Low and high values used for binning genome-
                                  wide track values, e.g. if `range`=(-0.05,
                                  0.05), `n-bins` equidistant bins would be
                                  generated. Use to prevent extreme track
                                  values from exploding the bin range and to
                                  ensure consistent bins across several runs
                                  of `compute_saddle` command using different
                                  track files.
  --qrange <FLOAT FLOAT>...       Low and high values used for quantile bins
                                  of genome-wide track values,e.g. if
                                  `qrange`=(0.02, 0.98) the lower bin would
                                  start at the 2nd percentile and the upper
                                  bin would end at the 98th percentile of the
                                  genome-wide signal. Use to prevent the
                                  extreme track values from exploding the bin
                                  range.  [default: None, None]
  --clr-weight-name TEXT          Use balancing weight with this name.
                                  [default: weight]
  --strength / --no-strength      Compute and save compartment 'saddle
                                  strength' profile
  --view, --regions PATH          Path to a BED file containing genomic
                                  regions for which saddleplot will be
                                  calculated. Region names can be provided in
                                  a 4th column and should match regions and
                                  their names in expected. Note that '--
                                  regions' is the deprecated name of the
                                  option. Use '--view' instead.
  -o, --out-prefix TEXT           Dump 'saddledata', 'binedges' and 'hist'
                                  arrays in a numpy-specific .npz container.
                                  Use numpy.load to load these arrays into a
                                  dict-like object. The digitized signal
                                  values are saved to a bedGraph-style TSV.
                                  [required]
  --fig [png|jpg|svg|pdf|ps|eps]  Generate a figure and save to a file of the
                                  specified format. If not specified - no
                                  image is generated. Repeat for multiple
                                  output formats.
  --scale [linear|log]            Value scale for the heatmap  [default: log]
  --cmap TEXT                     Name of matplotlib colormap  [default:
                                  coolwarm]
  --vmin FLOAT                    Low value of the saddleplot colorbar. Note:
                                  value in original units irrespective of used
                                  scale, and therefore should be positive for
                                  both vmin and vmax.
  --vmax FLOAT                    High value of the saddleplot colorbar
  --hist-color TEXT               Face color of histogram bar chart
  -v, --verbose                   Enable verbose output
  -h, --help                      Show this message and exit.
```


## cooltools_virtual4c

### Tool Description
Generate virtual 4C profile from a contact map by extracting all interactions of a given viewpoint with the rest of the genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooltools:0.7.1--py311h93dcfea_3
- **Homepage**: https://github.com/mirnylab/cooltools
- **Package**: https://anaconda.org/channels/bioconda/packages/cooltools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooltools virtual4c [OPTIONS] COOL_PATH VIEWPOINT

  Generate virtual 4C profile from a contact map by extracting all
  interactions of a given viewpoint with the rest of the genome.

  COOL_PATH : the paths to a .cool file with a Hi-C map. Use the '::' syntax
  to specify a group path in a multicooler file.

  VIEWPOINT : the viewpoint to use for the virtual 4C profile. Provide as a
  UCSC-string (e.g. chr1:1-1000)

  Note: this is a new (experimental) tool, the interface or output might
  change in a future version.

Options:
  --clr-weight-name TEXT  Use balancing weight with this name. Provide empty
                          argument to calculate insulation on raw data (no
                          masking bad pixels).  [default: weight]
  -o, --out-prefix TEXT   Save virtual 4C track as a BED-like file. Contact
                          frequency is stored in out_prefix.v4C.tsv
                          [required]
  --bigwig                Also save virtual 4C track as a bigWig file with the
                          name out_prefix.v4C.bw
  -p, --nproc INTEGER     Number of processes to split the work between.
                          [default: 1, i.e. no process pool]
  -h, --help              Show this message and exit.
```


## Metadata
- **Skill**: generated
