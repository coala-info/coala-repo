cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-avro
label: python3-avro
doc: "Python 3 implementation of the Apache Avro serialization system.\n\nTool homepage:
  https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-avro:v1.8.1dfsg-1-deb_cv1
stdout: python3-avro.out
