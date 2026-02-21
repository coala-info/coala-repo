cwlVersion: v1.2
class: CommandLineTool
baseCommand: daligner
label: daligner
doc: "The provided text does not contain help information for daligner; it is an error
  log indicating a failure to build a container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/thegenemyers/DALIGNER"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/daligner:2.0.20240118--h7b50bb2_0
stdout: daligner.out
