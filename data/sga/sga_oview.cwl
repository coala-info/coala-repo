cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - oview
label: sga_oview
doc: "Draw overlaps in ASQGFILE\n\nTool homepage: https://github.com/jts/sga"
inputs:
  - id: asqgfile
    type: File
    doc: ASQGFILE
    inputBinding:
      position: 1
  - id: default_padding
    type:
      - 'null'
      - int
    doc: pad the overlap lines with D characters
    default: 20
    inputBinding:
      position: 102
      prefix: --default-padding
  - id: id
    type:
      - 'null'
      - string
    doc: only show overlaps for read with ID
    inputBinding:
      position: 102
      prefix: --id
  - id: max_overhang
    type:
      - 'null'
      - int
    doc: only show D overhanging bases of the alignments
    default: 6
    inputBinding:
      position: 102
      prefix: --max-overhang
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_oview.out
