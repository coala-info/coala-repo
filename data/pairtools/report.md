# pairtools CWL Generation Report

## pairtools_dedup

### Tool Description
Find and remove PCR/optical duplicates.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Total Downloads**: 59.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mirnylab/pairtools
- **Stars**: N/A
### Original Help Text
```text
Usage: pairtools dedup [OPTIONS] [PAIRS_PATH]

  Find and remove PCR/optical duplicates.

  Find PCR/optical duplicates in an upper-triangular flipped sorted
  pairs/pairsam file. Allow for a +/-N bp mismatch at each side of duplicated
  molecules.

  PAIRS_PATH : input triu-flipped sorted .pairs or .pairsam file.  If the path
  ends with .gz/.lz4, the input is decompressed by bgzip/lz4c. By default, the
  input is read from stdin.

Options:
  -o, --output TEXT               output file for pairs after duplicate
                                  removal. If the path ends with .gz or .lz4,
                                  the output is bgzip-/lz4c-compressed. By
                                  default, the output is printed into stdout.
  --output-dups TEXT              output file for duplicated pairs.  If the
                                  path ends with .gz or .lz4, the output is
                                  bgzip-/lz4c-compressed. If the path is the
                                  same as in --output or -, output duplicates
                                  together  with deduped pairs. By default,
                                  duplicates are dropped.
  --output-unmapped TEXT          output file for unmapped pairs. If the path
                                  ends with .gz or .lz4, the output is
                                  bgzip-/lz4c-compressed. If the path is the
                                  same as in --output or -, output unmapped
                                  pairs together with deduped pairs. If the
                                  path is the same as --output-dups, output
                                  unmapped reads together with dups. By
                                  default, unmapped pairs are dropped.
  --output-stats TEXT             output file for duplicate statistics. If
                                  file exists, it will be open in the append
                                  mode. If the path ends with .gz or .lz4, the
                                  output is bgzip-/lz4c-compressed. By
                                  default, statistics are not printed.
  --output-bytile-stats TEXT      output file for duplicate statistics. Note
                                  that the readID should be provided and
                                  contain tile information for this option.
                                  This analysis is possible when pairtools is
                                  run on a dataset with original Illumina-
                                  generated read IDs,  because SRA does not
                                  store original read IDs from the sequencer.
                                  By default, by-tile duplicate statistics are
                                  not printed.  If file exists, it will be
                                  open in the append mode.  If the path ends
                                  with .gz or .lz4, the output is
                                  bgzip-/lz4c-compressed.
  --max-mismatch INTEGER          Pairs with both sides mapped within this
                                  distance (bp) from each other are considered
                                  duplicates. [dedup option]  [default: 3]
  --method [max|sum]              define the mismatch as either the max or the
                                  sum of the mismatches ofthe genomic
                                  locations of the both sides of the two
                                  compared molecules. [dedup option]
                                  [default: max]
  --backend [scipy|sklearn|cython]
                                  What backend to use: scipy and sklearn are
                                  based on KD-trees, cython is online indexed
                                  list-based algorithm. With cython backend,
                                  duplication is not transitive with non-zero
                                  max mismatch  (e.g. pairs A and B are
                                  duplicates, and B and C are duplicates, then
                                  A and C are  not necessary duplicates of
                                  each other), while with scipy and sklearn
                                  it's  transitive (i.e. A and C are
                                  necessarily duplicates). Cython is the
                                  original version used in pairtools since its
                                  beginning. It is available for backwards
                                  compatibility and to allow specification of
                                  the column order. Now the default scipy
                                  backend is generally the fastest, and with
                                  chunksize below 1 mln has the lowest memory
                                  requirements. [dedup option]
  --chunksize INTEGER             Number of pairs in each chunk. Reduce for
                                  lower memory footprint. Below 10,000
                                  performance starts suffering significantly
                                  and the algorithm might miss a few
                                  duplicates with non-zero --max-mismatch.
                                  Only works with '--backend scipy or
                                  sklearn'. [dedup option]  [default: 10000]
  --carryover INTEGER             Number of deduped pairs to carry over from
                                  previous chunk to the new chunk to avoid
                                  breaking duplicate clusters. Only works with
                                  '--backend scipy or sklearn'. [dedup option]
                                  [default: 100]
  -p, --n-proc INTEGER            Number of cores to use. Only applies with
                                  sklearn backend.Still needs testing whether
                                  it is ever useful. [dedup option]
  --mark-dups / --no-mark-dups    Specify if duplicate pairs should be marked
                                  as DD in "pair_type" and as a duplicate in
                                  the sam entries. True by default. [output
                                  format option]
  --keep-parent-id                If specified, duplicate pairs are marked
                                  with the readID of the retained deduped read
                                  in the 'parent_readID' field. [output format
                                  option]
  --extra-col-pair TEXT...        Extra columns that also must match for two
                                  pairs to be marked as duplicates. Can be
                                  either provided as 0-based column indices or
                                  as column names (requires the "#columns"
                                  header field). The option can be provided
                                  multiple times if multiple column pairs must
                                  match. Example: --extra-col-pair "phase1"
                                  "phase2". [output format option]
  --sep TEXT                      Separator (\t, \v, etc. characters are
                                  supported, pass them in quotes). [input
                                  format option]
  --send-header-to [dups|dedup|both|none]
                                  Which of the outputs should receive header
                                  and comment lines. [input format option]
  --c1 TEXT                       Chrom 1 column; default chrom1[input format
                                  option]
  --c2 TEXT                       Chrom 2 column; default chrom2[input format
                                  option]
  --p1 TEXT                       Position 1 column; default pos1[input format
                                  option]
  --p2 TEXT                       Position 2 column; default pos2[input format
                                  option]
  --s1 TEXT                       Strand 1 column; default strand1[input
                                  format option]
  --s2 TEXT                       Strand 2 column; default strand2[input
                                  format option]
  --unmapped-chrom TEXT           Placeholder for a chromosome on an unmapped
                                  side; default !
  --yaml / --no-yaml              Output stats in yaml format instead of
                                  table. [output stats format option]
  --filter TEXT                   Filter stats with condition to apply to the
                                  data (similar to `pairtools select` or
                                  `pairtools stats`). For non-YAML output only
                                  the first filter will be reported. [output
                                  stats filtering option] Note that this will
                                  not change the deduplicated output pairs.
                                  Example: pairtools dedup --yaml --filter
                                  'unique:(pair_type=="UU")' --filter
                                  'close:(pair_type=="UU") and
                                  (abs(pos1-pos2)<10)' --output-stats -
                                  test.pairs
  --engine TEXT                   Engine for regular expression parsing for
                                  stats filtering. Python will provide you
                                  regex functionality, while pandas does not
                                  accept custom funtctions and works faster.
                                  [output stats filtering option]
  --chrom-subset TEXT             A path to a chromosomes file (tab-separated,
                                  1st column contains chromosome names)
                                  containing a chromosome subset of interest
                                  for stats filter. If provided, additionally
                                  filter pairs with both sides originating
                                  from the provided subset of chromosomes.
                                  This operation modifies the #chromosomes:
                                  and #chromsize: header fields accordingly.
                                  Note that this will not change the
                                  deduplicated output pairs. [output stats
                                  filtering option]
  --startup-code TEXT             An auxiliary code to execute before
                                  filteringfor stats. Use to define functions
                                  that can be evaluated in the CONDITION
                                  statement. [output stats filtering option]
  -t, --type-cast <TEXT TEXT>...  Cast a given column to a given type for
                                  stats filtering. By default, only pos and
                                  mapq are cast to int, other columns are kept
                                  as str. Provide as -t <column_name> <type>,
                                  e.g. -t read_len1 int. Multiple entries are
                                  allowed. [output stats filtering option]
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.
```


