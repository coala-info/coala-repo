cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-smoothing
label: connectome-workbench_wb_command_surface-smoothing
doc: "Smooths a surface by averaging vertex coordinates with those of the neighboring vertices.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface_in
    type: File
    doc: "the surface file to smooth"
    inputBinding:
      position: 1
  - id: smoothing_strength
    type: float
    doc: "smoothing strength (ranges [0.0 - 1.0])"
    inputBinding:
      position: 2
  - id: smoothing_iterations
    type: int
    doc: "smoothing iterations"
    inputBinding:
      position: 3
  - id: surface_out
    type: string
    doc: "output - output surface file"
    inputBinding:
      position: 4
outputs:
  - id: output_surface
    type: File
    doc: "output surface file"
    outputBinding:
      glob: $(inputs.surface_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
