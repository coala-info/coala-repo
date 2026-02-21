cwlVersion: v1.2
class: CommandLineTool
baseCommand: forceatlas2-python
label: forceatlas2-python
doc: "ForceAtlas2 is a force-directed layout algorithm for network visualization.\n
  \nTool homepage: https://github.com/klarman-cell-observatory/forceatlas2-python"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/forceatlas2-python:1.1--py_1
stdout: forceatlas2-python.out
