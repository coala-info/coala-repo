cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jclusterfunk
  - scale
label: jclusterfunk_scale
doc: "Scale all the branch lengths in a tree by a factor.\n\nTool homepage: https://github.com/snake-flu/jclusterfunk"
inputs:
  - id: factor
    type: double
    doc: the factor to scale all branches by
    inputBinding:
      position: 101
      prefix: --factor
  - id: format
    type:
      - 'null'
      - string
    doc: output file format (nexus or newick)
    inputBinding:
      position: 101
      prefix: --format
  - id: input_file
    type: File
    doc: input tree file
    inputBinding:
      position: 101
      prefix: --input
  - id: threshold
    type:
      - 'null'
      - double
    doc: the threshold for branch lengths to be collapsed into polytomies
    inputBinding:
      position: 101
      prefix: --threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: write analysis details to console
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_file_path
    type: string
    doc: output file
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0
