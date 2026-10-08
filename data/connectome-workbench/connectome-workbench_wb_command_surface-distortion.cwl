cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-distortion
label: connectome-workbench_wb_command_surface-distortion
doc: 'This command, when not using -caret5-method, -edge-method, or -local-affine-method,
  is equivalent to using -surface-vertex-areas on each surface, smoothing both output
  metrics with the GEO_GAUSS_EQUAL method on the surface they came from if -smooth
  is specified, and then using the formula ''ln(distorted/reference)/ln(2)'' on the
  smoothed results.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface_reference
    type: File
    doc: the reference surface
    inputBinding:
      position: 1
  - id: surface_distorted
    type: File
    doc: the distorted surface
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the output distortion metric
    inputBinding:
      position: 3
  - id: smooth
    type:
      - 'null'
      - float
    doc: smooth the area data
    inputBinding:
      position: 4
      prefix: -smooth
  - id: caret5_method
    type:
      - 'null'
      - boolean
    doc: use the surface distortion method from caret5
    inputBinding:
      position: 4
      prefix: -caret5-method
  - id: edge_method
    type:
      - 'null'
      - boolean
    doc: calculate distortion of edge lengths rather than areas
    inputBinding:
      position: 4
      prefix: -edge-method
  - id: local_affine_method
    type:
      - 'null'
      - boolean
    doc: calculate distortion by the local affines between triangles
    inputBinding:
      position: 4
      prefix: -local-affine-method
outputs:
  - id: metric_out_file
    type: File
    doc: the output distortion metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