## pairtools_filterbycov

### Tool Description
Remove pairs from regions of high coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools filterbycov [OPTIONS] [PAIRS_PATH]

  Remove pairs from regions of high coverage.

  Find and remove pairs with >(MAX_COV-1) neighbouring pairs within a +/-
  MAX_DIST bp window around either side. Useful for single-cell Hi-C
  experiments, where coverage is naturally limited by the chromosome copy
  number.

  PAIRS_PATH : input triu-flipped sorted .pairs or .pairsam file.  If the path
  ends with .gz/.lz4, the input is decompressed by bgzip/lz4c. By default, the
  input is read from stdin.

Options:
  -o, --output TEXT               output file for pairs from low coverage
                                  regions. If the path ends with .gz or .lz4,
                                  the output is bgzip-/lz4c-compressed. By
                                  default, the output is printed into stdout.
  --output-highcov TEXT           output file for pairs from high coverage
                                  regions. If the path ends with .gz or .lz4,
                                  the output is bgzip-/lz4c-compressed. If the
                                  path is the same as in --output or -, output
                                  duplicates together  with deduped pairs. By
                                  default, duplicates are dropped.
  --output-unmapped TEXT          output file for unmapped pairs. If the path
                                  ends with .gz or .lz4, the output is
                                  bgzip-/lz4c-compressed. If the path is the
                                  same as in --output or -, output unmapped
                                  pairs together with deduped pairs. If the
                                  path is the same as --output-highcov, output
                                  unmapped reads together. By default,
                                  unmapped pairs are dropped.
  --output-stats TEXT             output file for statistics of multiple
                                  interactors.  If file exists, it will be
                                  open in the append mode. If the path ends
                                  with .gz or .lz4, the output is
                                  bgzip-/lz4c-compressed. By default,
                                  statistics are not printed.
  --max-cov INTEGER               The maximum allowed coverage per region.
  --max-dist INTEGER              The resolution for calculating coverage. For
                                  each pair, the local coverage around each
                                  end is calculated as (1 + the number of
                                  neighbouring pairs within +/- max_dist bp)
  --method [max|sum]              calculate the number of neighbouring pairs
                                  as either the sum or the max of the number
                                  of neighbours on the two sides  [default:
                                  max]
  --sep TEXT                      Separator (\t, \v, etc. characters are
                                  supported, pass them in quotes)
  --comment-char TEXT             The first character of comment lines
  --send-header-to [lowcov|highcov|both|none]
                                  Which of the outputs should receive header
                                  and comment lines
  --c1 INTEGER                    Chrom 1 column; default 1
  --c2 INTEGER                    Chrom 2 column; default 3
  --p1 INTEGER                    Position 1 column; default 2
  --p2 INTEGER                    Position 2 column; default 4
  --s1 INTEGER                    Strand 1 column; default 5
  --s2 INTEGER                    Strand 2 column; default 6
  --unmapped-chrom TEXT           Placeholder for a chromosome on an unmapped
                                  side; default !
  --mark-multi                    If specified, duplicate pairs are marked as
                                  FF in "pair_type" and as a duplicate in the
                                  sam entries.
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.
```


## pairtools_flip

### Tool Description
Flip pairs to get an upper-triangular matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools flip [OPTIONS] [PAIRS_PATH]

  Flip pairs to get an upper-triangular matrix.

  Change the order of side1 and side2 in pairs, such that (order(chrom1) <
  order(chrom2)  or (order(chrom1) == order(chrom2)) and (pos1 <=pos2))
  Equivalent to reflecting the lower triangle of a Hi-C matrix onto its upper
  triangle, resulting in an upper triangular matrix. The order of chromosomes
  must be provided via a .chromsizes file.

  PAIRS_PATH : input .pairs/.pairsam file. If the path ends with .gz or .lz4,
  the input is decompressed by bgzip/lz4c. By default, the input is read from
  stdin.

Options:
  -c, --chroms-path TEXT  Chromosome order used to flip interchromosomal
                          mates: path to a chromosomes file (e.g. UCSC
                          chrom.sizes or similar) whose first column lists
                          scaffold names. Any scaffolds not listed will be
                          ordered lexicographically following the names
                          provided.  [required]
  -o, --output TEXT       output file. If the path ends with .gz or .lz4, the
                          output is bgzip-/lz4c-compressed. By default, the
                          output is printed into stdout.
  --nproc-in INTEGER      Number of processes used by the auto-guessed input
                          decompressing command.  [default: 3]
  --nproc-out INTEGER     Number of processes used by the auto-guessed output
                          compressing command.  [default: 8]
  --cmd-in TEXT           A command to decompress the input file. If provided,
                          fully overrides the auto-guessed command. Does not
                          work with stdin and pairtools parse. Must read input
                          from stdin and print output into stdout. EXAMPLE:
                          pbgzip -dc -n 3
  --cmd-out TEXT          A command to compress the output file. If provided,
                          fully overrides the auto-guessed command. Does not
                          work with stdout. Must read input from stdin and
                          print output into stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help              Show this message and exit.
```


