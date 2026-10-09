cwlVersion: v1.2
class: CommandLineTool
baseCommand: humann2_reduce_table
label: humann2_humann2_reduce_table
doc: "Reduce table\n\nTool homepage: http://huttenhower.sph.harvard.edu/humann2"
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
    dockerPull: quay.io/biocontainers/humann2:2.8.1--py27_0
