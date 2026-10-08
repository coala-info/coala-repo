cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -border-length
label: connectome-workbench_wb_command_border-length
doc: "For each border, print its length along the surface, in mm. If a border has multiple parts, their lengths are summed before printing, unless -separate-pieces is specified. The -corrected-areas option is intended for when the length is not meaningfully measurable on individual surfaces, it is only an approximate correction for the reduction in structure of a group average surface.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: border
    type: File
    doc: the input border file
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: the surface to measure the borders on
    inputBinding:
      position: 2
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the surface: the corrected vertex areas, as a metric'
    inputBinding:
      position: 3
      prefix: -corrected-areas
  - id: separate_pieces
    type:
      - 'null'
      - boolean
    doc: report lengths for multi-part borders as separate numbers
    inputBinding:
      position: 4
      prefix: -separate-pieces
  - id: hide_border_name
    type:
      - 'null'
      - boolean
    doc: don't print border name before each output
    inputBinding:
      position: 5
      prefix: -hide-border-name
  - id: output_name
    type:
      - 'null'
      - string
    doc: name of the file that receives the standard output
    default: border-length.txt
outputs:
  - id: lengths
    type: File
    doc: length of each border in mm
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
