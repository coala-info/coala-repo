# cooler CWL Generation Report

## cooler_balance

### Tool Description
Out-of-core matrix balancing.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Total Downloads**: 291.2K
- **Last updated**: 2025-07-22
- **GitHub**: https://github.com/open2c/cooler
- **Stars**: N/A
### Original Help Text
```text
Usage: cooler balance [OPTIONS] COOL_PATH

  Out-of-core matrix balancing.

  Matrix must be symmetric. See the help for various filtering options to mask
  out poorly mapped bins.

  COOL_PATH : Path to a COOL file.

Options:
  --cis-only                      Calculate weights against intra-chromosomal
                                  data only instead of genome-wide.
  --trans-only                    Calculate weights against inter-chromosomal
                                  data only instead of genome-wide.
  --ignore-diags INTEGER          Number of diagonals of the contact matrix to
                                  ignore, including the main diagonal.
                                  Examples: 0 ignores nothing, 1 ignores the
                                  main diagonal, 2 ignores diagonals (-1, 0,
                                  1), etc.  [default: 2]
  --ignore-dist INTEGER           Distance from the diagonal in bp to ignore.
                                  The maximum of the corresponding number of
                                  diagonals and `--ignore-diags` will be used.
  --mad-max INTEGER               Ignore bins from the contact matrix using
                                  the 'MAD-max' filter: bins whose log
                                  marginal sum is less than ``mad-max`` median
                                  absolute deviations below the median log
                                  marginal sum of all the bins in the same
                                  chromosome.  [default: 5]
  --min-nnz INTEGER               Ignore bins from the contact matrix whose
                                  marginal number of nonzeros is less than
                                  this number.  [default: 10]
  --min-count INTEGER             Ignore bins from the contact matrix whose
                                  marginal count is less than this number.
                                  [default: 0]
  --blacklist PATH                Path to a 3-column BED file containing
                                  genomic regions to mask out during the
                                  balancing procedure, e.g. sequence gaps or
                                  regions of poor mappability.
  -p, --nproc INTEGER             Number of processes to split the work
                                  between.  [default: 8]
  -c, --chunksize INTEGER         Control the number of pixels handled by each
                                  worker process at a time.  [default:
                                  10000000]
  --tol FLOAT                     Threshold value of variance of the marginals
                                  for the algorithm to converge.  [default:
                                  1e-05]
  --max-iters INTEGER             Maximum number of iterations to perform if
                                  convergence is not achieved.  [default: 200]
  --name TEXT                     Name of column to write to.  [default:
                                  weight]
  -f, --force                     Overwrite the target dataset, 'weight', if
                                  it already exists.
  --check                         Check whether a data column 'weight' already
                                  exists.
  --stdout                        Print weight column to stdout instead of
                                  saving to file.
  --convergence-policy [store_final|store_nan|discard|error]
                                  What to do with weights when balancing
                                  doesn't converge in max_iters.
                                  'store_final': Store the final result,
                                  regardless of whether the iterations
                                  converge to the specified tolerance;
                                  'store_nan': Store a vector of NaN values to
                                  indicate that the matrix failed to converge;
                                  'discard': Store nothing and exit
                                  gracefully; 'error': Abort with non-zero
                                  exit status.  [default: store_final]
  -h, --help                      Show this message and exit.
```


## cooler_cload

### Tool Description
Create a cooler from genomic pairs and bins.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler cload [OPTIONS] COMMAND [ARGS]...

  Create a cooler from genomic pairs and bins.

  Choose a subcommand based on the format of the input contact list.

Options:
  -h, --help  Show this message and exit.

Commands:
  hiclib  Bin a hiclib HDF5 contact list (frag) file.
  pairix  Bin a pairix-indexed contact list file.
  pairs   Bin any text file or stream of pairs.
  tabix   Bin a tabix-indexed contact list file.
