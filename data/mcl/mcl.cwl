cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcl
label: mcl
doc: "The provided text does not contain help information for the tool. It contains
  a fatal error message indicating a failure to build or run the container image due
  to insufficient disk space.\n\nTool homepage: https://micans.org/mcl/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcl:22.282--pl5321h7b50bb2_4
stdout: mcl.out
