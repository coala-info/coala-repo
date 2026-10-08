cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-warpfield-affine-regression
label: connectome-workbench_wb_command_volume-warpfield-affine-regression
doc: "For all voxels in the warpfield, do a regression that predicts the post-warp coordinate from the source coordinate. When -roi is specified, only consider voxels with a value greater than 0 in <roi-vol>.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: warpfield
    type: File
    doc: "the input warpfield"
    inputBinding:
      position: 1
  - id: affine_out
    type: string
    doc: "output - the output affine file"
    inputBinding:
      position: 2
  - id: roi
    type:
      - 'null'
      - File
    doc: "only consider voxels within a mask (e.g., a brain mask): the mask volume"
    inputBinding:
      position: 3
      prefix: -roi
  - id: fnirt_source_volume
    type:
      - 'null'
      - File
    doc: "input is a fnirt warpfield: the source volume used when generating the fnirt warpfield"
    inputBinding:
      position: 4
      prefix: -fnirt
  - id: flirt_out_source_volume
    type:
      - 'null'
      - File
    doc: "the volume you want to apply the transform to (-flirt-out argument 1 of 2)"
    inputBinding:
      position: 5
      prefix: -flirt-out
  - id: flirt_out_target_volume
    type:
      - 'null'
      - File
    doc: "the target space you want the transformed volume to match (-flirt-out argument 2 of 2)"
    inputBinding:
      position: 6
outputs:
  - id: output_affine
    type: File
    doc: "the output affine file"
    outputBinding:
      glob: $(inputs.affine_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