## pairtools_header

### Tool Description
Manipulate the .pairs/.pairsam header

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools header [OPTIONS] COMMAND [ARGS]...

  Manipulate the .pairs/.pairsam header

Options:
  -h, --help  Show this message and exit.

Commands:
  generate          Generate the header
  set-columns       Add the columns to the .pairs/pairsam file
  transfer          Transfer the header from one pairs file to another
  validate-columns  Validate the columns of the .pairs/pairsam file...
```


## pairtools_markasdup

### Tool Description
Tag all pairs in the input file as duplicates.

  Change the type of all pairs inside a .pairs/.pairsam file to DD. If sam
  entries are present, change the pair type in the Yt SAM tag to 'Yt:Z:DD'.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools markasdup [OPTIONS] [PAIRSAM_PATH]

  Tag all pairs in the input file as duplicates.

  Change the type of all pairs inside a .pairs/.pairsam file to DD. If sam
  entries are present, change the pair type in the Yt SAM tag to 'Yt:Z:DD'.

  PAIRSAM_PATH : input .pairs/.pairsam file. If the path ends with .gz, the
  input is gzip-decompressed. By default, the input is read from stdin.

Options:
  -o, --output TEXT    output .pairsam file. If the path ends with .gz or
                       .lz4, the output is bgzip-/lz4c-compressed. By default,
                       the output is printed into stdout.
  --nproc-in INTEGER   Number of processes used by the auto-guessed input
                       decompressing command.  [default: 3]
  --nproc-out INTEGER  Number of processes used by the auto-guessed output
                       compressing command.  [default: 8]
  --cmd-in TEXT        A command to decompress the input file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdin and pairtools parse. Must read input from
                       stdin and print output into stdout. EXAMPLE: pbgzip -dc
                       -n 3
  --cmd-out TEXT       A command to compress the output file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdout. Must read input from stdin and print
                       output into stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help           Show this message and exit.
```


## pairtools_merge

### Tool Description
Merge .pairs/.pairsam files. By default, assumes that the files are sorted and maintains the sorting.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools merge [OPTIONS] [PAIRS_PATH]...

  Merge .pairs/.pairsam files. By default, assumes that the files are sorted
  and maintains the sorting.

  Merge triu-flipped sorted pairs/pairsam files. If present, the @SQ records
  of the SAM header must be identical; the sorting order of these lines is
  taken from the first file in the list. The ID fields of the @PG records of
  the SAM header are modified with a numeric suffix to produce unique records.
  The other unique SAM and non-SAM header lines are copied into the output
  header.

  PAIRS_PATH : upper-triangular flipped sorted .pairs/.pairsam files to merge
  or a group/groups of .pairs/.pairsam files specified by a wildcard. For
  paths ending in .gz/.lz4, the files are decompressed by bgzip/lz4c.

Options:
  -o, --output TEXT               output file. If the path ends with .gz/.lz4,
                                  the output is compressed by bgzip/lz4c. By
                                  default, the output is printed into stdout.
  --max-nmerge INTEGER            The maximal number of inputs merged at once.
                                  For more, store merged intermediates in
                                  temporary files.  [default: 8]
  --tmpdir TEXT                   Custom temporary folder for merged
                                  intermediates.
  --memory TEXT                   The amount of memory used by default.
                                  [default: 2G]
  --compress-program TEXT         A binary to compress temporary merged
                                  chunks. Must decompress input when the flag
                                  -d is provided. Suggested alternatives:
                                  lz4c, gzip, lzop, snzip. NOTE: fails
                                  silently if the command syntax is wrong.
                                  [default: ""]
  --nproc INTEGER                 Number of threads for merging.  [default: 8]
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 1]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin. Must read
                                  input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  --keep-first-header / --no-keep-first-header
                                  Keep the first header or merge the headers
                                  together. Default: merge headers.  [default:
                                  no-keep-first-header]
  --concatenate / --no-concatenate
                                  Simple concatenate instead of merging sorted
                                  files.  [default: no-concatenate]
  -h, --help                      Show this message and exit.
