cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_calculate-vertices-in-parallel
label: voronota_calculate-vertices-in-parallel
doc: "Calculates Voronoi vertices in parallel.\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_balls
    type: File
    doc: "list of balls (line format: 'x y z r')"
    inputBinding:
      position: 1
  - id: include_surplus_quadruples
    type:
      - 'null'
      - boolean
    doc: flag to include surplus quadruples
    inputBinding:
      position: 102
      prefix: --include-surplus-quadruples
  - id: init_radius_for_bsh
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
  - id: method
    type: string
    doc: "parallelization method name, variants are: 'openmp' 'simulated'"
    inputBinding:
      position: 102
      prefix: --method
  - id: parts
    type: int
    doc: number of parts for splitting, must be power of 2
    inputBinding:
      position: 102
      prefix: --parts
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
