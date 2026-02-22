cwlVersion: v1.2
class: CommandLineTool
baseCommand: avro
label: avro
doc: "The provided text does not contain help information or usage instructions for
  the 'avro' tool. It consists of system error messages related to a container execution
  failure (no space left on device).\n\nTool homepage: https://github.com/apache/avro"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/avro:1.8.0--py35_0
stdout: avro.out
