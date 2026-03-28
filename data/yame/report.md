# yame CWL Generation Report

## yame_pack

### Tool Description
Pack tab-delimited text into a compressed cx file.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Total Downloads**: 678
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/zhou-lab/YAME
- **Stars**: N/A
### Original Help Text
```text
Usage: yame pack [options] <in.txt> <out.cx>
Pack tab-delimited text into a compressed cx file.
The input file must have one row per CpG and match the
dimension and order of the reference CpG BED file.

Options:
    -f [char] Format specification (one of b,c,s,m,d,n,r):
              (b) Binary data (format 0).
                  Each entry is 0 or 1.
                  Example (single-sample, one column):
                      0
                      1
                      1

              (c) Character / small integer data (format 1).
                  One byte per entry, typically 0–255.
                  Example:
                      0
                      5
                      9

              (s) State data (format 2).
                  Categorical strings compressed via an index + RLE.
                  Best for chromatin states or other labels.
                  Example:
                      quies
                      quies
                      enhA

              (m) Sequencing MU data (format 3).
                  Input is 2-column text: M and U counts per CpG.
                  M=U=0 is treated as missing.
                  Example (M U):
                      10	5
                      20	0
                      13	17

              (d) Differential / mask data (format 6).
                  2-bit boolean for S (set) and U (universe).
                  Input is 2-column text: S and U, each 0 or 1.
                  Example (S U):
                      1	1
                      0	1
                      0	0

              (n) Fraction / beta data (format 4).
                  Floating-point fraction in [0,1] or NA.
                  Example:
                      0.250
                      NA
                      1.000

              (r) Reference coordinates (format 7).
                  Compressed BED records for CpG coordinates.
                  Input is 4-column BED: chrom, start, end, name.
                  Example:
                      chr1	100	101	CpG_1
                      chr1	200	201	CpG_2
                      chr1	300	301	CpG_3

              The examples above show single-sample input.
              Multi-sample input can be provided as additional
              columns per row, following the same conventions.

    -u [int]  Number of bytes per unit when inflated (1-8).
              Lower values are more memory efficient but may be lossier.
              0 - infer from data.
    -v        Verbose mode.
    -h        Display this help message.

Please supply input file.
```


## yame_unpack

### Tool Description
Print selected records from a .cx file as a tab-delimited table.
Each output row is a genomic row index; each output column is a selected sample/record.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  yame unpack [options] <in.cx> [sample1 sample2 ...]

Purpose:
  Print selected records from a .cx file as a tab-delimited table.
  Each output row is a genomic row index; each output column is a selected sample/record.

Sample selection (default: first record):
  -a            Output all records in the file.
  -l <list>     Sample list file (one name per line).
                Ignored if sample names are provided as trailing arguments.
  -H <N>        Output the first N samples.
  -T <N>        Output the last  N samples (requires index).

Row coordinates (optional first column):
  -R <rows.cx>  Row coordinate dataset (CX; typically format 7).
  -r <mode>     Coordinate print mode (default: 0):
                0: chrm<tab>beg0<tab>end1   (cg-style)
                1: chrm<tab>beg0<tab>end0   (allc-style)
                else: chrm_beg1

Output formatting:
  -C            Print a header line (column names).
  -u <bytes>    Inflated unit-size override (0=auto; allowed: 1,2,4,6,8).

Value printing (-f):
  -f <N>        Print mode for certain formats (default: 0):
                For format 3 (MU):
                  N == 0 : print packed MU (uint64)
                  N  < 0 : print M<tab>U (two columns)
                  N  > 0 : print beta; print NA if cov < N or cov==0
                For format 6 (set+universe):
                  N == 0 : print 0/1, NA coded as '2'
                  N  < 0 : print value<tab>universe  (e.g., 1<tab>1, 0<tab>1, NA<tab>0)
                  N  > 0 : print raw 2-bit code (FMT6_2BIT)

Chunked printing:
  -c            Enable chunked printing (reduces peak memory).
  -s <rows>     Chunk size in rows (default: 1000000).

Other:
  -h            Show this help message.

Notes:
  * Selecting by sample name or using -T requires an index (.cxi) unless reading from stdin.
  * Chunking does not support format 7 datasets.

Please supply input file.
```


## yame_hprint

### Tool Description
Print data transposed / horizontally.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yame hprint [options] <binary.cg>
Print data transposed / horizontally.

Options:
    -c         Coloring the output using ASCII-escape code.
    -h         This help

Please supply input file.
```