```


## cooler_coarsen

### Tool Description
Coarsen a cooler to a lower resolution.

Works by pooling *k*-by-*k* neighborhoods of pixels and aggregating. Each
chromosomal block is coarsened individually.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler coarsen [OPTIONS] COOL_PATH

  Coarsen a cooler to a lower resolution.

  Works by pooling *k*-by-*k* neighborhoods of pixels and aggregating. Each
  chromosomal block is coarsened individually.

  COOL_PATH : Path to a COOL file or Cooler URI.

Options:
  -k, --factor INTEGER     Gridding factor. The contact matrix is
                           coarsegrained by grouping each chromosomal contact
                           block into k-by-k element tiles  [default: 2]
  -n, -p, --nproc INTEGER  Number of processes to use for batch processing
                           chunks of pixels [default: 1, i.e. no process pool]
  -c, --chunksize INTEGER  Number of pixels allocated to each process
                           [default: 10000000]
  --field TEXT             Specify the names of value columns to merge as
                           '<name>'. Repeat the `--field` option for each one.
                           Use '<name>,dtype=<dtype>' to specify the dtype.
                           Include ',agg=<agg>' to specify an aggregation
                           function different from 'sum'.
  -o, --out TEXT           Output file or URI  [required]
  -a, --append             Pass this flag to append the output cooler to an
                           existing file instead of overwriting the file.
  -h, --help               Show this message and exit.
```


## cooler_csort

### Tool Description
Sort and index a contact list.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler csort [OPTIONS] PAIRS_PATH CHROMOSOMES_PATH

  Sort and index a contact list.

  Order the mates of each pair record so that all contacts are upper
  triangular with respect to the chromosome ordering given by the chromosomes
  file, sort contacts by genomic location, and index the resulting file.

  PAIRS_PATH : Contacts (i.e. read pairs) text file, optionally compressed.

  CHROMOSOMES_PATH : File listing desired chromosomes in the desired order.
  May be tab-delimited, e.g. a UCSC-style chromsizes file. Contacts mapping to
  other chromosomes will be discarded.

  **Notes**

  - csort can also be used to sort and index a text representation of   a
  contact *matrix* in bedGraph-like format. In this case, substitute   `pos1`
  and `pos2` with `start1` and `start2`, respectively. - Requires Unix tools:
  sort, bgzip + tabix or pairix.

  If indexing with Tabix, the output file will have the following properties:

  - Upper triangular: the read pairs on each row are assigned to side 1 or 2
  in such a way that (chrom1, pos1) is always "less than" (chrom2, pos2) -
  Rows are lexicographically sorted by chrom1, pos1, chrom2, pos2;   i.e.
  "positionally sorted" - Compressed with bgzip [*] - Indexed using Tabix [*]
  on chrom1 and pos1.

  If indexing with Pairix, the output file will have the following properties:

  - Upper triangular: the read pairs on each row are assigned to side 1 or 2
  in such a way that (chrom1, pos1) is always "less than" (chrom2, pos2) -
  Rows are lexicographically sorted by chrom1, chrom2, pos1, pos2; i.e.
  "block sorted" - Compressed with bgzip [*] - Indexed using Pairix [+] on
  chrom1, chrom2 and pos1.

  [*] Tabix manpage: <http://www.htslib.org/doc/tabix.html>. [+] Pairix on
  Github: <https://github.com/4dn-dcic/pairix>

