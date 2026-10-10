cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - microhapdb
  - population
label: microhapdb_population
doc: "Retrieve population records by identifier or query\n\nTool homepage: https://github.com/bioforensics/MicroHapDB/"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format: table or detail.'
    inputBinding:
      position: 101
      prefix: --format
  - id: query
    type:
      - 'null'
      - string
    doc: Retrieve records using a Pandas-style query.
    inputBinding:
      position: 101
      prefix: --query
  - id: ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Population identifier(s).
    inputBinding:
      position: 201
outputs:
  - id: result
    type: stdout
    doc: Population records (standard output).
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
stdout: microhapdb_population.out