## yame_index

### Tool Description
The index file name default to <in.cx>.idx

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yame index [options] <in.cx>
The index file name default to <in.cx>.idx

Options:
    -s [file path]   tab-delimited sample name list (use first column) 
    -1 [sample name] add one sample to the end of the index
    -c               output index to console
    -h               This help

Please supply input file.
```


## yame_split

### Tool Description
Split a cx file into multiple files based on sample names.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yame split [options] <in.cx> out_prefix

Options:
    -v        verbose
    -s        sample name list
    -h        This help

Please supply input file.
```


## yame_info

### Tool Description
Report information about a YAME file.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yame info [options] <in.cx>

Options:
    -1        Report one record per file.
    -h        This help

Please supply input file.
```


## yame_subset

### Tool Description
Subset a multi-sample .cx by sample names (requires an index), or (with -s) convert a format-2 state track into one binary track per state.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  yame subset [options] <in.cx> [sample1 sample2 ...] > out.cx

Purpose:
  Subset a multi-sample .cx by sample names (requires an index), or
  (with -s) convert a format-2 state track into one binary track per state.

Modes:
  (A) Sample subsetting (default):
      Select named samples from <in.cx> and emit them in the given order.
      Requires <in.cx>.cxi index.

  (B) Subset format-2 states (-s):
      Interpret <in.cx> as a single format-2 dataset (must be fmt2).
      For each requested state name, emit one format-0 bitset where
      bit=1 iff row state == that term.

Input sample list:
  Provide sample names either:
    * as trailing arguments on the command line, OR
    * via -l <list.txt> (one name per line).

Options:
  -o <out.cx>  Write output to a file. If provided, an output index (.cxi)
              is also generated. If omitted, writes to stdout (no index).
  -l <list>    Path to sample/state list. Ignored if names are provided as
              trailing command-line arguments.
  -s           Format-2 state filtering mode (output format 0; one record per term).
  -H <N>       If no names are provided, take the first N samples from the input index.
  -T <N>       If no names are provided, take the last  N samples from the input index.
  -h           Show this help message.

Notes:
  * -H/-T only apply when you did NOT provide an explicit name list.
  * -T requires an index (same as default sample subsetting).
  * In -s mode, the input is expected to be a single fmt2 record; the output
    contains one fmt0 record per requested term/state.

Please supply input file and output file.
```


## yame_rowsub

### Tool Description
Subset (slice) rows from each dataset (record) in a CX stream. Output is always written to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  yame rowsub [options] <in.cx> > out.cx

Purpose:
  Subset (slice) rows from each dataset (record) in a CX stream.
  Output is always written to stdout.

Row selection modes (choose one):
  (A) Explicit row indices (1-based list):
      -l <idx.txt>     One [index1] per line (1-based). Order preserved; no sorting required.

  (B) Explicit genomic coordinates via row coordinate table (format 7):
      -R <rows.cx>     Row coordinate dataset (format 7; e.g. BED-like coordinates).
      -L <coord.txt>   One [chrm]_[beg1] per line (1-based beg). Requires -R.
                       Order preserved; no sorting required.
      -1               If -R is provided, emit the subsetted row coordinates as the FIRST dataset.

  (C) Mask-based filtering (binary mask):
      -m <mask.cx>     Mask file (format 0/1 only). Rows with bit=1 are kept.

  (D) Contiguous block by absolute row range (0-based):
      -B <beg0>[_<end1>]
         Keep rows in [beg0, end0] where end0 = end1-1.
         If <end1> is omitted, keep a single row at beg0.

  (E) Contiguous block by block index and size (0-based):
      -I <blockIndex0>[_<blockSize>]
         Keep rows:
           beg0 = blockIndex0 * blockSize
           end0 = (blockIndex0+1)*blockSize - 1
         If <blockSize> is omitted, default blockSize=1000000.

Other options:
  -h               Show this help message.

Index conventions:
  - '0' suffix means 0-based (beg0, blockIndex0).
  - '1' suffix means 1-based (index1, beg1, end1).
  - For -B, end is provided as end1 (exclusive, 1-based), internally converted to end0.

Notes:
  * For format 2 (state data), the key section is preserved when slicing.
  * Format 7 (row coordinates) is sliced with fmt7_* helpers.
  * If multiple selection options are given, the effective precedence is:
      -l/-L  >  -m  >  -B/-I  >  default.