```


## pairtools_parse

### Tool Description
Find ligation pairs in .sam data, make .pairs. SAM_PATH : an input .sam/.bam file with paired-end sequence alignments of Hi-C molecules. If the path ends with .bam, the input is decompressed from bam with samtools. By default, the input is read from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools parse [OPTIONS] [SAM_PATH]

  Find ligation pairs in .sam data, make .pairs. SAM_PATH : an input .sam/.bam
  file with paired-end sequence alignments of Hi-C molecules. If the path ends
  with .bam, the input is decompressed from bam with samtools. By default, the
  input is read from stdin.

Options:
  -c, --chroms-path TEXT          Chromosome order used to flip
                                  interchromosomal mates: path to a
                                  chromosomes file (e.g. UCSC chrom.sizes or
                                  similar) whose first column lists scaffold
                                  names. Any scaffolds not listed will be
                                  ordered lexicographically following the
                                  names provided.  [required]
  -o, --output TEXT               output file.  If the path ends with .gz or
                                  .lz4, the output is bgzip-/lz4-compressed.By
                                  default, the output is printed into stdout.
  --assembly TEXT                 Name of genome assembly (e.g. hg19, mm10) to
                                  store in the pairs header.
  --min-mapq INTEGER              The minimal MAPQ score to consider a read as
                                  uniquely mapped  [default: 1]
  --max-molecule-size INTEGER     The maximal size of a Hi-C molecule; used to
                                  rescue single ligations(from molecules with
                                  three alignments) and to rescue complex
                                  ligations.The default is based on oriented
                                  P(s) at short ranges of multiple Hi-C.Not
                                  used with walks-policy all.  [default: 750]
  --drop-readid                   If specified, do not add read ids to the
                                  output
  --drop-seq                      If specified, remove sequences and PHREDs
                                  from the sam fields
  --drop-sam                      If specified, do not add sams to the output
  --add-pair-index                If specified, each pair will have pair index
                                  in the molecule
  --add-columns TEXT              Report extra columns describing alignments
                                  Possible values (can take multiple values as
                                  a comma-separated list): a SAM tag (any pair
                                  of uppercase letters) or mapq, pos5, pos3,
                                  cigar, read_len, matched_bp, algn_ref_span,
                                  algn_read_span, dist_to_5, dist_to_3, seq,
                                  mismatches, read_side, algn_idx,
                                  same_side_algn_count.
  --output-parsed-alignments TEXT
                                  output file for all parsed alignments,
                                  including walks. Useful for debugging and
                                  rnalysis of walks. If file exists, it will
                                  be open in the append mode. If the path ends
                                  with .gz or .lz4, the output is
                                  bgzip-/lz4-compressed. By default, not used.
  --output-stats TEXT             output file for various statistics of pairs
                                  file.  By default, statistics is not
                                  generated.
  --report-alignment-end [5|3]    specifies whether the 5' or 3' end of the
                                  alignment is reported as the position of the
                                  Hi-C read.
  --max-inter-align-gap INTEGER   read segments that are not covered by any
                                  alignment and longer than the specified
                                  value are treated as "null" alignments.
                                  These null alignments convert otherwise
                                  linear alignments into walks, and affect how
                                  they get reported as a Hi-C pair (see
                                  --walks-policy).  [default: 20]
  --walks-policy [mask|5any|5unique|3any|3unique|all]
                                  the policy for reporting unrescuable walks
                                  (reads containing more than one alignment on
                                  one or both sides, that can not be explained
                                  by a single ligation between two mappable
                                  DNA fragments). "mask" - mask walks
                                  (chrom="!", pos=0, strand="-");  "5any" -
                                  report the 5'-most alignment on each side;
                                  "5unique" - report the 5'-most unique
                                  alignment on each side, if present; "3any" -
                                  report the 3'-most alignment on each side;
                                  "3unique" - report the 3'-most unique
                                  alignment on each side, if present; "all" -
                                  report all available unique alignments on
                                  each side.  [default: 5unique]
  --readid-transform TEXT         A Python expression to modify read IDs.
                                  Useful when read IDs differ between the two
                                  reads of a pair. Must be a valid Python
                                  expression that uses variables called readID
                                  and/or i (the 0-based index of the read pair
                                  in the bam file) and returns a new value,
                                  e.g. "readID[:-2]+'_'+str(i)". Make sure
                                  that transformed readIDs remain unique!
  --flip / --no-flip              If specified, do not flip pairs in genomic
                                  order and instead preserve the order in
                                  which they were sequenced.
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.
```


## pairtools_parse2

### Tool Description
Extracts pairs from .sam/.bam data with complex walks, make .pairs. SAM_PATH : an input .sam/.bam file with paired-end or single-end sequence alignments of Hi-C (or Hi-C-like) molecules. If the path ends with .bam, the input is decompressed from bam with samtools. By default, the input is read from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools parse2 [OPTIONS] [SAM_PATH]

  Extracts pairs from .sam/.bam data with complex walks, make .pairs. SAM_PATH
  : an input .sam/.bam file with paired-end or single-end sequence alignments
  of Hi-C (or Hi-C-like) molecules. If the path ends with .bam, the input is
  decompressed from bam with samtools. By default, the input is read from
  stdin.

