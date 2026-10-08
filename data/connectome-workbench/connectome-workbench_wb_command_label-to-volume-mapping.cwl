cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-label-to-volume-mapping'
label: connectome-workbench_wb_command_label-to-volume-mapping
doc: "Map a label file to a volume. You must specify exactly one mapping method option. -nearest-vertex uses the label from the vertex closest to the voxel center. -ribbon-constrained uses the same method as -volume-to-surface-mapping, then uses the weights in reverse with popularity logic.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label
    type: File
    doc: the input label file
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: the surface to use coordinates from
    inputBinding:
      position: 2
  - id: volume_space
    type: File
    doc: a volume file in the desired output volume space
    inputBinding:
      position: 3
  - id: volume_out
    type: string
    doc: output - the output volume file
    inputBinding:
      position: 4
  - id: nearest_vertex
    type:
      - 'null'
      - float
    doc: use the label from the vertex closest to the voxel center; how far from the surface to map labels to voxels, in mm
    inputBinding:
      position: 5
      prefix: '-nearest-vertex'
  - id: ribbon_constrained
    type:
      - 'null'
      - type: array
        items: File
    doc: 'use ribbon constrained mapping algorithm; two files: inner surface, outer surface'
    inputBinding:
      position: 6
      prefix: '-ribbon-constrained'
  - id: voxel_subdiv
    type:
      - 'null'
      - int
    doc: 'with ribbon_constrained: voxel divisions while estimating voxel weights (default 3)'
    inputBinding:
      position: 7
      prefix: '-voxel-subdiv'
  - id: greedy
    type:
      - 'null'
      - boolean
    doc: 'with ribbon_constrained: also put labels in voxels with less than 50% partial volume (legacy behavior)'
    inputBinding:
      position: 7
      prefix: '-greedy'
  - id: thick_columns
    type:
      - 'null'
      - boolean
    doc: 'with ribbon_constrained: use overlapping columns (legacy method)'
    inputBinding:
      position: 7
      prefix: '-thick-columns'
outputs:
  - id: label_volume
    type: File
    doc: the output volume file
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