Please supply input files.
```


## yame_chunk

### Tool Description
Chunk a .cx file into smaller pieces.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yame chunk [options] <in.cx> <outdir>

Options:
    -v        verbose
    -s        chunk size
    -h        This help

Please supply input file.
```


## yame_chunkchar

### Tool Description
Chunk a text file into characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yame chunkchar [options] <in.txt>

Options:
    -v        verbose
    -s        chunk size
    -h        This help

Please supply input file.
```


## yame_summary

### Tool Description
Summarize a query feature set (or per-state composition) and optionally its overlap/enrichment against one or more masks.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  yame summary [options] <query.cx> [query2.cx ...]

Purpose:
  Summarize a query feature set (or per-state composition) and optionally
  its overlap/enrichment against one or more masks.

Input:
  <query.cx> may contain one or multiple samples (records). Supported query
  formats: 0/1 (binary), 2 (state), 3 (MU counts), 4 (float),
           6 (set+universe), 7 (genomic coordinates).

Masking:
  -m <mask.cx>   Optional mask feature file (can be multi-sample).
                 If provided, every query sample is summarized against every
                 mask sample (cartesian product).
  -M             Load all masks into memory (faster when mask file is on slow IO).
                 Also auto-enabled when the mask stream is unseekable.

Naming / output formatting:
  -H             Suppress the header line.
  -F             Use full paths in QFile/MFile (default: basename only).
  -T             Always include section/state names in output labels when
                 summarizing format-2 (state) data.
  -s <list.txt>  Override query sample names using a plain-text list.
                 Only applies to the first query file.

Stdin helpers:
  -q <name>      Backup query file name used only when <query.cx> is '-'.

Other:
  -6             Treat format-6 query as 2bit quaternary than set/universe.
  -h             Show this help message.

Output columns:
  QFile  Query  MFile  Mask  N_univ  N_query  N_mask  N_overlap  Log2OddsRatio  Beta  Depth

Notes:
  * For state masks (format 2), summary is emitted per state key (one row per key).
  * When no mask is given, Mask is reported as 'global'.

Please supply input file.
```


## yame_pairwise

### Tool Description
Compute a per-site differential-methylation set between two format-3 (M/U) samples, and output it as a single format-6 track (set + universe).

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  yame pairwise [options] <MU1.cx> [MU2.cx] > out.cx

Purpose:
  Compute a per-site differential-methylation set between two format-3 (M/U) samples,
  and output it as a single format-6 track (set + universe).

Inputs:
  <MU1.cx>   Format-3 input (M/U counts). The first record is used as sample 1.
  [MU2.cx]   Optional second format-3 input. If omitted, sample 2 is read as the
            SECOND record from MU1.cx (i.e., the top 2 samples in the same file).

Output:
  One format-6 record of length N (same as the inputs).
  Universe: site i is in-universe only if BOTH samples have coverage >= min_cov.
  Set:      site i is set if it passes the direction rule (-H) and effect threshold (-d).

Options:
  -o <out.cx>  Write output to file (default: stdout).
  -c <cov>     Minimum coverage (M+U) in BOTH samples to include site in universe (default: 1).
  -d <delta>   Minimum absolute beta difference required to call a site differential (default: 0).
  -H <mode>    Direction mode (default: 1):
              1  beta1 > beta2  (hypermethylated in sample 1)
              2  beta1 < beta2  (hypomethylated  in sample 1)
              3  beta1 != beta2 (any difference; with -d uses |beta1-beta2|>delta)
  -h           Show this help message.

Notes:
  * If you omit MU2.cx, MU1.cx must contain at least two records.
  * The output is a binary set; it does not store the delta magnitude.

Please supply input file.
```


## yame_binarize

### Tool Description
Convert per-site M/U counts (format 3) into a packed binary-with-universe track (format 6).

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  yame binarize [options] <mu.cx>

Purpose:
  Convert per-site M/U counts (format 3) into a packed binary-with-universe
  track (format 6).

Input / Output:
  Input : format 3 (.cx) with per-site (M,U) stored as uint64.
  Output: format 6 (.cx), where each site stores two bits:
          - universe bit: 1 if depth>=min_cov, else 0 (NA/outside-universe)
          - set bit:      1 if methylated by rule, else 0

Binarization rules:
  Default: set=1 if beta > T (beta = M/(M+U)), set=0 otherwise.
  If -m is provided (>0): set=1 if M >= Mmin, else 0 (overrides -t).
  Universe is always defined by coverage: (M+U) >= min_cov.

Options:
  -t <Tmin>   Beta threshold (default: 0.5).
  -m <Mmin>   M-count threshold (default: 0; if >0 overrides -t).
  -c <cov>    Minimum coverage (M+U) to include a site in universe (default: 1).
  -o <out.cx> Write output to file (default: stdout).
  -h          Show this help message.

Notes:
  * Sites with depth < min_cov remain NA in format 6 (universe bit = 0).
  * If the input has a sample index and -o is used, an output index is written.

Please supply input file.
```


