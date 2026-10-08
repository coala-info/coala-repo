cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-apply-warpfield
label: connectome-workbench_wb_command_surface-apply-warpfield
doc: 'NOTE: warping a surface requires the INVERSE of the warpfield used to warp the
  volume it lines up with. The header of the forward warp is needed by the -fnirt
  option in order to correctly interpret the displacements in the fnirt warpfield.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: in_surf
    type: File
    doc: the surface to transform
    inputBinding:
      position: 1
  - id: warpfield
    type: File
    doc: the INVERSE warpfield
    inputBinding:
      position: 2
  - id: out_surf
    type: string
    doc: output - the output transformed surface
    inputBinding:
      position: 3
  - id: fnirt
    type:
      - 'null'
      - File
    doc: MUST be used if using a fnirt warpfield
    inputBinding:
      position: 4
      prefix: -fnirt
outputs:
  - id: out_surf_file
    type: File
    doc: the output transformed surface
    outputBinding:
      glob: $(inputs.out_surf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
