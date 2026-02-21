cwlVersion: v1.2
class: CommandLineTool
baseCommand: ambtest
label: conus_ambtest
doc: "Test ambiguity in sequence models using a model file and sequence file.\n\n
  Tool homepage: http://eddylab.org/software/conus/"
inputs:
  - id: seq_file
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: ct_format
    type:
      - 'null'
      - boolean
    doc: debugging, print CT format of structure
    inputBinding:
      position: 102
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: debugging output
    inputBinding:
      position: 102
      prefix: -d
  - id: fill_matrix
    type:
      - 'null'
      - boolean
    doc: debugging, print fill matrix from cyk
    inputBinding:
      position: 102
      prefix: -f
  - id: ignore_structure
    type:
      - 'null'
      - boolean
    doc: ignore given structure -- use CYK calculated structure
    inputBinding:
      position: 102
      prefix: -i
  - id: model_file
    type: File
    doc: Use model <file>
    inputBinding:
      position: 102
      prefix: -m
  - id: print_parameters
    type:
      - 'null'
      - boolean
    doc: print out parameters of model
    inputBinding:
      position: 102
      prefix: -x
  - id: traceback
    type:
      - 'null'
      - boolean
    doc: debugging, print traceback
    inputBinding:
      position: 102
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conus:1.0--h7b50bb2_6
stdout: conus_ambtest.out
