cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-label-erode'
label: connectome-workbench_wb_command_label-erode
doc: "Erode a label file. Around each vertex that is unlabeled, set surrounding vertices to unlabeled. The surrounding vertices are all immediate neighbors and all vertices within the specified distance.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label
    type: File
    doc: the input label
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: the surface to erode on
    inputBinding:
      position: 2
  - id: erode_dist
    type: float
    doc: distance in mm to erode the labels
    inputBinding:
      position: 3
  - id: label_out
    type: string
    doc: output - the output label file
    inputBinding:
      position: 4
  - id: roi
    type:
      - 'null'
      - File
    doc: assume values outside this roi are labeled; metric file, positive values denote vertices that have data
    inputBinding:
      position: 5
      prefix: '-roi'
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to erode (number or name)
    inputBinding:
      position: 5
      prefix: '-column'
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface, as a metric
    inputBinding:
      position: 5
      prefix: '-corrected-areas'
outputs:
  - id: eroded_label
    type: File
    doc: the output label file
    outputBinding:
      glob: $(inputs.label_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
