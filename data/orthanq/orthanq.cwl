cwlVersion: v1.2
class: CommandLineTool
baseCommand: orthanq
label: orthanq
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error indicating a failure to pull or build
  the container image due to insufficient disk space.\n\nTool homepage: https://github.com/orthanq/orthanq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orthanq:1.21.0--py311h50b50ab_1
stdout: orthanq.out
