cwlVersion: v1.2
class: CommandLineTool
baseCommand: coolpup.py
label: coolpuppy_coolpup.py
doc: "Create pileups of Hi-C data around specified genomic features.\n\nTool homepage:
  https://github.com/open2c/coolpuppy"
inputs:
  - id: cool_path
    type: File
    doc: Cooler file with your Hi-C data
    inputBinding:
      position: 1
  - id: features
    type: File
    doc: A 3-column bed file or a 6-column double-bed file i.e. 
      chr1,start1,end1,chr2,start2,end2. Should be tab-delimited. With a bed 
      file, will consider all combinations of intervals. To pileup features 
      along the diagonal instead, use the ``--local`` argument. Can be piped in 
      via stdin, then use "-"
    inputBinding:
      position: 2
  - id: by_distance
    type:
      - 'null'
      - type: array
        items: int
    doc: Perform by-distance pile-ups. Create a separate pile-up for each 
      distance band. If empty, will use default (0,50000,100000,200000,...) 
      edges. Specify edges using multiple argument values, e.g. `--by_distance 
      1000000 2000000`
    inputBinding:
      position: 103
      prefix: --by_distance
  - id: by_strand
    type:
      - 'null'
      - boolean
    doc: Perform by-strand pile-ups. Create a separate pile-up for each strand 
      combination in the features.
    inputBinding:
      position: 103
      prefix: --by_strand
  - id: by_window
    type:
      - 'null'
      - boolean
    doc: Perform by-window pile-ups. Create a pile-up for each coordinate in the
      features. Not compatible with --by_strand and --by_distance. Only works 
      with bed format features, and generates pairwise combinations of each 
      feature against the rest.
    inputBinding:
      position: 103
      prefix: --by_window
  - id: clr_weight_name
    type:
      - 'null'
      - string
    doc: Name of the norm to use for getting balanced data. Provide empty 
      argument to calculate pileups on raw data (no masking bad pixels).
    inputBinding:
      position: 103
      prefix: --clr_weight_name
  - id: coverage_norm
    type:
      - 'null'
      - string
    doc: 'Normalize the final pileup by accumulated coverage as an alternative to
      balancing. Useful for single-cell Hi-C data. Can be a string: "cis" or "total"
      to use "cov_cis_raw" or "cov_tot_raw" columns in the cooler bin table, respectively.
      If they are not present, will calculate coverage with same ignore_diags as used
      in coolpup.py and store result in the cooler. Alternatively, if a different
      string is provided, will attempt to use a column with the that name in the cooler
      bin table, and will raise a ValueError if it does not exist. If no argument
      is given following the option string, will use "total". Only allowed when using
      empty --clr_weight_name'
    inputBinding:
      position: 103
      prefix: --coverage_norm
  - id: expected
    type:
      - 'null'
      - File
    doc: File with expected (output of ``cooltools compute-expected``). If None,
      don't use expected and use randomly shifted controls
    inputBinding:
      position: 103
      prefix: --expected
  - id: features_format
    type:
      - 'null'
      - string
    doc: 'Format of the features. Options: bed: chrom, start, end bedpe: chrom1, start1,
      end1, chrom2, start2, end2 auto (default): determined from the file name extension
      Has to be explicitly provided is features is piped through stdin'
    inputBinding:
      position: 103
      prefix: --features_format
  - id: flank
    type:
      - 'null'
      - int
    doc: Flanking of the windows around the centres of specified features i.e. 
      final size of the matrix is 2 × flank+res, in bp. Ignored with 
      ``--rescale``, use ``--rescale_flank`` instead
    inputBinding:
      position: 103
      prefix: --flank
  - id: flip_negative_strand
    type:
      - 'null'
      - boolean
    doc: Flip snippets so the positive strand always points to bottom-right. 
      Requires strands to be annotated for each feature (or two strands for 
      bedpe format features)
    inputBinding:
      position: 103
      prefix: --flip_negative_strand
  - id: groupby
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional columns of features to use for groupby, space separated. If 
      feature_format=='bed', each columns should be specified twice with 
      suffixes '1' and '2', i.e. if features have a column 'group', specify 
      'group1 group2'., e.g. --groupby chrom1 chrom2
    inputBinding:
      position: 103
      prefix: --groupby
  - id: ignore_diags
    type:
      - 'null'
      - int
    doc: How many diagonals to ignore
    inputBinding:
      position: 103
      prefix: --ignore_diags
  - id: ignore_group_order
    type:
      - 'null'
      - type: array
        items: string
    doc: When using groupby, reorder so that e.g. group1-group2 and 
      group2-group1 will be combined into one and flipped to the correct 
      orientation. If using multiple paired groupings (e.g. group1-group2 and 
      category1-category2), need to specify which grouping should be 
      prioritised, e.g. "group" or "group1 group2". For flip_negative_strand, +-
      and -+ strands will be combined
    inputBinding:
      position: 103
      prefix: --ignore_group_order
  - id: local
    type:
      - 'null'
      - boolean
    doc: Create local pileups, i.e. along the diagonal
    inputBinding:
      position: 103
      prefix: --local
  - id: log
    type:
      - 'null'
      - string
    doc: Set the logging level
    inputBinding:
      position: 103
      prefix: --log
  - id: maxdist
    type:
      - 'null'
      - int
    doc: Maximal distance of interactions to use
    inputBinding:
      position: 103
      prefix: --maxdist
  - id: maxshift
    type:
      - 'null'
      - int
    doc: Longest shift for random controls, bp
    inputBinding:
      position: 103
      prefix: --maxshift
  - id: mindist
    type:
      - 'null'
      - int
    doc: Minimal distance of interactions to use, bp. If not provided, uses 
      2*flank+2 (in bins) as mindist to avoid first two diagonals
    inputBinding:
      position: 103
      prefix: --mindist
  - id: minshift
    type:
      - 'null'
      - int
    doc: Shortest shift for random controls, bp
    inputBinding:
      position: 103
      prefix: --minshift
  - id: n_proc
    type:
      - 'null'
      - int
    doc: Number of processes to use. Each process works on a separate 
      chromosome, so might require quite a bit more memory, although the data 
      are always stored as sparse matrices. Set to 0 to use all available cores.
    inputBinding:
      position: 103
      prefix: --nproc
  - id: not_ooe
    type:
      - 'null'
      - boolean
    doc: If expected is provided, will accumulate all expected snippets just 
      like for randomly shifted controls, instead of normalizing each snippet 
      individually
    inputBinding:
      position: 103
      prefix: --not_ooe
  - id: nshifts
    type:
      - 'null'
      - int
    doc: Number of control regions per averaged window
    inputBinding:
      position: 103
      prefix: --nshifts
  - id: outname
    type:
      - 'null'
      - string
    doc: Name of the output file. If not set, file is saved in the current 
      directory and the name is generated automatically to include important 
      information and avoid overwriting files generated with different settings.
    inputBinding:
      position: 103
      prefix: --outname
  - id: post_mortem
    type:
      - 'null'
      - boolean
    doc: Enter debugger if there is an error
    inputBinding:
      position: 103
      prefix: --post_mortem
  - id: rescale
    type:
      - 'null'
      - boolean
    doc: Rescale all features to the same size. Do not use centres of features 
      and flank, and rather use the actual feature sizes and rescale pileups to 
      the same shape and size
    inputBinding:
      position: 103
      prefix: --rescale
  - id: rescale_flank
    type:
      - 'null'
      - float
    doc: If --rescale, flanking in fraction of feature length
    inputBinding:
      position: 103
      prefix: --rescale_flank
  - id: rescale_size
    type:
      - 'null'
      - int
    doc: Size to rescale to. If ``--rescale``, used to determine the final size 
      of the pileup, i.e. it will be size×size. Due to technical limitation in 
      the current implementation, has to be an odd number
    inputBinding:
      position: 103
      prefix: --rescale_size
  - id: seed
    type:
      - 'null'
      - int
    doc: Set specific seed value to ensure reproducibility
    inputBinding:
      position: 103
      prefix: --seed
  - id: store_stripes
    type:
      - 'null'
      - boolean
    doc: Store horizontal and vertical stripes in pileup output
    inputBinding:
      position: 103
      prefix: --store_stripes
  - id: subset
    type:
      - 'null'
      - int
    doc: Take a random sample of the bed file. Useful for files with too many 
      featuers to run as is, i.e. some repetitive elements. Set to 0 or lower to
      keep all data
    inputBinding:
      position: 103
      prefix: --subset
  - id: trans
    type:
      - 'null'
      - boolean
    doc: Perform inter-chromosomal (trans) pileups. This ignores all contacts in
      cis.
    inputBinding:
      position: 103
      prefix: --trans
  - id: view
    type:
      - 'null'
      - File
    doc: Path to a file which defines which regions of the chromosomes to use
    inputBinding:
      position: 103
      prefix: --view
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coolpuppy:1.1.0--pyh086e186_0
stdout: coolpuppy_coolpup.py.out
