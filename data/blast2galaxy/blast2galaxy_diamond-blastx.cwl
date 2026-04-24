cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blast2galaxy
  - diamond-blastx
label: blast2galaxy_diamond-blastx
doc: "search protein databases using a translated nucleotide query with DIAMOND\n\n\
  Tool homepage: https://github.com/IPK-BIT/blast2galaxy"
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
    doc: Cost to extend a gap [x>=0]
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: gapopen
    type:
      - 'null'
      - int
    doc: Cost to open a gap [x>=0]
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: matrix
    type:
      - 'null'
      - string
    doc: Scoring matrix name (normally BLOSUM62)
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
    inputBinding:
      position: 101
      prefix: --strand
  - id: task
    type:
      - 'null'
      - string
    doc: Task type
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
      for default [x>=1]'
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
