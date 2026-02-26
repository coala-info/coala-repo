cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - blast2galaxy
  - blastn
label: blast2galaxy_blastn
doc: "search nucleotide databases using a nucleotide query\n\nTool homepage: https://github.com/IPK-BIT/blast2galaxy"
inputs:
  - id: db
    type: string
    doc: Database name
    inputBinding:
      position: 101
      prefix: --db
  - id: dust
    type:
      - 'null'
      - string
    doc: Filter out low complexity regions (with DUST)
    default: yes
    inputBinding:
      position: 101
      prefix: --dust
  - id: evalue
    type:
      - 'null'
      - string
    doc: Expectation value cutoff
    default: '0.001'
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
  - id: max_hsps
    type:
      - 'null'
      - int
    doc: Maximum number of HSPs (alignments) to keep for any single 
      query-subject pair
    inputBinding:
      position: 101
      prefix: --max_hsps
  - id: outfmt
    type:
      - 'null'
      - string
    doc: Output format
    default: '6'
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
  - id: perc_identity
    type:
      - 'null'
      - float
    doc: Percent identity cutoff
    default: '0.0'
    inputBinding:
      position: 101
      prefix: --perc_identity
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
  - id: qcov_hsp_perc
    type:
      - 'null'
      - float
    doc: Minimum query coverage per hsp (percentage, 0 to 100)
    default: '0.0'
    inputBinding:
      position: 101
      prefix: --qcov_hsp_perc
  - id: query
    type: File
    doc: Path / filename of file with nucleotide query sequence(s)
    inputBinding:
      position: 101
      prefix: --query
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
    default: megablast
    inputBinding:
      position: 101
      prefix: --task
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