Options:
  -c, --chroms-path TEXT          Chromosome order used to flip
                                  interchromosomal mates: path to a
                                  chromosomes file (e.g. UCSC chrom.sizes or
                                  similar) whose first column lists scaffold
                                  names. Any scaffolds not listed will be
                                  ordered lexicographically following the
                                  names provided.  [required]
  -o, --output TEXT               output file with pairs.  If the path ends
                                  with .gz or .lz4, the output is
                                  bgzip-/lz4-compressed.By default, the output
                                  is printed into stdout.
  --report-position [junction|read|walk|outer]
                                  Reported position of alignments in pairs of
                                  complex walks (pos columns).  Each alignment
                                  in .bam/.sam Hi-C-like data has two ends,
                                  and you can report one or another depending
                                  of the position of alignment on a read or in
                                  a pair.
                                  
                                  "junction" - inner ends of sequential
                                  alignments in each pair, aka ligation
                                  junctions, "read" - 5'-end of alignments
                                  relative to R1 or R2 read coordinate system
                                  (as in traditional Hi-C), "walk" - 5'-end of
                                  alignments relative to the whole walk
                                  coordinate system, "outer" - outer ends of
                                  sequential alignments in each pair (parse2
                                  default).
  --report-orientation [pair|read|walk|junction]
                                  Reported orientataion of pairs in complex
                                  walk (strand columns). Each alignment in
                                  .bam/.sam Hi-C-like data has orientation,
                                  and you can report it relative to the read,
                                  pair or whole walk coordinate system.
                                  
                                  "pair" - orientation as if each pair in
                                  complex walk was sequenced independently
                                  from the outer ends or molecule (as in
                                  traditional Hi-C, also complex walks
                                  default), "read" - orientation defined by
                                  the read (R1 or R2 read coordinate system),
                                  "walk" - orientation defined by the walk
                                  coordinate system, "junction" - reversed
                                  "pair" orientation, as if pair was sequenced
                                  in both directions starting from the
                                  junction
  --assembly TEXT                 Name of genome assembly (e.g. hg19, mm10) to
                                  store in the pairs header.
  --min-mapq INTEGER              The minimal MAPQ score to consider a read as
                                  uniquely mapped.  [default: 1]
  --max-inter-align-gap INTEGER   Read segments that are not covered by any
                                  alignment and longer than the specified
                                  value are treated as "null" alignments.
                                  These null alignments convert otherwise
                                  linear alignments into walks, and affect how
                                  they get reported as a Hi-C pair.  [default:
                                  20]
  --max-insert-size INTEGER       When searching for overlapping ends of left
                                  and right read (R1 and R2), this sets the
                                  minimal distance when two alignments on the
                                  same strand and chromosome are considered
                                  part of the same fragment (and thus reported
                                  as the same alignment and not a pair). For
                                  traditional Hi-C with long restriction
                                  fragments and shorter molecules after
                                  ligation+sonication, this can be the
                                  expected molecule size. For complex walks
                                  with short restriction fragments, this can
                                  be the expected restriction fragment size.
                                  Note that unsequenced insert is *terra
                                  incognita* and might contain unsequenced DNA
                                  (including ligations) in it. This parameter
                                  is ignored in --single-end mode.   [default:
                                  500]
  --dedup-max-mismatch INTEGER    Allowed mismatch between intramolecular
                                  alignments to detect readthrough duplicates.
                                  Pairs with both sides mapped within this
                                  distance (bp) from each other are considered
                                  duplicates.   [default: 3]
  --single-end                    If specified, the input is single-end. Never
                                  use this for paired-end data, because R1
                                  read will be omitted. If single-end data is
                                  provided, but parameter is unset, the pairs
                                  will be generated, but may contain
                                  artificial UN pairs.
  --expand / --no-expand          If specified, perform combinatorial
                                  expansion on the pairs. Combinatorial
                                  expansion is a way to increase the number of
                                  contacts in you data, assuming that all DNA
                                  fragments in the same molecule (read) are in
                                  contact. Expanded pairs have modified pair
                                  type, 'E{separation}_{pair type}'
  --max-expansion-depth INTEGER   Works in combination with --expand. Maximum
                                  number of segments separating pair. By
                                  default, expanding all possible
                                  pairs.Setting the number will limit the
                                  expansion depth and enforce contacts from
                                  the same side of the read.
  --add-pair-index                If specified, parse2 will report pair index
                                  in the walk as additional columns (R1, R2,
                                  R1&R2 or R1-R2). See documentation: https://
                                  pairtools.readthedocs.io/en/latest/parsing.h
                                  tml#rescuing-complex-walks For combinatorial
                                  expanded pairs, two numbers will be
                                  reported: original pair index of the left
                                  and right segments.
  --flip / --no-flip              If specified, flip pairs in genomic order
                                  and instead preserve the order in which they
                                  were sequenced. Note that no flip is
                                  recommended for analysis of walks because it
                                  will override the order of alignments in
                                  pairs. Flip is required for appropriate
                                  deduplication of sorted pairs. Flip is not
                                  required for cooler cload, which runs
                                  flipping internally.
  --add-columns TEXT              Report extra columns describing alignments
                                  Possible values (can take multiple values as
                                  a comma-separated list): a SAM tag (any pair
                                  of uppercase letters) or mapq, pos5, pos3,
                                  cigar, read_len, matched_bp, algn_ref_span,
                                  algn_read_span, dist_to_5, dist_to_3, seq,
                                  mismatches, read_side, algn_idx,
                                  same_side_algn_count.
  --drop-readid / --keep-readid   If specified, do not add read ids to the
                                  output. By default, keep read ids. Useful
                                  for long walks analysis.
  --readid-transform TEXT         A Python expression to modify read IDs.
                                  Useful when read IDs differ between the two
                                  reads of a pair. Must be a valid Python
                                  expression that uses variables called readID
                                  and/or i (the 0-based index of the read pair
                                  in the bam file) and returns a new value,
                                  e.g. "readID[:-2]+'_'+str(i)". Make sure
                                  that transformed readIDs remain unique!
  --drop-seq / --keep-seq         Remove sequences and PHREDs from the sam
                                  fields by default. Kept otherwise.
  --drop-sam / --keep-sam         Do not add sams to the output by default.
                                  Kept otherwise.
  --output-parsed-alignments TEXT
                                  output file with all parsed alignments (one
                                  alignment per line). Useful for debugging
                                  and analysis of walks. If file exists, it
                                  will be open in the append mode. If the path
                                  ends with .gz or .lz4, the output is
                                  bgzip-/lz4-compressed. By default, not used.
  --output-stats TEXT             output file for various statistics of pairs
                                  file.  By default, statistics is not
                                  generated.
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.
```


## pairtools_phase

### Tool Description
Phase pairs mapped to a diploid genome. Diploid genome is the genome with
two set of the chromosome variants, where each chromosome has one of two
suffixes (phase-suffixes) corresponding to the genome version (phase-
suffixes).

By default, phasing adds two additional columns with phase 0, 1 or "."
(unpahsed).

Phasing is based on detection of chromosome origin of each mapped fragment.
Three scores are considered: best alignment score (S1), suboptimal alignment
(S2) and second suboptimal alignment (S3) scores. Each fragment can be: 1)
uniquely mapped and phased (S1>S2>S3, first alignment is the best hit), 2)
uniquely mapped but unphased (S1=S2>S3, cannot distinguish between
chromosome variants), 3) multiply mapped (S1=S2=S3) or unmapped.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools phase [OPTIONS] [PAIRS_PATH]

  Phase pairs mapped to a diploid genome. Diploid genome is the genome with
  two set of the chromosome variants, where each chromosome has one of two
  suffixes (phase-suffixes) corresponding to the genome version (phase-
  suffixes).

  By default, phasing adds two additional columns with phase 0, 1 or "."
  (unpahsed).

  Phasing is based on detection of chromosome origin of each mapped fragment.
  Three scores are considered: best alignment score (S1), suboptimal alignment
  (S2) and second suboptimal alignment (S3) scores. Each fragment can be: 1)
  uniquely mapped and phased (S1>S2>S3, first alignment is the best hit), 2)
  uniquely mapped but unphased (S1=S2>S3, cannot distinguish between
  chromosome variants), 3) multiply mapped (S1=S2=S3) or unmapped.

  PAIRS_PATH : input .pairs/.pairsam file. If the path ends with .gz or .lz4,
  the input is decompressed by bgzip/lz4c. By default, the input is read from
  stdin.

Options:
  -o, --output TEXT               output file. If the path ends with .gz or
                                  .lz4, the output is bgzip-/lz4c-compressed.
                                  By default, the output is printed into
                                  stdout.
  --phase-suffixes TEXT...        Phase suffixes (of the chrom names), always
                                  a pair.
  --clean-output                  Drop all columns besides the standard ones
                                  and phase1/2
  --tag-mode [XB|XA]              Specifies the mode of bwa reporting. XA will
                                  parse 'XA', the input should be generated
                                  with: --add-columns XA,NM,AS,XS --min-mapq 0
                                  XB will parse 'XB' tag, the input should be
                                  generated with: --add-columns XB,AS,XS
                                  --min-mapq 0  Note that XB tag is added by
                                  running bwa with -u tag, present in github
                                  version.  Both modes report similar results:
                                  XB reports 0.002% contacts more for phased
                                  data,  while XA can report ~1-2% more
                                  unphased contacts because its definition
                                  multiple mappers is more premissive.
  --report-scores / --no-report-scores
                                  Report scores of optional, suboptimal and
                                  second suboptimal alignments. NM (edit
                                  distance) with --tag-mode XA and AS (alfn
                                  score) with --tag-mode XB
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.
```


