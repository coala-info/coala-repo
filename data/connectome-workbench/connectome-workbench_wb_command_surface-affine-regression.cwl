cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-affine-regression
label: connectome-workbench_wb_command_surface-affine-regression
doc: 'Use linear regression to compute an affine that minimizes the sum of squares
  of the coordinate differences between the target surface and the warped source surface.
  Note that this has a bias to shrink the surface that is being warped. The output
  is written as a NIFTI ''world'' matrix, see -convert-affine to convert it for use
  in other software.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: source
    type: File
    doc: the surface to warp
    inputBinding:
      position: 1
  - id: target
    type: File
    doc: the surface to match the coordinates of
    inputBinding:
      position: 2
  - id: affine_out
    type: string
    doc: output - the output affine file
    inputBinding:
      position: 3
outputs:
  - id: affine_out_file
    type: File
    doc: the output affine file
    outputBinding:
      glob: $(inputs.affine_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
