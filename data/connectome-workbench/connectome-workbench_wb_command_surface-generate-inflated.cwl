cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-generate-inflated
label: connectome-workbench_wb_command_surface-generate-inflated
doc: 'Generate inflated and very inflated surfaces. The output surfaces are ''matched''
  (have same XYZ range) to the anatomical surface. In most cases, an iterations-scale
  of 1.0 (default) is sufficient. However, if the surface contains a large number
  of vertices (150,000), try an iterations-scale of 2.5.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: anatomical_surface_in
    type: File
    doc: the anatomical surface
    inputBinding:
      position: 1
  - id: inflated_surface_out
    type: string
    doc: output - the output inflated surface
    inputBinding:
      position: 2
  - id: very_inflated_surface_out
    type: string
    doc: output - the output very inflated surface
    inputBinding:
      position: 3
  - id: iterations_scale
    type:
      - 'null'
      - float
    doc: optional iterations scaling
    inputBinding:
      position: 4
      prefix: -iterations-scale
outputs:
  - id: inflated_surface_out_file
    type: File
    doc: the output inflated surface
    outputBinding:
      glob: $(inputs.inflated_surface_out)
  - id: very_inflated_surface_out_file
    type: File
    doc: the output very inflated surface
    outputBinding:
      glob: $(inputs.very_inflated_surface_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
