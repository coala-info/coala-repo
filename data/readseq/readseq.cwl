cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -cp readseq.jar run
label: readseq
doc: "Read & reformat biosequences, Java command-line version\n\nTool homepage: http://iubio.bio.indiana.edu/soft/molbio/readseq/java/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input file(s)
    inputBinding:
      position: 1
  - id: all_sequences
    type:
      - 'null'
      - boolean
    doc: select All sequences
    inputBinding:
      position: 102
      prefix: --all
  - id: amino_translate
    type:
      - 'null'
      - boolean
    doc: translate dna to amino acids
    inputBinding:
      position: 102
      prefix: --translate
  - id: case_lower
    type:
      - 'null'
      - boolean
    doc: change to lower case
    inputBinding:
      position: 102
      prefix: --aselower
  - id: case_upper
    type:
      - 'null'
      - boolean
    doc: change to UPPER CASE
    inputBinding:
      position: 102
      prefix: --ASEUPPER
  - id: checksum
    type:
      - 'null'
      - boolean
    doc: calculate & print checksum of sequences
    inputBinding:
      position: 102
      prefix: --checksum
  - id: column_space
    type:
      - 'null'
      - int
    doc: column space within sequence line on output
    inputBinding:
      position: 102
      prefix: --colspace
  - id: compare
    type:
      - 'null'
      - int
    doc: Compare two sequence files, reporting differences 
      (flags=nodoc,noid,nolen,nocrc)
    default: 1
    inputBinding:
      position: 102
      prefix: -compare
  - id: degap
    type:
      - 'null'
      - string
    doc: remove gap symbols
    default: '-'
    inputBinding:
      position: 102
      prefix: -degap
  - id: extract_features
    type:
      - 'null'
      - string
    doc: extract sequence of selected features
    inputBinding:
      position: 102
      prefix: --features
  - id: extract_range
    type:
      - 'null'
      - string
    doc: extract all features, sequence from given base range
    inputBinding:
      position: 102
      prefix: -extract
  - id: gap_count
    type:
      - 'null'
      - boolean
    doc: count gap chars in sequence numbers
    inputBinding:
      position: 102
      prefix: --gapcount
  - id: include_fields
    type:
      - 'null'
      - string
    doc: include selected document fields in output
    inputBinding:
      position: 102
      prefix: -field
  - id: indent_tab
    type:
      - 'null'
      - int
    doc: left indent
    inputBinding:
      position: 102
      prefix: -tab
  - id: input_format
    type:
      - 'null'
      - string
    doc: input format number, or input format name. Assume input data is this 
      format
    inputBinding:
      position: 102
      prefix: --informat
  - id: interline_blank
    type:
      - 'null'
      - string
    doc: blank line(s) between sequence blocks
    inputBinding:
      position: 102
      prefix: --interline
  - id: item_numbers
    type:
      - 'null'
      - string
    doc: select Item number(s) from several
    inputBinding:
      position: 102
      prefix: --item
  - id: list_sequences
    type:
      - 'null'
      - boolean
    doc: List sequences only
    inputBinding:
      position: 102
      prefix: --list
  - id: match_base
    type:
      - 'null'
      - string
    doc: use match base for 2..n species
    inputBinding:
      position: 102
      prefix: -match
  - id: name_left
    type:
      - 'null'
      - string
    doc: name on left side [=max width]
    inputBinding:
      position: 102
      prefix: -nameleft
  - id: name_right
    type:
      - 'null'
      - string
    doc: name on right side [=max width]
    inputBinding:
      position: 102
      prefix: -nameright
  - id: name_top
    type:
      - 'null'
      - boolean
    doc: name at top/bottom
    inputBinding:
      position: 102
      prefix: -nametop
  - id: num_bottom
    type:
      - 'null'
      - boolean
    doc: index on bottom side
    inputBinding:
      position: 102
      prefix: -numbot
  - id: num_left
    type:
      - 'null'
      - boolean
    doc: seq index on left side
    inputBinding:
      position: 102
      prefix: -numleft
  - id: num_right
    type:
      - 'null'
      - boolean
    doc: seq index on right side
    inputBinding:
      position: 102
      prefix: -numright
  - id: num_top
    type:
      - 'null'
      - boolean
    doc: index on top side
    inputBinding:
      position: 102
      prefix: -numtop
  - id: output_format
    type:
      - 'null'
      - string
    doc: Format number for output, or Format name for output
    inputBinding:
      position: 102
      prefix: --format
  - id: pair_features
    type:
      - 'null'
      - int
    doc: combine features (fff,gff) and sequence files to one output
    inputBinding:
      position: 102
      prefix: -pair
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Pipe (command line, < stdin, > stdout)
    inputBinding:
      position: 102
      prefix: --pipe
  - id: remove_features
    type:
      - 'null'
      - string
    doc: remove sequence of selected features
    inputBinding:
      position: 102
      prefix: --nofeatures
  - id: remove_fields
    type:
      - 'null'
      - string
    doc: remove selected document fields from output
    inputBinding:
      position: 102
      prefix: -nofield
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: reverse-complement of input sequence
    inputBinding:
      position: 102
      prefix: --reverse
  - id: sequence_width
    type:
      - 'null'
      - int
    doc: sequence line width
    inputBinding:
      position: 102
      prefix: --width
  - id: subrange
    type:
      - 'null'
      - string
    doc: extract subrange of sequence for feature locations
    inputBinding:
      position: 102
      prefix: -subrange
  - id: translate
    type:
      - 'null'
      - string
    doc: translate input symbol [i] to output symbol [o]
    inputBinding:
      position: 102
      prefix: --translate
  - id: unpair_features
    type:
      - 'null'
      - int
    doc: split features,sequence from one input to two files
    inputBinding:
      position: 102
      prefix: -unpair
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose progress
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: redirect Output
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/readseq:2.1.30--1
