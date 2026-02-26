cwlVersion: v1.2
class: CommandLineTool
baseCommand: py2neo
label: py2neo
doc: "A tool to run or evaluate Cypher statements against a Neo4j database.\n\nTool
  homepage: https://github.com/MazzaWill/neo4j-python-pandas-py2neo-v3"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (run or evaluate)
    inputBinding:
      position: 1
  - id: statement
    type: string
    doc: The Cypher statement to execute
    inputBinding:
      position: 2
  - id: host
    type:
      - 'null'
      - string
    doc: The host address of the Neo4j server
    inputBinding:
      position: 103
      prefix: -H
  - id: port
    type:
      - 'null'
      - int
    doc: The port number of the Neo4j server
    inputBinding:
      position: 103
      prefix: -P
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/py2neo:3.1.2--py34_0
stdout: py2neo.out
