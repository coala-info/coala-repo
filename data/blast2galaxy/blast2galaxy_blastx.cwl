cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blast2galaxy
  - blastx
label: blast2galaxy_blastx
doc: "search protein databases using a translated nucleotide query\n\nTool homepage:
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
    inputBinding:
      position: 101
      prefix: --comp_based_stats
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
  - id: html
    type:
      - 'null'
      - boolean
    doc: Format output as HTML document
    inputBinding:
      position: 101
      prefix: --html
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
      prefix: --max_hsps
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of aligned sequences to keep (value of 5 or more is 
      recommended) Default = 500
    inputBinding:
      position: 101
      prefix: --max_target_seqs
  - id: num_alignments
    type:
      - 'null'
      - int
    doc: 'Number of database sequences to show alignments for. Default = 250 * Incompatible
      with: max_target_seqs'
    inputBinding:
      position: 101
      prefix: --num_alignments
  - id: num_descriptions
    type:
      - 'null'
      - int
    doc: 'Number of database sequences to show one-line descriptions for. Not applicable
      for outfmt > 4. Default = 500 * Incompatible with: max_target_seqs'
    inputBinding:
      position: 101
      prefix: --num_descriptions
  - id: outfmt
    type:
      - 'null'
      - string
    doc: Output format
    inputBinding:
      position: 101
      prefix: --outfmt
  - id: parse_deflines
    type:
      - 'null'
      - boolean
    doc: Should the query and subject defline(s) be parsed?
    inputBinding:
      position: 101
      prefix: --parse_deflines
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
  - id: qcov_hsp_perc
    type:
      - 'null'
      - float
    doc: Minimum query coverage per hsp (percentage, 0 to 100)
    inputBinding:
      position: 101
      prefix: --qcov_hsp_perc
  - id: query
    type: File
    doc: Path / filename of file with nucleotide query sequence(s)
    inputBinding:
      position: 101
      prefix: --query
  - id: seg
    type:
      - 'null'
      - string
    doc: Filter out low complexity regions (with SEG)
    inputBinding:
      position: 101
      prefix: --seg
  - id: task
    type:
      - 'null'
      - string
    doc: Task type
    inputBinding:
      position: 101
      prefix: --task
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum word score such that the word is added to the BLAST lookup 
      table
    inputBinding:
      position: 101
      prefix: --threshold
  - id: ungapped
    type:
      - 'null'
      - boolean
    doc: Perform ungapped alignment only?
    inputBinding:
      position: 101
      prefix: --ungapped
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Multiple hits window size: use 0 to specify 1-hit algorithm, leave blank
      for default'
    inputBinding:
      position: 101
      prefix: --window_size
  - id: word_size
    type:
      - 'null'
      - int
    doc: Word size for wordfinder algorithm
    inputBinding:
      position: 101
      prefix: --word_size
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
