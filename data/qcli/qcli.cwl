cwlVersion: v1.2
class: CommandLineTool
baseCommand: qcli
label: qcli
doc: "The provided text is a container build log and does not contain help information
  or argument definitions for the tool.\n\nTool homepage: https://github.com/xyOz-dev/LogiQCLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/qcli:v0.1.1-3-deb-py2_cv1
stdout: qcli.out
