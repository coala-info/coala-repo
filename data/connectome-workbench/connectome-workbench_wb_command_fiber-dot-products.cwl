cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-fiber-dot-products'
label: connectome-workbench_wb_command_fiber-dot-products
doc: "Compute dot products of fiber orientations with surface normals. For each vertex, finds the closest fiber population that satisfies the <direction> test (INSIDE, OUTSIDE, or ANY), and computes the absolute value of the dot product of the surface normal and the normalized mean direction of each fiber.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: white_surf
    type: File
    doc: the white/gray boundary surface
    inputBinding:
      position: 1
  - id: fiber_file
    type: File
    doc: the fiber orientation file
    inputBinding:
      position: 2
  - id: max_dist
    type: float
    doc: the maximum distance from any surface vertex a fiber population may be, in mm
    inputBinding:
      position: 3
  - id: direction
    type: string
    doc: 'test against surface for whether a fiber population should be used: INSIDE, OUTSIDE or ANY'
    inputBinding:
      position: 4
  - id: dot_metric
    type: string
    doc: output - the metric of dot products
    inputBinding:
      position: 5
  - id: f_metric
    type: string
    doc: output - a metric of the f values of the fiber distributions
    inputBinding:
      position: 6
outputs:
  - id: dot_products
    type: File
    doc: the metric of dot products
    outputBinding:
      glob: $(inputs.dot_metric)
  - id: f_values
    type: File
    doc: metric of the f values of the fiber distributions
    outputBinding:
      glob: $(inputs.f_metric)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
