cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-label-dilate'
label: connectome-workbench_wb_command_label-dilate
doc: "Dilate a label file. Fills in label information for all vertices designated as bad, up to the specified distance away from other labels. Without -bad-vertex-roi, only vertices with the unlabeled key are bad.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label
    type: File
    doc: the input label
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: the surface to dilate on
    inputBinding:
      position: 2
  - id: dilate_dist
    type: float
    doc: distance in mm to dilate the labels
    inputBinding:
      position: 3
  - id: label_out
    type: string
    doc: output - the output label file
    inputBinding:
      position: 4
  - id: bad_vertex_roi
    type:
      - 'null'
      - File
    doc: metric file, positive values denote vertices to have their values replaced
    inputBinding:
      position: 5
      prefix: '-bad-vertex-roi'
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to dilate (number or name)
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
  - id: dilated_label
    type: File
    doc: the output label file
    outputBinding:
      glob: $(inputs.label_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
