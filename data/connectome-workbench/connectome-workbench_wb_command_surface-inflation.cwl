cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-inflation
label: connectome-workbench_wb_command_surface-inflation
doc: 'Inflate a surface by performing cycles that consist of smoothing followed by
  inflation (to correct shrinkage caused by smoothing).


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: anatomical_surface_in
    type: File
    doc: the anatomical surface
    inputBinding:
      position: 1
  - id: surface_in
    type: File
    doc: the surface file to inflate
    inputBinding:
      position: 2
  - id: number_of_smoothing_cycles
    type: int
    doc: number of smoothing cycles
    inputBinding:
      position: 3
  - id: smoothing_strength
    type: float
    doc: smoothing strength (ranges [0.0 - 1.0])
    inputBinding:
      position: 4
  - id: smoothing_iterations
    type: int
    doc: smoothing iterations
    inputBinding:
      position: 5
  - id: inflation_factor
    type: float
    doc: inflation factor
    inputBinding:
      position: 6
  - id: surface_out
    type: string
    doc: output - output surface file
    inputBinding:
      position: 7
outputs:
  - id: surface_out_file
    type: File
    doc: output surface file
    outputBinding:
      glob: $(inputs.surface_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
