cwlVersion: v1.2
class: CommandLineTool
baseCommand: avro-python2
label: avro-python2
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container execution failure (no space
  left on device).\n\nTool homepage: http://avro.apache.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/avro-python2:1.9.0--py_0
stdout: avro-python2.out
