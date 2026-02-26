cwlVersion: v1.2
class: CommandLineTool
baseCommand: tn93
label: tn93
doc: "compute Tamura Nei 93 distances between aligned sequences\n\nTool homepage:
  https://github.com/veg/tn93"
inputs:
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: read sequences to compare from this file (default=stdin)
    inputBinding:
      position: 1
  - id: ambigs
    type:
      - 'null'
      - string
    doc: "handle ambigous nucleotides using one of the following strategies (default=resolve)\n\
      \                           resolve: resolve ambiguities to minimize distance
      (e.g.R matches A);\n                           average: average ambiguities
      (e.g.R-A is 0.5 A-A and 0.5 G-A);\n                           skip: do not include
      sites with ambiguous nucleotides in distance calculations;\n               \
      \            gapmm: a gap ('-') matched to anything other than another gap is
      like matching an N (4-fold ambig) to it;\n                           a string
      (e.g. RY): any ambiguity in the list is RESOLVED; any ambiguitiy NOT in the
      list is averaged (LIST-NOT LIST will also be averaged);"
    default: resolve
    inputBinding:
      position: 102
      prefix: -a
  - id: ambiguity_fraction
    type:
      - 'null'
      - float
    doc: "in combination with AMBIGS, works to limit (for resolve and string options
      to AMBIG)\n                           the maximum tolerated FRACTION of ambiguous
      characters; sequences whose pairwise comparisons\n                         \
      \  include no more than FRACTION [0,1] of sites with resolvable ambiguities
      will be resolved\n                           while all others will be AVERAGED
      (default = 1.0)"
    default: 1.0
    inputBinding:
      position: 102
      prefix: -g
  - id: bootstrap_columns
    type:
      - 'null'
      - boolean
    doc: "bootstrap alignment columns before computing distances (default = false)\n\
      \                           when -s is supplied, permutes the assigment of sequences
      to files\n                           interacts with -r option"
    default: false
    inputBinding:
      position: 102
      prefix: -b
  - id: bootstrap_sites
    type:
      - 'null'
      - boolean
    doc: "if -b is specified AND -s is supplied, using -r will bootstrap across sites\n\
      \                           instead of allocating sequences to 'compartments'
      randomly"
    inputBinding:
      position: 102
      prefix: -r
  - id: compute_fst_means
    type:
      - 'null'
      - boolean
    doc: "compute inter- and intra-population means suitable for FST caclulations\n\
      \                           only applied when -s is used to provide a second
      file"
    inputBinding:
      position: 102
      prefix: -m
  - id: count_only
    type:
      - 'null'
      - boolean
    doc: only count the pairs below a threshold, do not write out all the pairs
    inputBinding:
      position: 102
      prefix: -c
  - id: counts_in_name_delimiter
    type:
      - 'null'
      - string
    doc: "if sequence name is of the form 'somethingCOUNTS_IN_NAMEinteger' then treat
      the integer as a copy number\n                           when computing distance
      histograms (a character, default=':'):"
    inputBinding:
      position: 102
      prefix: -d
  - id: delimiter
    type:
      - 'null'
      - string
    doc: use this character as a delimiter in the output column-file (a 
      character, default = ',')
    default: ','
    inputBinding:
      position: 102
      prefix: -D
  - id: include_self_distances
    type:
      - 'null'
      - boolean
    doc: "report distances between each sequence and itself (as 0); this is useful
      to ensure every sequence\n                           in the input file appears
      in the output, e.g. for network construction to contrast clustered/unclustered"
    inputBinding:
      position: 102
      prefix: '-0'
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: 'only process pairs of sequences that overlap over at least OVERLAP nucleotides
      (an integer >0, default=100):'
    default: 100
    inputBinding:
      position: 102
      prefix: -l
  - id: min_threshold
    type:
      - 'null'
      - float
    doc: report distances above minimum threshold
    inputBinding:
      position: 102
      prefix: -w
  - id: no_headers
    type:
      - 'null'
      - boolean
    doc: if set, do NOT write out headers for delimited files (default is to 
      write)
    inputBinding:
      position: 102
      prefix: -n
  - id: output_format
    type:
      - 'null'
      - string
    doc: "controls the format of the output unless -c is set (default=csv)\n     \
      \                      csv: seqname1, seqname2, distance;\n                \
      \           csvn: 1, 2, distance;\n                           hyphy: {{d11,d12,..,d1n}...{dn1,dn2,...,dnn}},
      where distances above THRESHOLD are set to 100;"
    default: csv
    inputBinding:
      position: 102
      prefix: -f
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: do not report progress updates and other diagnostics to stderr
    inputBinding:
      position: 102
      prefix: -q
  - id: second_fasta
    type:
      - 'null'
      - File
    doc: if specified, read another FASTA file from SECOND_FASTA and perform 
      pairwise comparison BETWEEN the files (default=NULL)
    inputBinding:
      position: 102
      prefix: -s
  - id: subsample_probability
    type:
      - 'null'
      - float
    doc: subsample sequences with specified probability (a value between 0 and 
      1, default = 1.0)
    default: 1.0
    inputBinding:
      position: 102
      prefix: -u
  - id: threshold
    type:
      - 'null'
      - float
    doc: only report (count) distances below this threshold (>=0, default=0.015)
    default: 0.015
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: direct the output to a file named OUTPUT (default=stdout)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tn93:1.0.15--h9948957_0
