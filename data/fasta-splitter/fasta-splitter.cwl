cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta-splitter
label: fasta-splitter
doc: "Divide FASTA files into parts based on size, count, or number of parts.\n\n\
  Tool homepage: http://kirill-kryukov.com/study/tools/fasta-splitter/"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input FASTA file(s)
    inputBinding:
      position: 1
  - id: eol
    type:
      - 'null'
      - string
    doc: Choose end-of-line character ('unix' by default).
    inputBinding:
      position: 102
      prefix: --eol
  - id: line_length
    type:
      - 'null'
      - int
    doc: 'Set output sequence line length, 0 for single line (default: 60).'
    inputBinding:
      position: 102
      prefix: --line-length
  - id: measure
    type:
      - 'null'
      - string
    doc: Specify whether all data, sequence length, or number of sequences is 
      used for determining part sizes ('all' by default).
    inputBinding:
      position: 102
      prefix: --measure
  - id: n_parts
    type:
      - 'null'
      - int
    doc: Divide into <N> parts
    inputBinding:
      position: 102
      prefix: --n-parts
  - id: nopad
    type:
      - 'null'
      - boolean
    doc: Don't pad part numbers with 0.
    inputBinding:
      position: 102
      prefix: --nopad
  - id: part_num_prefix
    type:
      - 'null'
      - string
    doc: 'Put T before part number in file names (def.: .part-)'
    inputBinding:
      position: 102
      prefix: --part-num-prefix
  - id: part_size
    type:
      - 'null'
      - int
    doc: Divide into parts of size <N>
    inputBinding:
      position: 102
      prefix: --part-size
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Specify output directory.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fasta-splitter:0.2.6--0