Options:
  -c1, --chrom1 INTEGER       chrom1 field number in the input file (starting
                              from 1)  [required]
  -c2, --chrom2 INTEGER       chrom2 field number  [required]
  -p1, --pos1 INTEGER         pos1 field number  [required]
  -p2, --pos2 INTEGER         pos2 field number  [required]
  -i, --index [tabix|pairix]  Select the preset sort and indexing options
                              [default: pairix]
  --flip-only                 Only flip mates; no sorting or indexing. Write
                              to stdout.
  -p, --nproc INTEGER         Number of processors  [default: 8]
  -0, --zero-based            Read positions are zero-based
  --sep TEXT                  Data delimiter in the input file  [default: \t]
  --comment-char TEXT         Comment character to skip header  [default: #]
  --sort-options TEXT         Quoted list of additional options to `sort`
                              command
  -o, --out TEXT              Output gzip file
  -s1, --strand1 INTEGER      strand1 field number (deprecated)
  -s2, --strand2 INTEGER      strand2 field number (deprecated)
  -h, --help                  Show this message and exit.
```


## cooler_digest

### Tool Description
Generate fragment-delimited genomic bins.

Output a genome segmentation of restriction fragments as a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler digest [OPTIONS] CHROMSIZES_PATH FASTA_PATH ENZYME

  Generate fragment-delimited genomic bins.

  Output a genome segmentation of restriction fragments as a BED file.

  CHROMSIZES_PATH : UCSC-like chromsizes file, with chromosomes in desired
  order.

  FASTA_PATH : Genome assembly FASTA file or folder containing FASTA files
  (uncompressed).

  ENZYME : Name of restriction enzyme

Options:
  -o, --out TEXT       Output file (defaults to stdout)
  -H, --header         Print the header of column names as the first row.
  -i, --rel-ids [0|1]  Include a column of relative bin IDs for each
                       chromosome. Choose whether to report them as 0- or
                       1-based.
  -h, --help           Show this message and exit.
```


## cooler_dump

### Tool Description
Dump a cooler's data to a text stream.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler dump [OPTIONS] COOL_PATH

  Dump a cooler's data to a text stream.

  COOL_PATH : Path to COOL file or cooler URI.

Options:
  -t, --table [chroms|bins|pixels]
                                  Which table to dump. Choosing 'chroms' or
                                  'bins' will cause all pixel-related options
                                  to be ignored. Note that for coolers stored
                                  in symmetric-upper mode, 'pixels' only holds
                                  the upper triangle values of the matrix.
                                  [default: pixels]
  -c, --columns SEPARATED[,]      Restrict output to a subset of columns,
                                  provided as a comma-separated list.
  -H, --header                    Print the header of column names as the
                                  first row.
  --na-rep TEXT                   Missing data representation. Default is
                                  empty ''.
  --float-format TEXT             Format string for floating point numbers
                                  (e.g. '.12g', '03.2f').  [default: g]
  -r, --range TEXT                The coordinates of a genomic region shown
                                  along the row dimension, in UCSC-style
                                  notation. (Example:
                                  chr1:10,000,000-11,000,000). If omitted, the
                                  entire contact matrix is printed.
  -r2, --range2 TEXT              The coordinates of a genomic region shown
                                  along the column dimension. If omitted, the
                                  column range is the same as the row range.
  -f, --fill-lower                For coolers using 'symmetric-upper' storage,
                                  populate implicit areas of the genomic query
                                  box by generating lower triangle pixels. If
                                  not specified, only upper triangle pixels
                                  are reported. This option has no effect on
                                  coolers stored in 'square' mode.
  -b, --balanced / --no-balance   Apply balancing weights to data. This will
                                  print an extra column called `balanced`
                                  [default: no-balance]
  --join                          Print the full chromosome bin coordinates
                                  instead of bin IDs. This will replace the
                                  `bin1_id` column with `chrom1`, `start1`,
                                  and `end1`, and the `bin2_id` column with
                                  `chrom2`, `start2` and `end2`.
  --annotate SEPARATED[,]         Join additional columns from the bin table
                                  against the pixels. Provide a comma
                                  separated list of column names (no spaces).
                                  The merged columns will be suffixed by '1'
                                  and '2' accordingly.
  --one-based-ids                 Print bin IDs as one-based rather than zero-
                                  based.
  --one-based-starts              Print start coordinates as one-based rather
                                  than zero-based.
  -k, --chunksize INTEGER         Sets the number of pixel records loaded from
                                  disk at one time. Can affect the performance
                                  of joins on high resolution datasets.
                                  [default: 1000000]
  -o, --out TEXT                  Output text file If .gz extension is
                                  detected, file is written using zlib.
                                  Default behavior is to stream to stdout.
  -h, --help                      Show this message and exit.
```


## cooler_ls

### Tool Description
List all coolers inside a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler ls [OPTIONS] COOL_PATH

  List all coolers inside a file.

Options:
  -l, --long  Long listing format
  -h, --help  Show this message and exit.
```


## cooler_cp

### Tool Description
Copy a cooler from one file to another or within the same file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler cp [OPTIONS] SRC_URI DST_URI

  Copy a cooler from one file to another or within the same file.

  See also: h5copy, h5repack tools from HDF5 suite.

Options:
  -w, --overwrite  Truncate and replace destination file if it already exists.
  -h, --help       Show this message and exit.
```


## cooler_ln

### Tool Description
Create a hard link to a cooler (rather than a true copy) in the same file.
  Also supports soft links (in the same file) or external links (different
  files).

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler ln [OPTIONS] SRC_URI DST_URI

  Create a hard link to a cooler (rather than a true copy) in the same file.
  Also supports soft links (in the same file) or external links (different
  files).

Options:
  -w, --overwrite  Truncate and replace destination file if it already exists.
  -s, --soft       Creates a soft link rather than a hard link if the source
                   and destination file are the same. Otherwise, creates an
                   external link. This type of link uses a path rather than a
                   pointer.
  -h, --help       Show this message and exit.
```


## cooler_mv

### Tool Description
Rename a cooler within the same file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler mv [OPTIONS] SRC_URI DST_URI

  Rename a cooler within the same file.

Options:
  -w, --overwrite  Truncate and replace destination file if it already exists.
  -h, --help       Show this message and exit.
```


## cooler_tree

### Tool Description
Display a file's data hierarchy.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler tree [OPTIONS] URI

  Display a file's data hierarchy.

Options:
  -L, --level INTEGER
  -h, --help           Show this message and exit.
```


## cooler_attrs

### Tool Description
Display a file's attribute hierarchy.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler attrs [OPTIONS] URI

  Display a file's attribute hierarchy.

Options:
  -L, --level INTEGER
  -h, --help           Show this message and exit.
```


## cooler_info

### Tool Description
Display a cooler's info and metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler info [OPTIONS] COOL_PATH

  Display a cooler's info and metadata.

  COOL_PATH : Path to a COOL file or cooler URI.

Options:
  -f, --field TEXT  Print the value of a specific info field.
  -m, --metadata    Print the user metadata in JSON format.
  -o, --out TEXT    Output file (defaults to stdout)
  -h, --help        Show this message and exit.
```


## cooler_load

### Tool Description
Create a cooler from a pre-binned matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler load [OPTIONS] BINS_PATH PIXELS_PATH COOL_PATH

  Create a cooler from a pre-binned matrix.

  BINS_PATH : One of the following

      <TEXT:INTEGER> : 1. Path to a chromsizes file, 2. Bin size in bp

      <TEXT> : Path to BED file defining the genomic bin segmentation.

  PIXELS_PATH : Text file containing nonzero pixel values. May be gzipped.
  Pass '-' to use stdin.

  COOL_PATH : Output COOL file path or URI.

  **Notes**

  Two input format options (tab-delimited). Input pixel file may be
  compressed.

  COO: COO-rdinate sparse matrix format (a.k.a. ijv triple). 3 columns:
  "bin1_id, bin2_id, count",

  BG2: 2D version of the bedGraph format. 7 columns: "chrom1, start1, end1,
  chrom2, start2, end2, count"

  **Examples**

  cooler load -f bg2 <chrom.sizes>:<binsize> in.bg2.gz out.cool

Options:
  -f, --format [coo|bg2]          'coo' refers to a tab-delimited sparse
                                  triplet file (bin1, bin2, count). 'bg2'
                                  refers to a 2D bedGraph-like file (chrom1,
                                  start1, end1, chrom2, start2, end2, count).
                                  [required]
  --metadata TEXT                 Path to JSON file containing user metadata.
  --assembly TEXT                 Name of genome assembly (e.g. hg19, mm10)
  --field TEXT                    Add supplemental value fields or override
                                  default field numbers for the specified
                                  format. Specify quantitative input fields to
                                  aggregate into value columns using the
                                  syntax ``--field <field-name>=<field-
                                  number>``. Optionally, append ``:`` followed
                                  by ``dtype=<dtype>`` to specify the data
                                  type (e.g. float). Field numbers are
                                  1-based. Repeat the ``--field`` option for
                                  each additional field.
  --count-as-float                Store the 'count' column as floating point
                                  values instead of as integers. Can also be
                                  specified using the `--field` option.
  --one-based                     Pass this flag if the bin IDs listed in a
                                  COO file are one-based instead of zero-
                                  based.
  --comment-char TEXT             Comment character that indicates lines to
                                  ignore.  [default: #]
  -N, --no-symmetric-upper        Create a complete square matrix without
                                  implicit symmetry. This allows for distinct
                                  upper- and lower-triangle values
  --input-copy-status [unique|duplex]
                                  Copy status of input data when using
                                  symmetric-upper storage. | `unique`:
                                  Incoming data comes from a unique half of a
                                  symmetric matrix, regardless of how element
                                  coordinates are ordered. Execution will be
                                  aborted if duplicates are detected.
                                  `duplex`: Incoming data contains upper- and
                                  lower-triangle duplicates. All lower-
                                  triangle input elements will be discarded! |
                                  If you wish to treat lower- and upper-
                                  triangle input data as distinct, use the
                                  ``--no-symmetric-upper`` option instead.
                                  [default: unique]
  -c, --chunksize INTEGER         Size in number of lines/records of data
                                  chunks to read and process from the input
                                  stream at a time. These chunks will be saved
                                  as temporary partial coolers and then
                                  merged.
  --mergebuf INTEGER              Total number of records to buffer per epoch
                                  of merging data. Defaults to the same value
                                  as `chunksize`.
  --temp-dir DIRECTORY            Create temporary files in a specified
                                  directory. Pass ``-`` to use the platform
                                  default temp dir.
  --max-merge INTEGER             Maximum number of chunks to merge in a
                                  single pass.  [default: 200]
  --no-delete-temp                Do not delete temporary files when finished.
  --storage-options TEXT          Options to modify the data filter pipeline.
                                  Provide as a comma-separated list of key-
                                  value pairs of the form 'k1=v1,k2=v2,...'.
                                  See http://docs.h5py.org/en/stable/high/data
                                  set.html#filter-pipeline for more details.
  -a, --append                    Pass this flag to append the output cooler
                                  to an existing file instead of overwriting
                                  the file.
  -h, --help                      Show this message and exit.
```


## cooler_makebins

### Tool Description
Generate fixed-width genomic bins.

  Output a genome segmentation at a fixed resolution as a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler makebins [OPTIONS] CHROMSIZES_PATH BINSIZE

  Generate fixed-width genomic bins.

  Output a genome segmentation at a fixed resolution as a BED file.

  CHROMSIZES_PATH : UCSC-like chromsizes file, with chromosomes in desired
  order.

  BINSIZE : Resolution (bin size) in base pairs <int>.

Options:
  -o, --out TEXT       Output file (defaults to stdout)
  -H, --header         Print the header of column names as the first row.
  -i, --rel-ids [0|1]  Include a column of relative bin IDs for each
                       chromosome. Choose whether to report them as 0- or
                       1-based.
  -h, --help           Show this message and exit.
```


## cooler_merge

### Tool Description
Merge multiple coolers with identical axes.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler merge [OPTIONS] OUT_PATH [IN_PATHS]...

  Merge multiple coolers with identical axes.

  OUT_PATH : Output file path or URI.

  IN_PATHS : Input file paths or URIs of coolers to merge.

  **Notes**

  Data columns merged:

      pixels/bin1_id, pixels/bin2_id, pixels/<value columns>

  Data columns preserved:

      chroms/name, chroms/length     bins/chrom, bins/start, bins/end

  Additional columns in the the input files are not transferred to the output.

Options:
  -c, --chunksize INTEGER  Size of the merge buffer in number of pixel table
                           rows.  [default: 20000000]
  --field TEXT             Specify the names of value columns to merge as
                           '<name>'. Repeat the `--field` option for each one.
                           Use '<name>,dtype=<dtype>' to specify the dtype.
                           Include ',agg=<agg>' to specify an aggregation
                           function different from 'sum'.
  -a, --append             Pass this flag to append the output cooler to an
                           existing file instead of overwriting the file.
  -h, --help               Show this message and exit.
```


## cooler_show

### Tool Description
Display and browse a cooler in matplotlib.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler show [OPTIONS] COOL_PATH RANGE

  Display and browse a cooler in matplotlib.

  COOL_PATH : Path to a COOL file or Cooler URI.

  RANGE : The coordinates of the genomic region to display, in UCSC notation.
  Example: chr1:10,000,000-11,000,000

Options:
  -r2, --range2 TEXT              The coordinates of a genomic region shown
                                  along the column dimension. If omitted, the
                                  column range is the same as the row range.
                                  Use to display asymmetric matrices or trans
                                  interactions.
  -b, --balanced                  Show the balanced contact matrix. If not
                                  provided, display the unbalanced counts.
  -o, --out TEXT                  Save the image of the contact matrix to a
                                  file. If not specified, the matrix is
                                  displayed in an interactive window. The
                                  figure format is deduced from the extension
                                  of the file, the supported formats are png,
                                  jpg, svg, pdf, ps and eps.
  --dpi INTEGER                   The DPI of the figure, if saving to a file
  -s, --scale [linear|log2|log10]
                                  Scale transformation of the colormap:
                                  linear, log2 or log10. Default is log10.
  -f, --force                     Force display very large matrices (>=10^8
                                  pixels). Use at your own risk as it may
                                  cause performance issues.
  --zmin FLOAT                    The minimal value of the color scale. Units
                                  must match those of the colormap scale. To
                                  provide a negative value use a equal sign
                                  and quotes, e.g. -zmin='-0.5'
  --zmax FLOAT                    The maximal value of the color scale. Units
                                  must match those of the colormap scale. To
                                  provide a negative value use a equal sign
                                  and quotes, e.g. -zmax='-0.5'
  --cmap TEXT                     The colormap used to display the contact
                                  matrix. See the full list at http://matplotl
                                  ib.org/examples/color/colormaps_reference.ht
                                  ml
  --field TEXT                    Pixel values to display.  [default: count]
  -h, --help                      Show this message and exit.
```


## cooler_zoomify

### Tool Description
Generate a multi-resolution cooler file by coarsening.

### Metadata
- **Docker Image**: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
- **Homepage**: https://github.com/open2c/cooler
- **Package**: https://anaconda.org/channels/bioconda/packages/cooler/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cooler zoomify [OPTIONS] COOL_PATH

  Generate a multi-resolution cooler file by coarsening.

  COOL_PATH : Path to a COOL file or Cooler URI.

Options:
  -n, -p, --nproc INTEGER  Number of processes to use for batch processing
                           chunks of pixels [default: 1, i.e. no process pool]
  -c, --chunksize INTEGER  Number of pixels allocated to each process
                           [default: 10000000]
  -r, --resolutions TEXT   Comma-separated list of target resolutions. Use
                           suffixes B or N to specify a progression: B for
                           binary (geometric steps of factor 2), N for nice
                           (geometric steps of factor 10 interleaved with
                           steps of 2 and 5). Examples:
                           1000B=1000,2000,4000,8000,...
                           1000N=1000,2000,5000,10000,...
                           5000N=5000,10000,25000,50000,... 4DN is an alias
                           for 1000,2000,5000N [default: B]
  --balance                Apply balancing to each zoom level. Off by default.
  --balance-args TEXT      Additional arguments to pass to cooler balance. To
                           deal with space ambiguity, use quotes to pass
                           multiple arguments, e.g. ``--balance-args '--nproc
                           8 --ignore-diags 3'``. Note that nproc for
                           balancing must be specified independently of
                           zoomify arguments.
  -i, --base-uri TEXT      One or more additional base coolers to aggregate
                           from, if needed.
  -o, --out TEXT           Output file or URI
  --field TEXT             Specify the names of value columns to merge as
                           '<name>'. Repeat the ``--field`` option for each
                           one. Use '<name>:dtype=<dtype>' to specify the
                           dtype. Include ',agg=<agg>' to specify an
                           aggregation function different from 'sum'.
  --legacy                 Use the legacy layout of integer-labeled zoom
                           levels.
  -h, --help               Show this message and exit.
```


## Metadata
- **Skill**: generated
