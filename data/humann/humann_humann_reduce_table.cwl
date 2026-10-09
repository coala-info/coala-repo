cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann_reduce_table
label: humann_humann_reduce_table
doc: "Reduce table\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann"
inputs:
  - id: input
    type: File
    doc: "the input table"
    inputBinding:
      position: 101
      prefix: "--input"
  - id: output_path
    type: string
    doc: "the output table"
    inputBinding:
      position: 102
      prefix: "--output"
  - id: function
    type:
      - 'null'
      - string
    doc: "the function to apply: sum, min, max or mean"
    inputBinding:
      position: 103
      prefix: "--function"
  - id: sort_by
    type:
      - 'null'
      - string
    doc: "sort the output by the selection: level, name or value"
    inputBinding:
      position: 104
      prefix: "--sort-by"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "additional output is printed"
    inputBinding:
      position: 105
      prefix: "--verbose"
outputs:
  - id: output
    type: File
    doc: "reduced table"
    outputBinding:
      glob: '$(inputs.output_path)'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humann:3.9--py312hdfd78af_0
