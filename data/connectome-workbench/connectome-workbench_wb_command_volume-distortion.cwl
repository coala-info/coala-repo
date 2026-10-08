cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-distortion
label: connectome-workbench_wb_command_volume-distortion
doc: "Calculates isotropic and anisotropic distortions in the volume warpfield. At each voxel, the gradient of the absolute warpfield is computed to obtain the local affine transforms for each voxel (jacobian matrices), and strain tensors are derived from them. The isotropic component (volumetric expansion ratio) is the product of the three principal strains. The default measure ('elongation') for the anisotropic component is the largest principal strain divided by the smallest.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: warpfield
    type: File
    doc: "the warpfield to compute the distortion of"
    inputBinding:
      position: 1
  - id: volume_out
    type: string
    doc: "output - the output distortion measures"
    inputBinding:
      position: 2
  - id: fnirt_source_volume
    type:
      - 'null'
      - File
    doc: "MUST be used if using a fnirt warpfield: the source volume used when generating the warpfield"
    inputBinding:
      position: 3
      prefix: -fnirt
  - id: circular
    type:
      - 'null'
      - boolean
    doc: "use the circle-based formula for the anisotropic measure"
    inputBinding:
      position: 4
      prefix: -circular
outputs:
  - id: output_volume
    type: File
    doc: "the output distortion measures"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
