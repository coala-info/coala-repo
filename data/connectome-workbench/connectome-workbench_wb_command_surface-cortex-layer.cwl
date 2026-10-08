cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-cortex-layer
label: connectome-workbench_wb_command_surface-cortex-layer
doc: 'The input surfaces must have vertex correspondence. The output surface is generated
  by placing vertices between the two surfaces such that the enclosed volume within
  any small patch of the new and white surfaces is the given fraction of the volume
  of the same patch between the pial and white surfaces (i.e., specifying 0 would
  give the white surface, 1 would give the pial surface).


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: white_surface
    type: File
    doc: the white matter surface
    inputBinding:
      position: 1
  - id: pial_surface
    type: File
    doc: the pial surface
    inputBinding:
      position: 2
  - id: location_value
    type: float
    doc: what volume fraction to place the layer at
    inputBinding:
      position: 3
  - id: out_surface
    type: string
    doc: output - the output surface
    inputBinding:
      position: 4
  - id: placement_out
    type:
      - 'null'
      - string
    doc: output the placement as a distance fraction from pial to white
    inputBinding:
      position: 5
      prefix: -placement-out
outputs:
  - id: out_surface_file
    type: File
    doc: the output surface
    outputBinding:
      glob: $(inputs.out_surface)
  - id: placement_out_file
    type:
      - 'null'
      - File
    doc: output metric
    outputBinding:
      glob: $(inputs.placement_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
