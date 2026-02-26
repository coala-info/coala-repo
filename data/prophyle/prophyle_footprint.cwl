cwlVersion: v1.2
class: CommandLineTool
baseCommand: prophyle_footprint
label: prophyle_footprint
doc: "Calculate footprint of prophages in a genome.\n\nTool homepage: https://github.com/karel-brinda/prophyle"
inputs:
  - id: index_dir
    type: Directory
    doc: index directory
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - type: array
        items: string
    doc: advanced configuration (a JSON dictionary)
    inputBinding:
      position: 102
      prefix: -c
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
stdout: prophyle_footprint.out
