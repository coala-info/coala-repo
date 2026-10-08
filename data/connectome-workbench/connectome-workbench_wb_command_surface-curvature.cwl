cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-curvature
label: connectome-workbench_wb_command_surface-curvature
doc: 'Compute the curvature of the surface, using the method from: Interactive Texture
  Mapping by J. Maillot, Yahia, and Verroust, 1993. ACM-0-98791-601-8/93/008


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to compute the curvature of
    inputBinding:
      position: 1
  - id: mean
    type:
      - 'null'
      - string
    doc: output mean curvature
    inputBinding:
      position: 2
      prefix: -mean
  - id: gauss
    type:
      - 'null'
      - string
    doc: output gaussian curvature
    inputBinding:
      position: 2
      prefix: -gauss
outputs:
  - id: mean_file
    type:
      - 'null'
      - File
    doc: mean curvature metric
    outputBinding:
      glob: $(inputs.mean)
  - id: gauss_file
    type:
      - 'null'
      - File
    doc: gaussian curvature metric
    outputBinding:
      glob: $(inputs.gauss)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
