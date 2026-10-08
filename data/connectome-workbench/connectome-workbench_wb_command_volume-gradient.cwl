cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-gradient
label: connectome-workbench_wb_command_volume-gradient
doc: "Computes the gradient of the volume by doing linear regressions for each voxel, considering only its face neighbors unless too few face neighbors exist. The gradient vector is constructed from the partial derivatives of the resulting linear function, and the magnitude of this vector is the output. If specified, the volume vector output is arranged with the x, y, and z components from a subvolume as consecutive subvolumes.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "the input volume"
    inputBinding:
      position: 1
  - id: volume_out
    type: string
    doc: "output - the output gradient magnitude volume"
    inputBinding:
      position: 2
  - id: presmooth
    type:
      - 'null'
      - float
    doc: "smooth the volume before computing the gradient: sigma for gaussian weighting function, in mm"
    inputBinding:
      position: 3
      prefix: -presmooth
  - id: roi
    type:
      - 'null'
      - File
    doc: "select a region of interest to take the gradient of: the region to take the gradient within"
    inputBinding:
      position: 4
      prefix: -roi
  - id: vector_volume_out
    type:
      - 'null'
      - string
    doc: "output vectors: output - the vectors as a volume file"
    inputBinding:
      position: 5
      prefix: -vectors
  - id: subvolume
    type:
      - 'null'
      - string
    doc: "select a single subvolume to take the gradient of: the subvolume number or name"
    inputBinding:
      position: 6
      prefix: -subvolume
outputs:
  - id: output_volume
    type: File
    doc: "the output gradient magnitude volume"
    outputBinding:
      glob: $(inputs.volume_out)
  - id: vector_volume
    type:
      - 'null'
      - File
    doc: "the vectors as a volume file"
    outputBinding:
      glob: $(inputs.vector_volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
