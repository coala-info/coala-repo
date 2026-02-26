cwlVersion: v1.2
class: CommandLineTool
baseCommand: cblaster gne
label: cblaster_gne
doc: "Gene neighbourhood estimation.\nRepeatedly recomputes homologue clusters with
  different --gap values.\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs:
  - id: session
    type: File
    doc: cblaster session file
    inputBinding:
      position: 1
  - id: decimals
    type:
      - 'null'
      - int
    doc: Total decimal places to use when printing score values
    inputBinding:
      position: 102
      prefix: --decimals
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Delimiter character to use when printing result output.
    inputBinding:
      position: 102
      prefix: --delimiter
  - id: hide_headers
    type:
      - 'null'
      - boolean
    doc: Hide headers when printing result output.
    inputBinding:
      position: 102
      prefix: --hide_headers
  - id: max_gap
    type:
      - 'null'
      - int
    doc: Maximum intergenic distance
    default: 100000
    inputBinding:
      position: 102
      prefix: --max_gap
  - id: plot
    type:
      - 'null'
      - File
    doc: Specify this argument without value to dynamically serve te plot. If a 
      file location is provided the plot will be saved there.
    inputBinding:
      position: 102
      prefix: --plot
  - id: samples
    type:
      - 'null'
      - int
    doc: Total samples taken from max_gap
    default: 100
    inputBinding:
      position: 102
      prefix: --samples
  - id: scale
    type:
      - 'null'
      - string
    doc: Draw sampling values from a linear or log scale
    default: linear
    inputBinding:
      position: 102
      prefix: --scale
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write results to file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
