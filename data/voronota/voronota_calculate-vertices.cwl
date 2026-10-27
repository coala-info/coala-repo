cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - calculate-vertices
label: voronota_calculate-vertices
doc: "Calculates Voronoi vertices (quadruples with tangent spheres) of balls.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_balls
    type: File
    doc: "list of balls (stdin)"
  - id: print_log
    type:
      - 'null'
      - boolean
    doc: "flag to print log of calculations"
    inputBinding:
      position: 101
      prefix: --print-log
  - id: exclude_hidden_balls
    type:
      - 'null'
      - boolean
    doc: "flag to exclude hidden input balls"
    inputBinding:
      position: 101
      prefix: --exclude-hidden-balls
  - id: include_surplus_quadruples
    type:
      - 'null'
      - boolean
    doc: "flag to include surplus quadruples"
    inputBinding:
      position: 101
      prefix: --include-surplus-quadruples
  - id: link
    type:
      - 'null'
      - boolean
    doc: "flag to output links between vertices"
    inputBinding:
      position: 101
      prefix: --link
  - id: init_radius_for_BSH
    type:
      - 'null'
      - float
    doc: "initial radius for bounding sphere hierarchy"
    inputBinding:
      position: 101
      prefix: --init-radius-for-BSH
  - id: check
    type:
      - 'null'
      - boolean
    doc: "flag to slowly check the resulting vertices (used only for testing)"
    inputBinding:
      position: 101
      prefix: --check
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_balls.path)
stdout: voronota_calculate-vertices.out
