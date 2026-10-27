cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - calculate-vertices-in-parallel
label: voronota_calculate-vertices-in-parallel
doc: "Calculates Voronoi vertices of balls in parallel.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_balls
    type: File
    doc: "list of balls (stdin)"
  - id: method
    type: string
    doc: "parallelization method name, variants are: 'openmp' 'simulated'"
    inputBinding:
      position: 101
      prefix: --method
  - id: parts
    type: int
    doc: "number of parts for splitting, must be power of 2"
    inputBinding:
      position: 101
      prefix: --parts
  - id: print_log
    type:
      - 'null'
      - boolean
    doc: "flag to print log of calculations"
    inputBinding:
      position: 101
      prefix: --print-log
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
stdin: $(inputs.input_balls.path)
stdout: voronota_calculate-vertices-in-parallel.out