## pairtools_restrict

### Tool Description
Assign restriction fragments to pairs.

Identify the restriction fragments that got ligated into a Hi-C molecule.

Note: rfrags are 0-indexed

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools restrict [OPTIONS] [PAIRS_PATH]

  Assign restriction fragments to pairs.

  Identify the restriction fragments that got ligated into a Hi-C molecule.

  Note: rfrags are 0-indexed

  PAIRS_PATH : input .pairs/.pairsam file. If the path ends with .gz/.lz4, the
  input is decompressed by bgzip/lz4c. By default, the input is read from
  stdin.

Options:
  -f, --frags TEXT     a tab-separated BED file with the positions of
                       restriction fragments (chrom, start, end). Can be
                       generated using cooler digest.  [required]
  -o, --output TEXT    output .pairs/.pairsam file. If the path ends with
                       .gz/.lz4, the output is compressed by bgzip/lz4c. By
                       default, the output is printed into stdout.
  --nproc-in INTEGER   Number of processes used by the auto-guessed input
                       decompressing command.  [default: 3]
  --nproc-out INTEGER  Number of processes used by the auto-guessed output
                       compressing command.  [default: 8]
  --cmd-in TEXT        A command to decompress the input file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdin and pairtools parse. Must read input from
                       stdin and print output into stdout. EXAMPLE: pbgzip -dc
                       -n 3
  --cmd-out TEXT       A command to compress the output file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdout. Must read input from stdin and print
                       output into stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help           Show this message and exit.
```


## pairtools_sample

### Tool Description
Select a random subset of pairs in a pairs file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools sample [OPTIONS] FRACTION [PAIRS_PATH]

  Select a random subset of pairs in a pairs file.

  FRACTION: the fraction of the randomly selected pairs subset

  PAIRS_PATH : input .pairs/.pairsam file. If the path ends with .gz or .lz4,
  the input is decompressed by bgzip/lz4c. By default, the input is read from
  stdin.

Options:
  -o, --output TEXT    output file. If the path ends with .gz or .lz4, the
                       output is bgzip-/lz4c-compressed. By default, the
                       output is printed into stdout.
  -s, --seed INTEGER   the seed of the random number generator.
  --nproc-in INTEGER   Number of processes used by the auto-guessed input
                       decompressing command.  [default: 3]
  --nproc-out INTEGER  Number of processes used by the auto-guessed output
                       compressing command.  [default: 8]
  --cmd-in TEXT        A command to decompress the input file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdin and pairtools parse. Must read input from
                       stdin and print output into stdout. EXAMPLE: pbgzip -dc
                       -n 3
  --cmd-out TEXT       A command to compress the output file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdout. Must read input from stdin and print
                       output into stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help           Show this message and exit.
```


## pairtools_scaling

### Tool Description
Calculate pairs scalings.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools scaling [OPTIONS] [INPUT_PATH]...

  Calculate pairs scalings.

  INPUT_PATH : by default, a .pairs/.pairsam file to calculate statistics. If
  not provided, the input is read from stdin.

  The files with paths ending with .gz/.lz4 are decompressed by bgzip/lz4c.

  Output is .tsv file with scaling stats (both cis scalings and trans levels).

