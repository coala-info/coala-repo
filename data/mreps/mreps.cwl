cwlVersion: v1.2
class: CommandLineTool
baseCommand: mreps
label: mreps
doc: "finds tandemly repeated fragments in a DNA sequence\n\nTool homepage: http://mreps.univ-mlv.fr/"
inputs:
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: DNA sequence file (use this or the sequence input)
    inputBinding:
      position: 200
  - id: allow_small
    type:
      - 'null'
      - boolean
    doc: output small repeats that can occur randomly
    inputBinding:
      position: 102
      prefix: -allowsmall
  - id: exponent
    type:
      - 'null'
      - float
    doc: repeats whose exponent is at least x
    inputBinding:
      position: 102
      prefix: -exp
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: allows DNA sequences in FASTA format
    inputBinding:
      position: 102
      prefix: -fasta
  - id: from_pos
    type:
      - 'null'
      - int
    doc: starting position n
    inputBinding:
      position: 102
      prefix: -from
  - id: max_period
    type:
      - 'null'
      - int
    doc: repeats whose period is at most n
    inputBinding:
      position: 102
      prefix: -maxperiod
  - id: max_size
    type:
      - 'null'
      - int
    doc: repeats whose size is at most n
    inputBinding:
      position: 102
      prefix: -maxsize
  - id: min_period
    type:
      - 'null'
      - int
    doc: repeats whose period is at least n
    inputBinding:
      position: 102
      prefix: -minperiod
  - id: min_size
    type:
      - 'null'
      - int
    doc: repeats whose size is at least n
    inputBinding:
      position: 102
      prefix: -minsize
  - id: noprint
    type:
      - 'null'
      - boolean
    doc: if specified, the repetition sequences will not be output
    inputBinding:
      position: 102
      prefix: -noprint
  - id: resolution
    type:
      - 'null'
      - int
    doc: '"resolution" (error level)'
    inputBinding:
      position: 102
      prefix: -res
  - id: sequence
    type:
      - 'null'
      - string
    doc: specifies the sequence in command line (use this or the sequence_file
      input)
    inputBinding:
      position: 102
      prefix: -s
  - id: to_pos
    type:
      - 'null'
      - int
    doc: end position n
    inputBinding:
      position: 102
      prefix: -to
  - id: window_size
    type:
      - 'null'
      - int
    doc: process by sliding windows of size 2*n overlaping by n
    inputBinding:
      position: 102
      prefix: -win
  - id: xml_output_file_path
    type:
      - 'null'
      - string
    doc: outputs to <file> in xml format
    inputBinding:
      position: 102
      prefix: -xmloutput
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: xml_output_file
    type:
      - 'null'
      - File
    doc: outputs to <file> in xml format
    outputBinding:
      glob: $(inputs.xml_output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mreps:2.6.01--h7b50bb2_6
stdout: mreps.out
