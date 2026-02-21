cwlVersion: v1.2
class: CommandLineTool
baseCommand: openms-thirdparty
label: openms-thirdparty
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error indicating a failure to pull or
  build the container image due to insufficient disk space.\n\nTool homepage: https://github.com/OpenMS/OpenMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/openms-thirdparty:3.5.0--h9ee0642_0
stdout: openms-thirdparty.out