## yame_mask

### Tool Description
Masking tool for CG files

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yame mask [options] <in.cg> <mask.cx>

Options:
    -o        output cx file name. if missing, output to stdout without index.
    -c        contextualize to format 6 using '1's in mask.
              if format 3 is used as mask, then use M+U>0 (coverage).
    -v        reverse the mask (default is to mask '1's, if -v will mask '0's).
    -h        This help

Please supply input file.
```


## yame_dsample

### Tool Description
Downsample methylation data for format 3 or 6.
  - For format 3, downsampling masks by setting M=U=0.
  - For format 6, downsampling masks by clearing the universe bit.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: yame dsample [options] <in.cx> [out.cx]

Downsample methylation data for format 3 or 6.
  - For format 3, downsampling masks by setting M=U=0.
  - For format 6, downsampling masks by clearing the universe bit.

Options:
    -o [PATH] output .cx file name.
              If missing, write to stdout (no index will be written).
    -s [int]  seed for random sampling (default: current time).
    -b        After sampling, randomly binarize sampled format 3 (MU)
              rows. Output is still format 3.
    -N [int]  number of records to sample/keep per sample (default: 100).
              If N >= available records, all available records are kept.
    -r [int]  number of downsampled replicates per input sample (default: 1).
              Each replicate is independently re-sampled.
    -p [str]  replicate sample name prefix [default: None].
              If given, the out sample name is: [sname]-[pre]-[rep_id].
    -h        this help.

Please supply input file.
```


## yame_rowop

### Tool Description
Perform row-wise operations across multiple records (samples) in a CX file.
  Depending on the operation, output is either a new CX file or plain text.

### Metadata
- **Docker Image**: quay.io/biocontainers/yame:1.8--ha83d96e_0
- **Homepage**: https://github.com/zhou-lab/YAME
- **Package**: https://anaconda.org/channels/bioconda/packages/yame/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  yame rowop [options] <in.cx> [out]

Purpose:
  Perform row-wise operations across multiple records (samples) in a CX file.
  Depending on the operation, output is either a new CX file or plain text.

Operation:
  -o <op>      Operation name (default: binasum)

CX-output operations:
  binasum      Convert per-sample values into per-row sample counts (M/U) as format 3.
              Input: fmt0, fmt1, or fmt3.
              For fmt3, beta thresholds (-p/-q) define methylated vs unmethylated calls.

  musum        Sum MU sequencing counts across samples.
              Input: fmt3 only. Output: one fmt3 record.

Text-output operations:
  stat         Per-row summary statistics across samples.
              Input: fmt3 only.
              Output columns:
                count  mean_beta  sd_beta  delta_beta  min_n
              delta_beta = min(beta>0.5) - max(beta<0.5).
              min_n      = min(#beta<0.5, #beta>0.5).

  binstring    Convert per-sample beta values into row-wise binary strings.
              Input: fmt3 only. Uses -b as the beta threshold.

  cometh       Neighbor co-methylation summary within a window.
              Input: fmt3 only.
              Output: packed 4-way counts (UU, UM, MU, MM) per neighbor offset.
              Use -v to print unpacked lanes.

Common filters:
  -c <mincov>  Minimum coverage (M+U) for a sample/row to contribute (default: 1).

binasum (fmt3 input) thresholds:
  -p <beta0>   Call unmethylated if beta < beta0 (default: 0.4).
  -q <beta1>   Call methylated   if beta > beta1 (default: 0.6).
              Betas in [beta0, beta1] are ignored.

binstring threshold:
  -b <beta>    Call methylated if beta > threshold (default: 0.5).
  -s [int]     Seed for tie breaking (default: current time).

cometh options:
  -w <W>       Neighbor window size (default: 5).
  -v           Verbose output (print UU-UM-MU-MM instead of packed uint64).

Other:
  -h           Show this help message.

Please supply input file.
```


## Metadata
- **Skill**: generated
