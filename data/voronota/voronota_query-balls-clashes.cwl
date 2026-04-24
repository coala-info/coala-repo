cwlVersion: v1.2
class: CommandLineTool
baseCommand: voronota_query-balls-clashes
label: voronota_query-balls-clashes
doc: "Query Voronota output for ball clashes.\n\nTool homepage: https://www.voronota.com/"
inputs:
  - id: input_balls
    type: File
    doc: "list of balls (line format: 'annotation x y z r')"
    inputBinding:
      position: 1
  - id: clash_distance
    type:
      - 'null'
      - float
    doc: clash distance threshold in angstroms
    inputBinding:
      position: 102
      prefix: --clash-distance
  - id: init_radius_for_bsh
    type:
      - 'null'
      - float
    doc: initial radius for bounding sphere hierarchy
    inputBinding:
      position: 102
      prefix: --init-radius-for-BSH
  - id: min_seq_sep
    type:
      - 'null'
      - int
    doc: minimum residue sequence separation
    inputBinding:
      position: 102
      prefix: --min-seq-sep
outputs:
  - id: output_clashes
    type: File
    doc: "list of clashes (line format: 'annotation1 annotation2 distance min-distance-between-balls')"
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/voronota:1.29.4602--h5755088_0
