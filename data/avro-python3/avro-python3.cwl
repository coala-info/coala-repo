cwlVersion: v1.2
class: CommandLineTool
baseCommand: avro-python3
label: avro-python3
doc: "The provided text does not contain help documentation for the tool. It consists
  of system error messages related to a Singularity/Docker container execution failure
  (no space left on device).\n\nTool homepage: http://avro.apache.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/avro-python3:1.9.0--py37_0
stdout: avro-python3.out