Options:
  -o, --output TEXT               output .tsv file with summary.
  --view, --regions TEXT          Path to a BED file which defines which
                                  regions (viewframe) of the chromosomes to
                                  use. By default, this is parsed from .pairs
                                  header.
  --chunksize INTEGER             Number of pairs in each chunk. Reduce for
                                  lower memory footprint.  [default: 100000]
  --dist-range <INTEGER INTEGER>...
                                  Distance range.   [default: 1, 1000000000]
  --n-dist-bins-decade INTEGER    Number of bins to split the distance range
                                  in log10-space, specified per a factor of 10
                                  difference.  [default: 8]
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.
```


## pairtools_select

### Tool Description
Select pairs according to some condition.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools select [OPTIONS] CONDITION [PAIRS_PATH]

  Select pairs according to some condition.

  CONDITION : A Python expression; if it returns True, select the read pair.
  Any column declared in the #columns line of the pairs header can be accessed
  by its name. If the header lacks the #columns line, the columns are assumed
  to follow the .pairs/.pairsam standard (readID, chrom1, chrom2, pos1, pos2,
  strand1, strand2, pair_type). Finally, CONDITION has access to COLS list
  which contains the string values of columns. In Bash, quote CONDITION with
  single quotes, and use double quotes for string variables inside CONDITION.

  PAIRS_PATH : input .pairs/.pairsam file. If the path ends with .gz or .lz4,
  the input is decompressed by bgzip/lz4c. By default, the input is read from
  stdin.

  The following functions can be used in CONDITION besides the standard Python
  functions:

  - csv_match(x, csv) - True if variable x is contained in a list of comma-
  separated values, e.g. csv_match(chrom1, 'chr1,chr2')

  - wildcard_match(x, wildcard) - True if variable x matches a wildcard, e.g.
  wildcard_match(pair_type, 'C*')

  - regex_match(x, regex) - True if variable x matches a Python-flavor regex,
  e.g. regex_match(chrom1, 'chr\d')

  Examples:
  pairtools select '(pair_type=="UU") or (pair_type=="UR") or (pair_type=="RU")'
  pairtools select 'chrom1==chrom2'
  pairtools select 'COLS[1]==COLS[3]'
  pairtools select '(chrom1==chrom2) and (abs(pos1 - pos2) < 1e6)'
  pairtools select '(chrom1=="!") and (chrom2!="!")'
  pairtools select 'regex_match(chrom1, "chr\d+") and regex_match(chrom2, "chr\d+")'

  pairtools select 'True' --chrom-subset mm9.reduced.chromsizes

Options:
  -o, --output TEXT               output file. If the path ends with .gz or
                                  .lz4, the output is bgzip-/lz4c-compressed.
                                  By default, the output is printed into
                                  stdout.
  --output-rest TEXT              output file for pairs of other types.  If
                                  the path ends with .gz or .lz4, the output
                                  is bgzip-/lz4c-compressed. By default, such
                                  pairs are dropped.
  --chrom-subset TEXT             A path to a chromosomes file (tab-separated,
                                  1st column contains chromosome names)
                                  containing a chromosome subset of interest.
                                  If provided, additionally filter pairs with
                                  both sides originating from the provided
                                  subset of chromosomes. This operation
                                  modifies the #chromosomes: and #chromsize:
                                  header fields accordingly.
  --startup-code TEXT             An auxiliary code to execute before
                                  filtering. Use to define functions that can
                                  be evaluated in the CONDITION statement
  -t, --type-cast <TEXT TEXT>...  Cast a given column to a given type. By
                                  default, only pos and mapq are cast to int,
                                  other columns are kept as str. Provide as -t
                                  <column_name> <type>, e.g. -t read_len1 int.
                                  Multiple entries are allowed.
  -r, --remove-columns TEXT       Comma-separated list of columns to be
                                  removed, e.g.: readID,chrom1,pos1,chrom2,pos
                                  2,strand1,strand2,pair_type,sam1,sam2,walk_p
                                  air_index,walk_pair_type
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.
```


## pairtools_sort

### Tool Description
Sort a .pairs/.pairsam file.

Sort pairs in the lexicographic order along chrom1 and chrom2, in the
numeric order along pos1 and pos2 and in the lexicographic order along
pair_type.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools sort [OPTIONS] [PAIRS_PATH]

  Sort a .pairs/.pairsam file.

  Sort pairs in the lexicographic order along chrom1 and chrom2, in the
  numeric order along pos1 and pos2 and in the lexicographic order along
  pair_type.

  PAIRS_PATH : input .pairs/.pairsam file. If the path ends with .gz or .lz4,
  the input is decompressed by bgzip or lz4c, correspondingly. By default, the
  input is read as text from stdin.

Options:
  -o, --output TEXT        output pairs file. If the path ends with .gz or
                           .lz4, the output is compressed by bgzip or lz4,
                           correspondingly. By default, the output is printed
                           into stdout.
  --c1 TEXT                Chrom 1 column; default chrom1[input format option]
  --c2 TEXT                Chrom 2 column; default chrom2[input format option]
  --p1 TEXT                Position 1 column; default pos1[input format
                           option]
  --p2 TEXT                Position 2 column; default pos2[input format
                           option]
  --pt TEXT                Pair type column; default pair_type[input format
                           option]
  --extra-col TEXT         Extra column (name or numerical index) that is also
                           used for sorting.The option can be provided
                           multiple times.Example: --extra-col "phase1"
                           --extra-col "phase2". [output format option]
  --nproc INTEGER          Number of processes to split the sorting work
                           between.  [default: 8]
  --tmpdir TEXT            Custom temporary folder for sorting intermediates.
  --memory TEXT            The amount of memory used by default.  [default:
                           2G]
  --compress-program TEXT  A binary to compress temporary sorted chunks. Must
                           decompress input when the flag -d is provided.
                           Suggested alternatives: gzip, lzop, lz4c, snzip. If
                           "auto", then use lz4c if available, and gzip
                           otherwise.  [default: auto]
  --nproc-in INTEGER       Number of processes used by the auto-guessed input
                           decompressing command.  [default: 3]
  --nproc-out INTEGER      Number of processes used by the auto-guessed output
                           compressing command.  [default: 8]
  --cmd-in TEXT            A command to decompress the input file. If
                           provided, fully overrides the auto-guessed command.
                           Does not work with stdin and pairtools parse. Must
                           read input from stdin and print output into stdout.
                           EXAMPLE: pbgzip -dc -n 3
  --cmd-out TEXT           A command to compress the output file. If provided,
                           fully overrides the auto-guessed command. Does not
                           work with stdout. Must read input from stdin and
                           print output into stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help               Show this message and exit.
