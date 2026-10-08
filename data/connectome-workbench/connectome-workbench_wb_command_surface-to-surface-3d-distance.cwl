cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-to-surface-3d-distance
label: connectome-workbench_wb_command_surface-to-surface-3d-distance
doc: "Computes the vector difference between the vertices of each surface with the same index, as (comp - ref), and output the magnitudes, and optionally the displacement vectors.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface_comp
    type: File
    doc: "the surface to compare to the reference"
    inputBinding:
      position: 1
  - id: surface_ref
    type: File
    doc: "the surface to use as the reference"
    inputBinding:
      position: 2
  - id: dists_out
    type: string
    doc: "output - the output distances"
    inputBinding:
      position: 3
  - id: vectors_out
    type:
      - 'null'
      - string
    doc: "output the displacement vectors: output - the output vectors"
    inputBinding:
      position: 4
      prefix: -vectors
outputs:
  - id: distances
    type: File
    doc: "the output distances"
    outputBinding:
      glob: $(inputs.dists_out)
  - id: vectors
    type:
      - 'null'
      - File
    doc: "the output vectors"
    outputBinding:
      glob: $(inputs.vectors_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
