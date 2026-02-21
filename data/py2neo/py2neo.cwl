cwlVersion: v1.2
class: CommandLineTool
baseCommand: py2neo
label: py2neo
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/MazzaWill/neo4j-python-pandas-py2neo-v3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/py2neo:3.1.2--py34_0
stdout: py2neo.out
