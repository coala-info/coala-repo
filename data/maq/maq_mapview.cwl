cwlVersion: v1.2
class: CommandLineTool
baseCommand: maq mapview
label: maq_mapview
doc: "View alignments in a map file\n\nTool homepage: https://github.com/maqetta/maqetta"
inputs:
  - id: input_map_file
    type: File
    doc: Input map file
    inputBinding:
      position: 1
  - id: binary_output
    type:
      - 'null'
      - boolean
    doc: Output in binary format
    inputBinding:
      position: 102
      prefix: -b
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not output header
    inputBinding:
      position: 102
      prefix: -N
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_mapview.out