```


## pairtools_split

### Tool Description
Split a .pairsam file into .pairs and .sam.

  Restore a .sam file from sam1 and sam2 fields of a .pairsam file. Create a
  .pairs file without sam1/sam2 fields.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools split [OPTIONS] [PAIRSAM_PATH]

  Split a .pairsam file into .pairs and .sam.

  Restore a .sam file from sam1 and sam2 fields of a .pairsam file. Create a
  .pairs file without sam1/sam2 fields.

  PAIRSAM_PATH : input .pairsam file. If the path ends with .gz or .lz4, the
  input is decompressed by bgzip or lz4c. By default, the input is read from
  stdin.

Options:
  --output-pairs TEXT  output pairs file. If the path ends with .gz or .lz4,
                       the output is bgzip-/lz4c-compressed. If -, pairs are
                       printed to stdout. If not specified, pairs are dropped.
  --output-sam TEXT    output sam file. If the path ends with .bam, the output
                       is compressed into a bam file. If -, sam entries are
                       printed to stdout. If not specified, sam entries are
                       dropped.
  --nproc-in INTEGER   Number of processes used by the auto-guessed input
                       decompressing command.  [default: 3]
  --nproc-out INTEGER  Number of processes used by the auto-guessed output
                       compressing command.  [default: 8]
  --cmd-in TEXT        A command to decompress the input file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdin and pairtools parse. Must read input from
                       stdin and print output into stdout. EXAMPLE: pbgzip -dc
                       -n 3
  --cmd-out TEXT       A command to compress the output file. If provided,
                       fully overrides the auto-guessed command. Does not work
                       with stdout. Must read input from stdin and print
                       output into stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help           Show this message and exit.
```


## pairtools_stats

### Tool Description
Calculate pairs statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
- **Homepage**: https://github.com/mirnylab/pairtools
- **Package**: https://anaconda.org/channels/bioconda/packages/pairtools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pairtools stats [OPTIONS] [INPUT_PATH]...

  Calculate pairs statistics.

  INPUT_PATH : by default, a .pairs/.pairsam file to calculate statistics. If
  not provided, the input is read from stdin. If --merge is specified, then
  INPUT_PATH is interpreted as an arbitrary number of stats files to merge.

  The files with paths ending with .gz/.lz4 are decompressed by bgzip/lz4c.

Options:
  -o, --output TEXT               output stats tsv file.
  --merge                         If specified, merge multiple input stats
                                  files instead of calculating statistics of a
                                  .pairs/.pairsam file. Merging is performed
                                  via summation of all overlapping statistics.
                                  Non-overlapping statistics are appended to
                                  the end of the file. Supported for tsv stats
                                  with single filter.
  --n-dist-bins-decade INTEGER    Number of bins to split the distance range
                                  in log10-space, specified per a factor of 10
                                  difference.  [default: 8]
  --with-chromsizes / --no-chromsizes
                                  If enabled, will store sizes of chromosomes
                                  from the header of the pairs file in the
                                  stats file.
  --yaml / --no-yaml              Output stats in yaml format instead of
                                  table.
  --bytile-dups / --no-bytile-dups
                                  If enabled, will analyse by-tile duplication
                                  statistics to estimate library complexity
                                  more accurately. Requires parent_readID
                                  column to be saved by dedup (will be ignored
                                  otherwise) Saves by-tile stats into
                                  --output_bytile-stats stream, or regular
                                  output if --output_bytile-stats is not
                                  provided.
  --output-bytile-stats TEXT      output file for tile duplicate statistics.
                                  If file exists, it will be open in the
                                  append mode. If the path ends with .gz or
                                  .lz4, the output is bgzip-/lz4c-compressed.
                                  By default, by-tile duplicate statistics are
                                  not printed. Note that the readID and
                                  parent_readID should be provided and contain
                                  tile information for this option.
  --filter TEXT                   Filters with conditions to apply to the data
                                  (similar to `pairtools select`). For non-
                                  YAML output only the first filter will be
                                  reported. Example: pairtools stats --yaml
                                  --filter 'unique:(pair_type=="UU")' --filter
                                  'close:(pair_type=="UU") and
                                  (abs(pos1-pos2)<10)' test.pairs
  --engine TEXT                   Engine for regular expression parsing.
                                  Python will provide you regex functionality,
                                  while pandas does not accept custom
                                  funtctions and works faster.
  --chrom-subset TEXT             A path to a chromosomes file (tab-separated,
                                  1st column contains chromosome names)
                                  containing a chromosome subset of interest.
                                  If provided, additionally filter pairs with
                                  both sides originating from the provided
                                  subset of chromosomes. This operation
                                  modifies the #chromosomes: and #chromsize:
                                  header fields accordingly.
  --startup-code TEXT             An auxiliary code to execute before
                                  filtering. Use to define functions that can
                                  be evaluated in the CONDITION statement
  -t, --type-cast <TEXT TEXT>...  Cast a given column to a given type. By
                                  default, only pos and mapq are cast to int,
                                  other columns are kept as str. Provide as -t
                                  <column_name> <type>, e.g. -t read_len1 int.
                                  Multiple entries are allowed.
  --nproc-in INTEGER              Number of processes used by the auto-guessed
                                  input decompressing command.  [default: 3]
  --nproc-out INTEGER             Number of processes used by the auto-guessed
                                  output compressing command.  [default: 8]
  --cmd-in TEXT                   A command to decompress the input file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdin and
                                  pairtools parse. Must read input from stdin
                                  and print output into stdout. EXAMPLE:
                                  pbgzip -dc -n 3
  --cmd-out TEXT                  A command to compress the output file. If
                                  provided, fully overrides the auto-guessed
                                  command. Does not work with stdout. Must
                                  read input from stdin and print output into
                                  stdout. EXAMPLE: pbgzip -c -n 8
  -h, --help                      Show this message and exit.
```


## Metadata
- **Skill**: generated
