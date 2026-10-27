cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - voronota
  - query-balls-clashes
label: voronota_query-balls-clashes
doc: "Finds clashes between balls.

Tool homepage: https://www.voronota.com/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_balls
    type: File
    doc: "list of annotated balls (stdin)"
  - id: clash_distance
    type:
      - 'null'
      - float
    doc: "clash distance threshold in angstroms, default is 3.0"
    inputBinding:
      position: 101
      prefix: --clash-distance
  - id: min_seq_sep
    type:
      - 'null'
      - int
    doc: "minimum residue sequence separation, default is 2"
    inputBinding:
      position: 101
      prefix: --min-seq-sep
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
stdout: voronota_query-balls-clashes.out
