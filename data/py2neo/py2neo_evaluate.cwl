cwlVersion: v1.2
class: CommandLineTool
baseCommand: evaluate
label: py2neo_evaluate
doc: "Evaluate a Cypher statement\n\nTool homepage: https://github.com/MazzaWill/neo4j-python-pandas-py2neo-v3"
inputs:
  - id: statement
    type: string
    doc: Cypher statement
    inputBinding:
      position: 1
  - id: host
    type:
      - 'null'
      - string
    doc: database host
    inputBinding:
      position: 102
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: database port (HTTP)
    inputBinding:
      position: 102
      prefix: --port
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/py2neo:3.1.2--py34_0
stdout: py2neo_evaluate.out
