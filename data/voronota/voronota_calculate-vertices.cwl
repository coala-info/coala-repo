cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_calculate-vertices
label: voronota_calculate-vertices
doc: "Calculates Voronoi vertices from a list of balls.\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_balls
    type: File
    doc: "list of balls (line format: 'x y z r')"
    inputBinding:
      position: 1
  - id: check
    type:
      - 'null'
      - boolean
    doc: flag to slowly check the resulting vertices (used only for testing)
    inputBinding:
      position: 102
      prefix: --check
  - id: exclude_hidden_balls
    type:
      - 'null'
      - boolean
    doc: flag to exclude hidden input balls
    inputBinding:
      position: 102
      prefix: --exclude-hidden-balls
  - id: include_surplus_quadruples
    type:
      - 'null'
      - boolean
    doc: flag to include surplus quadruples
    inputBinding:
      position: 102
      prefix: --include-surplus-quadruples
  - id: init_radius_for_BSH
    type:
      - 'null'
      - float
    doc: initial radius for bounding sphere hierarchy
    inputBinding:
      position: 102
      prefix: --init-radius-for-BSH
  - id: link
    type:
      - 'null'
      - boolean
    doc: flag to output links between vertices
    inputBinding:
      position: 102
      prefix: --link
  - id: print_log
    type:
      - 'null'
      - boolean
    doc: flag to print log of calculations
    inputBinding:
      position: 102
      prefix: --print-log
outputs:
  - id: output_vertices
    type: File
    doc: "list of Voronoi vertices, i.e. quadruples with tangent spheres (line format:
      'q1 q2 q3 q4 x y z r')"
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
