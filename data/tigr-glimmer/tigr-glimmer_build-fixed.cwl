cwlVersion: v1.2
class: CommandLineTool
baseCommand: tigr-glimmer_build-fixed
label: tigr-glimmer_build-fixed
doc: Read sequences from stdin and output to stdout the fixed-length 
  interpolated context model built from them
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 1
  - id: depth
    type:
      - 'null'
      - int
    doc: Set depth of model
    inputBinding:
      position: 102
      prefix: -d
  - id: output_text
    type:
      - 'null'
      - boolean
    doc: Output model as text (for debugging only)
    inputBinding:
      position: 102
      prefix: -t
  - id: permutation
    type:
      - 'null'
      - string
    doc: Permutation describing re-ordering of character positions of input 
      string to build model
    inputBinding:
      position: 102
      prefix: -p
  - id: special_position
    type:
      - 'null'
      - int
    doc: Specify special position in model
    inputBinding:
      position: 102
      prefix: -s
  - id: train_file
    type:
      - 'null'
      - File
    doc: Train using strings specified by subscripts in file named <fn>
    inputBinding:
      position: 102
      prefix: -i
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Set verbose level; higher is more diagnostic printouts
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tigr-glimmer:v3.02b-2-deb_cv1
