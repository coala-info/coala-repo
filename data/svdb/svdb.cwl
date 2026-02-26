cwlVersion: v1.2
class: CommandLineTool
baseCommand: SVDB-2.8.4
label: svdb
doc: "use the build module to construct databases, use the query module to query the
  database usign vcf files, or use the hist module to generate histograms\n\nTool
  homepage: https://github.com/J35P312/SVDB"
inputs:
  - id: build
    type:
      - 'null'
      - boolean
    doc: create a db
    inputBinding:
      position: 101
      prefix: --build
  - id: export
    type:
      - 'null'
      - boolean
    doc: export a database
    inputBinding:
      position: 101
      prefix: --export
  - id: merge
    type:
      - 'null'
      - boolean
    doc: merge similar structural variants within a vcf file
    inputBinding:
      position: 101
      prefix: --merge
  - id: query
    type:
      - 'null'
      - boolean
    doc: query a db
    inputBinding:
      position: 101
      prefix: --query
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svdb:2.8.4--py311h7c5c6c8_0
stdout: svdb.out
