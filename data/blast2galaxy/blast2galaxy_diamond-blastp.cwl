cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blast2galaxy
  - diamond-blastp
label: blast2galaxy_diamond-blastp
doc: "search protein databases using a protein query with DIAMOND\n\nTool homepage:
  https://github.com/IPK-BIT/blast2galaxy"
inputs:
  - id: comp_based_stats
    type:
      - 'null'
      - string
    doc: 'Use composition-based statistics: D or d: default (equivalent to 2 ); 0
      or F or f: No composition-based statistics; 1: Composition-based statistics
      as in NAR 29:2994-3005, 2001; 2 or T or t : Composition-based score adjustment
      as in Bioinformatics 21:902-911, 2005, conditioned on sequence properties; 3:
      Composition-based score adjustment as in Bioinformatics 21:902-911, 2005, unconditionally'
    default: '1'
    inputBinding:
      position: 101
      prefix: --comp-based-stats
  - id: db
    type: string
    doc: Database name
    inputBinding:
      position: 101
      prefix: --db
  - id: evalue
    type:
      - 'null'
      - string
    doc: Expectation value cutoff
    default: '0.001'
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fast
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --fast
  - id: faster
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --faster
  - id: gapextend
    type:
      - 'null'
      - int
    doc: Cost to extend a gap
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Cost to open a gap
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix name (normally BLOSUM62)
    default: BLOSUM62
    inputBinding:
      position: 101
      prefix: --matrix
  - id: max_hsps
    type:
      - 'null'
      - int
    doc: Maximum number of HSPs (alignments) to keep for any single 
      query-subject pair
    inputBinding:
      position: 101
      prefix: --max-hsps
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of aligned sequences to keep (value of 5 or more is 
      recommended) Default = 500
    default: 500
    inputBinding:
      position: 101
      prefix: --max-target-seqs
  - id: mid_sensitive
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --mid-sensitive
  - id: more_sensitive
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --more-sensitive
  - id: outfmt
    type:
      - 'null'
      - string
    doc: Output format
    default: '0'
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: profile
    type:
      - 'null'
      - string
    doc: ID of the profile as defined in your config TOML. The profile consists 
      of Galaxy server credentials and a Galaxy Tool-ID to be used for your 
      BLAST call
    default: default
    inputBinding:
      position: 101
      prefix: --profile
  - id: query
    type: File
    doc: Path / filename of file with nucleotide query sequence(s)
    inputBinding:
      position: 101
      prefix: --query
  - id: sensitive
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: strand
    type:
      - 'null'
      - string
    doc: Query strand(s) to search against database/subject
    default: both
    inputBinding:
      position: 101
      prefix: --strand
  - id: task
    type:
      - 'null'
      - string
    doc: Task type
    default: blastp
    inputBinding:
      position: 101
      prefix: --task
  - id: ultra_sensitive
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --ultra-sensitive
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --very-sensitive
  - id: window
    type:
      - 'null'
      - int
    doc: 'Multiple hits window size: use 0 to specify 1-hit algorithm, leave blank
      for default'
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: Path / filename of file to store the BLAST result
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
